<?php

# Local ARK resolver

# Developer: Maarten Coonen, Maastricht University Library, 2022.
# Adapted from the code developed by Gouda Tijd Machine.
# Many thanks to the Bob Coret, developer at Gouda Tijd Machine & Netwerk Digital Erfgoed, for sharing the code with us.


# You need to add a rewrite rule like below to your Apache configuration or .htaccess file to forward incoming ARKs to this local resolver code:
# RewriteRule ^ark:/99999/([a-zA-Z0-9]+)$ local-ark-site-resolver.php?ark=ark:/99999/$1 [PT,L]

# This local resolver code works like this:
# 1. Global resolver https://n2t.net/ark:/99999/a12vpho redirects to [302] > https://<BASE URL of your NAAN registration>/ark:/99999/a12vpho
# 2. RewriteRule redirects to ./local-ark-site-resolver.php?ark=ark:/99999/a12vpho
# 3. The local resolver redirects to [302] > https://<BASE URL of your NAAN registration>/<$omeka_basepath>/<$slug>/ark:/99999/a12vpho

# Example:
# 0. https://n2t.net/ark:/99999/a12vpho
# 1. https://omeka.local/ark:/99999/a12vpho
# 2. https://omeka.local/local-ark-site-resolver.php?ark=ark:/99999/a12vpho
# 3. https://omeka.local/s/examplesite/ark:/99999/a12vpho


// Given the URL http://omeka.local/s/examplesite/ark:/99999/a12vpho
// the $omeka_basepath would be "/s/"
// and the lookup result for $slug would be 'examplesite'
$omeka_basepath="/s/";

if (isset($_GET["ark"])) {
	#$ark="ark:/60537/b9MTov";
	$ark=preg_replace('/[^a-z0-9\:\/]/i','',$_GET["ark"]);

	# get omeka database settings
	$database_settings=parse_ini_file("config/database.ini");

	# connect to db via mysqli
	try {
		$mysqli = new mysqli($database_settings["host"], $database_settings["user"], $database_settings["password"], $database_settings["dbname"]);
	} catch (\mysqli_sql_exception $e) {
		 throw new \mysqli_sql_exception($e->getMessage(), $e->getCode());
	}

	# find site slug
	$dbname = $database_settings["dbname"];	// Note: $dbname can be left out in query below
	$stmt = $mysqli->prepare("SELECT slug, v.resource_id, r.resource_type FROM $dbname.value v LEFT JOIN $dbname.item_site i ON v.resource_id=i.item_id LEFT JOIN $dbname.site s ON i.site_id=s.id LEFT JOIN $dbname.resource r ON v.resource_id=r.id WHERE v.value=?");
	$stmt->bind_param("s", $ark);
	$stmt->execute();
	$result = $stmt->get_result()->fetch_assoc();

	//error_log(print_r($result,true));

	if ($ark=="ark:/60537/bI5Sxd") {
		$slug="";
	} else {
		$slug="referentie";  // als een item niet in een site zit (bijv. data catalog en distributies) kan er geen slug gevonden worden 
	}
	
	if (isset($_SERVER['HTTP_ACCEPT']) && !empty($_SERVER['HTTP_ACCEPT'])) {
		header('Accept: '.$_SERVER['HTTP_ACCEPT']);
	}
	if ($result) {

		if ($result["resource_type"]=="Omeka\Entity\ItemSet") {
		    if (empty($slug)) {
				header("Location: " . $omeka_basepath . "collection/" . $ark);
			} else {
				header("Location: " . $omeka_basepath . $slug . "/collection/" . $ark);
			}
			exit;
		} else {
			$slug=$result["slug"];
			header("Location: " . $omeka_basepath . $slug . "/" . $ark);
			exit;
		}
	}

	header("Location: " . $omeka_basepath);

} else {
	echo "<h1>Missing ARK</h1>";
}
exit;

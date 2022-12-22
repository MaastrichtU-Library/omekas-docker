<?php

# You need to add the following to your Apache configuration (exception to the rule not to server php files):
# RewriteCond %{REQUEST_FILENAME} -f
# RewriteRule ark-site-resolver.php$ - [NC,C]
# RewriteRule .* - [L]

# RewriteRule ^ark:/([0-9]+)/([a-zA-Z0-9]+)$ https://www.goudatijdmachine.nl/data/custom/ark-site-resolver.php?ark=ark:/$1/$2 [R=301,L]


# https://n2t.net/ark:/60537/b9MTov 
# [302] > https://www.goudatijdmachine.nl/ark:/60537/b9MTov
# [302] > https://www.goudatijdmachine.nl/data/custom/ark-site-resolver.php?ark=ark:/60537/b9MTov

# ARK resolver to right site

$omeka_basepath="/data/";

if (isset($_GET["ark"])) {
	#$ark="ark:/60537/b9MTov";
	$ark=preg_replace('/[^a-z0-9\:\/]/i','',$_GET["ark"]);

	# get omeka database settings

	$database_settings=parse_ini_file("database.ini");  # symlinked

	# connect to db via mysqli

	try {
		$mysqli = new mysqli($database_settings["host"], $database_settings["user"], $database_settings["password"], $database_settings["dbname"]);
	} catch (\mysqli_sql_exception $e) {
		 throw new \mysqli_sql_exception($e->getMessage(), $e->getCode());
	}

	# find site slug

	$stmt = $mysqli->prepare("SELECT slug, v.resource_id, r.resource_type FROM omeka.value v LEFT JOIN omeka.item_site i ON v.resource_id=i.item_id LEFT JOIN omeka.site s ON i.site_id=s.id LEFT JOIN omeka.resource r ON v.resource_id=r.id WHERE v.value=?");
	#$stmt = $mysqli->prepare("SELECT slug FROM omeka.value v, omeka.item_site i, omeka.site s WHERE v.value=? AND v.resource_id=i.item_id AND i.site_id=s.id");
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
				header("Location: ".$omeka_basepath."collection/".$ark);
			} else {
				header("Location: ".$omeka_basepath.$slug."/collection/".$ark);
			}
			exit;
		} else {
			$slug=$result["slug"];
			header("Location: ".$omeka_basepath.$slug."/document/".$ark);
			exit;
		}
	}

	header("Location: ".$omeka_basepath);

} else {
	echo "<h1>Missing ARK</h1>";
}
exit;

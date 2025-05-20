-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: May 20, 2025 at 08:25 AM
-- Server version: 8.0.40
-- PHP Version: 8.0.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `omekas`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_key`
--

CREATE TABLE `api_key` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_ip` varbinary(16) DEFAULT NULL COMMENT '(DC2Type:ip_address)',
  `last_accessed` datetime DEFAULT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset`
--

CREATE TABLE `asset` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_export`
--

CREATE TABLE `bulk_export` (
  `id` int NOT NULL,
  `exporter_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `job_id` int DEFAULT NULL,
  `comment` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `filename` varchar(760) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_exporter`
--

CREATE TABLE `bulk_exporter` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `writer` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bulk_exporter`
--

INSERT INTO `bulk_exporter` (`id`, `owner_id`, `label`, `writer`, `config`) VALUES
(1, 1, 'TSV (tab-separated values)', 'BulkExport\\Writer\\TsvWriter', '{\"writer\":{\"separator\":\" | \",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(2, 1, 'OpenDocument text (odt)', 'BulkExport\\Writer\\OpenDocumentTextWriter', '{\"writer\":{\"format_fields\":\"label\",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(3, 1, 'OpenDocument spreadsheet (ods)', 'BulkExport\\Writer\\OpenDocumentSpreadsheetWriter', '{\"writer\":{\"separator\":\" | \",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(4, 1, 'CSV', 'BulkExport\\Writer\\CsvWriter', '{\"writer\":{\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\",\"separator\":\" | \",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(5, 1, 'Text', 'BulkExport\\Writer\\TextWriter', '{\"writer\":{\"format_fields\":\"label\",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `content_lock`
--

CREATE TABLE `content_lock` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `entity_id` int NOT NULL,
  `entity_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `csvimport_entity`
--

CREATE TABLE `csvimport_entity` (
  `id` int NOT NULL,
  `job_id` int NOT NULL,
  `entity_id` int NOT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `csvimport_import`
--

CREATE TABLE `csvimport_import` (
  `id` int NOT NULL,
  `job_id` int NOT NULL,
  `undo_job_id` int DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_err` tinyint(1) NOT NULL,
  `stats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_vocab`
--

CREATE TABLE `custom_vocab` (
  `id` int NOT NULL,
  `item_set_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `uris` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_vocab`
--

INSERT INTO `custom_vocab` (`id`, `item_set_id`, `owner_id`, `label`, `lang`, `terms`, `uris`) VALUES
(1, NULL, 1, 'Languages', NULL, '[\"Dutch\",\"English\",\"French\",\"German\",\"Latin\"]', NULL),
(2, 2, 1, 'CC-Licenses', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fulltext_search`
--

CREATE TABLE `fulltext_search` (
  `id` int NOT NULL,
  `resource` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fulltext_search`
--

INSERT INTO `fulltext_search` (`id`, `resource`, `owner_id`, `is_public`, `title`, `text`) VALUES
(1, 'items', 1, 1, 'First item', 'First item\nThis is the first item in this Omeka instance. It was created during the Docker bootstrap phase.\nIt contains metadata, but no associated media files.\nark:/99999/a1apZs2'),
(2, 'item_sets', 1, 1, 'CC-Licenses Collection', 'CC-Licenses Collection\nark:/99999/a12vpho'),
(3, 'items', 1, 1, 'Creative Common license - CC-BY-NC', 'CC-BY-NC\nCreative Common license - CC-BY-NC\nhttps://creativecommons.org/licenses/by-nc/4.0/ Creative Commons website\nYou are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nThe licensor cannot revoke these freedoms as long as you follow the license terms.\nAttribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNonCommercial — You may not use the material for commercial purposes.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.\nark:/99999/a1UAQRM'),
(4, 'items', 1, 1, 'Creative Common license - CC-BY', 'CC-BY\nCreative Common license - CC-BY\nhttps://creativecommons.org/licenses/by/4.0/ Creative Commons website\nYou are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nfor any purpose, even commercially.\nUnder the following terms:\nAttribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.\nark:/99999/a1MGfH7');

-- --------------------------------------------------------

--
-- Table structure for table `hit`
--

CREATE TABLE `hit` (
  `id` int NOT NULL,
  `url` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `entity_id` int NOT NULL DEFAULT '0',
  `entity_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `site_id` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `query` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `referrer` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `user_agent` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `accept_language` varchar(190) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hit`
--

INSERT INTO `hit` (`id`, `url`, `entity_id`, `entity_name`, `site_id`, `user_id`, `ip`, `query`, `referrer`, `user_agent`, `accept_language`, `created`) VALUES
(1, '/', 0, '', 0, 0, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:124.0) Gecko/20100101 Firefox/124.0', 'en-US,en;q=0.5', '2024-03-26 13:43:37'),
(2, '/', 0, '', 0, 0, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:124.0) Gecko/20100101 Firefox/124.0', 'en-US,en;q=0.5', '2024-04-15 09:39:14'),
(3, '/s/default/item', 0, '', 1, 1, '::', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:33:56'),
(4, '/s/default/item', 0, '', 1, 1, '::', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:34:16'),
(5, '/s/default/item/1', 1, 'items', 1, 1, '::', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:34:18'),
(6, '/s/default/item', 0, '', 1, 1, '::', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:34:19'),
(7, '/', 0, '', 0, 0, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-16 12:07:36'),
(8, '/', 0, '', 0, 0, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:35:21'),
(9, '/', 0, '', 0, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:02'),
(10, '/s/default', 0, '', 1, 1, '::', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:04'),
(11, '/s/default/page/welcome', 1, 'site_pages', 1, 1, '::', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:04'),
(12, '/s/default/sitemap.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:11'),
(13, '/', 0, '', 0, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:37:24'),
(14, '/', 0, '', 0, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:45'),
(15, '/s/default', 0, '', 1, 1, '::', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:46'),
(16, '/s/default/page/welcome', 1, 'site_pages', 1, 1, '::', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:46'),
(17, '/s/default/sitemap.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:53'),
(18, '/s/default/sitemapindex.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:53'),
(19, '/s/default/sitemap.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:39:28'),
(20, '/s/default/sitemapindex.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:39:29'),
(21, '/s/default/sitemapindex.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:41:32'),
(22, '/s/default/sitemap.xml', 0, '', 1, 1, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:41:32'),
(23, '/', 0, '', 0, 0, '::', NULL, '', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-04-30 07:57:12');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int NOT NULL,
  `primary_media_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `primary_media_id`) VALUES
(1, NULL),
(3, NULL),
(4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `item_item_set`
--

CREATE TABLE `item_item_set` (
  `item_id` int NOT NULL,
  `item_set_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_item_set`
--

INSERT INTO `item_item_set` (`item_id`, `item_set_id`) VALUES
(3, 2),
(4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `item_set`
--

CREATE TABLE `item_set` (
  `id` int NOT NULL,
  `is_open` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_set`
--

INSERT INTO `item_set` (`id`, `is_open`) VALUES
(2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `item_site`
--

CREATE TABLE `item_site` (
  `item_id` int NOT NULL,
  `site_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_site`
--

INSERT INTO `item_site` (`item_id`, `site_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `pid` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `args` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `log` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `started` datetime NOT NULL,
  `ended` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `owner_id`, `pid`, `status`, `class`, `args`, `log`, `started`, `ended`) VALUES
(1, 1, '49', 'completed', 'Ark\\Job\\CreateArks', NULL, NULL, '2023-02-16 07:52:23', '2023-02-16 07:52:23'),
(2, 1, '41', 'completed', 'AdvancedSearch\\Job\\IndexSearch', '{\"search_engine_id\":2,\"start_resource_id\":1,\"resource_names\":[\"items\"],\"force\":false}', '2023-02-28T14:44:24+00:00 NOTICE (5): Search index #2 (\"Solr\"): start of indexing\n2023-02-28T14:44:24+00:00 INFO (6): Search index is not cleared: reindexing starts at resource #1.\n2023-02-28T14:44:24+00:00 INFO (6): Indexing in Solr core \"Default\": item #1\n2023-02-28T14:44:24+00:00 INFO (6): Search index #2 (\"Solr\"): end of indexing. items: 1 indexed. Execution time: 0 seconds. Failed indexed resources should be checked manually.\n', '2023-02-28 14:44:23', '2023-02-28 14:44:24');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `job_id` int DEFAULT NULL,
  `reference` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `severity` int NOT NULL DEFAULT '0',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `owner_id`, `job_id`, `reference`, `severity`, `message`, `context`, `created`) VALUES
(1, 1, NULL, '', 4, 'The module \"SearchSolr\" was automatically deactivated because the dependencies are unavailable.', '[]', '2023-11-09 15:49:13'),
(2, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #3', '[]', '2023-11-30 18:57:25'),
(3, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #4', '[]', '2023-11-30 18:58:55'),
(4, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #4', '[]', '2023-11-30 18:59:10'),
(5, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #3', '[]', '2023-11-30 18:59:22'),
(6, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #4', '[]', '2023-11-30 18:59:56'),
(7, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #3', '[]', '2023-11-30 19:00:07'),
(8, 1, NULL, '', 3, 'Laminas\\Form\\Exception\\DomainException: Laminas\\Form\\View\\Helper\\FormSelect does not allow specifying multiple selected values when the element does not have a multiple attribute set to a boolean true in /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormSelect.php:285\nStack trace:\n#0 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormSelect.php(119): Laminas\\Form\\View\\Helper\\FormSelect->validateMultiValue(Array, Array)\n#1 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormSelect.php(86): Laminas\\Form\\View\\Helper\\FormSelect->render(Object(Laminas\\Form\\Element\\Select))\n#2 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(168): Laminas\\Form\\View\\Helper\\FormSelect->__invoke(Object(Laminas\\Form\\Element\\Select))\n#3 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(193): Laminas\\Form\\View\\Helper\\FormElement->renderHelper(\'formselect\', Object(Laminas\\Form\\Element\\Select))\n#4 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(114): Laminas\\Form\\View\\Helper\\FormElement->renderType(Object(Laminas\\Form\\Element\\Select))\n#5 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(91): Laminas\\Form\\View\\Helper\\FormElement->render(Object(Laminas\\Form\\Element\\Select))\n#6 /var/www/html/vendor/laminas/laminas-view/src/Renderer/PhpRenderer.php(407): Laminas\\Form\\View\\Helper\\FormElement->__invoke(Object(Laminas\\Form\\Element\\Select))\n#7 /var/www/html/application/view/common/form-row.phtml(26): Laminas\\View\\Renderer\\PhpRenderer->__call(\'formElement\', Array)\n#8 /var/www/html/vendor/laminas/laminas-view/src/Renderer/PhpRenderer.php(519): include(\'/var/www/html/a...\')\n#9 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormRow.php(154): Laminas\\View\\Renderer\\PhpRenderer->render(NULL, NULL)\n#10 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormRow.php(108): Laminas\\Form\\View\\Helper\\FormRow->render(Object(Laminas\\Form\\Element\\Select), \'prepend\')\n#11 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormCollection.php(133): Laminas\\Form\\View\\Helper\\FormRow->__invoke(Object(Laminas\\Form\\Element\\Select))\n#12 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormCollection.php(104): Laminas\\Form\\View\\Helper\\FormCollection->render(Object(IiifServer\\Form\\ConfigForm))\n#13 /var/www/html/vendor/laminas/laminas-view/src/Renderer/PhpRenderer.php(407): Laminas\\Form\\View\\Helper\\FormCollection->__invoke(Object(IiifServer\\Form\\ConfigForm))\n#14 /var/www/html/modules/Generic/AbstractModule.php(219): Laminas\\View\\Renderer\\PhpRenderer->__call(\'formCollection\', Array)\n#15 /var/www/html/modules/IiifServer/Module.php(83): Generic\\AbstractModule->getConfigForm(Object(Laminas\\View\\Renderer\\PhpRenderer))\n#16 /var/www/html/application/src/Controller/Admin/ModuleController.php(291): IiifServer\\Module->getConfigForm(Object(Laminas\\View\\Renderer\\PhpRenderer))\n#17 /var/www/html/vendor/laminas/laminas-mvc/src/Controller/AbstractActionController.php(71): Omeka\\Controller\\Admin\\ModuleController->configureAction()\n#18 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(319): Laminas\\Mvc\\Controller\\AbstractActionController->onDispatch(Object(Laminas\\Mvc\\MvcEvent))\n#19 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(179): Laminas\\EventManager\\EventManager->triggerListeners(Object(Laminas\\Mvc\\MvcEvent), Object(Closure))\n#20 /var/www/html/vendor/laminas/laminas-mvc/src/Controller/AbstractController.php(97): Laminas\\EventManager\\EventManager->triggerEventUntil(Object(Closure), Object(Laminas\\Mvc\\MvcEvent))\n#21 /var/www/html/vendor/laminas/laminas-mvc/src/DispatchListener.php(132): Laminas\\Mvc\\Controller\\AbstractController->dispatch(Object(Laminas\\Http\\PhpEnvironment\\Request), Object(Laminas\\Http\\PhpEnvironment\\Response))\n#22 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(319): Laminas\\Mvc\\DispatchListener->onDispatch(Object(Laminas\\Mvc\\MvcEvent))\n#23 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(179): Laminas\\EventManager\\EventManager->triggerListeners(Object(Laminas\\Mvc\\MvcEvent), Object(Closure))\n#24 /var/www/html/vendor/laminas/laminas-mvc/src/Application.php(325): Laminas\\EventManager\\EventManager->triggerEventUntil(Object(Closure), Object(Laminas\\Mvc\\MvcEvent))\n#25 /var/www/html/index.php(21): Laminas\\Mvc\\Application->run()\n#26 {main}', '[]', '2024-06-04 13:12:11'),
(9, 1, NULL, '', 3, 'Laminas\\Form\\Exception\\DomainException: Laminas\\Form\\View\\Helper\\FormSelect does not allow specifying multiple selected values when the element does not have a multiple attribute set to a boolean true in /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormSelect.php:285\nStack trace:\n#0 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormSelect.php(119): Laminas\\Form\\View\\Helper\\FormSelect->validateMultiValue(Array, Array)\n#1 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormSelect.php(86): Laminas\\Form\\View\\Helper\\FormSelect->render(Object(Laminas\\Form\\Element\\Select))\n#2 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(168): Laminas\\Form\\View\\Helper\\FormSelect->__invoke(Object(Laminas\\Form\\Element\\Select))\n#3 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(193): Laminas\\Form\\View\\Helper\\FormElement->renderHelper(\'formselect\', Object(Laminas\\Form\\Element\\Select))\n#4 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(114): Laminas\\Form\\View\\Helper\\FormElement->renderType(Object(Laminas\\Form\\Element\\Select))\n#5 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormElement.php(91): Laminas\\Form\\View\\Helper\\FormElement->render(Object(Laminas\\Form\\Element\\Select))\n#6 /var/www/html/vendor/laminas/laminas-view/src/Renderer/PhpRenderer.php(407): Laminas\\Form\\View\\Helper\\FormElement->__invoke(Object(Laminas\\Form\\Element\\Select))\n#7 /var/www/html/application/view/common/form-row.phtml(26): Laminas\\View\\Renderer\\PhpRenderer->__call(\'formElement\', Array)\n#8 /var/www/html/vendor/laminas/laminas-view/src/Renderer/PhpRenderer.php(519): include(\'/var/www/html/a...\')\n#9 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormRow.php(154): Laminas\\View\\Renderer\\PhpRenderer->render(NULL, NULL)\n#10 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormRow.php(108): Laminas\\Form\\View\\Helper\\FormRow->render(Object(Laminas\\Form\\Element\\Select), \'prepend\')\n#11 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormCollection.php(133): Laminas\\Form\\View\\Helper\\FormRow->__invoke(Object(Laminas\\Form\\Element\\Select))\n#12 /var/www/html/vendor/laminas/laminas-form/src/View/Helper/FormCollection.php(104): Laminas\\Form\\View\\Helper\\FormCollection->render(Object(IiifServer\\Form\\ConfigForm))\n#13 /var/www/html/vendor/laminas/laminas-view/src/Renderer/PhpRenderer.php(407): Laminas\\Form\\View\\Helper\\FormCollection->__invoke(Object(IiifServer\\Form\\ConfigForm))\n#14 /var/www/html/modules/Generic/AbstractModule.php(219): Laminas\\View\\Renderer\\PhpRenderer->__call(\'formCollection\', Array)\n#15 /var/www/html/modules/IiifServer/Module.php(83): Generic\\AbstractModule->getConfigForm(Object(Laminas\\View\\Renderer\\PhpRenderer))\n#16 /var/www/html/application/src/Controller/Admin/ModuleController.php(291): IiifServer\\Module->getConfigForm(Object(Laminas\\View\\Renderer\\PhpRenderer))\n#17 /var/www/html/vendor/laminas/laminas-mvc/src/Controller/AbstractActionController.php(71): Omeka\\Controller\\Admin\\ModuleController->configureAction()\n#18 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(319): Laminas\\Mvc\\Controller\\AbstractActionController->onDispatch(Object(Laminas\\Mvc\\MvcEvent))\n#19 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(179): Laminas\\EventManager\\EventManager->triggerListeners(Object(Laminas\\Mvc\\MvcEvent), Object(Closure))\n#20 /var/www/html/vendor/laminas/laminas-mvc/src/Controller/AbstractController.php(97): Laminas\\EventManager\\EventManager->triggerEventUntil(Object(Closure), Object(Laminas\\Mvc\\MvcEvent))\n#21 /var/www/html/vendor/laminas/laminas-mvc/src/DispatchListener.php(132): Laminas\\Mvc\\Controller\\AbstractController->dispatch(Object(Laminas\\Http\\PhpEnvironment\\Request), Object(Laminas\\Http\\PhpEnvironment\\Response))\n#22 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(319): Laminas\\Mvc\\DispatchListener->onDispatch(Object(Laminas\\Mvc\\MvcEvent))\n#23 /var/www/html/vendor/laminas/laminas-eventmanager/src/EventManager.php(179): Laminas\\EventManager\\EventManager->triggerListeners(Object(Laminas\\Mvc\\MvcEvent), Object(Closure))\n#24 /var/www/html/vendor/laminas/laminas-mvc/src/Application.php(325): Laminas\\EventManager\\EventManager->triggerEventUntil(Object(Closure), Object(Laminas\\Mvc\\MvcEvent))\n#25 /var/www/html/index.php(21): Laminas\\Mvc\\Application->run()\n#26 {main}', '[]', '2024-06-04 13:12:19');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int NOT NULL,
  `item_id` int NOT NULL,
  `ingester` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `renderer` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `source` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `media_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sha256` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `has_original` tinyint(1) NOT NULL,
  `has_thumbnails` tinyint(1) NOT NULL,
  `position` int DEFAULT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE `migration` (
  `version` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migration`
--

INSERT INTO `migration` (`version`) VALUES
('20171128053327'),
('20180412035023'),
('20180919072656'),
('20180924033501'),
('20181002015551'),
('20181004043735'),
('20181106060421'),
('20190307043537'),
('20190319020708'),
('20190412090532'),
('20190423040354'),
('20190423071228'),
('20190514061351'),
('20190515055359'),
('20190729023728'),
('20190809092609'),
('20190815062003'),
('20200224022356'),
('20200226064602'),
('20200325091157'),
('20200326091310'),
('20200803000000'),
('20200831000000'),
('20210205101827'),
('20210225095734'),
('20210810083804'),
('20220718090449'),
('20220824103916'),
('20230124033031'),
('20230410074846'),
('20230523085358'),
('20230601060113'),
('20230713101012'),
('20231016000000'),
('20240103030617');

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `version` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`id`, `is_active`, `version`) VALUES
('AdvancedSearch', 1, '3.4.21'),
('ArchiveRepertory', 1, '3.15.17'),
('Ark', 1, '3.5.15'),
('BlockPlus', 1, '3.4.37'),
('BlocksDisposition', 1, '3.4.4'),
('BulkEdit', 1, '3.4.33'),
('BulkExport', 1, '3.4.35'),
('Common', 1, '3.4.66'),
('CreateMissingThumbnails', 1, '0.3.0'),
('CSVImport', 1, '2.6.2'),
('CustomVocab', 1, '2.0.2'),
('EasyAdmin', 1, '3.4.29'),
('EUCookieBar', 1, '3.4.5'),
('ExtractText', 1, '2.1.0'),
('FileSideload', 1, '1.7.1'),
('HideProperties', 1, '1.3.1'),
('IiifSearch', 1, '3.4.7'),
('IiifServer', 1, '3.6.16'),
('ImageServer', 1, '3.6.17'),
('Log', 1, '3.4.28'),
('Mirador', 1, '3.4.7.16'),
('ModelViewer', 1, '3.3.0.7-132'),
('NdeTermennetwerk', 1, '1.1.0'),
('NumericDataTypes', 1, '1.11.4'),
('PdfViewer', 1, '3.4.4'),
('SearchSolr', 1, '3.5.45'),
('Sitemaps', 1, '1.1'),
('Statistics', 1, '3.4.9'),
('UniversalViewer', 1, '3.6.9'),
('ValueSuggest', 1, '1.17.2');

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_duration`
--

CREATE TABLE `numeric_data_types_duration` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_integer`
--

CREATE TABLE `numeric_data_types_integer` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_interval`
--

CREATE TABLE `numeric_data_types_interval` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL,
  `value2` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_timestamp`
--

CREATE TABLE `numeric_data_types_timestamp` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_creation`
--

CREATE TABLE `password_creation` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  `created` datetime NOT NULL,
  `activate` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1, NULL, 1, 'title', 'Title', 'A name given to the resource.'),
(2, NULL, 1, 'creator', 'Creator', 'An entity primarily responsible for making the resource.'),
(3, NULL, 1, 'subject', 'Subject', 'The topic of the resource.'),
(4, NULL, 1, 'description', 'Description', 'An account of the resource.'),
(5, NULL, 1, 'publisher', 'Publisher', 'An entity responsible for making the resource available.'),
(6, NULL, 1, 'contributor', 'Contributor', 'An entity responsible for making contributions to the resource.'),
(7, NULL, 1, 'date', 'Date', 'A point or period of time associated with an event in the lifecycle of the resource.'),
(8, NULL, 1, 'type', 'Type', 'The nature or genre of the resource.'),
(9, NULL, 1, 'format', 'Format', 'The file format, physical medium, or dimensions of the resource.'),
(10, NULL, 1, 'identifier', 'Identifier', 'An unambiguous reference to the resource within a given context.'),
(11, NULL, 1, 'source', 'Source', 'A related resource from which the described resource is derived.'),
(12, NULL, 1, 'language', 'Language', 'A language of the resource.'),
(13, NULL, 1, 'relation', 'Relation', 'A related resource.'),
(14, NULL, 1, 'coverage', 'Coverage', 'The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.'),
(15, NULL, 1, 'rights', 'Rights', 'Information about rights held in and over the resource.'),
(16, NULL, 1, 'audience', 'Audience', 'A class of entity for whom the resource is intended or useful.'),
(17, NULL, 1, 'alternative', 'Alternative Title', 'An alternative name for the resource.'),
(18, NULL, 1, 'tableOfContents', 'Table Of Contents', 'A list of subunits of the resource.'),
(19, NULL, 1, 'abstract', 'Abstract', 'A summary of the resource.'),
(20, NULL, 1, 'created', 'Date Created', 'Date of creation of the resource.'),
(21, NULL, 1, 'valid', 'Date Valid', 'Date (often a range) of validity of a resource.'),
(22, NULL, 1, 'available', 'Date Available', 'Date (often a range) that the resource became or will become available.'),
(23, NULL, 1, 'issued', 'Date Issued', 'Date of formal issuance (e.g., publication) of the resource.'),
(24, NULL, 1, 'modified', 'Date Modified', 'Date on which the resource was changed.'),
(25, NULL, 1, 'extent', 'Extent', 'The size or duration of the resource.'),
(26, NULL, 1, 'medium', 'Medium', 'The material or physical carrier of the resource.'),
(27, NULL, 1, 'isVersionOf', 'Is Version Of', 'A related resource of which the described resource is a version, edition, or adaptation.'),
(28, NULL, 1, 'hasVersion', 'Has Version', 'A related resource that is a version, edition, or adaptation of the described resource.'),
(29, NULL, 1, 'isReplacedBy', 'Is Replaced By', 'A related resource that supplants, displaces, or supersedes the described resource.'),
(30, NULL, 1, 'replaces', 'Replaces', 'A related resource that is supplanted, displaced, or superseded by the described resource.'),
(31, NULL, 1, 'isRequiredBy', 'Is Required By', 'A related resource that requires the described resource to support its function, delivery, or coherence.'),
(32, NULL, 1, 'requires', 'Requires', 'A related resource that is required by the described resource to support its function, delivery, or coherence.'),
(33, NULL, 1, 'isPartOf', 'Is Part Of', 'A related resource in which the described resource is physically or logically included.'),
(34, NULL, 1, 'hasPart', 'Has Part', 'A related resource that is included either physically or logically in the described resource.'),
(35, NULL, 1, 'isReferencedBy', 'Is Referenced By', 'A related resource that references, cites, or otherwise points to the described resource.'),
(36, NULL, 1, 'references', 'References', 'A related resource that is referenced, cited, or otherwise pointed to by the described resource.'),
(37, NULL, 1, 'isFormatOf', 'Is Format Of', 'A related resource that is substantially the same as the described resource, but in another format.'),
(38, NULL, 1, 'hasFormat', 'Has Format', 'A related resource that is substantially the same as the pre-existing described resource, but in another format.'),
(39, NULL, 1, 'conformsTo', 'Conforms To', 'An established standard to which the described resource conforms.'),
(40, NULL, 1, 'spatial', 'Spatial Coverage', 'Spatial characteristics of the resource.'),
(41, NULL, 1, 'temporal', 'Temporal Coverage', 'Temporal characteristics of the resource.'),
(42, NULL, 1, 'mediator', 'Mediator', 'An entity that mediates access to the resource and for whom the resource is intended or useful.'),
(43, NULL, 1, 'dateAccepted', 'Date Accepted', 'Date of acceptance of the resource.'),
(44, NULL, 1, 'dateCopyrighted', 'Date Copyrighted', 'Date of copyright.'),
(45, NULL, 1, 'dateSubmitted', 'Date Submitted', 'Date of submission of the resource.'),
(46, NULL, 1, 'educationLevel', 'Audience Education Level', 'A class of entity, defined in terms of progression through an educational or training context, for which the described resource is intended.'),
(47, NULL, 1, 'accessRights', 'Access Rights', 'Information about who can access the resource or an indication of its security status.'),
(48, NULL, 1, 'bibliographicCitation', 'Bibliographic Citation', 'A bibliographic reference for the resource.'),
(49, NULL, 1, 'license', 'License', 'A legal document giving official permission to do something with the resource.'),
(50, NULL, 1, 'rightsHolder', 'Rights Holder', 'A person or organization owning or managing rights over the resource.'),
(51, NULL, 1, 'provenance', 'Provenance', 'A statement of any changes in ownership and custody of the resource since its creation that are significant for its authenticity, integrity, and interpretation.'),
(52, NULL, 1, 'instructionalMethod', 'Instructional Method', 'A process, used to engender knowledge, attitudes and skills, that the described resource is designed to support.'),
(53, NULL, 1, 'accrualMethod', 'Accrual Method', 'The method by which items are added to a collection.'),
(54, NULL, 1, 'accrualPeriodicity', 'Accrual Periodicity', 'The frequency with which items are added to a collection.'),
(55, NULL, 1, 'accrualPolicy', 'Accrual Policy', 'The policy governing the addition of items to a collection.'),
(56, NULL, 3, 'affirmedBy', 'affirmedBy', 'A legal decision that affirms a ruling.'),
(57, NULL, 3, 'annotates', 'annotates', 'Critical or explanatory note for a Document.'),
(58, NULL, 3, 'authorList', 'list of authors', 'An ordered list of authors. Normally, this list is seen as a priority list that order authors by importance.'),
(59, NULL, 3, 'citedBy', 'cited by', 'Relates a document to another document that cites the\nfirst document.'),
(60, NULL, 3, 'cites', 'cites', 'Relates a document to another document that is cited\nby the first document as reference, comment, review, quotation or for\nanother purpose.'),
(61, NULL, 3, 'contributorList', 'list of contributors', 'An ordered list of contributors. Normally, this list is seen as a priority list that order contributors by importance.'),
(62, NULL, 3, 'court', 'court', 'A court associated with a legal document; for example, that which issues a decision.'),
(63, NULL, 3, 'degree', 'degree', 'The thesis degree.'),
(64, NULL, 3, 'director', 'director', 'A Film director.'),
(65, NULL, 3, 'distributor', 'distributor', 'Distributor of a document or a collection of documents.'),
(66, NULL, 3, 'editor', 'editor', 'A person having managerial and sometimes policy-making responsibility for the editorial part of a publishing firm or of a newspaper, magazine, or other publication.'),
(67, NULL, 3, 'editorList', 'list of editors', 'An ordered list of editors. Normally, this list is seen as a priority list that order editors by importance.'),
(68, NULL, 3, 'interviewee', 'interviewee', 'An agent that is interviewed by another agent.'),
(69, NULL, 3, 'interviewer', 'interviewer', 'An agent that interview another agent.'),
(70, NULL, 3, 'issuer', 'issuer', 'An entity responsible for issuing often informally published documents such as press releases, reports, etc.'),
(71, NULL, 3, 'organizer', 'organizer', 'The organizer of an event; includes conference organizers, but also government agencies or other bodies that are responsible for conducting hearings.'),
(72, NULL, 3, 'owner', 'owner', 'Owner of a document or a collection of documents.'),
(73, NULL, 3, 'performer', 'performer', NULL),
(74, NULL, 3, 'presentedAt', 'presented at', 'Relates a document to an event; for example, a paper to a conference.'),
(75, NULL, 3, 'presents', 'presents', 'Relates an event to associated documents; for example, conference to a paper.'),
(76, NULL, 3, 'producer', 'producer', 'Producer of a document or a collection of documents.'),
(77, NULL, 3, 'recipient', 'recipient', 'An agent that receives a communication document.'),
(78, NULL, 3, 'reproducedIn', 'reproducedIn', 'The resource in which another resource is reproduced.'),
(79, NULL, 3, 'reversedBy', 'reversedBy', 'A legal decision that reverses a ruling.'),
(80, NULL, 3, 'reviewOf', 'review of', 'Relates a review document to a reviewed thing (resource, item, etc.).'),
(81, NULL, 3, 'status', 'status', 'The publication status of (typically academic) content.'),
(82, NULL, 3, 'subsequentLegalDecision', 'subsequentLegalDecision', 'A legal decision on appeal that takes action on a case (affirming it, reversing it, etc.).'),
(83, NULL, 3, 'transcriptOf', 'transcript of', 'Relates a document to some transcribed original.'),
(84, NULL, 3, 'translationOf', 'translation of', 'Relates a translated document to the original document.'),
(85, NULL, 3, 'translator', 'translator', 'A person who translates written document from one language to another.'),
(86, NULL, 3, 'abstract', 'abstract', 'A summary of the resource.'),
(87, NULL, 3, 'argued', 'date argued', 'The date on which a legal case is argued before a court. Date is of format xsd:date'),
(88, NULL, 3, 'asin', 'asin', NULL),
(89, NULL, 3, 'chapter', 'chapter', 'An chapter number'),
(90, NULL, 3, 'coden', 'coden', NULL),
(91, NULL, 3, 'content', 'content', 'This property is for a plain-text rendering of the content of a Document. While the plain-text content of an entire document could be described by this property.'),
(92, NULL, 3, 'doi', 'doi', NULL),
(93, NULL, 3, 'eanucc13', 'eanucc13', NULL),
(94, NULL, 3, 'edition', 'edition', 'The name defining a special edition of a document. Normally its a literal value composed of a version number and words.'),
(95, NULL, 3, 'eissn', 'eissn', NULL),
(96, NULL, 3, 'gtin14', 'gtin14', NULL),
(97, NULL, 3, 'handle', 'handle', NULL),
(98, NULL, 3, 'identifier', 'identifier', NULL),
(99, NULL, 3, 'isbn', 'isbn', NULL),
(100, NULL, 3, 'isbn10', 'isbn10', NULL),
(101, NULL, 3, 'isbn13', 'isbn13', NULL),
(102, NULL, 3, 'issn', 'issn', NULL),
(103, NULL, 3, 'issue', 'issue', 'An issue number'),
(104, NULL, 3, 'lccn', 'lccn', NULL),
(105, NULL, 3, 'locator', 'locator', 'A description (often numeric) that locates an item within a containing document or collection.'),
(106, NULL, 3, 'numPages', 'number of pages', 'The number of pages contained in a document'),
(107, NULL, 3, 'numVolumes', 'number of volumes', 'The number of volumes contained in a collection of documents (usually a series, periodical, etc.).'),
(108, NULL, 3, 'number', 'number', 'A generic item or document number. Not to be confused with issue number.'),
(109, NULL, 3, 'oclcnum', 'oclcnum', NULL),
(110, NULL, 3, 'pageEnd', 'page end', 'Ending page number within a continuous page range.'),
(111, NULL, 3, 'pageStart', 'page start', 'Starting page number within a continuous page range.'),
(112, NULL, 3, 'pages', 'pages', 'A string of non-contiguous page spans that locate a Document within a Collection. Example: 23-25, 34, 54-56. For continuous page ranges, use the pageStart and pageEnd properties.'),
(113, NULL, 3, 'pmid', 'pmid', NULL),
(114, NULL, 3, 'prefixName', 'prefix name', 'The prefix of a name'),
(115, NULL, 3, 'section', 'section', 'A section number'),
(116, NULL, 3, 'shortDescription', 'shortDescription', NULL),
(117, NULL, 3, 'shortTitle', 'short title', 'The abbreviation of a title.'),
(118, NULL, 3, 'sici', 'sici', NULL),
(119, NULL, 3, 'suffixName', 'suffix name', 'The suffix of a name'),
(120, NULL, 3, 'upc', 'upc', NULL),
(121, NULL, 3, 'uri', 'uri', 'Universal Resource Identifier of a document'),
(122, NULL, 3, 'volume', 'volume', 'A volume number'),
(123, NULL, 4, 'mbox', 'personal mailbox', 'A  personal mailbox, ie. an Internet mailbox associated with exactly one owner, the first owner of this mailbox. This is a \'static inverse functional property\', in that  there is (across time and change) at most one individual that ever has any particular value for foaf:mbox.'),
(124, NULL, 4, 'mbox_sha1sum', 'sha1sum of a personal mailbox URI name', 'The sha1sum of the URI of an Internet mailbox associated with exactly one owner, the  first owner of the mailbox.'),
(125, NULL, 4, 'gender', 'gender', 'The gender of this Agent (typically but not necessarily \'male\' or \'female\').'),
(126, NULL, 4, 'geekcode', 'geekcode', 'A textual geekcode for this person, see http://www.geekcode.com/geek.html'),
(127, NULL, 4, 'dnaChecksum', 'DNA checksum', 'A checksum for the DNA of some thing. Joke.'),
(128, NULL, 4, 'sha1', 'sha1sum (hex)', 'A sha1sum hash, in hex.'),
(129, NULL, 4, 'based_near', 'based near', 'A location that something is based near, for some broadly human notion of near.'),
(130, NULL, 4, 'title', 'title', 'Title (Mr, Mrs, Ms, Dr. etc)'),
(131, NULL, 4, 'nick', 'nickname', 'A short informal nickname characterising an agent (includes login identifiers, IRC and other chat nicknames).'),
(132, NULL, 4, 'jabberID', 'jabber ID', 'A jabber ID for something.'),
(133, NULL, 4, 'aimChatID', 'AIM chat ID', 'An AIM chat ID'),
(134, NULL, 4, 'skypeID', 'Skype ID', 'A Skype ID'),
(135, NULL, 4, 'icqChatID', 'ICQ chat ID', 'An ICQ chat ID'),
(136, NULL, 4, 'yahooChatID', 'Yahoo chat ID', 'A Yahoo chat ID'),
(137, NULL, 4, 'msnChatID', 'MSN chat ID', 'An MSN chat ID'),
(138, NULL, 4, 'name', 'name', 'A name for some thing.'),
(139, NULL, 4, 'firstName', 'firstName', 'The first name of a person.'),
(140, NULL, 4, 'lastName', 'lastName', 'The last name of a person.'),
(141, NULL, 4, 'givenName', 'Given name', 'The given name of some person.'),
(142, NULL, 4, 'givenname', 'Given name', 'The given name of some person.'),
(143, NULL, 4, 'surname', 'Surname', 'The surname of some person.'),
(144, NULL, 4, 'family_name', 'family_name', 'The family name of some person.'),
(145, NULL, 4, 'familyName', 'familyName', 'The family name of some person.'),
(146, NULL, 4, 'phone', 'phone', 'A phone,  specified using fully qualified tel: URI scheme (refs: http://www.w3.org/Addressing/schemes.html#tel).'),
(147, NULL, 4, 'homepage', 'homepage', 'A homepage for some thing.'),
(148, NULL, 4, 'weblog', 'weblog', 'A weblog of some thing (whether person, group, company etc.).'),
(149, NULL, 4, 'openid', 'openid', 'An OpenID for an Agent.'),
(150, NULL, 4, 'tipjar', 'tipjar', 'A tipjar document for this agent, describing means for payment and reward.'),
(151, NULL, 4, 'plan', 'plan', 'A .plan comment, in the tradition of finger and \'.plan\' files.'),
(152, NULL, 4, 'made', 'made', 'Something that was made by this agent.'),
(153, NULL, 4, 'maker', 'maker', 'An agent that  made this thing.'),
(154, NULL, 4, 'img', 'image', 'An image that can be used to represent some thing (ie. those depictions which are particularly representative of something, eg. one\'s photo on a homepage).'),
(155, NULL, 4, 'depiction', 'depiction', 'A depiction of some thing.'),
(156, NULL, 4, 'depicts', 'depicts', 'A thing depicted in this representation.'),
(157, NULL, 4, 'thumbnail', 'thumbnail', 'A derived thumbnail image.'),
(158, NULL, 4, 'myersBriggs', 'myersBriggs', 'A Myers Briggs (MBTI) personality classification.'),
(159, NULL, 4, 'workplaceHomepage', 'workplace homepage', 'A workplace homepage of some person; the homepage of an organization they work for.'),
(160, NULL, 4, 'workInfoHomepage', 'work info homepage', 'A work info homepage of some person; a page about their work for some organization.'),
(161, NULL, 4, 'schoolHomepage', 'schoolHomepage', 'A homepage of a school attended by the person.'),
(162, NULL, 4, 'knows', 'knows', 'A person known by this person (indicating some level of reciprocated interaction between the parties).'),
(163, NULL, 4, 'interest', 'interest', 'A page about a topic of interest to this person.'),
(164, NULL, 4, 'topic_interest', 'topic_interest', 'A thing of interest to this person.'),
(165, NULL, 4, 'publications', 'publications', 'A link to the publications of this person.'),
(166, NULL, 4, 'currentProject', 'current project', 'A current project this person works on.'),
(167, NULL, 4, 'pastProject', 'past project', 'A project this person has previously worked on.'),
(168, NULL, 4, 'fundedBy', 'funded by', 'An organization funding a project or person.'),
(169, NULL, 4, 'logo', 'logo', 'A logo representing some thing.'),
(170, NULL, 4, 'topic', 'topic', 'A topic of some page or document.'),
(171, NULL, 4, 'primaryTopic', 'primary topic', 'The primary topic of some page or document.'),
(172, NULL, 4, 'focus', 'focus', 'The underlying or \'focal\' entity associated with some SKOS-described concept.'),
(173, NULL, 4, 'isPrimaryTopicOf', 'is primary topic of', 'A document that this thing is the primary topic of.'),
(174, NULL, 4, 'page', 'page', 'A page or document about this thing.'),
(175, NULL, 4, 'theme', 'theme', 'A theme.'),
(176, NULL, 4, 'account', 'account', 'Indicates an account held by this agent.'),
(177, NULL, 4, 'holdsAccount', 'account', 'Indicates an account held by this agent.'),
(178, NULL, 4, 'accountServiceHomepage', 'account service homepage', 'Indicates a homepage of the service provide for this online account.'),
(179, NULL, 4, 'accountName', 'account name', 'Indicates the name (identifier) associated with this online account.'),
(180, NULL, 4, 'member', 'member', 'Indicates a member of a Group'),
(181, NULL, 4, 'membershipClass', 'membershipClass', 'Indicates the class of individuals that are a member of a Group'),
(182, NULL, 4, 'birthday', 'birthday', 'The birthday of this Agent, represented in mm-dd string form, eg. \'12-31\'.'),
(183, NULL, 4, 'age', 'age', 'The age in years of some agent.'),
(184, NULL, 4, 'status', 'status', 'A string expressing what the user is happy for the general public (normally) to know about their current activity.'),
(185, 1, 5, 'extracted_text', 'extracted text', 'Text extracted from a resource.'),
(186, 1, 6, 'maximumAttendeeCapacity', 'maximumAttendeeCapacity', 'The total number of individuals that may attend an event or venue.'),
(187, 1, 6, 'printEdition', 'printEdition', 'The edition of the print product in which the NewsArticle appears.'),
(188, 1, 6, 'actors', 'actors', 'An actor, e.g. in TV, radio, movie, video games etc. Actors can be associated with individual items or with a series, episode, clip.'),
(189, 1, 6, 'actor', 'actor', 'An actor, e.g. in TV, radio, movie, video games etc., or in an event. Actors can be associated with individual items or with a series, episode, clip.'),
(190, 1, 6, 'latitude', 'latitude', 'The latitude of a location. For example ```37.42242``` ([WGS 84](https://en.wikipedia.org/wiki/World_Geodetic_System)).'),
(191, 1, 6, 'geoCoveredBy', 'geoCoveredBy', 'Represents a relationship between two geometries (or the places they represent), relating a geometry to another that covers it. As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(192, 1, 6, 'requiredQuantity', 'requiredQuantity', 'The required quantity of the item(s).'),
(193, 1, 6, 'price', 'price', 'The offer price of a product, or of a price component when attached to PriceSpecification and its subtypes.\\n\\nUsage guidelines:\\n\\n* Use the [[priceCurrency]] property (with standard formats: [ISO 4217 currency format](http://en.wikipedia.org/wiki/ISO_4217), e.g. \"USD\"; [Ticker symbol](https://en.wikipedia.org/wiki/List_of_cryptocurrencies) for cryptocurrencies, e.g. \"BTC\"; well known names for [Local Exchange Trading Systems](https://en.wikipedia.org/wiki/Local_exchange_trading_system) (LETS) and other currency types, e.g. \"Ithaca HOUR\") instead of including [ambiguous symbols](http://en.wikipedia.org/wiki/Dollar_sign#Currencies_that_use_the_dollar_or_peso_sign) such as \'$\' in the value.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.\\n* Note that both [RDFa](http://www.w3.org/TR/xhtml-rdfa-primer/#using-the-content-attribute) and Microdata syntax allow the use of a \"content=\" attribute for publishing simple machine-readable values alongside more human-friendly formatting.\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\n      '),
(194, 1, 6, 'homeLocation', 'homeLocation', 'A contact location for a person\'s residence.'),
(195, 1, 6, 'location', 'location', 'The location of, for example, where an event is happening, where an organization is located, or where an action takes place.'),
(196, 1, 6, 'dayOfWeek', 'dayOfWeek', 'The day of the week for which these opening hours are valid.'),
(197, 1, 6, 'cvdNumC19OFMechVentPats', 'cvdNumC19OFMechVentPats', 'numc19ofmechventpats - ED/OVERFLOW and VENTILATED: Patients with suspected or confirmed COVID-19 who are in the ED or any overflow location awaiting an inpatient bed and on a mechanical ventilator.'),
(198, 1, 6, 'diversityStaffingReport', 'diversityStaffingReport', 'For an [[Organization]] (often but not necessarily a [[NewsMediaOrganization]]), a report on staffing diversity issues. In a news context this might be for example ASNE or RTDNA (US) reports, or self-reported.'),
(199, 1, 6, 'publishingPrinciples', 'publishingPrinciples', 'The publishingPrinciples property indicates (typically via [[URL]]) a document describing the editorial principles of an [[Organization]] (or individual, e.g. a [[Person]] writing a blog) that relate to their activities as a publisher, e.g. ethics or diversity policies. When applied to a [[CreativeWork]] (e.g. [[NewsArticle]]) the principles are those of the party primarily responsible for the creation of the [[CreativeWork]].\n\nWhile such policies are most typically expressed in natural language, sometimes related information (e.g. indicating a [[funder]]) can be expressed using schema.org terminology.\n'),
(200, 1, 6, 'billingDuration', 'billingDuration', 'Specifies for how long this price (or price component) will be billed. Can be used, for example, to model the contractual duration of a subscription or payment plan. Type can be either a Duration or a Number (in which case the unit of measurement, for example month, is specified by the unitCode property).'),
(201, 1, 6, 'prescriptionStatus', 'prescriptionStatus', 'Indicates the status of drug prescription, e.g. local catalogs classifications or whether the drug is available by prescription or over-the-counter, etc.'),
(202, 1, 6, 'monthlyMinimumRepaymentAmount', 'monthlyMinimumRepaymentAmount', 'The minimum payment is the lowest amount of money that one is required to pay on a credit card statement each month.'),
(203, 1, 6, 'associatedMediaReview', 'associatedMediaReview', 'An associated [[MediaReview]], related by specific common content, topic or claim. The expectation is that this property would be most typically used in cases where a single activity is conducting both claim reviews and media reviews, in which case [[relatedMediaReview]] would commonly be used on a [[ClaimReview]], while [[relatedClaimReview]] would be used on [[MediaReview]].'),
(204, 1, 6, 'associatedReview', 'associatedReview', 'An associated [[Review]].'),
(205, 1, 6, 'infectiousAgent', 'infectiousAgent', 'The actual infectious agent, such as a specific bacterium.'),
(206, 1, 6, 'occupancy', 'occupancy', 'The allowed total occupancy for the accommodation in persons (including infants etc). For individual accommodations, this is not necessarily the legal maximum but defines the permitted usage as per the contractual agreement (e.g. a double room used by a single person).\nTypical unit code(s): C62 for person'),
(207, 1, 6, 'merchantReturnLink', 'merchantReturnLink', 'Specifies a Web page or service by URL, for product returns.'),
(208, 1, 6, 'valueReference', 'valueReference', 'A secondary value that provides additional information on the original value, e.g. a reference temperature or a type of measurement.'),
(209, 1, 6, 'jobLocation', 'jobLocation', 'A (typically single) geographic location associated with the job position.'),
(210, 1, 6, 'geoRadius', 'geoRadius', 'Indicates the approximate radius of a GeoCircle (metres unless indicated otherwise via Distance notation).'),
(211, 1, 6, 'steps', 'steps', 'A single step item (as HowToStep, text, document, video, etc.) or a HowToSection (originally misnamed \'steps\'; \'step\' is preferred).'),
(212, 1, 6, 'step', 'step', 'A single step item (as HowToStep, text, document, video, etc.) or a HowToSection.'),
(213, 1, 6, 'followup', 'followup', 'Typical or recommended followup care after the procedure is performed.'),
(214, 1, 6, 'hasPOS', 'hasPOS', 'Points-of-Sales operated by the organization or person.'),
(215, 1, 6, 'floorLevel', 'floorLevel', 'The floor level for an [[Accommodation]] in a multi-storey building. Since counting\n  systems [vary internationally](https://en.wikipedia.org/wiki/Storey#Consecutive_number_floor_designations), the local system should be used where possible.'),
(216, 1, 6, 'variesBy', 'variesBy', 'Indicates the property or properties by which the variants in a [[ProductGroup]] vary, e.g. their size, color etc. Schema.org properties can be referenced by their short name e.g. \"color\"; terms defined elsewhere can be referenced with their URIs.'),
(217, 1, 6, 'estimatesRiskOf', 'estimatesRiskOf', 'The condition, complication, or symptom whose risk is being estimated.'),
(218, 1, 6, 'countryOfLastProcessing', 'countryOfLastProcessing', 'The place where the item (typically [[Product]]) was last processed and tested before importation.'),
(219, 1, 6, 'releaseDate', 'releaseDate', 'The release date of a product or product model. This can be used to distinguish the exact variant of a product.'),
(220, 1, 6, 'isSimilarTo', 'isSimilarTo', 'A pointer to another, functionally similar product (or multiple products).'),
(221, 1, 6, 'trailer', 'trailer', 'The trailer of a movie or TV/radio series, season, episode, etc.'),
(222, 1, 6, 'relatedCondition', 'relatedCondition', 'A medical condition associated with this anatomy.'),
(223, 1, 6, 'postalCodePrefix', 'postalCodePrefix', 'A defined range of postal codes indicated by a common textual prefix. Used for non-numeric systems such as UK.'),
(224, 1, 6, 'departureBusStop', 'departureBusStop', 'The stop or station from which the bus departs.'),
(225, 1, 6, 'datasetTimeInterval', 'datasetTimeInterval', 'The range of temporal applicability of a dataset, e.g. for a 2011 census dataset, the year 2011 (in ISO 8601 time interval format).'),
(226, 1, 6, 'temporalCoverage', 'temporalCoverage', 'The temporalCoverage of a CreativeWork indicates the period that the content applies to, i.e. that it describes, either as a DateTime or as a textual string indicating a time period in [ISO 8601 time interval format](https://en.wikipedia.org/wiki/ISO_8601#Time_intervals). In\n      the case of a Dataset it will typically indicate the relevant time period in a precise notation (e.g. for a 2011 census dataset, the year 2011 would be written \"2011/2012\"). Other forms of content, e.g. ScholarlyArticle, Book, TVSeries or TVEpisode, may indicate their temporalCoverage in broader terms - textually or via well-known URL.\n      Written works such as books may sometimes have precise temporal coverage too, e.g. a work set in 1939 - 1945 can be indicated in ISO 8601 interval format format via \"1939/1945\".\n\nOpen-ended date ranges can be written with \"..\" in place of the end date. For example, \"2015-11/..\" indicates a range beginning in November 2015 and with no specified final date. This is tentative and might be updated in future when ISO 8601 is officially updated.'),
(227, 1, 6, 'cvdNumBedsOcc', 'cvdNumBedsOcc', 'numbedsocc - HOSPITAL INPATIENT BED OCCUPANCY: Total number of staffed inpatient beds that are occupied.'),
(228, 1, 6, 'diseasePreventionInfo', 'diseasePreventionInfo', 'Information about disease prevention.'),
(229, 1, 6, 'flightDistance', 'flightDistance', 'The distance of the flight.'),
(230, 1, 6, 'exceptDate', 'exceptDate', 'Defines a [[Date]] or [[DateTime]] during which a scheduled [[Event]] will not take place. The property allows exceptions to\n      a [[Schedule]] to be specified. If an exception is specified as a [[DateTime]] then only the event that would have started at that specific date and time\n      should be excluded from the schedule. If an exception is specified as a [[Date]] then any event that is scheduled for that 24 hour period should be\n      excluded from the schedule. This allows a whole day to be excluded from the schedule without having to itemise every scheduled event.'),
(231, 1, 6, 'catalogNumber', 'catalogNumber', 'The catalog number for the release.'),
(232, 1, 6, 'costPerUnit', 'costPerUnit', 'The cost per unit of the drug.'),
(233, 1, 6, 'comprisedOf', 'comprisedOf', 'Specifying something physically contained by something else. Typically used here for the underlying anatomical structures, such as organs, that comprise the anatomical system.'),
(234, 1, 6, 'spokenByCharacter', 'spokenByCharacter', 'The (e.g. fictional) character, Person or Organization to whom the quotation is attributed within the containing CreativeWork.'),
(235, 1, 6, 'salaryCurrency', 'salaryCurrency', 'The currency (coded using [ISO 4217](http://en.wikipedia.org/wiki/ISO_4217)) used for the main salary information in this job posting or for this employee.'),
(236, 1, 6, 'acrissCode', 'acrissCode', 'The ACRISS Car Classification Code is a code used by many car rental companies, for classifying vehicles. ACRISS stands for Association of Car Rental Industry Systems and Standards.'),
(237, 1, 6, 'exercisePlan', 'exercisePlan', 'A sub property of instrument. The exercise plan used on this action.'),
(238, 1, 6, 'instrument', 'instrument', 'The object that helped the agent perform the action. E.g. John wrote a book with *a pen*.'),
(239, 1, 6, 'endorsers', 'endorsers', 'People or organizations that endorse the plan.'),
(240, 1, 6, 'transFatContent', 'transFatContent', 'The number of grams of trans fat.'),
(241, 1, 6, 'guidelineDate', 'guidelineDate', 'Date on which this guideline\'s recommendation was made.'),
(242, 1, 6, 'issueNumber', 'issueNumber', 'Identifies the issue of publication; for example, \"iii\" or \"2\".'),
(243, 1, 6, 'position', 'position', 'The position of an item in a series or sequence of items.'),
(244, 1, 6, 'workLocation', 'workLocation', 'A contact location for a person\'s place of work.'),
(245, 1, 6, 'hiringOrganization', 'hiringOrganization', 'Organization or Person offering the job position.'),
(246, 1, 6, 'broadcastChannelId', 'broadcastChannelId', 'The unique address by which the BroadcastService can be identified in a provider lineup. In US, this is typically a number.'),
(247, 1, 6, 'query', 'query', 'A sub property of instrument. The query used on this action.'),
(248, 1, 6, 'jobImmediateStart', 'jobImmediateStart', 'An indicator as to whether a position is available for an immediate start.'),
(249, 1, 6, 'applicationSuite', 'applicationSuite', 'The name of the application suite to which the application belongs (e.g. Excel belongs to Office).'),
(250, 1, 6, 'aircraft', 'aircraft', 'The kind of aircraft (e.g., \"Boeing 747\").'),
(251, 1, 6, 'grantee', 'grantee', 'The person, organization, contact point, or audience that has been granted this permission.'),
(252, 1, 6, 'medicineSystem', 'medicineSystem', 'The system of medicine that includes this MedicalEntity, for example \'evidence-based\', \'homeopathic\', \'chiropractic\', etc.'),
(253, 1, 6, 'correctionsPolicy', 'correctionsPolicy', 'For an [[Organization]] (e.g. [[NewsMediaOrganization]]), a statement describing (in news media, the newsroom’s) disclosure and correction policy for errors.'),
(254, 1, 6, 'sizeSystem', 'sizeSystem', 'The size system used to identify a product\'s size. Typically either a standard (for example, \"GS1\" or \"ISO-EN13402\"), country code (for example \"US\" or \"JP\"), or a measuring system (for example \"Metric\" or \"Imperial\").'),
(255, 1, 6, 'playersOnline', 'playersOnline', 'Number of players on the server.'),
(256, 1, 6, 'industry', 'industry', 'The industry associated with the job position.'),
(257, 1, 6, 'menuAddOn', 'menuAddOn', 'Additional menu item(s) such as a side dish of salad or side order of fries that can be added to this menu item. Additionally it can be a menu section containing allowed add-on menu items for this menu item.'),
(258, 1, 6, 'directApply', 'directApply', 'Indicates whether an [[url]] that is associated with a [[JobPosting]] enables direct application for the job, via the posting website. A job posting is considered to have directApply of [[True]] if an application process for the specified job can be directly initiated via the url(s) given (noting that e.g. multiple internet domains might nevertheless be involved at an implementation level). A value of [[False]] is appropriate if there is no clear path to applying directly online for the specified job, navigating directly from the JobPosting url(s) supplied.'),
(259, 1, 6, 'evidenceOrigin', 'evidenceOrigin', 'Source of the data used to formulate the guidance, e.g. RCT, consensus opinion, etc.'),
(260, 1, 6, 'actionableFeedbackPolicy', 'actionableFeedbackPolicy', 'For a [[NewsMediaOrganization]] or other news-related [[Organization]], a statement about public engagement activities (for news media, the newsroom’s), including involving the public - digitally or otherwise -- in coverage decisions, reporting and activities after publication.'),
(261, 1, 6, 'utterances', 'utterances', 'Text of an utterances (spoken words, lyrics etc.) that occurs at a certain section of a media object, represented as a [[HyperTocEntry]].'),
(262, 1, 6, 'studyLocation', 'studyLocation', 'The location in which the study is taking/took place.'),
(263, 1, 6, 'accessibilityControl', 'accessibilityControl', 'Identifies input methods that are sufficient to fully control the described resource. Values should be drawn from the [approved vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityControl-vocabulary).'),
(264, 1, 6, 'maximumEnrollment', 'maximumEnrollment', 'The maximum number of students who may be enrolled in the program.'),
(265, 1, 6, 'checkoutPageURLTemplate', 'checkoutPageURLTemplate', 'A URL template (RFC 6570) for a checkout page for an offer. This approach allows merchants to specify a URL for online checkout of the offered product, by interpolating parameters such as the logged in user ID, product ID, quantity, discount code etc. Parameter naming and standardization are not specified here.'),
(266, 1, 6, 'musicBy', 'musicBy', 'The composer of the soundtrack.'),
(267, 1, 6, 'lastReviewed', 'lastReviewed', 'Date on which the content on this web page was last reviewed for accuracy and/or completeness.'),
(268, 1, 6, 'courseMode', 'courseMode', 'The medium or means of delivery of the course instance or the mode of study, either as a text label (e.g. \"online\", \"onsite\" or \"blended\"; \"synchronous\" or \"asynchronous\"; \"full-time\" or \"part-time\") or as a URL reference to a term from a controlled vocabulary (e.g. https://ceds.ed.gov/element/001311#Asynchronous).'),
(269, 1, 6, 'competencyRequired', 'competencyRequired', 'Knowledge, skill, ability or personal attribute that must be demonstrated by a person or other entity in order to do something such as earn an Educational Occupational Credential or understand a LearningResource.'),
(270, 1, 6, 'paymentMethod', 'paymentMethod', 'The name of the credit card or other method of payment for the order.'),
(271, 1, 6, 'honorificPrefix', 'honorificPrefix', 'An honorific prefix preceding a Person\'s name such as Dr/Mrs/Mr.'),
(272, 1, 6, 'bed', 'bed', 'The type of bed or beds included in the accommodation. For the single case of just one bed of a certain type, you use bed directly with a text.\n      If you want to indicate the quantity of a certain kind of bed, use an instance of BedDetails. For more detailed information, use the amenityFeature property.'),
(273, 1, 6, 'tracks', 'tracks', 'A music recording (track)&#x2014;usually a single song.'),
(274, 1, 6, 'track', 'track', 'A music recording (track)&#x2014;usually a single song. If an ItemList is given, the list should contain items of type MusicRecording.'),
(275, 1, 6, 'mathExpression', 'mathExpression', 'A mathematical expression (e.g. \'x^2-3x=0\') that may be solved for a specific variable, simplified, or transformed. This can take many formats, e.g. LaTeX, Ascii-Math, or math as you would write with a keyboard.'),
(276, 1, 6, 'isbn', 'isbn', 'The ISBN of the book.'),
(277, 1, 6, 'identifier', 'identifier', 'The identifier property represents any kind of identifier for any kind of [[Thing]], such as ISBNs, GTIN codes, UUIDs etc. Schema.org provides dedicated properties for representing many of these, either as textual strings or as URL (URI) links. See [background notes](/docs/datamodel.html#identifierBg) for more details.\n        '),
(278, 1, 6, 'countriesSupported', 'countriesSupported', 'Countries for which the application is supported. You can also provide the two-letter ISO 3166-1 alpha-2 country code.'),
(279, 1, 6, 'checkinTime', 'checkinTime', 'The earliest someone may check into a lodging establishment.'),
(280, 1, 6, 'deliveryMethod', 'deliveryMethod', 'A sub property of instrument. The method of delivery.'),
(281, 1, 6, 'hasBioPolymerSequence', 'hasBioPolymerSequence', 'A symbolic representation of a BioChemEntity. For example, a nucleotide sequence of a Gene or an amino acid sequence of a Protein.'),
(282, 1, 6, 'hasRepresentation', 'hasRepresentation', 'A common representation such as a protein sequence or chemical structure for this entity. For images use schema.org/image.'),
(283, 1, 6, 'distribution', 'distribution', 'A downloadable form of this dataset, at a specific location, in a specific format. This property can be repeated if different variations are available. There is no expectation that different downloadable distributions must contain exactly equivalent information (see also [DCAT](https://www.w3.org/TR/vocab-dcat-3/#Class:Distribution) on this point). Different distributions might include or exclude different subsets of the entire dataset, for example.'),
(284, 1, 6, 'bankAccountType', 'bankAccountType', 'The type of a bank account.'),
(285, 1, 6, 'mediaItemAppearance', 'mediaItemAppearance', 'In the context of a [[MediaReview]], indicates specific media item(s) that are grouped using a [[MediaReviewItem]].'),
(286, 1, 6, 'audio', 'audio', 'An embedded audio object.'),
(287, 1, 6, 'playMode', 'playMode', 'Indicates whether this game is multi-player, co-op or single-player.  The game can be marked as multi-player, co-op and single-player at the same time.'),
(288, 1, 6, 'foodWarning', 'foodWarning', 'Any precaution, guidance, contraindication, etc. related to consumption of specific foods while taking this drug.'),
(289, 1, 6, 'vehicleInteriorType', 'vehicleInteriorType', 'The type or material of the interior of the vehicle (e.g. synthetic fabric, leather, wood, etc.). While most interior types are characterized by the material used, an interior type can also be based on vehicle usage or target audience.'),
(290, 1, 6, 'assesses', 'assesses', 'The item being described is intended to assess the competency or learning outcome defined by the referenced term.'),
(291, 1, 6, 'currentExchangeRate', 'currentExchangeRate', 'The current price of a currency.'),
(292, 1, 6, 'numberOfBathroomsTotal', 'numberOfBathroomsTotal', 'The total integer number of bathrooms in some [[Accommodation]], following real estate conventions as [documented in RESO](https://ddwiki.reso.org/display/DDW17/BathroomsTotalInteger+Field): \"The simple sum of the number of bathrooms. For example for a property with two Full Bathrooms and one Half Bathroom, the Bathrooms Total Integer will be 3.\". See also [[numberOfRooms]].'),
(293, 1, 6, 'experienceInPlaceOfEducation', 'experienceInPlaceOfEducation', 'Indicates whether a [[JobPosting]] will accept experience (as indicated by [[OccupationalExperienceRequirements]]) in place of its formal educational qualifications (as indicated by [[educationRequirements]]). If true, indicates that satisfying one of these requirements is sufficient.'),
(294, 1, 6, 'legislationTransposes', 'legislationTransposes', 'Indicates that this legislation (or part of legislation) fulfills the objectives set by another legislation, by passing appropriate implementation measures. Typically, some legislations of European Union\'s member states or regions transpose European Directives. This indicates a legally binding link between the 2 legislations.'),
(295, 1, 6, 'legislationApplies', 'legislationApplies', 'Indicates that this legislation (or part of a legislation) somehow transfers another legislation in a different legislative context. This is an informative link, and it has no legal value. For legally-binding links of transposition, use the <a href=\"/legislationTransposes\">legislationTransposes</a> property. For example an informative consolidated law of a European Union\'s member state \"applies\" the consolidated version of the European Directive implemented in it.'),
(296, 1, 6, 'distinguishingSign', 'distinguishingSign', 'One of a set of signs and symptoms that can be used to distinguish this diagnosis from others in the differential diagnosis.'),
(297, 1, 6, 'legislationJurisdiction', 'legislationJurisdiction', 'The jurisdiction from which the legislation originates.'),
(298, 1, 6, 'jurisdiction', 'jurisdiction', 'Indicates a legal jurisdiction, e.g. of some legislation, or where some government service is based.'),
(299, 1, 6, 'spatialCoverage', 'spatialCoverage', 'The spatialCoverage of a CreativeWork indicates the place(s) which are the focus of the content. It is a subproperty of\n      contentLocation intended primarily for more technical and detailed materials. For example with a Dataset, it indicates\n      areas that the dataset describes: a dataset of New York weather would have spatialCoverage which was the place: the state of New York.'),
(300, 1, 6, 'arrivalAirport', 'arrivalAirport', 'The airport where the flight terminates.'),
(301, 1, 6, 'interactingDrug', 'interactingDrug', 'Another drug that is known to interact with this drug in a way that impacts the effect of this drug or causes a risk to the patient. Note: disease interactions are typically captured as contraindications.'),
(302, 1, 6, 'availabilityStarts', 'availabilityStarts', 'The beginning of the availability of the product or service included in the offer.'),
(303, 1, 6, 'vehicleSeatingCapacity', 'vehicleSeatingCapacity', 'The number of passengers that can be seated in the vehicle, both in terms of the physical space available, and in terms of limitations set by law.\\n\\nTypical unit code(s): C62 for persons.'),
(304, 1, 6, 'relevantOccupation', 'relevantOccupation', 'The Occupation for the JobPosting.'),
(305, 1, 6, 'phoneticText', 'phoneticText', 'Representation of a text [[textValue]] using the specified [[speechToTextMarkup]]. For example the city name of Houston in IPA: /ˈhjuːstən/.'),
(306, 1, 6, 'vehicleInteriorColor', 'vehicleInteriorColor', 'The color or color combination of the interior of the vehicle.'),
(307, 1, 6, 'broadcastSubChannel', 'broadcastSubChannel', 'The subchannel used for the broadcast.'),
(308, 1, 6, 'targetPlatform', 'targetPlatform', 'Type of app development: phone, Metro style, desktop, XBox, etc.'),
(309, 1, 6, 'naics', 'naics', 'The North American Industry Classification System (NAICS) code for a particular organization or business person.'),
(310, 1, 6, 'color', 'color', 'The color of the product.'),
(311, 1, 6, 'risks', 'risks', 'Specific physiologic risks associated to the diet plan.'),
(312, 1, 6, 'dateIssued', 'dateIssued', 'The date the ticket was issued.'),
(313, 1, 6, 'propertyID', 'propertyID', 'A commonly used identifier for the characteristic represented by the property, e.g. a manufacturer or a standard code for a property. propertyID can be\n(1) a prefixed string, mainly meant to be used with standards for product properties; (2) a site-specific, non-prefixed string (e.g. the primary key of the property or the vendor-specific ID of the property), or (3)\na URL indicating the type of the property, either pointing to an external vocabulary, or a Web resource that describes the property (e.g. a glossary entry).\nStandards bodies should promote a standard prefix for the identifiers of properties from their standards.'),
(314, 1, 6, 'directors', 'directors', 'A director of e.g. TV, radio, movie, video games etc. content. Directors can be associated with individual items or with a series, episode, clip.'),
(315, 1, 6, 'director', 'director', 'A director of e.g. TV, radio, movie, video gaming etc. content, or of an event. Directors can be associated with individual items or with a series, episode, clip.'),
(316, 1, 6, 'map', 'map', 'A URL to a map of the place.'),
(317, 1, 6, 'hasMap', 'hasMap', 'A URL to a map of the place.'),
(318, 1, 6, 'stageAsNumber', 'stageAsNumber', 'The stage represented as a number, e.g. 3.'),
(319, 1, 6, 'awards', 'awards', 'Awards won by or for this item.'),
(320, 1, 6, 'award', 'award', 'An award won by or for this item.'),
(321, 1, 6, 'associatedDisease', 'associatedDisease', 'Disease associated to this BioChemEntity. Such disease can be a MedicalCondition or a URL. If you want to add an evidence supporting the association, please use PropertyValue.'),
(322, 1, 6, 'amenityFeature', 'amenityFeature', 'An amenity feature (e.g. a characteristic or service) of the Accommodation. This generic property does not make a statement about whether the feature is included in an offer for the main accommodation or available at extra costs.'),
(323, 1, 6, 'birthDate', 'birthDate', 'Date of birth.'),
(324, 1, 6, 'valueMaxLength', 'valueMaxLength', 'Specifies the allowed range for number of characters in a literal value.'),
(325, 1, 6, 'programName', 'programName', 'The program providing the membership.'),
(326, 1, 6, 'isRelatedTo', 'isRelatedTo', 'A pointer to another, somehow related product (or multiple products).'),
(327, 1, 6, 'vehicleModelDate', 'vehicleModelDate', 'The release date of a vehicle model (often used to differentiate versions of the same make and model).'),
(328, 1, 6, 'typicalCreditsPerTerm', 'typicalCreditsPerTerm', 'The number of credits or units a full-time student would be expected to take in 1 term however \'term\' is defined by the institution.'),
(329, 1, 6, 'titleEIDR', 'titleEIDR', 'An [EIDR](https://eidr.org/) (Entertainment Identifier Registry) [[identifier]] representing at the most general/abstract level, a work of film or television.\n\nFor example, the motion picture known as \"Ghostbusters\" has a titleEIDR of  \"10.5240/7EC7-228A-510A-053E-CBB8-J\". This title (or work) may have several variants, which EIDR calls \"edits\". See [[editEIDR]].\n\nSince schema.org types like [[Movie]] and [[TVEpisode]] can be used for both works and their multiple expressions, it is possible to use [[titleEIDR]] alone (for a general description), or alongside [[editEIDR]] for a more edit-specific description.\n'),
(330, 1, 6, 'editEIDR', 'editEIDR', 'An [EIDR](https://eidr.org/) (Entertainment Identifier Registry) [[identifier]] representing a specific edit / edition for a work of film or television.\n\nFor example, the motion picture known as \"Ghostbusters\" whose [[titleEIDR]] is \"10.5240/7EC7-228A-510A-053E-CBB8-J\" has several edits, e.g. \"10.5240/1F2A-E1C5-680A-14C6-E76B-I\" and \"10.5240/8A35-3BEE-6497-5D12-9E4F-3\".\n\nSince schema.org types like [[Movie]] and [[TVEpisode]] can be used for both works and their multiple expressions, it is possible to use [[titleEIDR]] alone (for a general description), or alongside [[editEIDR]] for a more edit-specific description.\n'),
(331, 1, 6, 'embeddedTextCaption', 'embeddedTextCaption', 'Represents textual captioning from a [[MediaObject]], e.g. text of a \'meme\'.'),
(332, 1, 6, 'caption', 'caption', 'The caption for this object. For downloadable machine formats (closed caption, subtitles etc.) use MediaObject and indicate the [[encodingFormat]].'),
(333, 1, 6, 'recommendedIntake', 'recommendedIntake', 'Recommended intake of this supplement for a given population as defined by a specific recommending authority.'),
(334, 1, 6, 'instructor', 'instructor', 'A person assigned to instruct or provide instructional assistance for the [[CourseInstance]].'),
(335, 1, 6, 'administrationRoute', 'administrationRoute', 'A route by which this drug may be administered, e.g. \'oral\'.'),
(336, 1, 6, 'postOp', 'postOp', 'A description of the postoperative procedures, care, and/or followups for this device.'),
(337, 1, 6, 'subStructure', 'subStructure', 'Component (sub-)structure(s) that comprise this anatomical structure.'),
(338, 1, 6, 'isResizable', 'isResizable', 'Whether the 3DModel allows resizing. For example, room layout applications often do not allow 3DModel elements to be resized to reflect reality.'),
(339, 1, 6, 'affectedBy', 'affectedBy', 'Drugs that affect the test\'s results.'),
(340, 1, 6, 'healthPlanPharmacyCategory', 'healthPlanPharmacyCategory', 'The category or type of pharmacy associated with this cost sharing.'),
(341, 1, 6, 'authenticator', 'authenticator', 'The Organization responsible for authenticating the user\'s subscription. For example, many media apps require a cable/satellite provider to authenticate your subscription before playing media.');
INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(342, 1, 6, 'vehicleIdentificationNumber', 'vehicleIdentificationNumber', 'The Vehicle Identification Number (VIN) is a unique serial number used by the automotive industry to identify individual motor vehicles.'),
(343, 1, 6, 'serialNumber', 'serialNumber', 'The serial number or any alphanumeric identifier of a particular product. When attached to an offer, it is a shortcut for the serial number of the product included in the offer.'),
(344, 1, 6, 'coverageStartTime', 'coverageStartTime', 'The time when the live blog will begin covering the Event. Note that coverage may begin before the Event\'s start time. The LiveBlogPosting may also be created before coverage begins.'),
(345, 1, 6, 'contentReferenceTime', 'contentReferenceTime', 'The specific time described by a creative work, for works (e.g. articles, video objects etc.) that emphasise a particular moment within an Event.'),
(346, 1, 6, 'epidemiology', 'epidemiology', 'The characteristics of associated patients, such as age, gender, race etc.'),
(347, 1, 6, 'schoolClosuresInfo', 'schoolClosuresInfo', 'Information about school closures.'),
(348, 1, 6, 'callSign', 'callSign', 'A [callsign](https://en.wikipedia.org/wiki/Call_sign), as used in broadcasting and radio communications to identify people, radio and TV stations, or vehicles.'),
(349, 1, 6, 'acquiredFrom', 'acquiredFrom', 'The organization or person from which the product was acquired.'),
(350, 1, 6, 'branchCode', 'branchCode', 'A short textual code (also called \"store code\") that uniquely identifies a place of business. The code is typically assigned by the parentOrganization and used in structured URLs.\\n\\nFor example, in the URL http://www.starbucks.co.uk/store-locator/etc/detail/3047 the code \"3047\" is a branchCode for a particular branch.\n      '),
(351, 1, 6, 'drug', 'drug', 'Specifying a drug or medicine used in a medication procedure.'),
(352, 1, 6, 'code', 'code', 'A medical code for the entity, taken from a controlled vocabulary or ontology such as ICD-9, DiseasesDB, MeSH, SNOMED-CT, RxNorm, etc.'),
(353, 1, 6, 'codingSystem', 'codingSystem', 'The coding system, e.g. \'ICD-10\'.'),
(354, 1, 6, 'gtin12', 'gtin12', 'The GTIN-12 code of the product, or the product to which the offer refers. The GTIN-12 is the 12-digit GS1 Identification Key composed of a U.P.C. Company Prefix, Item Reference, and Check Digit used to identify trade items. See [GS1 GTIN Summary](http://www.gs1.org/barcodes/technical/idkeys/gtin) for more details.'),
(355, 1, 6, 'gtin', 'gtin', 'A Global Trade Item Number ([GTIN](https://www.gs1.org/standards/id-keys/gtin)). GTINs identify trade items, including products and services, using numeric identification codes.\n\nThe GS1 [digital link specifications](https://www.gs1.org/standards/Digital-Link/) express GTINs as URLs (URIs, IRIs, etc.). Details including regular expression examples can be found in, Section 6 of the GS1 URI Syntax specification; see also [schema.org tracking issue](https://github.com/schemaorg/schemaorg/issues/3156#issuecomment-1209522809) for schema.org-specific discussion. A correct [[gtin]] value should be a valid GTIN, which means that it should be an all-numeric string of either 8, 12, 13 or 14 digits, or a \"GS1 Digital Link\" URL based on such a string. The numeric component should also have a [valid GS1 check digit](https://www.gs1.org/services/check-digit-calculator) and meet the other rules for valid GTINs. See also [GS1\'s GTIN Summary](http://www.gs1.org/barcodes/technical/idkeys/gtin) and [Wikipedia](https://en.wikipedia.org/wiki/Global_Trade_Item_Number) for more details. Left-padding of the gtin values is not required or encouraged. The [[gtin]] property generalizes the earlier [[gtin8]], [[gtin12]], [[gtin13]], and [[gtin14]] properties.\n\nNote also that this is a definition for how to include GTINs in Schema.org data, and not a definition of GTINs in general - see the GS1 documentation for authoritative details.'),
(356, 1, 6, 'applicationStartDate', 'applicationStartDate', 'The date at which the program begins collecting applications for the next enrollment cycle.'),
(357, 1, 6, 'includesObject', 'includesObject', 'This links to a node or nodes indicating the exact quantity of the products included in  an [[Offer]] or [[ProductCollection]].'),
(358, 1, 6, 'volumeNumber', 'volumeNumber', 'Identifies the volume of publication or multi-part work; for example, \"iii\" or \"2\".'),
(359, 1, 6, 'acceptedOffer', 'acceptedOffer', 'The offer(s) -- e.g., product, quantity and price combinations -- included in the order.'),
(360, 1, 6, 'cvdNumC19HospPats', 'cvdNumC19HospPats', 'numc19hosppats - HOSPITALIZED: Patients currently hospitalized in an inpatient care location who have suspected or confirmed COVID-19.'),
(361, 1, 6, 'entertainmentBusiness', 'entertainmentBusiness', 'A sub property of location. The entertainment business where the action occurred.'),
(362, 1, 6, 'educationalLevel', 'educationalLevel', 'The level in terms of progression through an educational or training context. Examples of educational levels include \'beginner\', \'intermediate\' or \'advanced\', and formal sets of level indicators.'),
(363, 1, 6, 'uploadDate', 'uploadDate', 'Date when this media object was uploaded to this site.'),
(364, 1, 6, 'programType', 'programType', 'The type of educational or occupational program. For example, classroom, internship, alternance, etc.'),
(365, 1, 6, 'highPrice', 'highPrice', 'The highest price of all offers available.\\n\\nUsage guidelines:\\n\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.'),
(366, 1, 6, 'byDay', 'byDay', 'Defines the day(s) of the week on which a recurring [[Event]] takes place. May be specified using either [[DayOfWeek]], or alternatively [[Text]] conforming to iCal\'s syntax for byDay recurrence rules.'),
(367, 1, 6, 'additionalProperty', 'additionalProperty', 'A property-value pair representing an additional characteristic of the entity, e.g. a product feature or another characteristic for which there is no matching property in schema.org.\\n\\nNote: Publishers should be aware that applications designed to use specific schema.org properties (e.g. https://schema.org/width, https://schema.org/color, https://schema.org/gtin13, ...) will typically expect such data to be provided using those properties, rather than using the generic property/value mechanism.\n'),
(368, 1, 6, 'catalog', 'catalog', 'A data catalog which contains this dataset.'),
(369, 1, 6, 'includedInDataCatalog', 'includedInDataCatalog', 'A data catalog which contains this dataset.'),
(370, 1, 6, 'seriousAdverseOutcome', 'seriousAdverseOutcome', 'A possible serious complication and/or serious side effect of this therapy. Serious adverse outcomes include those that are life-threatening; result in death, disability, or permanent damage; require hospitalization or prolong existing hospitalization; cause congenital anomalies or birth defects; or jeopardize the patient and may require medical or surgical intervention to prevent one of the outcomes in this definition.'),
(371, 1, 6, 'brand', 'brand', 'The brand(s) associated with a product or service, or the brand(s) maintained by an organization or business person.'),
(372, 1, 6, 'isLiveBroadcast', 'isLiveBroadcast', 'True if the broadcast is of a live event.'),
(373, 1, 6, 'sensoryRequirement', 'sensoryRequirement', 'A description of any sensory requirements and levels necessary to function on the job, including hearing and vision. Defined terms such as those in O*net may be used, but note that there is no way to specify the level of ability as well as its nature when using a defined term.'),
(374, 1, 6, 'linkRelationship', 'linkRelationship', 'Indicates the relationship type of a Web link. '),
(375, 1, 6, 'productSupported', 'productSupported', 'The product or service this support contact point is related to (such as product support for a particular product line). This can be a specific product or product line (e.g. \"iPhone\") or a general category of products or services (e.g. \"smartphones\").'),
(376, 1, 6, 'ccRecipient', 'ccRecipient', 'A sub property of recipient. The recipient copied on a message.'),
(377, 1, 6, 'recipient', 'recipient', 'A sub property of participant. The participant who is at the receiving end of the action.'),
(378, 1, 6, 'occupationalCategory', 'occupationalCategory', 'A category describing the job, preferably using a term from a taxonomy such as [BLS O*NET-SOC](http://www.onetcenter.org/taxonomy.html), [ISCO-08](https://www.ilo.org/public/english/bureau/stat/isco/isco08/) or similar, with the property repeated for each applicable value. Ideally the taxonomy should be identified, and both the textual label and formal code for the category should be provided.\\n\nNote: for historical reasons, any textual label and formal code provided as a literal may be assumed to be from O*NET-SOC.'),
(379, 1, 6, 'responsibilities', 'responsibilities', 'Responsibilities associated with this role or Occupation.'),
(380, 1, 6, 'nonEqual', 'nonEqual', 'This ordering relation for qualitative values indicates that the subject is not equal to the object.'),
(381, 1, 6, 'qualifications', 'qualifications', 'Specific qualifications required for this role or Occupation.'),
(382, 1, 6, 'contactlessPayment', 'contactlessPayment', 'A secure method for consumers to purchase products or services via debit, credit or smartcards by using RFID or NFC technology.'),
(383, 1, 6, 'causeOf', 'causeOf', 'The condition, complication, symptom, sign, etc. caused.'),
(384, 1, 6, 'passengerPriorityStatus', 'passengerPriorityStatus', 'The priority status assigned to a passenger for security or boarding (e.g. FastTrack or Priority).'),
(385, 1, 6, 'freeShippingThreshold', 'freeShippingThreshold', 'A monetary value above (or at) which the shipping rate becomes free. Intended to be used via an [[OfferShippingDetails]] with [[shippingSettingsLink]] matching this [[ShippingRateSettings]].'),
(386, 1, 6, 'marginOfError', 'marginOfError', 'A marginOfError for an [[Observation]].'),
(387, 1, 6, 'pageStart', 'pageStart', 'The page on which the work starts; for example \"135\" or \"xiii\".'),
(388, 1, 6, 'dateRead', 'dateRead', 'The date/time at which the message has been read by the recipient if a single recipient exists.'),
(389, 1, 6, 'tool', 'tool', 'A sub property of instrument. An object used (but not consumed) when performing instructions or a direction.'),
(390, 1, 6, 'priceCurrency', 'priceCurrency', 'The currency of the price, or a price component when attached to [[PriceSpecification]] and its subtypes.\\n\\nUse standard formats: [ISO 4217 currency format](http://en.wikipedia.org/wiki/ISO_4217), e.g. \"USD\"; [Ticker symbol](https://en.wikipedia.org/wiki/List_of_cryptocurrencies) for cryptocurrencies, e.g. \"BTC\"; well known names for [Local Exchange Trading Systems](https://en.wikipedia.org/wiki/Local_exchange_trading_system) (LETS) and other currency types, e.g. \"Ithaca HOUR\".'),
(391, 1, 6, 'merchantReturnDays', 'merchantReturnDays', 'Specifies either a fixed return date or the number of days (from the delivery date) that a product can be returned. Used when the [[returnPolicyCategory]] property is specified as [[MerchantReturnFiniteReturnWindow]].'),
(392, 1, 6, 'sugarContent', 'sugarContent', 'The number of grams of sugar.'),
(393, 1, 6, 'thumbnail', 'thumbnail', 'Thumbnail image for an image or video.'),
(394, 1, 6, 'hasMenuSection', 'hasMenuSection', 'A subgrouping of the menu (by dishes, course, serving time period, etc.).'),
(395, 1, 6, 'loanRepaymentForm', 'loanRepaymentForm', 'A form of paying back money previously borrowed from a lender. Repayment usually takes the form of periodic payments that normally include part principal plus interest in each payment.'),
(396, 1, 6, 'publisherImprint', 'publisherImprint', 'The publishing division which published the comic.'),
(397, 1, 6, 'productionCompany', 'productionCompany', 'The production company or studio responsible for the item, e.g. series, video game, episode etc.'),
(398, 1, 6, 'startTime', 'startTime', 'The startTime of something. For a reserved event or service (e.g. FoodEstablishmentReservation), the time that it is expected to start. For actions that span a period of time, when the action was performed. E.g. John wrote a book from *January* to December. For media, including audio and video, it\'s the time offset of the start of a clip within a larger file.\\n\\nNote that Event uses startDate/endDate instead of startTime/endTime, even when describing dates with times. This situation may be clarified in future revisions.'),
(399, 1, 6, 'contactPoints', 'contactPoints', 'A contact point for a person or organization.'),
(400, 1, 6, 'contactPoint', 'contactPoint', 'A contact point for a person or organization.'),
(401, 1, 6, 'candidate', 'candidate', 'A sub property of object. The candidate subject of this action.'),
(402, 1, 6, 'object', 'object', 'The object upon which the action is carried out, whose state is kept intact or changed. Also known as the semantic roles patient, affected or undergoer (which change their state) or theme (which doesn\'t). E.g. John read *a book*.'),
(403, 1, 6, 'netWorth', 'netWorth', 'The total financial value of the person as calculated by subtracting assets from liabilities.'),
(404, 1, 6, 'recordLabel', 'recordLabel', 'The label that issued the release.'),
(405, 1, 6, 'offerCount', 'offerCount', 'The number of offers for the product.'),
(406, 1, 6, 'seasons', 'seasons', 'A season in a media series.'),
(407, 1, 6, 'season', 'season', 'A season in a media series.'),
(408, 1, 6, 'status', 'status', 'The status of the study (enumerated).'),
(409, 1, 6, 'includedComposition', 'includedComposition', 'Smaller compositions included in this work (e.g. a movement in a symphony).'),
(410, 1, 6, 'inventoryLevel', 'inventoryLevel', 'The current approximate inventory level for the item or items.'),
(411, 1, 6, 'isPlanForApartment', 'isPlanForApartment', 'Indicates some accommodation that this floor plan describes.'),
(412, 1, 6, 'teaches', 'teaches', 'The item being described is intended to help a person learn the competency or learning outcome defined by the referenced term.'),
(413, 1, 6, 'numberedPosition', 'numberedPosition', 'A number associated with a role in an organization, for example, the number on an athlete\'s jersey.'),
(414, 1, 6, 'governmentBenefitsInfo', 'governmentBenefitsInfo', 'governmentBenefitsInfo provides information about government benefits associated with a SpecialAnnouncement.'),
(415, 1, 6, 'cvdNumC19OverflowPats', 'cvdNumC19OverflowPats', 'numc19overflowpats - ED/OVERFLOW: Patients with suspected or confirmed COVID-19 who are in the ED or any overflow location awaiting an inpatient bed.'),
(416, 1, 6, 'procedure', 'procedure', 'A description of the procedure involved in setting up, using, and/or installing the device.'),
(417, 1, 6, 'paymentUrl', 'paymentUrl', 'The URL for sending a payment.'),
(418, 1, 6, 'endTime', 'endTime', 'The endTime of something. For a reserved event or service (e.g. FoodEstablishmentReservation), the time that it is expected to end. For actions that span a period of time, when the action was performed. E.g. John wrote a book from January to *December*. For media, including audio and video, it\'s the time offset of the end of a clip within a larger file.\\n\\nNote that Event uses startDate/endDate instead of startTime/endTime, even when describing dates with times. This situation may be clarified in future revisions.'),
(419, 1, 6, 'itemListElement', 'itemListElement', 'For itemListElement values, you can use simple strings (e.g. \"Peter\", \"Paul\", \"Mary\"), existing entities, or use ListItem.\\n\\nText values are best if the elements in the list are plain strings. Existing entities are best for a simple, unordered list of existing things in your data. ListItem is used with ordered lists when you want to provide additional context about the element in that list or when the same item might be in different places in different lists.\\n\\nNote: The order of elements in your mark-up is not sufficient for indicating the order or elements.  Use ListItem with a \'position\' property in such cases.'),
(420, 1, 6, 'successorOf', 'successorOf', 'A pointer from a newer variant of a product  to its previous, often discontinued predecessor.'),
(421, 1, 6, 'cvdNumVent', 'cvdNumVent', 'numvent - MECHANICAL VENTILATORS: Total number of ventilators available.'),
(422, 1, 6, 'numberOfRooms', 'numberOfRooms', 'The number of rooms (excluding bathrooms and closets) of the accommodation or lodging business.\nTypical unit code(s): ROM for room or C62 for no unit. The type of room can be put in the unitText property of the QuantitativeValue.'),
(423, 1, 6, 'potentialUse', 'potentialUse', 'Intended use of the BioChemEntity by humans.'),
(424, 1, 6, 'characterAttribute', 'characterAttribute', 'A piece of data that represents a particular aspect of a fictional character (skill, power, character points, advantage, disadvantage).'),
(425, 1, 6, 'chemicalComposition', 'chemicalComposition', 'The chemical composition describes the identity and relative ratio of the chemical elements that make up the substance.'),
(426, 1, 6, 'numberOfSeasons', 'numberOfSeasons', 'The number of seasons in this series.'),
(427, 1, 6, 'offersPrescriptionByMail', 'offersPrescriptionByMail', 'Whether prescriptions can be delivered by mail.'),
(428, 1, 6, 'lyricist', 'lyricist', 'The person who wrote the words.'),
(429, 1, 6, 'sdPublisher', 'sdPublisher', 'Indicates the party responsible for generating and publishing the current structured data markup, typically in cases where the structured data is derived automatically from existing published content but published on a different site. For example, student projects and open data initiatives often re-publish existing content with more explicitly structured metadata. The\n[[sdPublisher]] property helps make such practices more explicit.'),
(430, 1, 6, 'isAvailableGenerically', 'isAvailableGenerically', 'True if the drug is available in a generic form (regardless of name).'),
(431, 1, 6, 'algorithm', 'algorithm', 'The algorithm or rules to follow to compute the score.'),
(432, 1, 6, 'includedRiskFactor', 'includedRiskFactor', 'A modifiable or non-modifiable risk factor included in the calculation, e.g. age, coexisting condition.'),
(433, 1, 6, 'colorist', 'colorist', 'The individual who adds color to inked drawings.'),
(434, 1, 6, 'recipeInstructions', 'recipeInstructions', 'A step in making the recipe, in the form of a single item (document, video, etc.) or an ordered list with HowToStep and/or HowToSection items.'),
(435, 1, 6, 'repeatFrequency', 'repeatFrequency', 'Defines the frequency at which [[Event]]s will occur according to a schedule [[Schedule]]. The intervals between\n      events should be defined as a [[Duration]] of time.'),
(436, 1, 6, 'frequency', 'frequency', 'How often the dose is taken, e.g. \'daily\'.'),
(437, 1, 6, 'beneficiaryBank', 'beneficiaryBank', 'A bank or bank’s branch, financial institution or international financial institution operating the beneficiary’s bank account or releasing funds for the beneficiary.'),
(438, 1, 6, 'arrivalGate', 'arrivalGate', 'Identifier of the flight\'s arrival gate.'),
(439, 1, 6, 'contentType', 'contentType', 'The supported content type(s) for an EntryPoint response.'),
(440, 1, 6, 'arrivalBoatTerminal', 'arrivalBoatTerminal', 'The terminal or port from which the boat arrives.'),
(441, 1, 6, 'address', 'address', 'Physical address of the item.'),
(442, 1, 6, 'checkoutTime', 'checkoutTime', 'The latest someone may check out of a lodging establishment.'),
(443, 1, 6, 'billingAddress', 'billingAddress', 'The billing address for the order.'),
(444, 1, 6, 'eventSchedule', 'eventSchedule', 'Associates an [[Event]] with a [[Schedule]]. There are circumstances where it is preferable to share a schedule for a series of\n      repeating events rather than data on the individual events themselves. For example, a website or application might prefer to publish a schedule for a weekly\n      gym class rather than provide data on every event. A schedule could be processed by applications to add forthcoming events to a calendar. An [[Event]] that\n      is associated with a [[Schedule]] using this property should not have [[startDate]] or [[endDate]] properties. These are instead defined within the associated\n      [[Schedule]], this avoids any ambiguity for clients using the data. The property might have repeated values to specify different schedules, e.g. for different months\n      or seasons.'),
(445, 1, 6, 'validThrough', 'validThrough', 'The date after when the item is not valid. For example the end of an offer, salary period, or a period of opening hours.'),
(446, 1, 6, 'warrantyPromise', 'warrantyPromise', 'The warranty promise(s) included in the offer.'),
(447, 1, 6, 'warranty', 'warranty', 'The warranty promise(s) included in the offer.'),
(448, 1, 6, 'relatedTherapy', 'relatedTherapy', 'A medical therapy related to this anatomy.'),
(449, 1, 6, 'slogan', 'slogan', 'A slogan or motto associated with the item.'),
(450, 1, 6, 'employmentUnit', 'employmentUnit', 'Indicates the department, unit and/or facility where the employee reports and/or in which the job is to be performed.'),
(451, 1, 6, 'geographicArea', 'geographicArea', 'The geographic area associated with the audience.'),
(452, 1, 6, 'inverseOf', 'inverseOf', 'Relates a property to a property that is its inverse. Inverse properties relate the same pairs of items to each other, but in reversed direction. For example, the \'alumni\' and \'alumniOf\' properties are inverseOf each other. Some properties don\'t have explicit inverses; in these situations RDFa and JSON-LD syntax for reverse properties can be used.'),
(453, 1, 6, 'broadcastTimezone', 'broadcastTimezone', 'The timezone in [ISO 8601 format](http://en.wikipedia.org/wiki/ISO_8601) for which the service bases its broadcasts.'),
(454, 1, 6, 'timeOfDay', 'timeOfDay', 'The time of day the program normally runs. For example, \"evenings\".'),
(455, 1, 6, 'bestRating', 'bestRating', 'The highest value allowed in this rating system. If bestRating is omitted, 5 is assumed.'),
(456, 1, 6, 'processingTime', 'processingTime', 'Estimated processing time for the service using this channel.'),
(457, 1, 6, 'membershipPointsEarned', 'membershipPointsEarned', 'The number of membership points earned by the member. If necessary, the unitText can be used to express the units the points are issued in. (E.g. stars, miles, etc.)'),
(458, 1, 6, 'elevation', 'elevation', 'The elevation of a location ([WGS 84](https://en.wikipedia.org/wiki/World_Geodetic_System)). Values may be of the form \'NUMBER UNIT\\_OF\\_MEASUREMENT\' (e.g., \'1,000 m\', \'3,200 ft\') while numbers alone should be assumed to be a value in meters.'),
(459, 1, 6, 'creditedTo', 'creditedTo', 'The group the release is credited to if different than the byArtist. For example, Red and Blue is credited to \"Stefani Germanotta Band\", but by Lady Gaga.'),
(460, 1, 6, 'sport', 'sport', 'A type of sport (e.g. Baseball).'),
(461, 1, 6, 'seeks', 'seeks', 'A pointer to products or services sought by the organization or person (demand).'),
(462, 1, 6, 'additionalName', 'additionalName', 'An additional name for a Person, can be used for a middle name.'),
(463, 1, 6, 'alternateName', 'alternateName', 'An alias for the item.'),
(464, 1, 6, 'downPayment', 'downPayment', 'a type of payment made in cash during the onset of the purchase of an expensive good/service. The payment typically represents only a percentage of the full purchase price.'),
(465, 1, 6, 'postOfficeBoxNumber', 'postOfficeBoxNumber', 'The post office box number for PO box addresses.'),
(466, 1, 6, 'energyEfficiencyScaleMax', 'energyEfficiencyScaleMax', 'Specifies the most energy efficient class on the regulated EU energy consumption scale for the product category a product belongs to. For example, energy consumption for televisions placed on the market after January 1, 2020 is scaled from D to A+++.'),
(467, 1, 6, 'userInteractionCount', 'userInteractionCount', 'The number of interactions for the CreativeWork using the WebSite or SoftwareApplication.'),
(468, 1, 6, 'sizeGroup', 'sizeGroup', 'The size group (also known as \"size type\") for a product\'s size. Size groups are common in the fashion industry to define size segments and suggested audiences for wearable products. Multiple values can be combined, for example \"men\'s big and tall\", \"petite maternity\" or \"regular\"'),
(469, 1, 6, 'productionDate', 'productionDate', 'The date of production of the item, e.g. vehicle.'),
(470, 1, 6, 'hostingOrganization', 'hostingOrganization', 'The organization (airline, travelers\' club, etc.) the membership is made with.'),
(471, 1, 6, 'addOn', 'addOn', 'An additional offer that can only be obtained in combination with the first base offer (e.g. supplements and extensions that are available for a surcharge).'),
(472, 1, 6, 'hasOfferCatalog', 'hasOfferCatalog', 'Indicates an OfferCatalog listing for this Organization, Person, or Service.'),
(473, 1, 6, 'shippingDetails', 'shippingDetails', 'Indicates information about the shipping policies and options associated with an [[Offer]].'),
(474, 1, 6, 'seasonNumber', 'seasonNumber', 'Position of the season within an ordered group of seasons.'),
(475, 1, 6, 'loanType', 'loanType', 'The type of a loan or credit.'),
(476, 1, 6, 'documentation', 'documentation', 'Further documentation describing the Web API in more detail.'),
(477, 1, 6, 'domiciledMortgage', 'domiciledMortgage', 'Whether borrower is a resident of the jurisdiction where the property is located.'),
(478, 1, 6, 'drugUnit', 'drugUnit', 'The unit in which the drug is measured, e.g. \'5 mg tablet\'.'),
(479, 1, 6, 'physicalRequirement', 'physicalRequirement', 'A description of the types of physical activity associated with the job. Defined terms such as those in O*net may be used, but note that there is no way to specify the level of ability as well as its nature when using a defined term.'),
(480, 1, 6, 'numberOfCredits', 'numberOfCredits', 'The number of credits or units awarded by a Course or required to complete an EducationalOccupationalProgram.'),
(481, 1, 6, 'funder', 'funder', 'A person or organization that supports (sponsors) something through some kind of financial contribution.'),
(482, 1, 6, 'sponsor', 'sponsor', 'A person or organization that supports a thing through a pledge, promise, or financial contribution. E.g. a sponsor of a Medical Study or a corporate sponsor of an event.'),
(483, 1, 6, 'nonProprietaryName', 'nonProprietaryName', 'The generic name of this drug or supplement.'),
(484, 1, 6, 'returnPolicyCountry', 'returnPolicyCountry', 'The country where the product has to be sent to for returns, for example \"Ireland\" using the [[name]] property of [[Country]]. You can also provide the two-letter [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1). Note that this can be different from the country where the product was originally shipped from or sent to.'),
(485, 1, 6, 'screenCount', 'screenCount', 'The number of screens in the movie theater.'),
(486, 1, 6, 'cashBack', 'cashBack', 'A cardholder benefit that pays the cardholder a small percentage of their net expenditures.'),
(487, 1, 6, 'underName', 'underName', 'The person or organization the reservation or ticket is for.'),
(488, 1, 6, 'logo', 'logo', 'An associated logo.'),
(489, 1, 6, 'image', 'image', 'An image of the item. This can be a [[URL]] or a fully described [[ImageObject]].'),
(490, 1, 6, 'domainIncludes', 'domainIncludes', 'Relates a property to a class that is (one of) the type(s) the property is expected to be used on.'),
(491, 1, 6, 'inChI', 'inChI', 'Non-proprietary identifier for molecular entity that can be used in printed and electronic data sources thus enabling easier linking of diverse data compilations.'),
(492, 1, 6, 'quarantineGuidelines', 'quarantineGuidelines', 'Guidelines about quarantine rules, e.g. in the context of a pandemic.'),
(493, 1, 6, 'discountCode', 'discountCode', 'Code used to redeem a discount.'),
(494, 1, 6, 'musicalKey', 'musicalKey', 'The key, mode, or scale this composition uses.'),
(495, 1, 6, 'productID', 'productID', 'The product identifier, such as ISBN. For example: ``` meta itemprop=\"productID\" content=\"isbn:123-456-789\" ```.'),
(496, 1, 6, 'breastfeedingWarning', 'breastfeedingWarning', 'Any precaution, guidance, contraindication, etc. related to this drug\'s use by breastfeeding mothers.'),
(497, 1, 6, 'relatedStructure', 'relatedStructure', 'Related anatomical structure(s) that are not part of the system but relate or connect to it, such as vascular bundles associated with an organ system.'),
(498, 1, 6, 'currency', 'currency', 'The currency in which the monetary amount is expressed.\\n\\nUse standard formats: [ISO 4217 currency format](http://en.wikipedia.org/wiki/ISO_4217), e.g. \"USD\"; [Ticker symbol](https://en.wikipedia.org/wiki/List_of_cryptocurrencies) for cryptocurrencies, e.g. \"BTC\"; well known names for [Local Exchange Trading Systems](https://en.wikipedia.org/wiki/Local_exchange_trading_system) (LETS) and other currency types, e.g. \"Ithaca HOUR\".'),
(499, 1, 6, 'cvdNumC19MechVentPats', 'cvdNumC19MechVentPats', 'numc19mechventpats - HOSPITALIZED and VENTILATED: Patients hospitalized in an NHSN inpatient care location who have suspected or confirmed COVID-19 and are on a mechanical ventilator.'),
(500, 1, 6, 'ethicsPolicy', 'ethicsPolicy', 'Statement about ethics policy, e.g. of a [[NewsMediaOrganization]] regarding journalistic and publishing practices, or of a [[Restaurant]], a page describing food source policies. In the case of a [[NewsMediaOrganization]], an ethicsPolicy is typically a statement describing the personal, organizational, and corporate standards of behavior expected by the organization.'),
(501, 1, 6, 'refundType', 'refundType', 'A refund type, from an enumerated list.'),
(502, 1, 6, 'postalCodeRange', 'postalCodeRange', 'A defined range of postal codes.'),
(503, 1, 6, 'recognizedBy', 'recognizedBy', 'An organization that acknowledges the validity, value or utility of a credential. Note: recognition may include a process of quality assurance or accreditation.'),
(504, 1, 6, 'workPerformed', 'workPerformed', 'A work performed in some event, for example a play performed in a TheaterEvent.'),
(505, 1, 6, 'workFeatured', 'workFeatured', 'A work featured in some event, e.g. exhibited in an ExhibitionEvent.\n       Specific subproperties are available for workPerformed (e.g. a play), or a workPresented (a Movie at a ScreeningEvent).'),
(506, 1, 6, 'mentions', 'mentions', 'Indicates that the CreativeWork contains a reference to, but is not necessarily about a concept.'),
(507, 1, 6, 'customerRemorseReturnLabelSource', 'customerRemorseReturnLabelSource', 'The method (from an enumeration) by which the customer obtains a return shipping label for a product returned due to customer remorse.'),
(508, 1, 6, 'legislationConsolidates', 'legislationConsolidates', 'Indicates another legislation taken into account in this consolidated legislation (which is usually the product of an editorial process that revises the legislation). This property should be used multiple times to refer to both the original version or the previous consolidated version, and to the legislations making the change.'),
(509, 1, 6, 'aggregateRating', 'aggregateRating', 'The overall rating, based on a collection of reviews or ratings, of the item.'),
(510, 1, 6, 'itinerary', 'itinerary', 'Destination(s) ( [[Place]] ) that make up a trip. For a trip where destination order is important use [[ItemList]] to specify that order (see examples).'),
(511, 1, 6, 'globalLocationNumber', 'globalLocationNumber', 'The [Global Location Number](http://www.gs1.org/gln) (GLN, sometimes also referred to as International Location Number or ILN) of the respective organization, person, or place. The GLN is a 13-digit number used to identify parties and physical locations.'),
(512, 1, 6, 'applicantLocationRequirements', 'applicantLocationRequirements', 'The location(s) applicants can apply from. This is usually used for telecommuting jobs where the applicant does not need to be in a physical office. Note: This should not be used for citizenship or work visa requirements.'),
(513, 1, 6, 'unitCode', 'unitCode', 'The unit of measurement given using the UN/CEFACT Common Code (3 characters) or a URL. Other codes than the UN/CEFACT Common Code may be used with a prefix followed by a colon.'),
(514, 1, 6, 'parents', 'parents', 'A parents of the person.'),
(515, 1, 6, 'parent', 'parent', 'A parent of this person.'),
(516, 1, 6, 'renegotiableLoan', 'renegotiableLoan', 'Whether the terms for payment of interest can be renegotiated during the life of the loan.'),
(517, 1, 6, 'priceComponent', 'priceComponent', 'This property links to all [[UnitPriceSpecification]] nodes that apply in parallel for the [[CompoundPriceSpecification]] node.'),
(518, 1, 6, 'eligibleDuration', 'eligibleDuration', 'The duration for which the given offer is valid.'),
(519, 1, 6, 'copyrightYear', 'copyrightYear', 'The year during which the claimed copyright for the CreativeWork was first asserted.'),
(520, 1, 6, 'trialDesign', 'trialDesign', 'Specifics about the trial design (enumerated).'),
(521, 1, 6, 'serviceAudience', 'serviceAudience', 'The audience eligible for this service.'),
(522, 1, 6, 'audience', 'audience', 'An intended audience, i.e. a group for whom something was created.'),
(523, 1, 6, 'vehicleSpecialUsage', 'vehicleSpecialUsage', 'Indicates whether the vehicle has been used for special purposes, like commercial rental, driving school, or as a taxi. The legislation in many countries requires this information to be revealed when offering a car for sale.'),
(524, 1, 6, 'comment', 'comment', 'Comments, typically from users.'),
(525, 1, 6, 'publicationType', 'publicationType', 'The type of the medical article, taken from the US NLM MeSH publication type catalog. See also [MeSH documentation](http://www.nlm.nih.gov/mesh/pubtypes.html).'),
(526, 1, 6, 'availableIn', 'availableIn', 'The location in which the strength is available.'),
(527, 1, 6, 'legislationIdentifier', 'legislationIdentifier', 'An identifier for the legislation. This can be either a string-based identifier, like the CELEX at EU level or the NOR in France, or a web-based, URL/URI identifier, like an ELI (European Legislation Identifier) or an URN-Lex.'),
(528, 1, 6, 'discount', 'discount', 'Any discount applied (to an Order).'),
(529, 1, 6, 'model', 'model', 'The model of the product. Use with the URL of a ProductModel or a textual representation of the model identifier. The URL of the ProductModel can be from an external source. It is recommended to additionally provide strong product identifiers via the gtin8/gtin13/gtin14 and mpn properties.'),
(530, 1, 6, 'numberOfEpisodes', 'numberOfEpisodes', 'The number of episodes in this season or series.'),
(531, 1, 6, 'deathDate', 'deathDate', 'Date of death.'),
(532, 1, 6, 'servingSize', 'servingSize', 'The serving size, in terms of the number of volume or mass.'),
(533, 1, 6, 'ownershipFundingInfo', 'ownershipFundingInfo', 'For an [[Organization]] (often but not necessarily a [[NewsMediaOrganization]]), a description of organizational ownership structure; funding and grants. In a news/media setting, this is with particular reference to editorial independence.   Note that the [[funder]] is also available and can be used to make basic funder information machine-readable.'),
(534, 1, 6, 'playerType', 'playerType', 'Player type required&#x2014;for example, Flash or Silverlight.'),
(535, 1, 6, 'priceComponentType', 'priceComponentType', 'Identifies a price component (for example, a line item on an invoice), part of the total price for an offer.'),
(536, 1, 6, 'abridged', 'abridged', 'Indicates whether the book is an abridged edition.'),
(537, 1, 6, 'reviewAspect', 'reviewAspect', 'This Review or Rating is relevant to this part or facet of the itemReviewed.'),
(538, 1, 6, 'advanceBookingRequirement', 'advanceBookingRequirement', 'The amount of time that is required between accepting the offer and the actual usage of the resource or service.'),
(539, 1, 6, 'sender', 'sender', 'A sub property of participant. The participant who is at the sending end of the action.'),
(540, 1, 6, 'participant', 'participant', 'Other co-agents that participated in the action indirectly. E.g. John wrote a book with *Steve*.'),
(541, 1, 6, 'ingredients', 'ingredients', 'A single ingredient used in the recipe, e.g. sugar, flour or garlic.'),
(542, 1, 6, 'recipeIngredient', 'recipeIngredient', 'A single ingredient used in the recipe, e.g. sugar, flour or garlic.'),
(543, 1, 6, 'supply', 'supply', 'A sub-property of instrument. A supply consumed when performing instructions or a direction.'),
(544, 1, 6, 'area', 'area', 'The area within which users can expect to reach the broadcast service.'),
(545, 1, 6, 'serviceArea', 'serviceArea', 'The geographic area where the service is provided.'),
(546, 1, 6, 'downvoteCount', 'downvoteCount', 'The number of downvotes this question, answer or comment has received from the community.'),
(547, 1, 6, 'children', 'children', 'A child of the person.'),
(548, 1, 6, 'arrivalPlatform', 'arrivalPlatform', 'The platform where the train arrives.'),
(549, 1, 6, 'firstPerformance', 'firstPerformance', 'The date and place the work was first performed.'),
(550, 1, 6, 'ratingValue', 'ratingValue', 'The rating for the content.\\n\\nUsage guidelines:\\n\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.'),
(551, 1, 6, 'collectionSize', 'collectionSize', 'The number of items in the [[Collection]].'),
(552, 1, 6, 'resultReview', 'resultReview', 'A sub property of result. The review that resulted in the performing of the action.'),
(553, 1, 6, 'result', 'result', 'The result produced in the action. E.g. John wrote *a book*.'),
(554, 1, 6, 'albums', 'albums', 'A collection of music albums.'),
(555, 1, 6, 'album', 'album', 'A music album.'),
(556, 1, 6, 'datePublished', 'datePublished', 'Date of first broadcast/publication.'),
(557, 1, 6, 'includesAttraction', 'includesAttraction', 'Attraction located at destination.'),
(558, 1, 6, 'publishedOn', 'publishedOn', 'A broadcast service associated with the publication event.'),
(559, 1, 6, 'actionStatus', 'actionStatus', 'Indicates the current disposition of the Action.'),
(560, 1, 6, 'orderDate', 'orderDate', 'Date order was placed.'),
(561, 1, 6, 'prescribingInfo', 'prescribingInfo', 'Link to prescribing information for the drug.'),
(562, 1, 6, 'contributor', 'contributor', 'A secondary contributor to the CreativeWork or Event.'),
(563, 1, 6, 'yearBuilt', 'yearBuilt', 'The year an [[Accommodation]] was constructed. This corresponds to the [YearBuilt field in RESO](https://ddwiki.reso.org/display/DDW17/YearBuilt+Field). '),
(564, 1, 6, 'trainingSalary', 'trainingSalary', 'The estimated salary earned while in the program.'),
(565, 1, 6, 'orderQuantity', 'orderQuantity', 'The number of the item ordered. If the property is not set, assume the quantity is one.'),
(566, 1, 6, 'bioChemInteraction', 'bioChemInteraction', 'A BioChemEntity that is known to interact with this item.'),
(567, 1, 6, 'healthPlanId', 'healthPlanId', 'The 14-character, HIOS-generated Plan ID number. (Plan IDs must be unique, even across different markets.)'),
(568, 1, 6, 'valuePattern', 'valuePattern', 'Specifies a regular expression for testing literal values according to the HTML spec.'),
(569, 1, 6, 'orderItemNumber', 'orderItemNumber', 'The identifier of the order item.'),
(570, 1, 6, 'accommodationCategory', 'accommodationCategory', 'Category of an [[Accommodation]], following real estate conventions, e.g. RESO (see [PropertySubType](https://ddwiki.reso.org/display/DDW17/PropertySubType+Field), and [PropertyType](https://ddwiki.reso.org/display/DDW17/PropertyType+Field) fields  for suggested values).'),
(571, 1, 6, 'category', 'category', 'A category for the item. Greater signs or slashes can be used to informally indicate a category hierarchy.'),
(572, 1, 6, 'sdLicense', 'sdLicense', 'A license document that applies to this structured data, typically indicated by URL.'),
(573, 1, 6, 'broadcastFrequency', 'broadcastFrequency', 'The frequency used for over-the-air broadcasts. Numeric values or simple ranges, e.g. 87-99. In addition a shortcut idiom is supported for frequences of AM and FM radio channels, e.g. \"87 FM\".'),
(574, 1, 6, 'abstract', 'abstract', 'An abstract is a short description that summarizes a [[CreativeWork]].'),
(575, 1, 6, 'floorSize', 'floorSize', 'The size of the accommodation, e.g. in square meter or squarefoot.\nTypical unit code(s): MTK for square meter, FTK for square foot, or YDK for square yard '),
(576, 1, 6, 'measurementTechnique', 'measurementTechnique', 'A technique or technology used in a [[Dataset]] (or [[DataDownload]], [[DataCatalog]]),\ncorresponding to the method used for measuring the corresponding variable(s) (described using [[variableMeasured]]). This is oriented towards scientific and scholarly dataset publication but may have broader applicability; it is not intended as a full representation of measurement, but rather as a high level summary for dataset discovery.\n\nFor example, if [[variableMeasured]] is: molecule concentration, [[measurementTechnique]] could be: \"mass spectrometry\" or \"nmr spectroscopy\" or \"colorimetry\" or \"immunofluorescence\".\n\nIf the [[variableMeasured]] is \"depression rating\", the [[measurementTechnique]] could be \"Zung Scale\" or \"HAM-D\" or \"Beck Depression Inventory\".\n\nIf there are several [[variableMeasured]] properties recorded for some given data object, use a [[PropertyValue]] for each [[variableMeasured]] and attach the corresponding [[measurementTechnique]].\n      '),
(577, 1, 6, 'seatRow', 'seatRow', 'The row location of the reserved seat (e.g., B).'),
(578, 1, 6, 'programPrerequisites', 'programPrerequisites', 'Prerequisites for enrolling in the program.'),
(579, 1, 6, 'endOffset', 'endOffset', 'The end time of the clip expressed as the number of seconds from the beginning of the work.'),
(580, 1, 6, 'associatedClaimReview', 'associatedClaimReview', 'An associated [[ClaimReview]], related by specific common content, topic or claim. The expectation is that this property would be most typically used in cases where a single activity is conducting both claim reviews and media reviews, in which case [[relatedMediaReview]] would commonly be used on a [[ClaimReview]], while [[relatedClaimReview]] would be used on [[MediaReview]].'),
(581, 1, 6, 'application', 'application', 'An application that can complete the request.'),
(582, 1, 6, 'actionApplication', 'actionApplication', 'An application that can complete the request.'),
(583, 1, 6, 'cookTime', 'cookTime', 'The time it takes to actually cook the dish, in [ISO 8601 duration format](http://en.wikipedia.org/wiki/ISO_8601).'),
(584, 1, 6, 'performTime', 'performTime', 'The length of time it takes to perform instructions or a direction (not including time to prepare the supplies), in [ISO 8601 duration format](http://en.wikipedia.org/wiki/ISO_8601).'),
(585, 1, 6, 'availableChannel', 'availableChannel', 'A means of accessing the service (e.g. a phone bank, a web site, a location, etc.).'),
(586, 1, 6, 'seatNumber', 'seatNumber', 'The location of the reserved seat (e.g., 27).'),
(587, 1, 6, 'costCategory', 'costCategory', 'The category of cost, such as wholesale, retail, reimbursement cap, etc.'),
(588, 1, 6, 'associatedAnatomy', 'associatedAnatomy', 'The anatomy of the underlying organ system or structures associated with this entity.'),
(589, 1, 6, 'homeTeam', 'homeTeam', 'The home team in a sports event.'),
(590, 1, 6, 'competitor', 'competitor', 'A competitor in a sports event.'),
(591, 1, 6, 'iswcCode', 'iswcCode', 'The International Standard Musical Work Code for the composition.'),
(592, 1, 6, 'inChIKey', 'inChIKey', 'InChIKey is a hashed version of the full InChI (using the SHA-256 algorithm).'),
(593, 1, 6, 'gameAvailabilityType', 'gameAvailabilityType', 'Indicates the availability type of the game content associated with this action, such as whether it is a full version or a demo.'),
(594, 1, 6, 'publishedBy', 'publishedBy', 'An agent associated with the publication event.'),
(595, 1, 6, 'shippingOrigin', 'shippingOrigin', 'Indicates the origin of a shipment, i.e. where it should be coming from.'),
(596, 1, 6, 'requirements', 'requirements', 'Component dependency requirements for application. This includes runtime environments and shared libraries that are not included in the application distribution package, but required to run the application (examples: DirectX, Java or .NET runtime).'),
(597, 1, 6, 'softwareRequirements', 'softwareRequirements', 'Component dependency requirements for application. This includes runtime environments and shared libraries that are not included in the application distribution package, but required to run the application (examples: DirectX, Java or .NET runtime).'),
(598, 1, 6, 'thumbnailUrl', 'thumbnailUrl', 'A thumbnail image relevant to the Thing.'),
(599, 1, 6, 'newsUpdatesAndGuidelines', 'newsUpdatesAndGuidelines', 'Indicates a page with news updates and guidelines. This could often be (but is not required to be) the main page containing [[SpecialAnnouncement]] markup on a site.'),
(600, 1, 6, 'priceSpecification', 'priceSpecification', 'One or more detailed price specifications, indicating the unit price and delivery or payment charges.'),
(601, 1, 6, 'availableStrength', 'availableStrength', 'An available dosage strength for the drug.'),
(602, 1, 6, 'musicArrangement', 'musicArrangement', 'An arrangement derived from the composition.'),
(603, 1, 6, 'healthPlanCoinsuranceOption', 'healthPlanCoinsuranceOption', 'Whether the coinsurance applies before or after deductible, etc. TODO: Is this a closed set?'),
(604, 1, 6, 'datePosted', 'datePosted', 'Publication date of an online listing.'),
(605, 1, 6, 'reviews', 'reviews', 'Review of the item.'),
(606, 1, 6, 'review', 'review', 'A review of the item.'),
(607, 1, 6, 'validUntil', 'validUntil', 'The date when the item is no longer valid.'),
(608, 1, 6, 'requiresSubscription', 'requiresSubscription', 'Indicates if use of the media require a subscription  (either paid or free). Allowed values are ```true``` or ```false``` (note that an earlier version had \'yes\', \'no\').'),
(609, 1, 6, 'ratingCount', 'ratingCount', 'The count of total number of ratings.'),
(610, 1, 6, 'expectedArrivalFrom', 'expectedArrivalFrom', 'The earliest date the package may arrive.'),
(611, 1, 6, 'version', 'version', 'The version of the CreativeWork embodied by a specified resource.'),
(612, 1, 6, 'dropoffTime', 'dropoffTime', 'When a rental car can be dropped off.'),
(613, 1, 6, 'infectiousAgentClass', 'infectiousAgentClass', 'The class of infectious agent (bacteria, prion, etc.) that causes the disease.'),
(614, 1, 6, 'doseValue', 'doseValue', 'The value of the dose, e.g. 500.'),
(615, 1, 6, 'cvdNumC19Died', 'cvdNumC19Died', 'numc19died - DEATHS: Patients with suspected or confirmed COVID-19 who died in the hospital, ED, or any overflow location.'),
(616, 1, 6, 'alternativeHeadline', 'alternativeHeadline', 'A secondary title of the CreativeWork.'),
(617, 1, 6, 'longitude', 'longitude', 'The longitude of a location. For example ```-122.08585``` ([WGS 84](https://en.wikipedia.org/wiki/World_Geodetic_System)).'),
(618, 1, 6, 'energyEfficiencyScaleMin', 'energyEfficiencyScaleMin', 'Specifies the least energy efficient class on the regulated EU energy consumption scale for the product category a product belongs to. For example, energy consumption for televisions placed on the market after January 1, 2020 is scaled from D to A+++.'),
(619, 1, 6, 'appliesToPaymentMethod', 'appliesToPaymentMethod', 'The payment method(s) to which the payment charge specification applies.'),
(620, 1, 6, 'credentialCategory', 'credentialCategory', 'The category or type of credential being described, for example \"degree”, “certificate”, “badge”, or more specific term.'),
(621, 1, 6, 'appliesToDeliveryMethod', 'appliesToDeliveryMethod', 'The delivery method(s) to which the delivery charge or payment charge specification applies.'),
(622, 1, 6, 'targetName', 'targetName', 'The name of a node in an established educational framework.'),
(623, 1, 6, 'repetitions', 'repetitions', 'Number of times one should repeat the activity.'),
(624, 1, 6, 'originatesFrom', 'originatesFrom', 'The vasculature the lymphatic structure originates, or afferents, from.'),
(625, 1, 6, 'positiveNotes', 'positiveNotes', 'Provides positive considerations regarding something, for example product highlights or (alongside [[negativeNotes]]) pro/con lists for reviews.\n\nIn the case of a [[Review]], the property describes the [[itemReviewed]] from the perspective of the review; in the case of a [[Product]], the product itself is being described.\n\nThe property values can be expressed either as unstructured text (repeated as necessary), or if ordered, as a list (in which case the most positive is at the beginning of the list).'),
(626, 1, 6, 'passengerSequenceNumber', 'passengerSequenceNumber', 'The passenger\'s sequence number as assigned by the airline.'),
(627, 1, 6, 'clipNumber', 'clipNumber', 'Position of the clip within an ordered group of clips.');
INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(628, 1, 6, 'gtin13', 'gtin13', 'The GTIN-13 code of the product, or the product to which the offer refers. This is equivalent to 13-digit ISBN codes and EAN UCC-13. Former 12-digit UPC codes can be converted into a GTIN-13 code by simply adding a preceding zero. See [GS1 GTIN Summary](http://www.gs1.org/barcodes/technical/idkeys/gtin) for more details.'),
(629, 1, 6, 'hasAdultConsideration', 'hasAdultConsideration', 'Used to tag an item to be intended or suitable for consumption or use by adults only.'),
(630, 1, 6, 'asin', 'asin', 'An Amazon Standard Identification Number (ASIN) is a 10-character alphanumeric unique identifier assigned by Amazon.com and its partners for product identification within the Amazon organization (summary from [Wikipedia](https://en.wikipedia.org/wiki/Amazon_Standard_Identification_Number)\'s article).\n\nNote also that this is a definition for how to include ASINs in Schema.org data, and not a definition of ASINs in general - see documentation from Amazon for authoritative details.\nASINs are most commonly encoded as text strings, but the [asin] property supports URL/URI as potential values too.'),
(631, 1, 6, 'reservedTicket', 'reservedTicket', 'A ticket associated with the reservation.'),
(632, 1, 6, 'commentCount', 'commentCount', 'The number of comments this CreativeWork (e.g. Article, Question or Answer) has received. This is most applicable to works published in Web sites with commenting system; additional comments may exist elsewhere.'),
(633, 1, 6, 'programMembershipUsed', 'programMembershipUsed', 'Any membership in a frequent flyer, hotel loyalty program, etc. being applied to the reservation.'),
(634, 1, 6, 'alcoholWarning', 'alcoholWarning', 'Any precaution, guidance, contraindication, etc. related to consumption of alcohol while taking this drug.'),
(635, 1, 6, 'typicalTest', 'typicalTest', 'A medical test typically performed given this condition.'),
(636, 1, 6, 'duringMedia', 'duringMedia', 'A media object representing the circumstances while performing this direction.'),
(637, 1, 6, 'valueMinLength', 'valueMinLength', 'Specifies the minimum allowed range for number of characters in a literal value.'),
(638, 1, 6, 'cvdNumC19HOPats', 'cvdNumC19HOPats', 'numc19hopats - HOSPITAL ONSET: Patients hospitalized in an NHSN inpatient care location with onset of suspected or confirmed COVID-19 14 or more days after hospitalization.'),
(639, 1, 6, 'citation', 'citation', 'A citation or reference to another creative work, such as another publication, web page, scholarly article, etc.'),
(640, 1, 6, 'musicGroupMember', 'musicGroupMember', 'A member of a music group&#x2014;for example, John, Paul, George, or Ringo.'),
(641, 1, 6, 'member', 'member', 'A member of an Organization or a ProgramMembership. Organizations can be members of organizations; ProgramMembership is typically for individuals.'),
(642, 1, 6, 'cvdNumICUBedsOcc', 'cvdNumICUBedsOcc', 'numicubedsocc - ICU BED OCCUPANCY: Total number of staffed inpatient ICU beds that are occupied.'),
(643, 1, 6, 'numberOfEmployees', 'numberOfEmployees', 'The number of employees in an organization, e.g. business.'),
(644, 1, 6, 'subStageSuffix', 'subStageSuffix', 'The substage, e.g. \'a\' for Stage IIIa.'),
(645, 1, 6, 'coursePrerequisites', 'coursePrerequisites', 'Requirements for taking the Course. May be completion of another [[Course]] or a textual description like \"permission of instructor\". Requirements may be a pre-requisite competency, referenced using [[AlignmentObject]].'),
(646, 1, 6, 'sharedContent', 'sharedContent', 'A CreativeWork such as an image, video, or audio clip shared as part of this posting.'),
(647, 1, 6, 'urlTemplate', 'urlTemplate', 'An url template (RFC6570) that will be used to construct the target of the execution of the action.'),
(648, 1, 6, 'gtin8', 'gtin8', 'The GTIN-8 code of the product, or the product to which the offer refers. This code is also known as EAN/UCC-8 or 8-digit EAN. See [GS1 GTIN Summary](http://www.gs1.org/barcodes/technical/idkeys/gtin) for more details.'),
(649, 1, 6, 'vehicleEngine', 'vehicleEngine', 'Information about the engine or engines of the vehicle.'),
(650, 1, 6, 'priceRange', 'priceRange', 'The price range of the business, for example ```$$$```.'),
(651, 1, 6, 'numberOfAvailableAccommodationUnits', 'numberOfAvailableAccommodationUnits', 'Indicates the number of available accommodation units in an [[ApartmentComplex]], or the number of accommodation units for a specific [[FloorPlan]] (within its specific [[ApartmentComplex]]). See also [[numberOfAccommodationUnits]].'),
(652, 1, 6, 'priceType', 'priceType', 'Defines the type of a price specified for an offered product, for example a list price, a (temporary) sale price or a manufacturer suggested retail price. If multiple prices are specified for an offer the [[priceType]] property can be used to identify the type of each such specified price. The value of priceType can be specified as a value from enumeration PriceTypeEnumeration or as a free form text string for price types that are not already predefined in PriceTypeEnumeration.'),
(653, 1, 6, 'verificationFactCheckingPolicy', 'verificationFactCheckingPolicy', 'Disclosure about verification and fact-checking processes for a [[NewsMediaOrganization]] or other fact-checking [[Organization]].'),
(654, 1, 6, 'negativeNotes', 'negativeNotes', 'Provides negative considerations regarding something, most typically in pro/con lists for reviews (alongside [[positiveNotes]]). For symmetry \n\nIn the case of a [[Review]], the property describes the [[itemReviewed]] from the perspective of the review; in the case of a [[Product]], the product itself is being described. Since product descriptions \ntend to emphasise positive claims, it may be relatively unusual to find [[negativeNotes]] used in this way. Nevertheless for the sake of symmetry, [[negativeNotes]] can be used on [[Product]].\n\nThe property values can be expressed either as unstructured text (repeated as necessary), or if ordered, as a list (in which case the most negative is at the beginning of the list).'),
(655, 1, 6, 'startOffset', 'startOffset', 'The start time of the clip expressed as the number of seconds from the beginning of the work.'),
(656, 1, 6, 'codeRepository', 'codeRepository', 'Link to the repository where the un-compiled, human readable code and related code is located (SVN, GitHub, CodePlex).'),
(657, 1, 6, 'differentialDiagnosis', 'differentialDiagnosis', 'One of a set of differential diagnoses for the condition. Specifically, a closely-related or competing diagnosis typically considered later in the cognitive process whereby this medical condition is distinguished from others most likely responsible for a similar collection of signs and symptoms to reach the most parsimonious diagnosis or diagnoses in a patient.'),
(658, 1, 6, 'free', 'free', 'A flag to signal that the item, event, or place is accessible for free.'),
(659, 1, 6, 'isAccessibleForFree', 'isAccessibleForFree', 'A flag to signal that the item, event, or place is accessible for free.'),
(660, 1, 6, 'subEvents', 'subEvents', 'Events that are a part of this event. For example, a conference event includes many presentations, each subEvents of the conference.'),
(661, 1, 6, 'subEvent', 'subEvent', 'An Event that is part of this event. For example, a conference event includes many presentations, each of which is a subEvent of the conference.'),
(662, 1, 6, 'amountOfThisGood', 'amountOfThisGood', 'The quantity of the goods included in the offer.'),
(663, 1, 6, 'geoEquals', 'geoEquals', 'Represents spatial relations in which two geometries (or the places they represent) are topologically equal, as defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM). \"Two geometries are topologically equal if their interiors intersect and no part of the interior or boundary of one geometry intersects the exterior of the other\" (a symmetric relationship).'),
(664, 1, 6, 'geoMidpoint', 'geoMidpoint', 'Indicates the GeoCoordinates at the centre of a GeoShape, e.g. GeoCircle.'),
(665, 1, 6, 'backstory', 'backstory', 'For an [[Article]], typically a [[NewsArticle]], the backstory property provides a textual summary giving a brief explanation of why and how an article was created. In a journalistic setting this could include information about reporting process, methods, interviews, data sources, etc.'),
(666, 1, 6, 'acceptedAnswer', 'acceptedAnswer', 'The answer(s) that has been accepted as best, typically on a Question/Answer site. Sites vary in their selection mechanisms, e.g. drawing on community opinion and/or the view of the Question author.'),
(667, 1, 6, 'suggestedAnswer', 'suggestedAnswer', 'An answer (possibly one of several, possibly incorrect) to a Question, e.g. on a Question/Answer site.'),
(668, 1, 6, 'cvdNumTotBeds', 'cvdNumTotBeds', 'numtotbeds - ALL HOSPITAL BEDS: Total number of all inpatient and outpatient beds, including all staffed, ICU, licensed, and overflow (surge) beds used for inpatients or outpatients.'),
(669, 1, 6, 'educationRequirements', 'educationRequirements', 'Educational background needed for the position or Occupation.'),
(670, 1, 6, 'programmingModel', 'programmingModel', 'Indicates whether API is managed or unmanaged.'),
(671, 1, 6, 'blogPosts', 'blogPosts', 'Indicates a post that is part of a [[Blog]]. Note that historically, what we term a \"Blog\" was once known as a \"weblog\", and that what we term a \"BlogPosting\" is now often colloquially referred to as a \"blog\".'),
(672, 1, 6, 'blogPost', 'blogPost', 'A posting that is part of this blog.'),
(673, 1, 6, 'validFor', 'validFor', 'The duration of validity of a permit or similar thing.'),
(674, 1, 6, 'biomechnicalClass', 'biomechnicalClass', 'The biomechanical properties of the bone.'),
(675, 1, 6, 'codeValue', 'codeValue', 'A short textual code that uniquely identifies the value.'),
(676, 1, 6, 'termCode', 'termCode', 'A code that identifies this [[DefinedTerm]] within a [[DefinedTermSet]]'),
(677, 1, 6, 'biologicalRole', 'biologicalRole', 'A role played by the BioChemEntity within a biological context.'),
(678, 1, 6, 'occupationalCredentialAwarded', 'occupationalCredentialAwarded', 'A description of the qualification, award, certificate, diploma or other occupational credential awarded as a consequence of successful completion of this course or program.'),
(679, 1, 6, 'greater', 'greater', 'This ordering relation for qualitative values indicates that the subject is greater than the object.'),
(680, 1, 6, 'unnamedSourcesPolicy', 'unnamedSourcesPolicy', 'For an [[Organization]] (typically a [[NewsMediaOrganization]]), a statement about policy on use of unnamed sources and the decision process required.'),
(681, 1, 6, 'naturalProgression', 'naturalProgression', 'The expected progression of the condition if it is not treated and allowed to progress naturally.'),
(682, 1, 6, 'geoContains', 'geoContains', 'Represents a relationship between two geometries (or the places they represent), relating a containing geometry to a contained geometry. \"a contains b iff no points of b lie in the exterior of a, and at least one point of the interior of b lies in the interior of a\". As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(683, 1, 6, 'announcementLocation', 'announcementLocation', 'Indicates a specific [[CivicStructure]] or [[LocalBusiness]] associated with the SpecialAnnouncement. For example, a specific testing facility or business with special opening hours. For a larger geographic region like a quarantine of an entire region, use [[spatialCoverage]].'),
(684, 1, 6, 'runtime', 'runtime', 'Runtime platform or script interpreter dependencies (example: Java v1, Python 2.3, .NET Framework 3.0).'),
(685, 1, 6, 'runtimePlatform', 'runtimePlatform', 'Runtime platform or script interpreter dependencies (example: Java v1, Python 2.3, .NET Framework 3.0).'),
(686, 1, 6, 'currenciesAccepted', 'currenciesAccepted', 'The currency accepted.\\n\\nUse standard formats: [ISO 4217 currency format](http://en.wikipedia.org/wiki/ISO_4217), e.g. \"USD\"; [Ticker symbol](https://en.wikipedia.org/wiki/List_of_cryptocurrencies) for cryptocurrencies, e.g. \"BTC\"; well known names for [Local Exchange Trading Systems](https://en.wikipedia.org/wiki/Local_exchange_trading_system) (LETS) and other currency types, e.g. \"Ithaca HOUR\".'),
(687, 1, 6, 'touristType', 'touristType', 'Attraction suitable for type(s) of tourist. E.g. children, visitors from a particular country, etc. '),
(688, 1, 6, 'printPage', 'printPage', 'If this NewsArticle appears in print, this field indicates the name of the page on which the article is found. Please note that this field is intended for the exact page name (e.g. A5, B18).'),
(689, 1, 6, 'typicalAgeRange', 'typicalAgeRange', 'The typical expected age range, e.g. \'7-9\', \'11-\'.'),
(690, 1, 6, 'suitableForDiet', 'suitableForDiet', 'Indicates a dietary restriction or guideline for which this recipe or menu item is suitable, e.g. diabetic, halal etc.'),
(691, 1, 6, 'shippingRate', 'shippingRate', 'The shipping rate is the cost of shipping to the specified destination. Typically, the maxValue and currency values (of the [[MonetaryAmount]]) are most appropriate.'),
(692, 1, 6, 'assemblyVersion', 'assemblyVersion', 'Associated product/technology version. E.g., .NET Framework 4.5.'),
(693, 1, 6, 'publicAccess', 'publicAccess', 'A flag to signal that the [[Place]] is open to public visitors.  If this property is omitted there is no assumed default boolean value'),
(694, 1, 6, 'occupationLocation', 'occupationLocation', ' The region/country for which this occupational description is appropriate. Note that educational requirements and qualifications can vary between jurisdictions.'),
(695, 1, 6, 'benefitsSummaryUrl', 'benefitsSummaryUrl', 'The URL that goes directly to the summary of benefits and coverage for the specific standard plan or plan variation.'),
(696, 1, 6, 'targetProduct', 'targetProduct', 'Target Operating System / Product to which the code applies.  If applies to several versions, just the product name can be used.'),
(697, 1, 6, 'workPresented', 'workPresented', 'The movie presented during this event.'),
(698, 1, 6, 'carrierRequirements', 'carrierRequirements', 'Specifies specific carrier(s) requirements for the application (e.g. an application may only work on a specific carrier network).'),
(699, 1, 6, 'dateReceived', 'dateReceived', 'The date/time the message was received if a single recipient exists.'),
(700, 1, 6, 'handlingTime', 'handlingTime', 'The typical delay between the receipt of the order and the goods either leaving the warehouse or being prepared for pickup, in case the delivery method is on site pickup. Typical properties: minValue, maxValue, unitCode (d for DAY).  This is by common convention assumed to mean business days (if a unitCode is used, coded as \"d\"), i.e. only counting days when the business normally operates.'),
(701, 1, 6, 'educationalAlignment', 'educationalAlignment', 'An alignment to an established educational framework.\n\nThis property should not be used where the nature of the alignment can be described using a simple property, for example to express that a resource [[teaches]] or [[assesses]] a competency.'),
(702, 1, 6, 'deliveryTime', 'deliveryTime', 'The total delay between the receipt of the order and the goods reaching the final customer.'),
(703, 1, 6, 'iupacName', 'iupacName', 'Systematic method of naming chemical compounds as recommended by the International Union of Pure and Applied Chemistry (IUPAC).'),
(704, 1, 6, 'trailerWeight', 'trailerWeight', 'The permitted weight of a trailer attached to the vehicle.\\n\\nTypical unit code(s): KGM for kilogram, LBR for pound\\n* Note 1: You can indicate additional information in the [[name]] of the [[QuantitativeValue]] node.\\n* Note 2: You may also link to a [[QualitativeValue]] node that provides additional information using [[valueReference]].\\n* Note 3: Note that you can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(705, 1, 6, 'shippingLabel', 'shippingLabel', 'Label to match an [[OfferShippingDetails]] with a [[ShippingRateSettings]] (within the context of a [[shippingSettingsLink]] cross-reference).'),
(706, 1, 6, 'partySize', 'partySize', 'Number of people the reservation should accommodate.'),
(707, 1, 6, 'publication', 'publication', 'A publication event associated with the item.'),
(708, 1, 6, 'payload', 'payload', 'The permitted weight of passengers and cargo, EXCLUDING the weight of the empty vehicle.\\n\\nTypical unit code(s): KGM for kilogram, LBR for pound\\n\\n* Note 1: Many databases specify the permitted TOTAL weight instead, which is the sum of [[weight]] and [[payload]]\\n* Note 2: You can indicate additional information in the [[name]] of the [[QuantitativeValue]] node.\\n* Note 3: You may also link to a [[QualitativeValue]] node that provides additional information using [[valueReference]].\\n* Note 4: Note that you can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(709, 1, 6, 'termDuration', 'termDuration', 'The amount of time in a term as defined by the institution. A term is a length of time where students take one or more classes. Semesters and quarters are common units for term.'),
(710, 1, 6, 'itemReviewed', 'itemReviewed', 'The item that is being reviewed/rated.'),
(711, 1, 6, 'recipe', 'recipe', 'A sub property of instrument. The recipe/instructions used to perform the action.'),
(712, 1, 6, 'telephone', 'telephone', 'The telephone number.'),
(713, 1, 6, 'exchangeRateSpread', 'exchangeRateSpread', 'The difference between the price at which a broker or other intermediary buys and sells foreign currency.'),
(714, 1, 6, 'itemDefectReturnShippingFeesAmount', 'itemDefectReturnShippingFeesAmount', 'Amount of shipping costs for defect product returns. Applicable when property [[itemDefectReturnFees]] equals [[ReturnShippingFees]].'),
(715, 1, 6, 'addressRegion', 'addressRegion', 'The region in which the locality is, and which is in the country. For example, California or another appropriate first-level [Administrative division](https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country).'),
(716, 1, 6, 'spatial', 'spatial', 'The \"spatial\" property can be used in cases when more specific properties\n(e.g. [[locationCreated]], [[spatialCoverage]], [[contentLocation]]) are not known to be appropriate.'),
(717, 1, 6, 'estimatedCost', 'estimatedCost', 'The estimated cost of the supply or supplies consumed when performing instructions.'),
(718, 1, 6, 'financialAidEligible', 'financialAidEligible', 'A financial aid type or program which students may use to pay for tuition or fees associated with the program.'),
(719, 1, 6, 'sensoryUnit', 'sensoryUnit', 'The neurological pathway extension that inputs and sends information to the brain or spinal cord.'),
(720, 1, 6, 'awayTeam', 'awayTeam', 'The away team in a sports event.'),
(721, 1, 6, 'antagonist', 'antagonist', 'The muscle whose action counteracts the specified muscle.'),
(722, 1, 6, 'orderDelivery', 'orderDelivery', 'The delivery of the parcel related to this order or order item.'),
(723, 1, 6, 'supplyTo', 'supplyTo', 'The area to which the artery supplies blood.'),
(724, 1, 6, 'bookingTime', 'bookingTime', 'The date and time the reservation was booked.'),
(725, 1, 6, 'circle', 'circle', 'A circle is the circular region of a specified radius centered at a specified latitude and longitude. A circle is expressed as a pair followed by a radius in meters.'),
(726, 1, 6, 'beforeMedia', 'beforeMedia', 'A media object representing the circumstances before performing this direction.'),
(727, 1, 6, 'episodeNumber', 'episodeNumber', 'Position of the episode within an ordered group of episodes.'),
(728, 1, 6, 'gracePeriod', 'gracePeriod', 'The period of time after any due date that the borrower has to fulfil its obligations before a default (failure to pay) is deemed to have occurred.'),
(729, 1, 6, 'addressLocality', 'addressLocality', 'The locality in which the street address is, and which is in the region. For example, Mountain View.'),
(730, 1, 6, 'learningResourceType', 'learningResourceType', 'The predominant type or kind characterizing the learning resource. For example, \'presentation\', \'handout\'.'),
(731, 1, 6, 'fuelType', 'fuelType', 'The type of fuel suitable for the engine or engines of the vehicle. If the vehicle has only one engine, this property can be attached directly to the vehicle.'),
(732, 1, 6, 'accessibilityAPI', 'accessibilityAPI', 'Indicates that the resource is compatible with the referenced accessibility API. Values should be drawn from the [approved vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityAPI-vocabulary).'),
(733, 1, 6, 'masthead', 'masthead', 'For a [[NewsMediaOrganization]], a link to the masthead page or a page listing top editorial management.'),
(734, 1, 6, 'ticketToken', 'ticketToken', 'Reference to an asset (e.g., Barcode, QR code image or PDF) usable for entrance.'),
(735, 1, 6, 'eligibleRegion', 'eligibleRegion', 'The ISO 3166-1 (ISO 3166-1 alpha-2) or ISO 3166-2 code, the place, or the GeoShape for the geo-political region(s) for which the offer or delivery charge specification is valid.\\n\\nSee also [[ineligibleRegion]].\n    '),
(736, 1, 6, 'areaServed', 'areaServed', 'The geographic area where a service or offered item is provided.'),
(737, 1, 6, 'disambiguatingDescription', 'disambiguatingDescription', 'A sub property of description. A short description of the item used to disambiguate from other, similar items. Information from other properties (in particular, name) may be necessary for the description to be useful for disambiguation.'),
(738, 1, 6, 'description', 'description', 'A description of the item.'),
(739, 1, 6, 'suggestedMaxAge', 'suggestedMaxAge', 'Maximum recommended age in years for the audience or user.'),
(740, 1, 6, 'quest', 'quest', 'The task that a player-controlled character, or group of characters may complete in order to gain a reward.'),
(741, 1, 6, 'containedIn', 'containedIn', 'The basic containment relation between a place and one that contains it.'),
(742, 1, 6, 'containedInPlace', 'containedInPlace', 'The basic containment relation between a place and one that contains it.'),
(743, 1, 6, 'contraindication', 'contraindication', 'A contraindication for this therapy.'),
(744, 1, 6, 'recipeYield', 'recipeYield', 'The quantity produced by the recipe (for example, number of people served, number of servings, etc).'),
(745, 1, 6, 'yield', 'yield', 'The quantity that results by performing instructions. For example, a paper airplane, 10 personalized candles.'),
(746, 1, 6, 'cvdCollectionDate', 'cvdCollectionDate', 'collectiondate - Date for which patient counts are reported.'),
(747, 1, 6, 'requiredMinAge', 'requiredMinAge', 'Audiences defined by a person\'s minimum age.'),
(748, 1, 6, 'referencesOrder', 'referencesOrder', 'The Order(s) related to this Invoice. One or more Orders may be combined into a single Invoice.'),
(749, 1, 6, 'identifyingTest', 'identifyingTest', 'A diagnostic test that can identify this sign.'),
(750, 1, 6, 'inker', 'inker', 'The individual who traces over the pencil drawings in ink after pencils are complete.'),
(751, 1, 6, 'operatingSystem', 'operatingSystem', 'Operating systems supported (Windows 7, OS X 10.6, Android 1.6).'),
(752, 1, 6, 'byMonth', 'byMonth', 'Defines the month(s) of the year on which a recurring [[Event]] takes place. Specified as an [[Integer]] between 1-12. January is 1.'),
(753, 1, 6, 'steeringPosition', 'steeringPosition', 'The position of the steering wheel or similar device (mostly for cars).'),
(754, 1, 6, 'branch', 'branch', 'The branches that delineate from the nerve bundle. Not to be confused with [[branchOf]].'),
(755, 1, 6, 'arterialBranch', 'arterialBranch', 'The branches that comprise the arterial structure.'),
(756, 1, 6, 'taxID', 'taxID', 'The Tax / Fiscal ID of the organization or person, e.g. the TIN in the US or the CIF/NIF in Spain.'),
(757, 1, 6, 'stage', 'stage', 'The stage of the condition, if applicable.'),
(758, 1, 6, 'engineType', 'engineType', 'The type of engine or engines powering the vehicle.'),
(759, 1, 6, 'acceptedPaymentMethod', 'acceptedPaymentMethod', 'The payment method(s) accepted by seller for this offer.'),
(760, 1, 6, 'representativeOfPage', 'representativeOfPage', 'Indicates whether this image is representative of the content of the page.'),
(761, 1, 6, 'partOfOrder', 'partOfOrder', 'The overall order the items in this delivery were included in.'),
(762, 1, 6, 'purchaseDate', 'purchaseDate', 'The date the item, e.g. vehicle, was purchased by the current owner.'),
(763, 1, 6, 'loser', 'loser', 'A sub property of participant. The loser of the action.'),
(764, 1, 6, 'issn', 'issn', 'The International Standard Serial Number (ISSN) that identifies this serial publication. You can repeat this property to identify different formats of, or the linking ISSN (ISSN-L) for, this serial publication.'),
(765, 1, 6, 'landlord', 'landlord', 'A sub property of participant. The owner of the real estate property.'),
(766, 1, 6, 'language', 'language', 'A sub property of instrument. The language used on this action.'),
(767, 1, 6, 'inLanguage', 'inLanguage', 'The language of the content or performance or used in an action. Please use one of the language codes from the [IETF BCP 47 standard](http://tools.ietf.org/html/bcp47). See also [[availableLanguage]].'),
(768, 1, 6, 'legislationDateVersion', 'legislationDateVersion', 'The point-in-time at which the provided description of the legislation is valid (e.g.: when looking at the law on the 2016-04-07 (= dateVersion), I get the consolidation of 2015-04-12 of the \"National Insurance Contributions Act 2015\")'),
(769, 1, 6, 'originAddress', 'originAddress', 'Shipper\'s address.'),
(770, 1, 6, 'healthPlanDrugTier', 'healthPlanDrugTier', 'The tier(s) of drugs offered by this formulary or insurance plan.'),
(771, 1, 6, 'eduQuestionType', 'eduQuestionType', 'For questions that are part of learning resources (e.g. Quiz), eduQuestionType indicates the format of question being given. Example: \"Multiple choice\", \"Open ended\", \"Flashcard\".'),
(772, 1, 6, 'keywords', 'keywords', 'Keywords or tags used to describe some item. Multiple textual entries in a keywords list are typically delimited by commas, or by repeating the property.'),
(773, 1, 6, 'recognizingAuthority', 'recognizingAuthority', 'If applicable, the organization that officially recognizes this entity as part of its endorsed system of medicine.'),
(774, 1, 6, 'transitTime', 'transitTime', 'The typical delay the order has been sent for delivery and the goods reach the final customer. Typical properties: minValue, maxValue, unitCode (d for DAY).'),
(775, 1, 6, 'availableTest', 'availableTest', 'A diagnostic test or procedure offered by this lab.'),
(776, 1, 6, 'isFamilyFriendly', 'isFamilyFriendly', 'Indicates whether this content is family friendly.'),
(777, 1, 6, 'knowsLanguage', 'knowsLanguage', 'Of a [[Person]], and less typically of an [[Organization]], to indicate a known language. We do not distinguish skill levels or reading/writing/speaking/signing here. Use language codes from the [IETF BCP 47 standard](http://tools.ietf.org/html/bcp47).'),
(778, 1, 6, 'constrainingProperty', 'constrainingProperty', 'Indicates a property used as a constraint to define a [[StatisticalPopulation]] with respect to the set of entities\n  corresponding to an indicated type (via [[populationType]]).'),
(779, 1, 6, 'geoCovers', 'geoCovers', 'Represents a relationship between two geometries (or the places they represent), relating a covering geometry to a covered geometry. \"Every point of b is a point of (the interior or boundary of) a\". As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(780, 1, 6, 'penciler', 'penciler', 'The individual who draws the primary narrative artwork.'),
(781, 1, 6, 'availableAtOrFrom', 'availableAtOrFrom', 'The place(s) from which the offer can be obtained (e.g. store locations).'),
(782, 1, 6, 'requiredGender', 'requiredGender', 'Audiences defined by a person\'s gender.'),
(783, 1, 6, 'educationalCredentialAwarded', 'educationalCredentialAwarded', 'A description of the qualification, award, certificate, diploma or other educational credential awarded as a consequence of successful completion of this course or program.'),
(784, 1, 6, 'medicalSpecialty', 'medicalSpecialty', 'A medical specialty of the provider.'),
(785, 1, 6, 'startDate', 'startDate', 'The start date and time of the item (in [ISO 8601 date format](http://en.wikipedia.org/wiki/ISO_8601)).'),
(786, 1, 6, 'pregnancyCategory', 'pregnancyCategory', 'Pregnancy category of this drug.'),
(787, 1, 6, 'line', 'line', 'A line is a point-to-point path consisting of two or more points. A line is expressed as a series of two or more point objects separated by space.'),
(788, 1, 6, 'numTracks', 'numTracks', 'The number of tracks in this album or playlist.'),
(789, 1, 6, 'numberOfForwardGears', 'numberOfForwardGears', 'The total number of forward gears available for the transmission system of the vehicle.\\n\\nTypical unit code(s): C62'),
(790, 1, 6, 'recourseLoan', 'recourseLoan', 'The only way you get the money back in the event of default is the security. Recourse is where you still have the opportunity to go back to the borrower for the rest of the money.'),
(791, 1, 6, 'manufacturer', 'manufacturer', 'The manufacturer of the product.'),
(792, 1, 6, 'minValue', 'minValue', 'The lower value of some characteristic or property.'),
(793, 1, 6, 'dropoffLocation', 'dropoffLocation', 'Where a rental car can be dropped off.'),
(794, 1, 6, 'isAcceptingNewPatients', 'isAcceptingNewPatients', 'Whether the provider is accepting new patients.'),
(795, 1, 6, 'permissionType', 'permissionType', 'The type of permission granted the person, organization, or audience.'),
(796, 1, 6, 'realEstateAgent', 'realEstateAgent', 'A sub property of participant. The real estate agent involved in the action.'),
(797, 1, 6, 'bookFormat', 'bookFormat', 'The format of the book.'),
(798, 1, 6, 'numAdults', 'numAdults', 'The number of adults staying in the unit.'),
(799, 1, 6, 'partOfSeason', 'partOfSeason', 'The season to which this episode belongs.'),
(800, 1, 6, 'isPartOf', 'isPartOf', 'Indicates an item or CreativeWork that this item, or CreativeWork (in some sense), is part of.'),
(801, 1, 6, 'produces', 'produces', 'The tangible thing generated by the service, e.g. a passport, permit, etc.'),
(802, 1, 6, 'serviceOutput', 'serviceOutput', 'The tangible thing generated by the service, e.g. a passport, permit, etc.'),
(803, 1, 6, 'functionalClass', 'functionalClass', 'The degree of mobility the joint allows.'),
(804, 1, 6, 'populationType', 'populationType', 'Indicates the populationType common to all members of a [[StatisticalPopulation]].'),
(805, 1, 6, 'inCodeSet', 'inCodeSet', 'A [[CategoryCodeSet]] that contains this category code.'),
(806, 1, 6, 'inDefinedTermSet', 'inDefinedTermSet', 'A [[DefinedTermSet]] that contains this term.'),
(807, 1, 6, 'additionalVariable', 'additionalVariable', 'Any additional component of the exercise prescription that may need to be articulated to the patient. This may include the order of exercises, the number of repetitions of movement, quantitative distance, progressions over time, etc.'),
(808, 1, 6, 'servicePhone', 'servicePhone', 'The phone number to use to access the service.'),
(809, 1, 6, 'readonlyValue', 'readonlyValue', 'Whether or not a property is mutable.  Default is false. Specifying this for a property that also has a value makes it act similar to a \"hidden\" input in an HTML form.'),
(810, 1, 6, 'addressCountry', 'addressCountry', 'The country. For example, USA. You can also provide the two-letter [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1).'),
(811, 1, 6, 'calories', 'calories', 'The number of calories.'),
(812, 1, 6, 'lesser', 'lesser', 'This ordering relation for qualitative values indicates that the subject is lesser than the object.'),
(813, 1, 6, 'remainingAttendeeCapacity', 'remainingAttendeeCapacity', 'The number of attendee places for an event that remain unallocated.'),
(814, 1, 6, 'recipeCuisine', 'recipeCuisine', 'The cuisine of the recipe (for example, French or Ethiopian).'),
(815, 1, 6, 'accelerationTime', 'accelerationTime', 'The time needed to accelerate the vehicle from a given start velocity to a given target velocity.\\n\\nTypical unit code(s): SEC for seconds\\n\\n* Note: There are unfortunately no standard unit codes for seconds/0..100 km/h or seconds/0..60 mph. Simply use \"SEC\" for seconds and indicate the velocities in the [[name]] of the [[QuantitativeValue]], or use [[valueReference]] with a [[QuantitativeValue]] of 0..60 mph or 0..100 km/h to specify the reference speeds.'),
(816, 1, 6, 'lesserOrEqual', 'lesserOrEqual', 'This ordering relation for qualitative values indicates that the subject is lesser than or equal to the object.'),
(817, 1, 6, 'course', 'course', 'A sub property of location. The course where this action was taken.'),
(818, 1, 6, 'exerciseCourse', 'exerciseCourse', 'A sub property of location. The course where this action was taken.'),
(819, 1, 6, 'study', 'study', 'A medical study or trial related to this entity.'),
(820, 1, 6, 'numConstraints', 'numConstraints', 'Indicates the number of constraints (not counting [[populationType]]) defined for a particular [[StatisticalPopulation]]. This helps applications understand if they have access to a sufficiently complete description of a [[StatisticalPopulation]].'),
(821, 1, 6, 'icaoCode', 'icaoCode', 'ICAO identifier for an airport.'),
(822, 1, 6, 'videoFormat', 'videoFormat', 'The type of screening or video broadcast used (e.g. IMAX, 3D, SD, HD, etc.).'),
(823, 1, 6, 'inStoreReturnsOffered', 'inStoreReturnsOffered', 'Are in-store returns offered? (For more advanced return methods use the [[returnMethod]] property.)'),
(824, 1, 6, 'diagnosis', 'diagnosis', 'One or more alternative conditions considered in the differential diagnosis process as output of a diagnosis process.'),
(825, 1, 6, 'drainsTo', 'drainsTo', 'The vasculature that the vein drains into.'),
(826, 1, 6, 'accountablePerson', 'accountablePerson', 'Specifies the Person that is legally accountable for the CreativeWork.'),
(827, 1, 6, 'associatedPathophysiology', 'associatedPathophysiology', 'If applicable, a description of the pathophysiology associated with the anatomical system, including potential abnormal changes in the mechanical, physical, and biochemical functions of the system.'),
(828, 1, 6, 'doesNotShip', 'doesNotShip', 'Indicates when shipping to a particular [[shippingDestination]] is not available.'),
(829, 1, 6, 'exerciseRelatedDiet', 'exerciseRelatedDiet', 'A sub property of instrument. The diet used in this action.'),
(830, 1, 6, 'recipeCategory', 'recipeCategory', 'The category of the recipe—for example, appetizer, entree, etc.'),
(831, 1, 6, 'cvdNumBeds', 'cvdNumBeds', 'numbeds - HOSPITAL INPATIENT BEDS: Inpatient beds, including all staffed, licensed, and overflow (surge) beds used for inpatients.'),
(832, 1, 6, 'isGift', 'isGift', 'Indicates whether the offer was accepted as a gift for someone other than the buyer.'),
(833, 1, 6, 'emissionsCO2', 'emissionsCO2', 'The CO2 emissions in g/km. When used in combination with a QuantitativeValue, put \"g/km\" into the unitText property of that value, since there is no UN/CEFACT Common Code for \"g/km\".'),
(834, 1, 6, 'musicCompositionForm', 'musicCompositionForm', 'The type of composition (e.g. overture, sonata, symphony, etc.).'),
(835, 1, 6, 'members', 'members', 'A member of this organization.'),
(836, 1, 6, 'pagination', 'pagination', 'Any description of pages that is not separated into pageStart and pageEnd; for example, \"1-6, 9, 55\" or \"10-12, 46-49\".'),
(837, 1, 6, 'contentUrl', 'contentUrl', 'Actual bytes of the media object, for example the image file or video file.'),
(838, 1, 6, 'additionalNumberOfGuests', 'additionalNumberOfGuests', 'If responding yes, the number of guests who will attend in addition to the invitee.'),
(839, 1, 6, 'nonprofitStatus', 'nonprofitStatus', 'nonprofitStatus indicates the legal status of a non-profit organization in its primary place of business.'),
(840, 1, 6, 'strengthValue', 'strengthValue', 'The value of an active ingredient\'s strength, e.g. 325.'),
(841, 1, 6, 'affiliation', 'affiliation', 'An organization that this person is affiliated with. For example, a school/university, a club, or a team.'),
(842, 1, 6, 'memberOf', 'memberOf', 'An Organization (or ProgramMembership) to which this Person or Organization belongs.'),
(843, 1, 6, 'audienceType', 'audienceType', 'The target group associated with a given audience (e.g. veterans, car owners, musicians, etc.).'),
(844, 1, 6, 'significantLinks', 'significantLinks', 'The most significant URLs on the page. Typically, these are the non-navigation links that are clicked on the most.'),
(845, 1, 6, 'significantLink', 'significantLink', 'One of the more significant URLs on the page. Typically, these are the non-navigation links that are clicked on the most.'),
(846, 1, 6, 'knows', 'knows', 'The most generic bi-directional social/work relation.'),
(847, 1, 6, 'experienceRequirements', 'experienceRequirements', 'Description of skills and experience needed for the position or Occupation.'),
(848, 1, 6, 'worksFor', 'worksFor', 'Organizations that the person works for.'),
(849, 1, 6, 'coach', 'coach', 'A person that acts in a coaching role for a sports team.'),
(850, 1, 6, 'givenName', 'givenName', 'Given name. In the U.S., the first name of a Person.'),
(851, 1, 6, 'cvdFacilityCounty', 'cvdFacilityCounty', 'Name of the County of the NHSN facility that this data record applies to. Use [[cvdFacilityId]] to identify the facility. To provide other details, [[healthcareReportingData]] can be used on a [[Hospital]] entry.'),
(852, 1, 6, 'returnPolicySeasonalOverride', 'returnPolicySeasonalOverride', 'Seasonal override of a return policy.'),
(853, 1, 6, 'typeOfGood', 'typeOfGood', 'The product that this structured value is referring to.'),
(854, 1, 6, 'isicV4', 'isicV4', 'The International Standard of Industrial Classification of All Economic Activities (ISIC), Revision 4 code for a particular organization, business person, or place.'),
(855, 1, 6, 'possibleTreatment', 'possibleTreatment', 'A possible treatment to address this condition, sign or symptom.'),
(856, 1, 6, 'measuredProperty', 'measuredProperty', 'The measuredProperty of an [[Observation]], either a schema.org property, a property from other RDF-compatible systems, e.g. W3C RDF Data Cube, or schema.org extensions such as [GS1\'s](https://www.gs1.org/voc/?show=properties).'),
(857, 1, 6, 'partOfTVSeries', 'partOfTVSeries', 'The TV series to which this episode or season belongs.'),
(858, 1, 6, 'partOfSeries', 'partOfSeries', 'The series to which this episode or season belongs.'),
(859, 1, 6, 'diversityPolicy', 'diversityPolicy', 'Statement on diversity policy by an [[Organization]] e.g. a [[NewsMediaOrganization]]. For a [[NewsMediaOrganization]], a statement describing the newsroom’s diversity policy on both staffing and sources, typically providing staffing data.'),
(860, 1, 6, 'numberOfPreviousOwners', 'numberOfPreviousOwners', 'The number of owners of the vehicle, including the current one.\\n\\nTypical unit code(s): C62'),
(861, 1, 6, 'mapType', 'mapType', 'Indicates the kind of Map, from the MapCategoryType Enumeration.'),
(862, 1, 6, 'departureTerminal', 'departureTerminal', 'Identifier of the flight\'s departure terminal.'),
(863, 1, 6, 'pickupTime', 'pickupTime', 'When a taxi will pick up a passenger or a rental car can be picked up.'),
(864, 1, 6, 'mealService', 'mealService', 'Description of the meals that will be provided or available for purchase.'),
(865, 1, 6, 'restPeriods', 'restPeriods', 'How often one should break from the activity.'),
(866, 1, 6, 'messageAttachment', 'messageAttachment', 'A CreativeWork attached to the message.'),
(867, 1, 6, 'rsvpResponse', 'rsvpResponse', 'The response (yes, no, maybe) to the RSVP.'),
(868, 1, 6, 'departureBoatTerminal', 'departureBoatTerminal', 'The terminal or port from which the boat departs.'),
(869, 1, 6, 'numberOfLoanPayments', 'numberOfLoanPayments', 'The number of payments contractually required at origination to repay the loan. For monthly paying loans this is the number of months from the contractual first payment date to the maturity date.'),
(870, 1, 6, 'pregnancyWarning', 'pregnancyWarning', 'Any precaution, guidance, contraindication, etc. related to this drug\'s use during pregnancy.'),
(871, 1, 6, 'guideline', 'guideline', 'A medical guideline related to this entity.'),
(872, 1, 6, 'eligibleCustomerType', 'eligibleCustomerType', 'The type(s) of customers for which the given offer is valid.'),
(873, 1, 6, 'lyrics', 'lyrics', 'The words in the song.'),
(874, 1, 6, 'returnPolicyCategory', 'returnPolicyCategory', 'Specifies an applicable return policy (from an enumeration).'),
(875, 1, 6, 'usesDevice', 'usesDevice', 'Device used to perform the test.'),
(876, 1, 6, 'increasesRiskOf', 'increasesRiskOf', 'The condition, complication, etc. influenced by this factor.'),
(877, 1, 6, 'healthCondition', 'healthCondition', 'Specifying the health condition(s) of a patient, medical study, or other target audience.'),
(878, 1, 6, 'median', 'median', 'The median value.'),
(879, 1, 6, 'scheduleTimezone', 'scheduleTimezone', 'Indicates the timezone for which the time(s) indicated in the [[Schedule]] are given. The value provided should be among those listed in the IANA Time Zone Database.'),
(880, 1, 6, 'gamePlatform', 'gamePlatform', 'The electronic systems used to play <a href=\"http://en.wikipedia.org/wiki/Category:Video_game_platforms\">video games</a>.'),
(881, 1, 6, 'healthPlanMarketingUrl', 'healthPlanMarketingUrl', 'The URL that goes directly to the plan brochure for the specific standard plan or plan variation.'),
(882, 1, 6, 'hasDigitalDocumentPermission', 'hasDigitalDocumentPermission', 'A permission related to the access to this document (e.g. permission to read or write an electronic document). For a public document, specify a grantee with an Audience with audienceType equal to \"public\".'),
(883, 1, 6, 'sodiumContent', 'sodiumContent', 'The number of milligrams of sodium.'),
(884, 1, 6, 'letterer', 'letterer', 'The individual who adds lettering, including speech balloons and sound effects, to artwork.'),
(885, 1, 6, 'knowsAbout', 'knowsAbout', 'Of a [[Person]], and less typically of an [[Organization]], to indicate a topic that is known about - suggesting possible expertise but not implying it. We do not distinguish skill levels here, or relate this to educational content, events, objectives or [[JobPosting]] descriptions.'),
(886, 1, 6, 'opponent', 'opponent', 'A sub property of participant. The opponent on this action.'),
(887, 1, 6, 'guidelineSubject', 'guidelineSubject', 'The medical conditions, treatments, etc. that are the subject of the guideline.'),
(888, 1, 6, 'equal', 'equal', 'This ordering relation for qualitative values indicates that the subject is equal to the object.'),
(889, 1, 6, 'geoCrosses', 'geoCrosses', 'Represents a relationship between two geometries (or the places they represent), relating a geometry to another that crosses it: \"a crosses b: they have some but not all interior points in common, and the dimension of the intersection is less than that of at least one of them\". As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(890, 1, 6, 'postalCodeEnd', 'postalCodeEnd', 'Last postal code in the range (included). Needs to be after [[postalCodeBegin]].'),
(891, 1, 6, 'department', 'department', 'A relationship between an organization and a department of that organization, also described as an organization (allowing different urls, logos, opening hours). For example: a store with a pharmacy, or a bakery with a cafe.'),
(892, 1, 6, 'lodgingUnitType', 'lodgingUnitType', 'Textual description of the unit type (including suite vs. room, size of bed, etc.).'),
(893, 1, 6, 'applicationSubCategory', 'applicationSubCategory', 'Subcategory of the application, e.g. \'Arcade Game\'.'),
(894, 1, 6, 'applicationDeadline', 'applicationDeadline', 'The date at which the program stops collecting applications for the next enrollment cycle.'),
(895, 1, 6, 'activeIngredient', 'activeIngredient', 'An active ingredient, typically chemical compounds and/or biologic substances.'),
(896, 1, 6, 'feesAndCommissionsSpecification', 'feesAndCommissionsSpecification', 'Description of fees, commissions, and other terms applied either to a class of financial product, or by a financial service organization.'),
(897, 1, 6, 'molecularWeight', 'molecularWeight', 'This is the molecular weight of the entity being described, not of the parent. Units should be included in the form \'&lt;Number&gt; &lt;unit&gt;\', for example \'12 amu\' or as \'&lt;QuantitativeValue&gt;.'),
(898, 1, 6, 'carbohydrateContent', 'carbohydrateContent', 'The number of grams of carbohydrates.'),
(899, 1, 6, 'performers', 'performers', 'The main performer or performers of the event&#x2014;for example, a presenter, musician, or actor.'),
(900, 1, 6, 'performer', 'performer', 'A performer at the event&#x2014;for example, a presenter, musician, musical group or actor.'),
(901, 1, 6, 'healthcareReportingData', 'healthcareReportingData', 'Indicates data describing a hospital, e.g. a CDC [[CDCPMDRecord]] or as some kind of [[Dataset]].'),
(902, 1, 6, 'openingHoursSpecification', 'openingHoursSpecification', 'The opening hours of a certain place.'),
(903, 1, 6, 'author', 'author', 'The author of this content or rating. Please note that author is special in that HTML 5 provides a special mechanism for indicating authorship via the rel tag. That is equivalent to this and may be used interchangeably.'),
(904, 1, 6, 'unitText', 'unitText', 'A string or text indicating the unit of measurement. Useful if you cannot provide a standard unit code for\n<a href=\'unitCode\'>unitCode</a>.'),
(905, 1, 6, 'speed', 'speed', 'The speed range of the vehicle. If the vehicle is powered by an engine, the upper limit of the speed range (indicated by [[maxValue]]) should be the maximum speed achievable under regular conditions.\\n\\nTypical unit code(s): KMH for km/h, HM for mile per hour (0.447 04 m/s), KNT for knot\\n\\n*Note 1: Use [[minValue]] and [[maxValue]] to indicate the range. Typically, the minimal value is zero.\\n* Note 2: There are many different ways of measuring the speed range. You can link to information about how the given value has been determined using the [[valueReference]] property.'),
(906, 1, 6, 'servicePostalAddress', 'servicePostalAddress', 'The address for accessing the service by mail.'),
(907, 1, 6, 'pathophysiology', 'pathophysiology', 'Changes in the normal mechanical, physical, and biochemical functions that are associated with this activity or condition.'),
(908, 1, 6, 'healthPlanDrugOption', 'healthPlanDrugOption', 'TODO.'),
(909, 1, 6, 'pickupLocation', 'pickupLocation', 'Where a taxi will pick up a passenger or a rental car can be picked up.'),
(910, 1, 6, 'weightTotal', 'weightTotal', 'The permitted total weight of the loaded vehicle, including passengers and cargo and the weight of the empty vehicle.\\n\\nTypical unit code(s): KGM for kilogram, LBR for pound\\n\\n* Note 1: You can indicate additional information in the [[name]] of the [[QuantitativeValue]] node.\\n* Note 2: You may also link to a [[QualitativeValue]] node that provides additional information using [[valueReference]].\\n* Note 3: Note that you can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(911, 1, 6, 'athlete', 'athlete', 'A person that acts as performing member of a sports team; a player as opposed to a coach.'),
(912, 1, 6, 'hasDriveThroughService', 'hasDriveThroughService', 'Indicates whether some facility (e.g. [[FoodEstablishment]], [[CovidTestingFacility]]) offers a service that can be used by driving through in a car. In the case of [[CovidTestingFacility]] such facilities could potentially help with social distancing from other potentially-infected users.'),
(913, 1, 6, 'storageRequirements', 'storageRequirements', 'Storage requirements (free space required).'),
(914, 1, 6, 'dateline', 'dateline', 'A [dateline](https://en.wikipedia.org/wiki/Dateline) is a brief piece of text included in news articles that describes where and when the story was written or filed though the date is often omitted. Sometimes only a placename is provided.\n\nStructured representations of dateline-related information can also be expressed more explicitly using [[locationCreated]] (which represents where a work was created, e.g. where a news report was written).  For location depicted or described in the content, use [[contentLocation]].\n\nDateline summaries are oriented more towards human readers than towards automated processing, and can vary substantially. Some examples: \"BEIRUT, Lebanon, June 2.\", \"Paris, France\", \"December 19, 2017 11:43AM Reporting from Washington\", \"Beijing/Moscow\", \"QUEZON CITY, Philippines\".\n      '),
(915, 1, 6, 'encodings', 'encodings', 'A media object that encodes this CreativeWork.'),
(916, 1, 6, 'encoding', 'encoding', 'A media object that encodes this CreativeWork. This property is a synonym for associatedMedia.'),
(917, 1, 6, 'returnLabelSource', 'returnLabelSource', 'The method (from an enumeration) by which the customer obtains a return shipping label for a product returned for any reason.'),
(918, 1, 6, 'geoOverlaps', 'geoOverlaps', 'Represents a relationship between two geometries (or the places they represent), relating a geometry to another that geospatially overlaps it, i.e. they have some but not all points in common. As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(919, 1, 6, 'billingStart', 'billingStart', 'Specifies after how much time this price (or price component) becomes valid and billing starts. Can be used, for example, to model a price increase after the first year of a subscription. The unit of measurement is specified by the unitCode property.');
INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(920, 1, 6, 'applicationCategory', 'applicationCategory', 'Type of software application, e.g. \'Game, Multimedia\'.'),
(921, 1, 6, 'legislationDate', 'legislationDate', 'The date of adoption or signature of the legislation. This is the date at which the text is officially aknowledged to be a legislation, even though it might not even be published or in force.'),
(922, 1, 6, 'dateCreated', 'dateCreated', 'The date on which the CreativeWork was created or the item was added to a DataFeed.'),
(923, 1, 6, 'itemListOrder', 'itemListOrder', 'Type of ordering (e.g. Ascending, Descending, Unordered).'),
(924, 1, 6, 'typeOfBed', 'typeOfBed', 'The type of bed to which the BedDetail refers, i.e. the type of bed available in the quantity indicated by quantity.'),
(925, 1, 6, 'proficiencyLevel', 'proficiencyLevel', 'Proficiency needed for this content; expected values: \'Beginner\', \'Expert\'.'),
(926, 1, 6, 'installUrl', 'installUrl', 'URL at which the app may be installed, if different from the URL of the item.'),
(927, 1, 6, 'character', 'character', 'Fictional person connected with a creative work.'),
(928, 1, 6, 'gameLocation', 'gameLocation', 'Real or fictional location of the game (or part of game).'),
(929, 1, 6, 'costCurrency', 'costCurrency', 'The currency (in 3-letter) of the drug cost. See: http://en.wikipedia.org/wiki/ISO_4217. '),
(930, 1, 6, 'departureTime', 'departureTime', 'The expected departure time.'),
(931, 1, 6, 'annualPercentageRate', 'annualPercentageRate', 'The annual rate that is charged for borrowing (or made by investing), expressed as a single percentage number that represents the actual yearly cost of funds over the term of a loan. This includes any fees or additional costs associated with the transaction.'),
(932, 1, 6, 'doorTime', 'doorTime', 'The time admission will commence.'),
(933, 1, 6, 'claimReviewed', 'claimReviewed', 'A short summary of the specific claims reviewed in a ClaimReview.'),
(934, 1, 6, 'bookEdition', 'bookEdition', 'The edition of the book.'),
(935, 1, 6, 'specialCommitments', 'specialCommitments', 'Any special commitments associated with this job posting. Valid entries include VeteranCommit, MilitarySpouseCommit, etc.'),
(936, 1, 6, 'molecularFormula', 'molecularFormula', 'The empirical formula is the simplest whole number ratio of all the atoms in a molecule.'),
(937, 1, 6, 'iataCode', 'iataCode', 'IATA identifier for an airline or airport.'),
(938, 1, 6, 'broadcastServiceTier', 'broadcastServiceTier', 'The type of service required to have access to the channel (e.g. Standard or Premium).'),
(939, 1, 6, 'firstAppearance', 'firstAppearance', 'Indicates the first known occurrence of a [[Claim]] in some [[CreativeWork]].'),
(940, 1, 6, 'workExample', 'workExample', 'Example/instance/realization/derivation of the concept of this creative work. E.g. the paperback edition, first edition, or e-book.'),
(941, 1, 6, 'numberOfBeds', 'numberOfBeds', 'The quantity of the given bed type available in the HotelRoom, Suite, House, or Apartment.'),
(942, 1, 6, 'postalCode', 'postalCode', 'The postal code. For example, 94043.'),
(943, 1, 6, 'eventAttendanceMode', 'eventAttendanceMode', 'The eventAttendanceMode of an event indicates whether it occurs online, offline, or a mix.'),
(944, 1, 6, 'taxonomicRange', 'taxonomicRange', 'The taxonomic grouping of the organism that expresses, encodes, or in some way related to the BioChemEntity.'),
(945, 1, 6, 'supersededBy', 'supersededBy', 'Relates a term (i.e. a property, class or enumeration) to one that supersedes it.'),
(946, 1, 6, 'resultComment', 'resultComment', 'A sub property of result. The Comment created or sent as a result of this action.'),
(947, 1, 6, 'characterName', 'characterName', 'The name of a character played in some acting or performing role, i.e. in a PerformanceRole.'),
(948, 1, 6, 'employmentType', 'employmentType', 'Type of employment (e.g. full-time, part-time, contract, temporary, seasonal, internship).'),
(949, 1, 6, 'albumReleaseType', 'albumReleaseType', 'The kind of release which this album is: single, EP or album.'),
(950, 1, 6, 'featureList', 'featureList', 'Features or modules provided by this application (and possibly required by other applications).'),
(951, 1, 6, 'title', 'title', 'The title of the job.'),
(952, 1, 6, 'dateModified', 'dateModified', 'The date on which the CreativeWork was most recently modified or when the item\'s entry was modified within a DataFeed.'),
(953, 1, 6, 'identifyingExam', 'identifyingExam', 'A physical examination that can identify this sign.'),
(954, 1, 6, 'expectedArrivalUntil', 'expectedArrivalUntil', 'The latest date the package may arrive.'),
(955, 1, 6, 'roofLoad', 'roofLoad', 'The permitted total weight of cargo and installations (e.g. a roof rack) on top of the vehicle.\\n\\nTypical unit code(s): KGM for kilogram, LBR for pound\\n\\n* Note 1: You can indicate additional information in the [[name]] of the [[QuantitativeValue]] node.\\n* Note 2: You may also link to a [[QualitativeValue]] node that provides additional information using [[valueReference]]\\n* Note 3: Note that you can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(956, 1, 6, 'missionCoveragePrioritiesPolicy', 'missionCoveragePrioritiesPolicy', 'For a [[NewsMediaOrganization]], a statement on coverage priorities, including any public agenda or stance on issues.'),
(957, 1, 6, 'floorLimit', 'floorLimit', 'A floor limit is the amount of money above which credit card transactions must be authorized.'),
(958, 1, 6, 'foodEstablishment', 'foodEstablishment', 'A sub property of location. The specific food establishment where the action occurred.'),
(959, 1, 6, 'nationality', 'nationality', 'Nationality of the person.'),
(960, 1, 6, 'alternativeOf', 'alternativeOf', 'Another gene which is a variation of this one.'),
(961, 1, 6, 'temporal', 'temporal', 'The \"temporal\" property can be used in cases where more specific properties\n(e.g. [[temporalCoverage]], [[dateCreated]], [[dateModified]], [[datePublished]]) are not known to be appropriate.'),
(962, 1, 6, 'variantCover', 'variantCover', 'A description of the variant cover\n    	for the issue, if the issue is a variant printing. For example, \"Bryan Hitch\n    	Variant Cover\" or \"2nd Printing Variant\".'),
(963, 1, 6, 'broadcastSignalModulation', 'broadcastSignalModulation', 'The modulation (e.g. FM, AM, etc) used by a particular broadcast service.'),
(964, 1, 6, 'secondaryPrevention', 'secondaryPrevention', 'A preventative therapy used to prevent reoccurrence of the medical condition after an initial episode of the condition.'),
(965, 1, 6, 'hasCredential', 'hasCredential', 'A credential awarded to the Person or Organization.'),
(966, 1, 6, 'contactOption', 'contactOption', 'An option available on this contact point (e.g. a toll-free number or support for hearing-impaired callers).'),
(967, 1, 6, 'discountCurrency', 'discountCurrency', 'The currency of the discount.\\n\\nUse standard formats: [ISO 4217 currency format](http://en.wikipedia.org/wiki/ISO_4217), e.g. \"USD\"; [Ticker symbol](https://en.wikipedia.org/wiki/List_of_cryptocurrencies) for cryptocurrencies, e.g. \"BTC\"; well known names for [Local Exchange Trading Systems](https://en.wikipedia.org/wiki/Local_exchange_trading_system) (LETS) and other currency types, e.g. \"Ithaca HOUR\".'),
(968, 1, 6, 'reservationId', 'reservationId', 'A unique identifier for the reservation.'),
(969, 1, 6, 'dateDeleted', 'dateDeleted', 'The datetime the item was removed from the DataFeed.'),
(970, 1, 6, 'videoQuality', 'videoQuality', 'The quality of the video.'),
(971, 1, 6, 'dateVehicleFirstRegistered', 'dateVehicleFirstRegistered', 'The date of the first registration of the vehicle with the respective public authorities.'),
(972, 1, 6, 'partOfEpisode', 'partOfEpisode', 'The episode to which this clip belongs.'),
(973, 1, 6, 'specialOpeningHoursSpecification', 'specialOpeningHoursSpecification', 'The special opening hours of a certain place.\\n\\nUse this to explicitly override general opening hours brought in scope by [[openingHoursSpecification]] or [[openingHours]].\n      '),
(974, 1, 6, 'duns', 'duns', 'The Dun & Bradstreet DUNS number for identifying an organization or business person.'),
(975, 1, 6, 'customerRemorseReturnShippingFeesAmount', 'customerRemorseReturnShippingFeesAmount', 'The amount of shipping costs if a product is returned due to customer remorse. Applicable when property [[customerRemorseReturnFees]] equals [[ReturnShippingFees]].'),
(976, 1, 6, 'copyrightNotice', 'copyrightNotice', 'Text of a notice appropriate for describing the copyright aspects of this Creative Work, ideally indicating the owner of the copyright for the Work.'),
(977, 1, 6, 'numberOfFullBathrooms', 'numberOfFullBathrooms', 'Number of full bathrooms - The total number of full and ¾ bathrooms in an [[Accommodation]]. This corresponds to the [BathroomsFull field in RESO](https://ddwiki.reso.org/display/DDW17/BathroomsFull+Field).'),
(978, 1, 6, 'tourBookingPage', 'tourBookingPage', 'A page providing information on how to book a tour of some [[Place]], such as an [[Accommodation]] or [[ApartmentComplex]] in a real estate setting, as well as other kinds of tours as appropriate.'),
(979, 1, 6, 'arrivalStation', 'arrivalStation', 'The station where the train trip ends.'),
(980, 1, 6, 'mediaAuthenticityCategory', 'mediaAuthenticityCategory', 'Indicates a MediaManipulationRatingEnumeration classification of a media object (in the context of how it was published or shared).'),
(981, 1, 6, 'healthPlanCoinsuranceRate', 'healthPlanCoinsuranceRate', 'The rate of coinsurance expressed as a number between 0.0 and 1.0.'),
(982, 1, 6, 'branchOf', 'branchOf', 'The larger organization that this local business is a branch of, if any. Not to be confused with (anatomical) [[branch]].'),
(983, 1, 6, 'parentOrganization', 'parentOrganization', 'The larger organization that this organization is a [[subOrganization]] of, if any.'),
(984, 1, 6, 'attendees', 'attendees', 'A person attending the event.'),
(985, 1, 6, 'attendee', 'attendee', 'A person or organization attending the event.'),
(986, 1, 6, 'maximumPhysicalAttendeeCapacity', 'maximumPhysicalAttendeeCapacity', 'The maximum physical attendee capacity of an [[Event]] whose [[eventAttendanceMode]] is [[OfflineEventAttendanceMode]] (or the offline aspects, in the case of a [[MixedEventAttendanceMode]]). '),
(987, 1, 6, 'applicableLocation', 'applicableLocation', 'The location in which the status applies.'),
(988, 1, 6, 'membershipNumber', 'membershipNumber', 'A unique identifier for the membership.'),
(989, 1, 6, 'courseCode', 'courseCode', 'The identifier for the [[Course]] used by the course [[provider]] (e.g. CS101 or 6.001).'),
(990, 1, 6, 'termsOfService', 'termsOfService', 'Human-readable terms of service documentation.'),
(991, 1, 6, 'originalMediaContextDescription', 'originalMediaContextDescription', 'Describes, in a [[MediaReview]] when dealing with [[DecontextualizedContent]], background information that can contribute to better interpretation of the [[MediaObject]].'),
(992, 1, 6, 'countryOfOrigin', 'countryOfOrigin', 'The country of origin of something, including products as well as creative  works such as movie and TV content.\n\nIn the case of TV and movie, this would be the country of the principle offices of the production company or individual responsible for the movie. For other kinds of [[CreativeWork]] it is difficult to provide fully general guidance, and properties such as [[contentLocation]] and [[locationCreated]] may be more applicable.\n\nIn the case of products, the country of origin of the product. The exact interpretation of this may vary by context and product type, and cannot be fully enumerated here.'),
(993, 1, 6, 'countryOfAssembly', 'countryOfAssembly', 'The place where the product was assembled.'),
(994, 1, 6, 'gettingTestedInfo', 'gettingTestedInfo', 'Information about getting tested (for a [[MedicalCondition]]), e.g. in the context of a pandemic.'),
(995, 1, 6, 'question', 'question', 'A sub property of object. A question.'),
(996, 1, 6, 'totalTime', 'totalTime', 'The total time required to perform instructions or a direction (including time to prepare the supplies), in [ISO 8601 duration format](http://en.wikipedia.org/wiki/ISO_8601).'),
(997, 1, 6, 'serverStatus', 'serverStatus', 'Status of a game server.'),
(998, 1, 6, 'acceptsReservations', 'acceptsReservations', 'Indicates whether a FoodEstablishment accepts reservations. Values can be Boolean, an URL at which reservations can be made or (for backwards compatibility) the strings ```Yes``` or ```No```.'),
(999, 1, 6, 'starRating', 'starRating', 'An official rating for a lodging business or food establishment, e.g. from national associations or standards bodies. Use the author property to indicate the rating organization, e.g. as an Organization with name such as (e.g. HOTREC, DEHOGA, WHR, or Hotelstars).'),
(1000, 1, 6, 'agent', 'agent', 'The direct performer or driver of the action (animate or inanimate). E.g. *John* wrote a book.'),
(1001, 1, 6, 'email', 'email', 'Email address.'),
(1002, 1, 6, 'numberOfItems', 'numberOfItems', 'The number of items in an ItemList. Note that some descriptions might not fully describe all items in a list (e.g., multi-page pagination); in such cases, the numberOfItems would be for the entire list.'),
(1003, 1, 6, 'chemicalRole', 'chemicalRole', 'A role played by the BioChemEntity within a chemical context.'),
(1004, 1, 6, 'item', 'item', 'An entity represented by an entry in a list or data feed (e.g. an \'artist\' in a list of \'artists\').'),
(1005, 1, 6, 'validFrom', 'validFrom', 'The date when the item becomes valid.'),
(1006, 1, 6, 'taxonRank', 'taxonRank', 'The taxonomic rank of this taxon given preferably as a URI from a controlled vocabulary – typically the ranks from TDWG TaxonRank ontology or equivalent Wikidata URIs.'),
(1007, 1, 6, 'hasCategoryCode', 'hasCategoryCode', 'A Category code contained in this code set.'),
(1008, 1, 6, 'hasDefinedTerm', 'hasDefinedTerm', 'A Defined Term contained in this term set.'),
(1009, 1, 6, 'healthPlanCostSharing', 'healthPlanCostSharing', 'The costs to the patient for services under this network or formulary.'),
(1010, 1, 6, 'actionPlatform', 'actionPlatform', 'The high level platform(s) where the Action can be performed for the given URL. To specify a specific application or operating system instance, use actionApplication.'),
(1011, 1, 6, 'observationDate', 'observationDate', 'The observationDate of an [[Observation]].'),
(1012, 1, 6, 'cssSelector', 'cssSelector', 'A CSS selector, e.g. of a [[SpeakableSpecification]] or [[WebPageElement]]. In the latter case, multiple matches within a page can constitute a single conceptual \"Web page element\".'),
(1013, 1, 6, 'bccRecipient', 'bccRecipient', 'A sub property of recipient. The recipient blind copied on a message.'),
(1014, 1, 6, 'gameEdition', 'gameEdition', 'The edition of a video game.'),
(1015, 1, 6, 'evidenceLevel', 'evidenceLevel', 'Strength of evidence of the data used to formulate the guideline (enumerated).'),
(1016, 1, 6, 'headline', 'headline', 'Headline of the article.'),
(1017, 1, 6, 'interactionType', 'interactionType', 'The Action representing the type of interaction. For up votes, +1s, etc. use [[LikeAction]]. For down votes use [[DislikeAction]]. Otherwise, use the most specific Action.'),
(1018, 1, 6, 'structuralClass', 'structuralClass', 'The name given to how bone physically connects to each other.'),
(1019, 1, 6, 'workload', 'workload', 'Quantitative measure of the physiologic output of the exercise; also referred to as energy expenditure.'),
(1020, 1, 6, 'repeatCount', 'repeatCount', 'Defines the number of times a recurring [[Event]] will take place.'),
(1021, 1, 6, 'adverseOutcome', 'adverseOutcome', 'A possible complication and/or side effect of this therapy. If it is known that an adverse outcome is serious (resulting in death, disability, or permanent damage; requiring hospitalization; or otherwise life-threatening or requiring immediate medical attention), tag it as a seriousAdverseOutcome instead.'),
(1022, 1, 6, 'departureStation', 'departureStation', 'The station from which the train departs.'),
(1023, 1, 6, 'proteinContent', 'proteinContent', 'The number of grams of protein.'),
(1024, 1, 6, 'accessibilityHazard', 'accessibilityHazard', 'A characteristic of the described resource that is physiologically dangerous to some users. Related to WCAG 2.0 guideline 2.3. Values should be drawn from the [approved vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityHazard-vocabulary).'),
(1025, 1, 6, 'regionDrained', 'regionDrained', 'The anatomical or organ system drained by this vessel; generally refers to a specific part of an organ.'),
(1026, 1, 6, 'commentTime', 'commentTime', 'The time at which the UserComment was made.'),
(1027, 1, 6, 'boardingPolicy', 'boardingPolicy', 'The type of boarding policy used by the airline (e.g. zone-based or group-based).'),
(1028, 1, 6, 'vehicleConfiguration', 'vehicleConfiguration', 'A short text indicating the configuration of the vehicle, e.g. \'5dr hatchback ST 2.5 MT 225 hp\' or \'limited edition\'.'),
(1029, 1, 6, 'billingIncrement', 'billingIncrement', 'This property specifies the minimal quantity and rounding increment that will be the basis for the billing. The unit of measurement is specified by the unitCode property.'),
(1030, 1, 6, 'securityClearanceRequirement', 'securityClearanceRequirement', 'A description of any security clearance requirements of the job.'),
(1031, 1, 6, 'drugClass', 'drugClass', 'The class of drug this belongs to (e.g., statins).'),
(1032, 1, 6, 'regionsAllowed', 'regionsAllowed', 'The regions where the media is allowed. If not specified, then it\'s assumed to be allowed everywhere. Specify the countries in [ISO 3166 format](http://en.wikipedia.org/wiki/ISO_3166).'),
(1033, 1, 6, 'screenshot', 'screenshot', 'A link to a screenshot image of the app.'),
(1034, 1, 6, 'appearance', 'appearance', 'Indicates an occurrence of a [[Claim]] in some [[CreativeWork]].'),
(1035, 1, 6, 'toRecipient', 'toRecipient', 'A sub property of recipient. The recipient who was directly sent the message.'),
(1036, 1, 6, 'numberOfPartialBathrooms', 'numberOfPartialBathrooms', 'Number of partial bathrooms - The total number of half and ¼ bathrooms in an [[Accommodation]]. This corresponds to the [BathroomsPartial field in RESO](https://ddwiki.reso.org/display/DDW17/BathroomsPartial+Field). '),
(1037, 1, 6, 'arrivalTerminal', 'arrivalTerminal', 'Identifier of the flight\'s arrival terminal.'),
(1038, 1, 6, 'hasCourse', 'hasCourse', 'A course or class that is one of the learning opportunities that constitute an educational / occupational program. No information is implied about whether the course is mandatory or optional; no guarantee is implied about whether the course will be available to everyone on the program.'),
(1039, 1, 6, 'includedInHealthInsurancePlan', 'includedInHealthInsurancePlan', 'The insurance plans that cover this drug.'),
(1040, 1, 6, 'valueRequired', 'valueRequired', 'Whether the property must be filled in to complete the action.  Default is false.'),
(1041, 1, 6, 'processorRequirements', 'processorRequirements', 'Processor architecture required to run the application (e.g. IA64).'),
(1042, 1, 6, 'minPrice', 'minPrice', 'The lowest price if the price is a range.'),
(1043, 1, 6, 'diseaseSpreadStatistics', 'diseaseSpreadStatistics', 'Statistical information about the spread of a disease, either as [[WebContent]], or\n  described directly as a [[Dataset]], or the specific [[Observation]]s in the dataset. When a [[WebContent]] URL is\n  provided, the page indicated might also contain more such markup.'),
(1044, 1, 6, 'cutoffTime', 'cutoffTime', 'Order cutoff time allows merchants to describe the time after which they will no longer process orders received on that day. For orders processed after cutoff time, one day gets added to the delivery time estimate. This property is expected to be most typically used via the [[ShippingRateSettings]] publication pattern. The time is indicated using the ISO-8601 Time format, e.g. \"23:30:00-05:00\" would represent 6:30 pm Eastern Standard Time (EST) which is 5 hours behind Coordinated Universal Time (UTC).'),
(1045, 1, 6, 'legislationChanges', 'legislationChanges', 'Another legislation that this legislation changes. This encompasses the notions of amendment, replacement, correction, repeal, or other types of change. This may be a direct change (textual or non-textual amendment) or a consequential or indirect change. The property is to be used to express the existence of a change relationship between two acts rather than the existence of a consolidated version of the text that shows the result of the change. For consolidation relationships, use the <a href=\"/legislationConsolidates\">legislationConsolidates</a> property.'),
(1046, 1, 6, 'episodes', 'episodes', 'An episode of a TV/radio series or season.'),
(1047, 1, 6, 'episode', 'episode', 'An episode of a TV, radio or game media within a series or season.'),
(1048, 1, 6, 'permissions', 'permissions', 'Permission(s) required to run the app (for example, a mobile app may require full internet access or may run only on wifi).'),
(1049, 1, 6, 'strengthUnit', 'strengthUnit', 'The units of an active ingredient\'s strength, e.g. mg.'),
(1050, 1, 6, 'endDate', 'endDate', 'The end date and time of the item (in [ISO 8601 date format](http://en.wikipedia.org/wiki/ISO_8601)).'),
(1051, 1, 6, 'shippingDestination', 'shippingDestination', 'indicates (possibly multiple) shipping destinations. These can be defined in several ways, e.g. postalCode ranges.'),
(1052, 1, 6, 'accessCode', 'accessCode', 'Password, PIN, or access code needed for delivery (e.g. from a locker).'),
(1053, 1, 6, 'smiles', 'smiles', 'A specification in form of a line notation for describing the structure of chemical species using short ASCII strings.  Double bond stereochemistry \\ indicators may need to be escaped in the string in formats where the backslash is an escape character.'),
(1054, 1, 6, 'afterMedia', 'afterMedia', 'A media object representing the circumstances after performing this direction.'),
(1055, 1, 6, 'gameTip', 'gameTip', 'Links to tips, tactics, etc.'),
(1056, 1, 6, 'yearsInOperation', 'yearsInOperation', 'The age of the business.'),
(1057, 1, 6, 'speakable', 'speakable', 'Indicates sections of a Web page that are particularly \'speakable\' in the sense of being highlighted as being especially appropriate for text-to-speech conversion. Other sections of a page may also be usefully spoken in particular circumstances; the \'speakable\' property serves to indicate the parts most likely to be generally useful for speech.\n\nThe *speakable* property can be repeated an arbitrary number of times, with three kinds of possible \'content-locator\' values:\n\n1.) *id-value* URL references - uses *id-value* of an element in the page being annotated. The simplest use of *speakable* has (potentially relative) URL values, referencing identified sections of the document concerned.\n\n2.) CSS Selectors - addresses content in the annotated page, e.g. via class attribute. Use the [[cssSelector]] property.\n\n3.)  XPaths - addresses content via XPaths (assuming an XML view of the content). Use the [[xpath]] property.\n\n\nFor more sophisticated markup of speakable sections beyond simple ID references, either CSS selectors or XPath expressions to pick out document section(s) as speakable. For this\nwe define a supporting type, [[SpeakableSpecification]]  which is defined to be a possible value of the *speakable* property.\n         '),
(1058, 1, 6, 'accessMode', 'accessMode', 'The human sensory perceptual system or cognitive faculty through which a person may process or perceive information. Values should be drawn from the [approved vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/#accessMode-vocabulary).'),
(1059, 1, 6, 'orderNumber', 'orderNumber', 'The identifier of the transaction.'),
(1060, 1, 6, 'foundingDate', 'foundingDate', 'The date that this organization was founded.'),
(1061, 1, 6, 'fuelEfficiency', 'fuelEfficiency', 'The distance traveled per unit of fuel used; most commonly miles per gallon (mpg) or kilometers per liter (km/L).\\n\\n* Note 1: There are unfortunately no standard unit codes for miles per gallon or kilometers per liter. Use [[unitText]] to indicate the unit of measurement, e.g. mpg or km/L.\\n* Note 2: There are two ways of indicating the fuel consumption, [[fuelConsumption]] (e.g. 8 liters per 100 km) and [[fuelEfficiency]] (e.g. 30 miles per gallon). They are reciprocal.\\n* Note 3: Often, the absolute value is useful only when related to driving speed (\"at 80 km/h\") or usage pattern (\"city traffic\"). You can use [[valueReference]] to link the value for the fuel economy to another value.'),
(1062, 1, 6, 'hasOccupation', 'hasOccupation', 'The Person\'s occupation. For past professions, use Role for expressing dates.'),
(1063, 1, 6, 'inAlbum', 'inAlbum', 'The album to which this recording belongs.'),
(1064, 1, 6, 'knownVehicleDamages', 'knownVehicleDamages', 'A textual description of known damages, both repaired and unrepaired.'),
(1065, 1, 6, 'dataFeedElement', 'dataFeedElement', 'An item within a data feed. Data feeds may have many elements.'),
(1066, 1, 6, 'expressedIn', 'expressedIn', 'Tissue, organ, biological sample, etc in which activity of this gene has been observed experimentally. For example brain, digestive system.'),
(1067, 1, 6, 'size', 'size', 'A standardized size of a product or creative work, specified either through a simple textual string (for example \'XL\', \'32Wx34L\'), a  QuantitativeValue with a unitCode, or a comprehensive and structured [[SizeSpecification]]; in other cases, the [[width]], [[height]], [[depth]] and [[weight]] properties may be more applicable. '),
(1068, 1, 6, 'customer', 'customer', 'Party placing the order or paying the invoice.'),
(1069, 1, 6, 'employees', 'employees', 'People working for this organization.'),
(1070, 1, 6, 'employee', 'employee', 'Someone working for this organization.'),
(1071, 1, 6, 'providesService', 'providesService', 'The service provided by this channel.'),
(1072, 1, 6, 'printSection', 'printSection', 'If this NewsArticle appears in print, this field indicates the print section in which the article appeared.'),
(1073, 1, 6, 'text', 'text', 'The textual content of this CreativeWork.'),
(1074, 1, 6, 'legislationLegalValue', 'legislationLegalValue', 'The legal value of this legislation file. The same legislation can be written in multiple files with different legal values. Typically a digitally signed PDF have a \"stronger\" legal value than the HTML file of the same act.'),
(1075, 1, 6, 'earlyPrepaymentPenalty', 'earlyPrepaymentPenalty', 'The amount to be paid as a penalty in the event of early payment of the loan.'),
(1076, 1, 6, 'returnMethod', 'returnMethod', 'The type of return method offered, specified from an enumeration.'),
(1077, 1, 6, 'commentText', 'commentText', 'The text of the UserComment.'),
(1078, 1, 6, 'geoTouches', 'geoTouches', 'Represents spatial relations in which two geometries (or the places they represent) touch: \"they have at least one boundary point in common, but no interior points.\" (A symmetric relationship, as defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).)'),
(1079, 1, 6, 'labelDetails', 'labelDetails', 'Link to the drug\'s label details.'),
(1080, 1, 6, 'answerCount', 'answerCount', 'The number of answers this question has received.'),
(1081, 1, 6, 'archivedAt', 'archivedAt', 'Indicates a page or other link involved in archival of a [[CreativeWork]]. In the case of [[MediaReview]], the items in a [[MediaReviewItem]] may often become inaccessible, but be archived by archival, journalistic, activist, or law enforcement organizations. In such cases, the referenced page may not directly publish the content.'),
(1082, 1, 6, 'relatedAnatomy', 'relatedAnatomy', 'Anatomical systems or structures that relate to the superficial anatomy.'),
(1083, 1, 6, 'accountMinimumInflow', 'accountMinimumInflow', 'A minimum amount that has to be paid in every month.'),
(1084, 1, 6, 'photos', 'photos', 'Photographs of this place.'),
(1085, 1, 6, 'photo', 'photo', 'A photograph of this place.'),
(1086, 1, 6, 'interactionService', 'interactionService', 'The WebSite or SoftwareApplication where the interactions took place.'),
(1087, 1, 6, 'physiologicalBenefits', 'physiologicalBenefits', 'Specific physiologic benefits associated to the plan.'),
(1088, 1, 6, 'previousItem', 'previousItem', 'A link to the ListItem that precedes the current one.'),
(1089, 1, 6, 'duplicateTherapy', 'duplicateTherapy', 'A therapy that duplicates or overlaps this one.'),
(1090, 1, 6, 'busNumber', 'busNumber', 'The unique identifier for the bus.'),
(1091, 1, 6, 'artEdition', 'artEdition', 'The number of copies when multiple copies of a piece of artwork are produced - e.g. for a limited edition of 20 prints, \'artEdition\' refers to the total number of copies (in this example \"20\").'),
(1092, 1, 6, 'foodEvent', 'foodEvent', 'A sub property of location. The specific food event where the action occurred.'),
(1093, 1, 6, 'gender', 'gender', 'Gender of something, typically a [[Person]], but possibly also fictional characters, animals, etc. While https://schema.org/Male and https://schema.org/Female may be used, text strings are also acceptable for people who do not identify as a binary gender. The [[gender]] property can also be used in an extended sense to cover e.g. the gender of sports teams. As with the gender of individuals, we do not try to enumerate all possibilities. A mixed-gender [[SportsTeam]] can be indicated with a text value of \"Mixed\".'),
(1094, 1, 6, 'deliveryAddress', 'deliveryAddress', 'Destination address.'),
(1095, 1, 6, 'valueName', 'valueName', 'Indicates the name of the PropertyValueSpecification to be used in URL templates and form encoding in a manner analogous to HTML\'s input@name.'),
(1096, 1, 6, 'saturatedFatContent', 'saturatedFatContent', 'The number of grams of saturated fat.'),
(1097, 1, 6, 'articleSection', 'articleSection', 'Articles may belong to one or more \'sections\' in a magazine or newspaper, such as Sports, Lifestyle, etc.'),
(1098, 1, 6, 'byMonthWeek', 'byMonthWeek', 'Defines the week(s) of the month on which a recurring Event takes place. Specified as an Integer between 1-5. For clarity, byMonthWeek is best used in conjunction with byDay to indicate concepts like the first and third Mondays of a month.'),
(1099, 1, 6, 'assembly', 'assembly', 'Library file name, e.g., mscorlib.dll, system.web.dll.'),
(1100, 1, 6, 'executableLibraryName', 'executableLibraryName', 'Library file name, e.g., mscorlib.dll, system.web.dll.'),
(1101, 1, 6, 'closes', 'closes', 'The closing hour of the place or service on the given day(s) of the week.'),
(1102, 1, 6, 'activityDuration', 'activityDuration', 'Length of time to engage in the activity.'),
(1103, 1, 6, 'bitrate', 'bitrate', 'The bitrate of the media object.'),
(1104, 1, 6, 'amount', 'amount', 'The amount of money.'),
(1105, 1, 6, 'rxcui', 'rxcui', 'The RxCUI drug identifier from RXNORM.'),
(1106, 1, 6, 'percentile90', 'percentile90', 'The 90th percentile value.'),
(1107, 1, 6, 'diagram', 'diagram', 'An image containing a diagram that illustrates the structure and/or its component substructures and/or connections with other structures.'),
(1108, 1, 6, 'loanPaymentAmount', 'loanPaymentAmount', 'The amount of money to pay in a single payment.'),
(1109, 1, 6, 'paymentDue', 'paymentDue', 'The date that payment is due.'),
(1110, 1, 6, 'paymentDueDate', 'paymentDueDate', 'The date that payment is due.'),
(1111, 1, 6, 'maxValue', 'maxValue', 'The upper value of some characteristic or property.'),
(1112, 1, 6, 'numberOfAccommodationUnits', 'numberOfAccommodationUnits', 'Indicates the total (available plus unavailable) number of accommodation units in an [[ApartmentComplex]], or the number of accommodation units for a specific [[FloorPlan]] (within its specific [[ApartmentComplex]]). See also [[numberOfAvailableAccommodationUnits]].'),
(1113, 1, 6, 'restockingFee', 'restockingFee', 'Use [[MonetaryAmount]] to specify a fixed restocking fee for product returns, or use [[Number]] to specify a percentage of the product price paid by the customer.'),
(1114, 1, 6, 'colleagues', 'colleagues', 'A colleague of the person.'),
(1115, 1, 6, 'colleague', 'colleague', 'A colleague of the person.'),
(1116, 1, 6, 'mobileUrl', 'mobileUrl', 'The [[mobileUrl]] property is provided for specific situations in which data consumers need to determine whether one of several provided URLs is a dedicated \'mobile site\'.\n\nTo discourage over-use, and reflecting intial usecases, the property is expected only on [[Product]] and [[Offer]], rather than [[Thing]]. The general trend in web technology is towards [responsive design](https://en.wikipedia.org/wiki/Responsive_web_design) in which content can be flexibly adapted to a wide range of browsing environments. Pages and sites referenced with the long-established [[url]] property should ideally also be usable on a wide variety of devices, including mobile phones. In most cases, it would be pointless and counter productive to attempt to update all [[url]] markup to use [[mobileUrl]] for more mobile-oriented pages. The property is intended for the case when items (primarily [[Product]] and [[Offer]]) have extra URLs hosted on an additional \"mobile site\" alongside the main one. It should not be taken as an endorsement of this publication style.\n    '),
(1117, 1, 6, 'suggestedGender', 'suggestedGender', 'The suggested gender of the intended person or audience, for example \"male\", \"female\", or \"unisex\".'),
(1118, 1, 6, 'eventStatus', 'eventStatus', 'An eventStatus of an event represents its status; particularly useful when an event is cancelled or rescheduled.'),
(1119, 1, 6, 'discusses', 'discusses', 'Specifies the CreativeWork associated with the UserComment.'),
(1120, 1, 6, 'borrower', 'borrower', 'A sub property of participant. The person that borrows the object being lent.'),
(1121, 1, 6, 'inBroadcastLineup', 'inBroadcastLineup', 'The CableOrSatelliteService offering the channel.'),
(1122, 1, 6, 'intensity', 'intensity', 'Quantitative measure gauging the degree of force involved in the exercise, for example, heartbeats per minute. May include the velocity of the movement.'),
(1123, 1, 6, 'textValue', 'textValue', 'Text value being annotated.'),
(1124, 1, 6, 'isAccessoryOrSparePartFor', 'isAccessoryOrSparePartFor', 'A pointer to another product (or multiple products) for which this product is an accessory or spare part.'),
(1125, 1, 6, 'previousStartDate', 'previousStartDate', 'Used in conjunction with eventStatus for rescheduled or cancelled events. This property contains the previously scheduled start date. For rescheduled events, the startDate property should be used for the newly scheduled start date. In the (rare) case of an event that has been postponed and rescheduled multiple times, this field may be repeated.'),
(1126, 1, 6, 'maintainer', 'maintainer', 'A maintainer of a [[Dataset]], software package ([[SoftwareApplication]]), or other [[Project]]. A maintainer is a [[Person]] or [[Organization]] that manages contributions to, and/or publication of, some (typically complex) artifact. It is common for distributions of software and data to be based on \"upstream\" sources. When [[maintainer]] is applied to a specific version of something e.g. a particular version or packaging of a [[Dataset]], it is always  possible that the upstream source has a different maintainer. The [[isBasedOn]] property can be used to indicate such relationships between datasets to make the different maintenance roles clear. Similarly in the case of software, a package may have dedicated maintainers working on integration into software distributions such as Ubuntu, as well as upstream maintainers of the underlying work.\n      '),
(1127, 1, 6, 'primaryPrevention', 'primaryPrevention', 'A preventative therapy used to prevent an initial occurrence of the medical condition, such as vaccination.'),
(1128, 1, 6, 'buyer', 'buyer', 'A sub property of participant. The participant/person/organization that bought the object.'),
(1129, 1, 6, 'suggestedAge', 'suggestedAge', 'The age or age range for the intended audience or person, for example 3-12 months for infants, 1-5 years for toddlers.'),
(1130, 1, 6, 'httpMethod', 'httpMethod', 'An HTTP method that specifies the appropriate HTTP method for a request to an HTTP EntryPoint. Values are capitalized strings as used in HTTP.'),
(1131, 1, 6, 'originalMediaLink', 'originalMediaLink', 'Link to the page containing an original version of the content, or directly to an online copy of the original [[MediaObject]] content, e.g. video file.'),
(1132, 1, 6, 'sameAs', 'sameAs', 'URL of a reference Web page that unambiguously indicates the item\'s identity. E.g. the URL of the item\'s Wikipedia page, Wikidata entry, or official website.'),
(1133, 1, 6, 'broadcaster', 'broadcaster', 'The organization owning or operating the broadcast service.'),
(1134, 1, 6, 'jobLocationType', 'jobLocationType', 'A description of the job location (e.g. TELECOMMUTE for telecommute jobs).'),
(1135, 1, 6, 'arrivalBusStop', 'arrivalBusStop', 'The stop or station from which the bus arrives.'),
(1136, 1, 6, 'relevantSpecialty', 'relevantSpecialty', 'If applicable, a medical specialty in which this entity is relevant.'),
(1137, 1, 6, 'permitAudience', 'permitAudience', 'The target audience for this permit.'),
(1138, 1, 6, 'seatingCapacity', 'seatingCapacity', 'The number of persons that can be seated (e.g. in a vehicle), both in terms of the physical space available, and in terms of limitations set by law.\\n\\nTypical unit code(s): C62 for persons '),
(1139, 1, 6, 'reviewBody', 'reviewBody', 'The actual body of the review.'),
(1140, 1, 6, 'serviceType', 'serviceType', 'The type of service being offered, e.g. veterans\' benefits, emergency relief, etc.'),
(1141, 1, 6, 'jobTitle', 'jobTitle', 'The job title of the person (for example, Financial Manager).'),
(1142, 1, 6, 'riskFactor', 'riskFactor', 'A modifiable or non-modifiable factor that increases the risk of a patient contracting this condition, e.g. age,  coexisting condition.'),
(1143, 1, 6, 'reservationFor', 'reservationFor', 'The thing -- flight, event, restaurant, etc. being reserved.'),
(1144, 1, 6, 'itemShipped', 'itemShipped', 'Item(s) being shipped.'),
(1145, 1, 6, 'trackingNumber', 'trackingNumber', 'Shipper tracking number.'),
(1146, 1, 6, 'totalPrice', 'totalPrice', 'The total price for the reservation or ticket, including applicable taxes, shipping, etc.\\n\\nUsage guidelines:\\n\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.'),
(1147, 1, 6, 'inSupportOf', 'inSupportOf', 'Qualification, candidature, degree, application that Thesis supports.'),
(1148, 1, 6, 'educationalProgramMode', 'educationalProgramMode', 'Similar to courseMode, the medium or means of delivery of the program as a whole. The value may either be a text label (e.g. \"online\", \"onsite\" or \"blended\"; \"synchronous\" or \"asynchronous\"; \"full-time\" or \"part-time\") or a URL reference to a term from a controlled vocabulary (e.g. https://ceds.ed.gov/element/001311#Asynchronous ).'),
(1149, 1, 6, 'nsn', 'nsn', 'Indicates the [NATO stock number](https://en.wikipedia.org/wiki/NATO_Stock_Number) (nsn) of a [[Product]]. '),
(1150, 1, 6, 'maxPrice', 'maxPrice', 'The highest price if the price is a range.'),
(1151, 1, 6, 'accessibilityFeature', 'accessibilityFeature', 'Content features of the resource, such as accessible media, alternatives and supported enhancements for accessibility. Values should be drawn from the [approved vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityFeature-vocabulary).'),
(1152, 1, 6, 'measuredValue', 'measuredValue', 'The measuredValue of an [[Observation]].'),
(1153, 1, 6, 'broadcastOfEvent', 'broadcastOfEvent', 'The event being broadcast such as a sporting event or awards ceremony.'),
(1154, 1, 6, 'leiCode', 'leiCode', 'An organization identifier that uniquely identifies a legal entity as defined in ISO 17442.'),
(1155, 1, 6, 'includesHealthPlanNetwork', 'includesHealthPlanNetwork', 'Networks covered by this plan.'),
(1156, 1, 6, 'sha256', 'sha256', 'The [SHA-2](https://en.wikipedia.org/wiki/SHA-2) SHA256 hash of the content of the item. For example, a zero-length input has value \'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\''),
(1157, 1, 6, 'creativeWorkStatus', 'creativeWorkStatus', 'The status of a creative work in terms of its stage in a lifecycle. Example terms include Incomplete, Draft, Published, Obsolete. Some organizations define a set of terms for the stages of their publication lifecycle.'),
(1158, 1, 6, 'availability', 'availability', 'The availability of this item&#x2014;for example In stock, Out of stock, Pre-order, etc.'),
(1159, 1, 6, 'suggestedMinAge', 'suggestedMinAge', 'Minimum recommended age in years for the audience or user.'),
(1160, 1, 6, 'reviewRating', 'reviewRating', 'The rating given in this review. Note that reviews can themselves be rated. The ```reviewRating``` applies to rating given by the review. The [[aggregateRating]] property applies to the review itself, as a creative work.'),
(1161, 1, 6, 'arrivalTime', 'arrivalTime', 'The expected arrival time.'),
(1162, 1, 6, 'doseUnit', 'doseUnit', 'The unit of the dose, e.g. \'mg\'.'),
(1163, 1, 6, 'legalName', 'legalName', 'The official name of the organization, e.g. the registered company name.'),
(1164, 1, 6, 'priceValidUntil', 'priceValidUntil', 'The date after which the price is no longer available.'),
(1165, 1, 6, 'founders', 'founders', 'A person who founded this organization.'),
(1166, 1, 6, 'founder', 'founder', 'A person who founded this organization.'),
(1167, 1, 6, 'partOfSystem', 'partOfSystem', 'The anatomical or organ system that this structure is part of.'),
(1168, 1, 6, 'businessDays', 'businessDays', 'Days of the week when the merchant typically operates, indicated via opening hours markup.'),
(1169, 1, 6, 'numberOfBedrooms', 'numberOfBedrooms', 'The total integer number of bedrooms in a some [[Accommodation]], [[ApartmentComplex]] or [[FloorPlan]].'),
(1170, 1, 6, 'fiberContent', 'fiberContent', 'The number of grams of fiber.'),
(1171, 1, 6, 'diet', 'diet', 'A sub property of instrument. The diet used in this action.'),
(1172, 1, 6, 'normalRange', 'normalRange', 'Range of acceptable values for a typical patient, when applicable.'),
(1173, 1, 6, 'boardingGroup', 'boardingGroup', 'The airline-specific indicator of boarding order / preference.'),
(1174, 1, 6, 'applicationContact', 'applicationContact', 'Contact details for further information relevant to this job posting.'),
(1175, 1, 6, 'numChildren', 'numChildren', 'The number of children staying in the unit.'),
(1176, 1, 6, 'sportsActivityLocation', 'sportsActivityLocation', 'A sub property of location. The sports activity location where this action occurred.'),
(1177, 1, 6, 'target', 'target', 'Indicates a target EntryPoint, or url, for an Action.'),
(1178, 1, 6, 'billingPeriod', 'billingPeriod', 'The time interval used to compute the invoice.'),
(1179, 1, 6, 'dissolutionDate', 'dissolutionDate', 'The date that this organization was dissolved.'),
(1180, 1, 6, 'interpretedAsClaim', 'interpretedAsClaim', 'Used to indicate a specific claim contained, implied, translated or refined from the content of a [[MediaObject]] or other [[CreativeWork]]. The interpreting party can be indicated using [[claimInterpreter]].'),
(1181, 1, 6, 'fileSize', 'fileSize', 'Size of the application / package (e.g. 18MB). In the absence of a unit (MB, KB etc.), KB will be assumed.'),
(1182, 1, 6, 'availableService', 'availableService', 'A medical service available from this provider.'),
(1183, 1, 6, 'subtitleLanguage', 'subtitleLanguage', 'Languages in which subtitles/captions are available, in [IETF BCP 47 standard format](http://tools.ietf.org/html/bcp47).'),
(1184, 1, 6, 'postalCodeBegin', 'postalCodeBegin', 'First postal code in a range (included).'),
(1185, 1, 6, 'loanMortgageMandateAmount', 'loanMortgageMandateAmount', 'Amount of mortgage mandate that can be converted into a proper mortgage at a later stage.'),
(1186, 1, 6, 'totalPaymentDue', 'totalPaymentDue', 'The total amount due.'),
(1187, 1, 6, 'trainNumber', 'trainNumber', 'The unique identifier for the train.'),
(1188, 1, 6, 'gameItem', 'gameItem', 'An item is an object within the game world that can be collected by a player or, occasionally, a non-player character.'),
(1189, 1, 6, 'targetDescription', 'targetDescription', 'The description of a node in an established educational framework.'),
(1190, 1, 6, 'availableLanguage', 'availableLanguage', 'A language someone may use with or at the item, service or place. Please use one of the language codes from the [IETF BCP 47 standard](http://tools.ietf.org/html/bcp47). See also [[inLanguage]].'),
(1191, 1, 6, 'exerciseType', 'exerciseType', 'Type(s) of exercise or activity, such as strength training, flexibility training, aerobics, cardiac rehabilitation, etc.'),
(1192, 1, 6, 'mileageFromOdometer', 'mileageFromOdometer', 'The total distance travelled by the particular vehicle since its initial production, as read from its odometer.\\n\\nTypical unit code(s): KMT for kilometers, SMI for statute miles'),
(1193, 1, 6, 'wheelbase', 'wheelbase', 'The distance between the centers of the front and rear wheels.\\n\\nTypical unit code(s): CMT for centimeters, MTR for meters, INH for inches, FOT for foot/feet'),
(1194, 1, 6, 'estimatedFlightDuration', 'estimatedFlightDuration', 'The estimated time the flight will take.'),
(1195, 1, 6, 'activityFrequency', 'activityFrequency', 'How often one should engage in the activity.'),
(1196, 1, 6, 'prepTime', 'prepTime', 'The length of time it takes to prepare the items to be used in instructions or a direction, in [ISO 8601 duration format](http://en.wikipedia.org/wiki/ISO_8601).'),
(1197, 1, 6, 'returnShippingFeesAmount', 'returnShippingFeesAmount', 'Amount of shipping costs for product returns (for any reason). Applicable when property [[returnFees]] equals [[ReturnShippingFees]].'),
(1198, 1, 6, 'educationalRole', 'educationalRole', 'An educationalRole of an EducationalAudience.'),
(1199, 1, 6, 'isUnlabelledFallback', 'isUnlabelledFallback', 'This can be marked \'true\' to indicate that some published [[DeliveryTimeSettings]] or [[ShippingRateSettings]] are intended to apply to all [[OfferShippingDetails]] published by the same merchant, when referenced by a [[shippingSettingsLink]] in those settings. It is not meaningful to use a \'true\' value for this property alongside a transitTimeLabel (for [[DeliveryTimeSettings]]) or shippingLabel (for [[ShippingRateSettings]]), since this property is for use with unlabelled settings.'),
(1200, 1, 6, 'supportingData', 'supportingData', 'Supporting data for a SoftwareApplication.'),
(1201, 1, 6, 'salaryUponCompletion', 'salaryUponCompletion', 'The expected salary upon completing the training.'),
(1202, 1, 6, 'orderedItem', 'orderedItem', 'The item ordered.'),
(1203, 1, 6, 'geoWithin', 'geoWithin', 'Represents a relationship between two geometries (or the places they represent), relating a geometry to one that contains it, i.e. it is inside (i.e. within) its interior. As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(1204, 1, 6, 'subReservation', 'subReservation', 'The individual reservations included in the package. Typically a repeated property.'),
(1205, 1, 6, 'doseSchedule', 'doseSchedule', 'A dosing schedule for the drug for a given population, either observed, recommended, or maximum dose based on the type used.'),
(1206, 1, 6, 'bloodSupply', 'bloodSupply', 'The blood vessel that carries blood from the heart to the muscle.'),
(1207, 1, 6, 'ownedFrom', 'ownedFrom', 'The date and time of obtaining the product.'),
(1208, 1, 6, 'healthPlanNetworkId', 'healthPlanNetworkId', 'Name or unique ID of network. (Networks are often reused across different insurance plans.)'),
(1209, 1, 6, 'reportNumber', 'reportNumber', 'The number or other unique designator assigned to a Report by the publishing organization.'),
(1210, 1, 6, 'sourceOrganization', 'sourceOrganization', 'The Organization on whose behalf the creator was working.'),
(1211, 1, 6, 'browserRequirements', 'browserRequirements', 'Specifies browser requirements in human-readable text. For example, \'requires HTML5 support\'.'),
(1212, 1, 6, 'legislationPassedBy', 'legislationPassedBy', 'The person or organization that originally passed or made the law: typically parliament (for primary legislation) or government (for secondary legislation). This indicates the \"legal author\" of the law, as opposed to its physical author.'),
(1213, 1, 6, 'creator', 'creator', 'The creator/author of this CreativeWork. This is the same as the Author property for CreativeWork.'),
(1214, 1, 6, 'dosageForm', 'dosageForm', 'A dosage form in which this drug/supplement is available, e.g. \'tablet\', \'suspension\', \'injection\'.'),
(1215, 1, 6, 'byMonthDay', 'byMonthDay', 'Defines the day(s) of the month on which a recurring [[Event]] takes place. Specified as an [[Integer]] between 1-31.'),
(1216, 1, 6, 'locationCreated', 'locationCreated', 'The location where the CreativeWork was created, which may not be the same as the location depicted in the CreativeWork.'),
(1217, 1, 6, 'timeToComplete', 'timeToComplete', 'The expected length of time to complete the program if attending full-time.'),
(1218, 1, 6, 'durationOfWarranty', 'durationOfWarranty', 'The duration of the warranty promise. Common unitCode values are ANN for year, MON for months, or DAY for days.');
INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1219, 1, 6, 'namedPosition', 'namedPosition', 'A position played, performed or filled by a person or organization, as part of an organization. For example, an athlete in a SportsTeam might play in the position named \'Quarterback\'.'),
(1220, 1, 6, 'roleName', 'roleName', 'A role played, performed or filled by a person or organization. For example, the team of creators for a comic book might fill the roles named \'inker\', \'penciller\', and \'letterer\'; or an athlete in a SportsTeam might play in the position named \'Quarterback\'.'),
(1221, 1, 6, 'observedNode', 'observedNode', 'The observedNode of an [[Observation]], often a [[StatisticalPopulation]].'),
(1222, 1, 6, 'applicableCountry', 'applicableCountry', 'A country where a particular merchant return policy applies to, for example the two-letter ISO 3166-1 alpha-2 country code.'),
(1223, 1, 6, 'softwareAddOn', 'softwareAddOn', 'Additional content for a software application.'),
(1224, 1, 6, 'noBylinesPolicy', 'noBylinesPolicy', 'For a [[NewsMediaOrganization]] or other news-related [[Organization]], a statement explaining when authors of articles are not named in bylines.'),
(1225, 1, 6, 'legislationLegalForce', 'legislationLegalForce', 'Whether the legislation is currently in force, not in force, or partially in force.'),
(1226, 1, 6, 'torque', 'torque', 'The torque (turning force) of the vehicle\'s engine.\\n\\nTypical unit code(s): NU for newton metre (N m), F17 for pound-force per foot, or F48 for pound-force per inch\\n\\n* Note 1: You can link to information about how the given value has been determined (e.g. reference RPM) using the [[valueReference]] property.\\n* Note 2: You can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(1227, 1, 6, 'toLocation', 'toLocation', 'A sub property of location. The final location of the object or the agent after the action.'),
(1228, 1, 6, 'readBy', 'readBy', 'A person who reads (performs) the audiobook.'),
(1229, 1, 6, 'sdDatePublished', 'sdDatePublished', 'Indicates the date on which the current structured data was generated / published. Typically used alongside [[sdPublisher]]'),
(1230, 1, 6, 'flightNumber', 'flightNumber', 'The unique identifier for a flight including the airline IATA code. For example, if describing United flight 110, where the IATA code for United is \'UA\', the flightNumber is \'UA110\'.'),
(1231, 1, 6, 'sku', 'sku', 'The Stock Keeping Unit (SKU), i.e. a merchant-specific identifier for a product or service, or the product to which the offer refers.'),
(1232, 1, 6, 'loanPaymentFrequency', 'loanPaymentFrequency', 'Frequency of payments due, i.e. number of months between payments. This is defined as a frequency, i.e. the reciprocal of a period of time.'),
(1233, 1, 6, 'isProprietary', 'isProprietary', 'True if this item\'s name is a proprietary/brand name (vs. generic name).'),
(1234, 1, 6, 'expertConsiderations', 'expertConsiderations', 'Medical expert advice related to the plan.'),
(1235, 1, 6, 'baseSalary', 'baseSalary', 'The base salary of the job or of an employee in an EmployeeRole.'),
(1236, 1, 6, 'hasCourseInstance', 'hasCourseInstance', 'An offering of the course at a specific time and place or through specific media or mode of study or to a specific section of students.'),
(1237, 1, 6, 'isConsumableFor', 'isConsumableFor', 'A pointer to another product (or multiple products) for which this product is a consumable.'),
(1238, 1, 6, 'menu', 'menu', 'Either the actual menu as a structured representation, as text, or a URL of the menu.'),
(1239, 1, 6, 'hasMenu', 'hasMenu', 'Either the actual menu as a structured representation, as text, or a URL of the menu.'),
(1240, 1, 6, 'deliveryLeadTime', 'deliveryLeadTime', 'The typical delay between the receipt of the order and the goods either leaving the warehouse or being prepared for pickup, in case the delivery method is on site pickup.'),
(1241, 1, 6, 'signDetected', 'signDetected', 'A sign detected by the test.'),
(1242, 1, 6, 'isLocatedInSubcellularLocation', 'isLocatedInSubcellularLocation', 'Subcellular location where this BioChemEntity is located; please use PropertyValue if you want to include any evidence.'),
(1243, 1, 6, 'stepValue', 'stepValue', 'The stepValue attribute indicates the granularity that is expected (and required) of the value in a PropertyValueSpecification.'),
(1244, 1, 6, 'tissueSample', 'tissueSample', 'The type of tissue sample required for the test.'),
(1245, 1, 6, 'producer', 'producer', 'The person or organization who produced the work (e.g. music album, movie, TV/radio series etc.).'),
(1246, 1, 6, 'publicTransportClosuresInfo', 'publicTransportClosuresInfo', 'Information about public transport closures.'),
(1247, 1, 6, 'performerIn', 'performerIn', 'Event that this person is a performer or participant in.'),
(1248, 1, 6, 'requiredCollateral', 'requiredCollateral', 'Assets required to secure loan or credit repayments. It may take form of third party pledge, goods, financial instruments (cash, securities, etc.)'),
(1249, 1, 6, 'enginePower', 'enginePower', 'The power of the vehicle\'s engine.\n    Typical unit code(s): KWT for kilowatt, BHP for brake horsepower, N12 for metric horsepower (PS, with 1 PS = 735,49875 W)\\n\\n* Note 1: There are many different ways of measuring an engine\'s power. For an overview, see  [http://en.wikipedia.org/wiki/Horsepower#Engine\\_power\\_test\\_codes](http://en.wikipedia.org/wiki/Horsepower#Engine_power_test_codes).\\n* Note 2: You can link to information about how the given value has been determined using the [[valueReference]] property.\\n* Note 3: You can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(1250, 1, 6, 'sportsEvent', 'sportsEvent', 'A sub property of location. The sports event where this action occurred.'),
(1251, 1, 6, 'validIn', 'validIn', 'The geographic area where a permit or similar thing is valid.'),
(1252, 1, 6, 'vatID', 'vatID', 'The Value-added Tax ID of the organization or person.'),
(1253, 1, 6, 'subTest', 'subTest', 'A component test of the panel.'),
(1254, 1, 6, 'runsTo', 'runsTo', 'The vasculature the lymphatic structure runs, or efferents, to.'),
(1255, 1, 6, 'hasMolecularFunction', 'hasMolecularFunction', 'Molecular function performed by this BioChemEntity; please use PropertyValue if you want to include any evidence.'),
(1256, 1, 6, 'parentItem', 'parentItem', 'The parent of a question, answer or item in general.'),
(1257, 1, 6, 'byArtist', 'byArtist', 'The artist that performed this album or recording.'),
(1258, 1, 6, 'box', 'box', 'A box is the area enclosed by the rectangle formed by two points. The first point is the lower corner, the second point is the upper corner. A box is expressed as two points separated by a space character.'),
(1259, 1, 6, 'replacer', 'replacer', 'A sub property of object. The object that replaces.'),
(1260, 1, 6, 'isrcCode', 'isrcCode', 'The International Standard Recording Code for the recording.'),
(1261, 1, 6, 'itemDefectReturnFees', 'itemDefectReturnFees', 'The type of return fees for returns of defect products.'),
(1262, 1, 6, 'includesHealthPlanFormulary', 'includesHealthPlanFormulary', 'Formularies covered by this plan.'),
(1263, 1, 6, 'meetsEmissionStandard', 'meetsEmissionStandard', 'Indicates that the vehicle meets the respective emission standard.'),
(1264, 1, 6, 'releasedEvent', 'releasedEvent', 'The place and time the release was issued, expressed as a PublicationEvent.'),
(1265, 1, 6, 'itemDefectReturnLabelSource', 'itemDefectReturnLabelSource', 'The method (from an enumeration) by which the customer obtains a return shipping label for a defect product.'),
(1266, 1, 6, 'preOp', 'preOp', 'A description of the workup, testing, and other preparations required before implanting this device.'),
(1267, 1, 6, 'composer', 'composer', 'The person or organization who wrote a composition, or who is the composer of a work performed at some event.'),
(1268, 1, 6, 'replyToUrl', 'replyToUrl', 'The URL at which a reply may be posted to the specified UserComment.'),
(1269, 1, 6, 'organizer', 'organizer', 'An organizer of an Event.'),
(1270, 1, 6, 'lodgingUnitDescription', 'lodgingUnitDescription', 'A full description of the lodging unit.'),
(1271, 1, 6, 'recommendationStrength', 'recommendationStrength', 'Strength of the guideline\'s recommendation (e.g. \'class I\').'),
(1272, 1, 6, 'legislationType', 'legislationType', 'The type of the legislation. Examples of values are \"law\", \"act\", \"directive\", \"decree\", \"regulation\", \"statutory instrument\", \"loi organique\", \"règlement grand-ducal\", etc., depending on the country.'),
(1273, 1, 6, 'genre', 'genre', 'Genre of the creative work, broadcast channel or group.'),
(1274, 1, 6, 'bioChemSimilarity', 'bioChemSimilarity', 'A similar BioChemEntity, e.g., obtained by fingerprint similarity algorithms.'),
(1275, 1, 6, 'partOfInvoice', 'partOfInvoice', 'The order is being paid as part of the referenced Invoice.'),
(1276, 1, 6, 'honorificSuffix', 'honorificSuffix', 'An honorific suffix following a Person\'s name such as M.D./PhD/MSCSW.'),
(1277, 1, 6, 'spouse', 'spouse', 'The person\'s spouse.'),
(1278, 1, 6, 'gtin14', 'gtin14', 'The GTIN-14 code of the product, or the product to which the offer refers. See [GS1 GTIN Summary](http://www.gs1.org/barcodes/technical/idkeys/gtin) for more details.'),
(1279, 1, 6, 'countriesNotSupported', 'countriesNotSupported', 'Countries for which the application is not supported. You can also provide the two-letter ISO 3166-1 alpha-2 country code.'),
(1280, 1, 6, 'mpn', 'mpn', 'The Manufacturer Part Number (MPN) of the product, or the product to which the offer refers.'),
(1281, 1, 6, 'merchant', 'merchant', '\'merchant\' is an out-dated term for \'seller\'.'),
(1282, 1, 6, 'seller', 'seller', 'An entity which offers (sells / leases / lends / loans) the services / goods.  A seller may also be a provider.'),
(1283, 1, 6, 'productGroupID', 'productGroupID', 'Indicates a textual identifier for a ProductGroup.'),
(1284, 1, 6, 'faxNumber', 'faxNumber', 'The fax number.'),
(1285, 1, 6, 'estimatedSalary', 'estimatedSalary', 'An estimated salary for a job posting or occupation, based on a variety of variables including, but not limited to industry, job title, and location. Estimated salaries  are often computed by outside organizations rather than the hiring organization, who may not have committed to the estimated value.'),
(1286, 1, 6, 'serviceOperator', 'serviceOperator', 'The operating organization, if different from the provider.  This enables the representation of services that are provided by an organization, but operated by another organization like a subcontractor.'),
(1287, 1, 6, 'materialExtent', 'materialExtent', 'The quantity of the materials being described or an expression of the physical space they occupy.'),
(1288, 1, 6, 'orderStatus', 'orderStatus', 'The current status of the order.'),
(1289, 1, 6, 'benefits', 'benefits', 'Description of benefits associated with the job.'),
(1290, 1, 6, 'jobBenefits', 'jobBenefits', 'Description of benefits associated with the job.'),
(1291, 1, 6, 'numberOfAxles', 'numberOfAxles', 'The number of axles.\\n\\nTypical unit code(s): C62'),
(1292, 1, 6, 'hasHealthAspect', 'hasHealthAspect', 'Indicates the aspect or aspects specifically addressed in some [[HealthTopicContent]]. For example, that the content is an overview, or that it talks about treatment, self-care, treatments or their side-effects.'),
(1293, 1, 6, 'medicalAudience', 'medicalAudience', 'Medical audience for page.'),
(1294, 1, 6, 'height', 'height', 'The height of the item.'),
(1295, 1, 6, 'seatSection', 'seatSection', 'The section location of the reserved seat (e.g. Orchestra).'),
(1296, 1, 6, 'warrantyScope', 'warrantyScope', 'The scope of the warranty promise.'),
(1297, 1, 6, 'multipleValues', 'multipleValues', 'Whether multiple values are allowed for the property.  Default is false.'),
(1298, 1, 6, 'employerOverview', 'employerOverview', 'A description of the employer, career opportunities and work environment for this position.'),
(1299, 1, 6, 'healthPlanCopay', 'healthPlanCopay', 'The copay amount.'),
(1300, 1, 6, 'percentile25', 'percentile25', 'The 25th percentile value.'),
(1301, 1, 6, 'parentService', 'parentService', 'A broadcast service to which the broadcast service may belong to such as regional variations of a national channel.'),
(1302, 1, 6, 'ticketedSeat', 'ticketedSeat', 'The seat associated with the ticket.'),
(1303, 1, 6, 'error', 'error', 'For failed actions, more information on the cause of the failure.'),
(1304, 1, 6, 'pageEnd', 'pageEnd', 'The page on which the work ends; for example \"138\" or \"xvi\".'),
(1305, 1, 6, 'engineDisplacement', 'engineDisplacement', 'The volume swept by all of the pistons inside the cylinders of an internal combustion engine in a single movement. \\n\\nTypical unit code(s): CMQ for cubic centimeter, LTR for liters, INQ for cubic inches\\n* Note 1: You can link to information about how the given value has been determined using the [[valueReference]] property.\\n* Note 2: You can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(1306, 1, 6, 'maximumIntake', 'maximumIntake', 'Recommended intake of this supplement for a given population as defined by a specific recommending authority.'),
(1307, 1, 6, 'possibleComplication', 'possibleComplication', 'A possible unexpected and unfavorable evolution of a medical condition. Complications may include worsening of the signs or symptoms of the disease, extension of the condition to other organ systems, etc.'),
(1308, 1, 6, 'serviceUrl', 'serviceUrl', 'The website to access the service.'),
(1309, 1, 6, 'serviceLocation', 'serviceLocation', 'The location (e.g. civic structure, local business, etc.) where a person can go to access the service.'),
(1310, 1, 6, 'pattern', 'pattern', 'A pattern that something has, for example \'polka dot\', \'striped\', \'Canadian flag\'. Values are typically expressed as text, although links to controlled value schemes are also supported.'),
(1311, 1, 6, 'broadcastDisplayName', 'broadcastDisplayName', 'The name displayed in the channel guide. For many US affiliates, it is the network name.'),
(1312, 1, 6, 'artMedium', 'artMedium', 'The material used. (E.g. Oil, Watercolour, Acrylic, Linoprint, Marble, Cyanotype, Digital, Lithograph, DryPoint, Intaglio, Pastel, Woodcut, Pencil, Mixed Media, etc.)'),
(1313, 1, 6, 'material', 'material', 'A material that something is made from, e.g. leather, wool, cotton, paper.'),
(1314, 1, 6, 'usesHealthPlanIdStandard', 'usesHealthPlanIdStandard', 'The standard for interpreting the Plan ID. The preferred is \"HIOS\". See the Centers for Medicare & Medicaid Services for more details.'),
(1315, 1, 6, 'relatedDrug', 'relatedDrug', 'Any other drug related to this one, for example commonly-prescribed alternatives.'),
(1316, 1, 6, 'usedToDiagnose', 'usedToDiagnose', 'A condition the test is used to diagnose.'),
(1317, 1, 6, 'memoryRequirements', 'memoryRequirements', 'Minimum memory requirements.'),
(1318, 1, 6, 'leaseLength', 'leaseLength', 'Length of the lease for some [[Accommodation]], either particular to some [[Offer]] or in some cases intrinsic to the property.'),
(1319, 1, 6, 'webFeed', 'webFeed', 'The URL for a feed, e.g. associated with a podcast series, blog, or series of date-stamped updates. This is usually RSS or Atom.'),
(1320, 1, 6, 'creditText', 'creditText', 'Text that can be used to credit person(s) and/or organization(s) associated with a published Creative Work.'),
(1321, 1, 6, 'reservationStatus', 'reservationStatus', 'The current status of the reservation.'),
(1322, 1, 6, 'insertion', 'insertion', 'The place of attachment of a muscle, or what the muscle moves.'),
(1323, 1, 6, 'fileFormat', 'fileFormat', 'Media type, typically MIME format (see [IANA site](http://www.iana.org/assignments/media-types/media-types.xhtml)) of the content, e.g. application/zip of a SoftwareApplication binary. In cases where a CreativeWork has several media type representations, \'encoding\' can be used to indicate each MediaObject alongside particular fileFormat information. Unregistered or niche file formats can be indicated instead via the most appropriate URL, e.g. defining Web page or a Wikipedia entry.'),
(1324, 1, 6, 'encodingFormat', 'encodingFormat', 'Media type typically expressed using a MIME format (see [IANA site](http://www.iana.org/assignments/media-types/media-types.xhtml) and [MDN reference](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)), e.g. application/zip for a SoftwareApplication binary, audio/mpeg for .mp3 etc.\n\nIn cases where a [[CreativeWork]] has several media type representations, [[encoding]] can be used to indicate each [[MediaObject]] alongside particular [[encodingFormat]] information.\n\nUnregistered or niche encoding and file formats can be indicated instead via the most appropriate URL, e.g. defining Web page or a Wikipedia/Wikidata entry.'),
(1325, 1, 6, 'scheduledTime', 'scheduledTime', 'The time the object is scheduled to.'),
(1326, 1, 6, 'availabilityEnds', 'availabilityEnds', 'The end of the availability of the product or service included in the offer.'),
(1327, 1, 6, 'video', 'video', 'An embedded video object.'),
(1328, 1, 6, 'fuelConsumption', 'fuelConsumption', 'The amount of fuel consumed for traveling a particular distance or temporal duration with the given vehicle (e.g. liters per 100 km).\\n\\n* Note 1: There are unfortunately no standard unit codes for liters per 100 km.  Use [[unitText]] to indicate the unit of measurement, e.g. L/100 km.\\n* Note 2: There are two ways of indicating the fuel consumption, [[fuelConsumption]] (e.g. 8 liters per 100 km) and [[fuelEfficiency]] (e.g. 30 miles per gallon). They are reciprocal.\\n* Note 3: Often, the absolute value is useful only when related to driving speed (\"at 80 km/h\") or usage pattern (\"city traffic\"). You can use [[valueReference]] to link the value for the fuel consumption to another value.'),
(1329, 1, 6, 'greaterOrEqual', 'greaterOrEqual', 'This ordering relation for qualitative values indicates that the subject is greater than or equal to the object.'),
(1330, 1, 6, 'layoutImage', 'layoutImage', 'A schematic image showing the floorplan layout.'),
(1331, 1, 6, 'broadcastAffiliateOf', 'broadcastAffiliateOf', 'The media network(s) whose content is broadcast on this station.'),
(1332, 1, 6, 'siblings', 'siblings', 'A sibling of the person.'),
(1333, 1, 6, 'sibling', 'sibling', 'A sibling of the person.'),
(1334, 1, 6, 'returnFees', 'returnFees', 'The type of return fees for purchased products (for any return reason).'),
(1335, 1, 6, 'defaultValue', 'defaultValue', 'The default value of the input.  For properties that expect a literal, the default is a literal value, for properties that expect an object, it\'s an ID reference to one of the current values.'),
(1336, 1, 6, 'foundingLocation', 'foundingLocation', 'The place where the Organization was founded.'),
(1337, 1, 6, 'childMinAge', 'childMinAge', 'Minimal age of the child.'),
(1338, 1, 6, 'followee', 'followee', 'A sub property of object. The person or organization being followed.'),
(1339, 1, 6, 'claimInterpreter', 'claimInterpreter', 'For a [[Claim]] interpreted from [[MediaObject]] content\n    sed to indicate a claim contained, implied or refined from the content of a [[MediaObject]].'),
(1340, 1, 6, 'dietFeatures', 'dietFeatures', 'Nutritional information specific to the dietary plan. May include dietary recommendations on what foods to avoid, what foods to consume, and specific alterations/deviations from the USDA or other regulatory body\'s approved dietary guidelines.'),
(1341, 1, 6, 'bookingAgent', 'bookingAgent', '\'bookingAgent\' is an out-dated term indicating a \'broker\' that serves as a booking agent.'),
(1342, 1, 6, 'broker', 'broker', 'An entity that arranges for an exchange between a buyer and a seller.  In most cases a broker never acquires or releases ownership of a product or service involved in an exchange.  If it is not clear whether an entity is a broker, seller, or buyer, the latter two terms are preferred.'),
(1343, 1, 6, 'bodyType', 'bodyType', 'Indicates the design and body style of the vehicle (e.g. station wagon, hatchback, etc.).'),
(1344, 1, 6, 'geo', 'geo', 'The geo coordinates of the place.'),
(1345, 1, 6, 'skills', 'skills', 'A statement of knowledge, skill, ability, task or any other assertion expressing a competency that is desired or required to fulfill this role or to work in this occupation.'),
(1346, 1, 6, 'hasMenuItem', 'hasMenuItem', 'A food or drink item contained in a menu or menu section.'),
(1347, 1, 6, 'cargoVolume', 'cargoVolume', 'The available volume for cargo or luggage. For automobiles, this is usually the trunk volume.\\n\\nTypical unit code(s): LTR for liters, FTQ for cubic foot/feet\\n\\nNote: You can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(1348, 1, 6, 'minimumPaymentDue', 'minimumPaymentDue', 'The minimum payment required at this time.'),
(1349, 1, 6, 'hospitalAffiliation', 'hospitalAffiliation', 'A hospital with which the physician or office is affiliated.'),
(1350, 1, 6, 'scheduledPaymentDate', 'scheduledPaymentDate', 'The date the invoice is scheduled to be paid.'),
(1351, 1, 6, 'targetUrl', 'targetUrl', 'The URL of a node in an established educational framework.'),
(1352, 1, 6, 'overdosage', 'overdosage', 'Any information related to overdose on a drug, including signs or symptoms, treatments, contact information for emergency response.'),
(1353, 1, 6, 'legislationResponsible', 'legislationResponsible', 'An individual or organization that has some kind of responsibility for the legislation. Typically the ministry who is/was in charge of elaborating the legislation, or the adressee for potential questions about the legislation once it is published.'),
(1354, 1, 6, 'safetyConsideration', 'safetyConsideration', 'Any potential safety concern associated with the supplement. May include interactions with other drugs and foods, pregnancy, breastfeeding, known adverse reactions, and documented efficacy of the supplement.'),
(1355, 1, 6, 'hasMeasurement', 'hasMeasurement', 'A product measurement, for example the inseam of pants, the wheel size of a bicycle, or the gauge of a screw. Usually an exact measurement, but can also be a range of measurements for adjustable products, for example belts and ski bindings.'),
(1356, 1, 6, 'smokingAllowed', 'smokingAllowed', 'Indicates whether it is allowed to smoke in the place, e.g. in the restaurant, hotel or hotel room.'),
(1357, 1, 6, 'correction', 'correction', 'Indicates a correction to a [[CreativeWork]], either via a [[CorrectionComment]], textually or in another document.'),
(1358, 1, 6, 'studyDesign', 'studyDesign', 'Specifics about the observational study design (enumerated).'),
(1359, 1, 6, 'artform', 'artform', 'e.g. Painting, Drawing, Sculpture, Print, Photograph, Assemblage, Collage, etc.'),
(1360, 1, 6, 'fatContent', 'fatContent', 'The number of grams of fat.'),
(1361, 1, 6, 'costOrigin', 'costOrigin', 'Additional details to capture the origin of the cost data. For example, \'Medicare Part B\'.'),
(1362, 1, 6, 'aspect', 'aspect', 'An aspect of medical practice that is considered on the page, such as \'diagnosis\', \'treatment\', \'causes\', \'prognosis\', \'etiology\', \'epidemiology\', etc.'),
(1363, 1, 6, 'mainContentOfPage', 'mainContentOfPage', 'Indicates if this web page element is the main subject of the page.'),
(1364, 1, 6, 'transitTimeLabel', 'transitTimeLabel', 'Label to match an [[OfferShippingDetails]] with a [[DeliveryTimeSettings]] (within the context of a [[shippingSettingsLink]] cross-reference).'),
(1365, 1, 6, 'nerveMotor', 'nerveMotor', 'The neurological pathway extension that involves muscle control.'),
(1366, 1, 6, 'alignmentType', 'alignmentType', 'A category of alignment between the learning resource and the framework node. Recommended values include: \'requires\', \'textComplexity\', \'readingLevel\', and \'educationalSubject\'.'),
(1367, 1, 6, 'tongueWeight', 'tongueWeight', 'The permitted vertical load (TWR) of a trailer attached to the vehicle. Also referred to as Tongue Load Rating (TLR) or Vertical Load Rating (VLR).\\n\\nTypical unit code(s): KGM for kilogram, LBR for pound\\n\\n* Note 1: You can indicate additional information in the [[name]] of the [[QuantitativeValue]] node.\\n* Note 2: You may also link to a [[QualitativeValue]] node that provides additional information using [[valueReference]].\\n* Note 3: Note that you can use [[minValue]] and [[maxValue]] to indicate ranges.'),
(1368, 1, 6, 'predecessorOf', 'predecessorOf', 'A pointer from a previous, often discontinued variant of the product to its newer variant.'),
(1369, 1, 6, 'paymentAccepted', 'paymentAccepted', 'Cash, Credit Card, Cryptocurrency, Local Exchange Tradings System, etc.'),
(1370, 1, 6, 'sportsTeam', 'sportsTeam', 'A sub property of participant. The sports team that participated on this action.'),
(1371, 1, 6, 'wordCount', 'wordCount', 'The number of words in the text of the Article.'),
(1372, 1, 6, 'vendor', 'vendor', '\'vendor\' is an earlier term for \'seller\'.'),
(1373, 1, 6, 'seatingType', 'seatingType', 'The type/class of the seat.'),
(1374, 1, 6, 'driveWheelConfiguration', 'driveWheelConfiguration', 'The drive wheel configuration, i.e. which roadwheels will receive torque from the vehicle\'s engine via the drivetrain.'),
(1375, 1, 6, 'expires', 'expires', 'Date the content expires and is no longer useful or available. For example a [[VideoObject]] or [[NewsArticle]] whose availability or relevance is time-limited, or a [[ClaimReview]] fact check whose publisher wants to indicate that it may no longer be relevant (or helpful to highlight) after some date.'),
(1376, 1, 6, 'yearlyRevenue', 'yearlyRevenue', 'The size of the business in annual revenue.'),
(1377, 1, 6, 'replacee', 'replacee', 'A sub property of object. The object that is being replaced.'),
(1378, 1, 6, 'departureAirport', 'departureAirport', 'The airport where the flight originates.'),
(1379, 1, 6, 'availableFrom', 'availableFrom', 'When the item is available for pickup from the store, locker, etc.'),
(1380, 1, 6, 'follows', 'follows', 'The most generic uni-directional social relation.'),
(1381, 1, 6, 'workHours', 'workHours', 'The typical working hours for this job (e.g. 1st shift, night shift, 8am-5pm).'),
(1382, 1, 6, 'sampleType', 'sampleType', 'What type of code sample: full (compile ready) solution, code snippet, inline code, scripts, template.'),
(1383, 1, 6, 'codeSampleType', 'codeSampleType', 'What type of code sample: full (compile ready) solution, code snippet, inline code, scripts, template.'),
(1384, 1, 6, 'confirmationNumber', 'confirmationNumber', 'A number that confirms the given order or payment has been received.'),
(1385, 1, 6, 'isBasedOnUrl', 'isBasedOnUrl', 'A resource that was used in the creation of this resource. This term can be repeated for multiple sources. For example, http://example.com/great-multiplication-intro.html.'),
(1386, 1, 6, 'isBasedOn', 'isBasedOn', 'A resource from which this work is derived or from which it is a modification or adaption.'),
(1387, 1, 6, 'travelBans', 'travelBans', 'Information about travel bans, e.g. in the context of a pandemic.'),
(1388, 1, 6, 'value', 'value', 'The value of the quantitative value or property value node.\\n\\n* For [[QuantitativeValue]] and [[MonetaryAmount]], the recommended type for values is \'Number\'.\\n* For [[PropertyValue]], it can be \'Text\', \'Number\', \'Boolean\', or \'StructuredValue\'.\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.'),
(1389, 1, 6, 'proprietaryName', 'proprietaryName', 'Proprietary name given to the diet plan, typically by its originator or creator.'),
(1390, 1, 6, 'hoursAvailable', 'hoursAvailable', 'The hours during which this service or contact is available.'),
(1391, 1, 6, 'vehicleTransmission', 'vehicleTransmission', 'The type of component used for transmitting the power from a rotating power source to the wheels or other relevant component(s) (\"gearbox\" for cars).'),
(1392, 1, 6, 'ratingExplanation', 'ratingExplanation', 'A short explanation (e.g. one to two sentences) providing background context and other information that led to the conclusion expressed in the rating. This is particularly applicable to ratings associated with \"fact check\" markup using [[ClaimReview]].'),
(1393, 1, 6, 'artist', 'artist', 'The primary artist for a work\n    	in a medium other than pencils or digital line art--for example, if the\n    	primary artwork is done in watercolors or digital paints.'),
(1394, 1, 6, 'itemLocation', 'itemLocation', 'Current location of the item.'),
(1395, 1, 6, 'cvdFacilityId', 'cvdFacilityId', 'Identifier of the NHSN facility that this data record applies to. Use [[cvdFacilityCounty]] to indicate the county. To provide other details, [[healthcareReportingData]] can be used on a [[Hospital]] entry.'),
(1396, 1, 6, 'translator', 'translator', 'Organization or person who adapts a creative work to different languages, regional differences and technical requirements of a target market, or that translates during some event.'),
(1397, 1, 6, 'eligibilityToWorkRequirement', 'eligibilityToWorkRequirement', 'The legal requirements such as citizenship, visa and other documentation required for an applicant to this job.'),
(1398, 1, 6, 'rangeIncludes', 'rangeIncludes', 'Relates a property to a class that constitutes (one of) the expected type(s) for values of the property.'),
(1399, 1, 6, 'lowPrice', 'lowPrice', 'The lowest price of all offers available.\\n\\nUsage guidelines:\\n\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.'),
(1400, 1, 6, 'loanTerm', 'loanTerm', 'The duration of the loan or credit agreement.'),
(1401, 1, 6, 'duration', 'duration', 'The duration of the item (movie, audio recording, event, etc.) in [ISO 8601 date format](http://en.wikipedia.org/wiki/ISO_8601).'),
(1402, 1, 6, 'percentile75', 'percentile75', 'The 75th percentile value.'),
(1403, 1, 6, 'tocEntry', 'tocEntry', 'Indicates a [[HyperTocEntry]] in a [[HyperToc]].'),
(1404, 1, 6, 'hasPart', 'hasPart', 'Indicates an item or CreativeWork that is part of this item, or CreativeWork (in some sense).'),
(1405, 1, 6, 'busName', 'busName', 'The name of the bus (e.g. Bolt Express).'),
(1406, 1, 6, 'interestRate', 'interestRate', 'The interest rate, charged or paid, applicable to the financial product. Note: This is different from the calculated annualPercentageRate.'),
(1407, 1, 6, 'hasEnergyEfficiencyCategory', 'hasEnergyEfficiencyCategory', 'Defines the energy efficiency Category (which could be either a rating out of range of values or a yes/no certification) for a product according to an international energy efficiency standard.'),
(1408, 1, 6, 'illustrator', 'illustrator', 'The illustrator of the book.'),
(1409, 1, 6, 'eligibleTransactionVolume', 'eligibleTransactionVolume', 'The transaction volume, in a monetary unit, for which the offer or price specification is valid, e.g. for indicating a minimal purchasing volume, to express free shipping above a certain order volume, or to limit the acceptance of credit cards to purchases to a certain minimal amount.'),
(1410, 1, 6, 'additionalType', 'additionalType', 'An additional type for the item, typically used for adding more specific types from external vocabularies in microdata syntax. This is a relationship between something and a class that the thing is in. In RDFa syntax, it is better to use the native RDFa syntax - the \'typeof\' attribute - for multiple types. Schema.org tools may have only weaker understanding of extra types, in particular those defined externally.'),
(1411, 1, 6, 'exifData', 'exifData', 'exif data for this object.'),
(1412, 1, 6, 'imagingTechnique', 'imagingTechnique', 'Imaging technique used.'),
(1413, 1, 6, 'ownedThrough', 'ownedThrough', 'The date and time of giving up ownership on the product.'),
(1414, 1, 6, 'targetPopulation', 'targetPopulation', 'Characteristics of the population for which this is intended, or which typically uses it, e.g. \'adults\'.'),
(1415, 1, 6, 'referenceQuantity', 'referenceQuantity', 'The reference quantity for which a certain price applies, e.g. 1 EUR per 4 kWh of electricity. This property is a replacement for unitOfMeasurement for the advanced cases where the price does not relate to a standard unit.'),
(1416, 1, 6, 'howPerformed', 'howPerformed', 'How the procedure is performed.'),
(1417, 1, 6, 'signOrSymptom', 'signOrSymptom', 'A sign or symptom of this condition. Signs are objective or physically observable manifestations of the medical condition while symptoms are the subjective experience of the medical condition.'),
(1418, 1, 6, 'isInvolvedInBiologicalProcess', 'isInvolvedInBiologicalProcess', 'Biological process this BioChemEntity is involved in; please use PropertyValue if you want to include any evidence.'),
(1419, 1, 6, 'preparation', 'preparation', 'Typical preparation that a patient must undergo before having the procedure performed.'),
(1420, 1, 6, 'winner', 'winner', 'A sub property of participant. The winner of the action.'),
(1421, 1, 6, 'muscleAction', 'muscleAction', 'The movement the muscle generates.'),
(1422, 1, 6, 'numberOfAirbags', 'numberOfAirbags', 'The number or type of airbags in the vehicle.'),
(1423, 1, 6, 'expectsAcceptanceOf', 'expectsAcceptanceOf', 'An Offer which must be accepted before the user can perform the Action. For example, the user may need to buy a movie before being able to watch it.'),
(1424, 1, 6, 'courseWorkload', 'courseWorkload', 'The amount of work expected of students taking the course, often provided as a figure per week or per month, and may be broken down by type. For example, \"2 hours of lectures, 1 hour of lab work and 3 hours of independent study per week\".'),
(1425, 1, 6, 'issuedThrough', 'issuedThrough', 'The service through which the permit was granted.'),
(1426, 1, 6, 'depth', 'depth', 'The depth of the item.'),
(1427, 1, 6, 'transmissionMethod', 'transmissionMethod', 'How the disease spreads, either as a route or vector, for example \'direct contact\', \'Aedes aegypti\', etc.'),
(1428, 1, 6, 'petsAllowed', 'petsAllowed', 'Indicates whether pets are allowed to enter the accommodation or lodging business. More detailed information can be put in a text value.'),
(1429, 1, 6, 'fromLocation', 'fromLocation', 'A sub property of location. The original location of the object or the agent before the action.'),
(1430, 1, 6, 'editor', 'editor', 'Specifies the Person who edited the CreativeWork.'),
(1431, 1, 6, 'ineligibleRegion', 'ineligibleRegion', 'The ISO 3166-1 (ISO 3166-1 alpha-2) or ISO 3166-2 code, the place, or the GeoShape for the geo-political region(s) for which the offer or delivery charge specification is not valid, e.g. a region where the transaction is not allowed.\\n\\nSee also [[eligibleRegion]].\n      '),
(1432, 1, 6, 'events', 'events', 'Upcoming or past events associated with this place or organization.'),
(1433, 1, 6, 'event', 'event', 'Upcoming or past event associated with this place, organization, or action.'),
(1434, 1, 6, 'modifiedTime', 'modifiedTime', 'The date and time the reservation was modified.'),
(1435, 1, 6, 'nerve', 'nerve', 'The underlying innervation associated with the muscle.'),
(1436, 1, 6, 'customerRemorseReturnFees', 'customerRemorseReturnFees', 'The type of return fees if the product is returned due to customer remorse.'),
(1437, 1, 6, 'associatedMedia', 'associatedMedia', 'A media object that encodes this CreativeWork. This property is a synonym for encoding.'),
(1438, 1, 6, 'educationalUse', 'educationalUse', 'The purpose of a work in the context of education; for example, \'assignment\', \'group work\'.'),
(1439, 1, 6, 'numberOfPlayers', 'numberOfPlayers', 'Indicate how many people can play this game (minimum, maximum, or range).'),
(1440, 1, 6, 'width', 'width', 'The width of the item.'),
(1441, 1, 6, 'conditionsOfAccess', 'conditionsOfAccess', 'Conditions that affect the availability of, or method(s) of access to, an item. Typically used for real world items such as an [[ArchiveComponent]] held by an [[ArchiveOrganization]]. This property is not suitable for use as a general Web access control mechanism. It is expressed only in natural language.\\n\\nFor example \"Available by appointment from the Reading Room\" or \"Accessible only from logged-in accounts \". '),
(1442, 1, 6, 'bodyLocation', 'bodyLocation', 'Location in the body of the anatomical structure.'),
(1443, 1, 6, 'nutrition', 'nutrition', 'Nutrition information about the recipe or menu item.'),
(1444, 1, 6, 'eligibleQuantity', 'eligibleQuantity', 'The interval and unit of measurement of ordering quantities for which the offer or price specification is valid. This allows e.g. specifying that a certain freight charge is valid only for a certain quantity.'),
(1445, 1, 6, 'owns', 'owns', 'Products owned by the organization or person.'),
(1446, 1, 6, 'breadcrumb', 'breadcrumb', 'A set of links that can help a user understand and navigate a website hierarchy.'),
(1447, 1, 6, 'percentile10', 'percentile10', 'The 10th percentile value.'),
(1448, 1, 6, 'dateSent', 'dateSent', 'The date/time at which the message was sent.'),
(1449, 1, 6, 'healthPlanCopayOption', 'healthPlanCopayOption', 'Whether the copay is before or after deductible, etc. TODO: Is this a closed set?'),
(1450, 1, 6, 'birthPlace', 'birthPlace', 'The place where the person was born.'),
(1451, 1, 6, 'name', 'name', 'The name of the item.'),
(1452, 1, 6, 'permittedUsage', 'permittedUsage', 'Indications regarding the permitted usage of the accommodation.'),
(1453, 1, 6, 'includedDataCatalog', 'includedDataCatalog', 'A data catalog which contains this dataset (this property was previously \'catalog\', preferred name is now \'includedInDataCatalog\').'),
(1454, 1, 6, 'dependencies', 'dependencies', 'Prerequisites needed to fulfill steps in article.'),
(1455, 1, 6, 'actionAccessibilityRequirement', 'actionAccessibilityRequirement', 'A set of requirements that must be fulfilled in order to perform an Action. If more than one value is specified, fulfilling one set of requirements will allow the Action to be performed.'),
(1456, 1, 6, 'inPlaylist', 'inPlaylist', 'The playlist to which this recording belongs.'),
(1457, 1, 6, 'geoIntersects', 'geoIntersects', 'Represents spatial relations in which two geometries (or the places they represent) have at least one point in common. As defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).'),
(1458, 1, 6, 'openingHours', 'openingHours', 'The general opening hours for a business. Opening hours can be specified as a weekly time range, starting with days, then times per day. Multiple days can be listed with commas \',\' separating each day. Day or time ranges are specified using a hyphen \'-\'.\\n\\n* Days are specified using the following two-letter combinations: ```Mo```, ```Tu```, ```We```, ```Th```, ```Fr```, ```Sa```, ```Su```.\\n* Times are specified using 24:00 format. For example, 3pm is specified as ```15:00```, 10am as ```10:00```. \\n* Here is an example: <code>&lt;time itemprop=\"openingHours\" datetime=&quot;Tu,Th 16:00-20:00&quot;&gt;Tuesdays and Thursdays 4-8pm&lt;/time&gt;</code>.\\n* If a business is open 7 days a week, then it can be specified as <code>&lt;time itemprop=&quot;openingHours&quot; datetime=&quot;Mo-Su&quot;&gt;Monday through Sunday, all day&lt;/time&gt;</code>.'),
(1459, 1, 6, 'familyName', 'familyName', 'Family name. In the U.S., the last name of a Person.'),
(1460, 1, 6, 'nextItem', 'nextItem', 'A link to the ListItem that follows the current one.'),
(1461, 1, 6, 'maps', 'maps', 'A URL to a map of the place.'),
(1462, 1, 6, 'fuelCapacity', 'fuelCapacity', 'The capacity of the fuel tank or in the case of electric cars, the battery. If there are multiple components for storage, this should indicate the total of all storage of the same type.\\n\\nTypical unit code(s): LTR for liters, GLL of US gallons, GLI for UK / imperial gallons, AMH for ampere-hours (for electrical vehicles).'),
(1463, 1, 6, 'maximumVirtualAttendeeCapacity', 'maximumVirtualAttendeeCapacity', 'The maximum physical attendee capacity of an [[Event]] whose [[eventAttendanceMode]] is [[OnlineEventAttendanceMode]] (or the online aspects, in the case of a [[MixedEventAttendanceMode]]). '),
(1464, 1, 6, 'itemCondition', 'itemCondition', 'A predefined value from OfferItemCondition specifying the condition of the product or service, or the products or services included in the offer. Also used for product return policies to specify the condition of products accepted for returns.'),
(1465, 1, 6, 'cvdNumVentUse', 'cvdNumVentUse', 'numventuse - MECHANICAL VENTILATORS IN USE: Total number of ventilators in use.'),
(1466, 1, 6, 'modelDate', 'modelDate', 'The release date of a vehicle model (often used to differentiate versions of the same make and model).'),
(1467, 1, 6, 'monoisotopicMolecularWeight', 'monoisotopicMolecularWeight', 'The monoisotopic mass is the sum of the masses of the atoms in a molecule using the unbound, ground-state, rest mass of the principal (most abundant) isotope for each element instead of the isotopic average mass. Please include the units in the form \'&lt;Number&gt; &lt;unit&gt;\', for example \'770.230488 g/mol\' or as \'&lt;QuantitativeValue&gt;.'),
(1468, 1, 6, 'polygon', 'polygon', 'A polygon is the area enclosed by a point-to-point path for which the starting and ending points are the same. A polygon is expressed as a series of four or more space delimited points where the first and final points are identical.'),
(1469, 1, 6, 'legalStatus', 'legalStatus', 'The drug or supplement\'s legal status, including any controlled substance schedules that apply.'),
(1470, 1, 6, 'servesCuisine', 'servesCuisine', 'The cuisine of the restaurant.'),
(1471, 1, 6, 'answerExplanation', 'answerExplanation', 'A step-by-step or full explanation about Answer. Can outline how this Answer was achieved or contain more broad clarification or statement about it. '),
(1472, 1, 6, 'childMaxAge', 'childMaxAge', 'Maximal age of the child.'),
(1473, 1, 6, 'lender', 'lender', 'A sub property of participant. The person that lends the object being borrowed.'),
(1474, 1, 6, 'significance', 'significance', 'The significance associated with the superficial anatomy; as an example, how characteristics of the superficial anatomy can suggest underlying medical conditions or courses of treatment.'),
(1475, 1, 6, 'relatedTo', 'relatedTo', 'The most generic familial relation.'),
(1476, 1, 6, 'shippingSettingsLink', 'shippingSettingsLink', 'Link to a page containing [[ShippingRateSettings]] and [[DeliveryTimeSettings]] details.'),
(1477, 1, 6, 'hasMerchantReturnPolicy', 'hasMerchantReturnPolicy', 'Specifies a MerchantReturnPolicy that may be applicable.'),
(1478, 1, 6, 'variableMeasured', 'variableMeasured', 'The variableMeasured property can indicate (repeated as necessary) the  variables that are measured in some dataset, either described as text or as pairs of identifier and description using PropertyValue.'),
(1479, 1, 6, 'acquireLicensePage', 'acquireLicensePage', 'Indicates a page documenting how licenses can be purchased or otherwise acquired, for the current item.'),
(1480, 1, 6, 'usageInfo', 'usageInfo', 'The schema.org [[usageInfo]] property indicates further information about a [[CreativeWork]]. This property is applicable both to works that are freely available and to those that require payment or other transactions. It can reference additional information, e.g. community expectations on preferred linking and citation conventions, as well as purchasing details. For something that can be commercially licensed, usageInfo can provide detailed, resource-specific information about licensing options.\n\nThis property can be used alongside the license property which indicates license(s) applicable to some piece of content. The usageInfo property can provide information about other licensing options, e.g. acquiring commercial usage rights for an image that is also available under non-commercial creative commons licenses.'),
(1481, 1, 6, 'reviewedBy', 'reviewedBy', 'People or organizations that have reviewed the content on this web page for accuracy and/or completeness.'),
(1482, 1, 6, 'availableDeliveryMethod', 'availableDeliveryMethod', 'The delivery method(s) available for this offer.'),
(1483, 1, 6, 'embedUrl', 'embedUrl', 'A URL pointing to a player for a specific video. In general, this is the information in the ```src``` element of an ```embed``` tag and should not be the same as the content of the ```loc``` tag.'),
(1484, 1, 6, 'option', 'option', 'A sub property of object. The options subject to this action.'),
(1485, 1, 6, 'actionOption', 'actionOption', 'A sub property of object. The options subject to this action.'),
(1486, 1, 6, 'collection', 'collection', 'A sub property of object. The collection target of the action.'),
(1487, 1, 6, 'targetCollection', 'targetCollection', 'A sub property of object. The collection target of the action.'),
(1488, 1, 6, 'encodingType', 'encodingType', 'The supported encoding type(s) for an EntryPoint request.'),
(1489, 1, 6, 'musicReleaseFormat', 'musicReleaseFormat', 'Format of this release (the type of recording media used, i.e. compact disc, digital media, LP, etc.).'),
(1490, 1, 6, 'interactionCount', 'interactionCount', 'This property is deprecated, alongside the UserInteraction types on which it depended.'),
(1491, 1, 6, 'interactionStatistic', 'interactionStatistic', 'The number of interactions for the CreativeWork using the WebSite or SoftwareApplication. The most specific child type of InteractionCounter should be used.'),
(1492, 1, 6, 'worstRating', 'worstRating', 'The lowest value allowed in this rating system. If worstRating is omitted, 1 is assumed.'),
(1493, 1, 6, 'providerMobility', 'providerMobility', 'Indicates the mobility of a provided service (e.g. \'static\', \'dynamic\').'),
(1494, 1, 6, 'trackingUrl', 'trackingUrl', 'Tracking url for the parcel delivery.'),
(1495, 1, 6, 'departureGate', 'departureGate', 'Identifier of the flight\'s departure gate.'),
(1496, 1, 6, 'paymentStatus', 'paymentStatus', 'The status of payment; whether the invoice has been paid or not.'),
(1497, 1, 6, 'valueAddedTaxIncluded', 'valueAddedTaxIncluded', 'Specifies whether the applicable value-added tax (VAT) is included in the price specification or not.'),
(1498, 1, 6, 'carrier', 'carrier', '\'carrier\' is an out-dated term indicating the \'provider\' for parcel delivery and flights.'),
(1499, 1, 6, 'provider', 'provider', 'The service provider, service operator, or service performer; the goods producer. Another party (a seller) may offer those services or goods on behalf of the provider. A provider may also serve as the seller.'),
(1500, 1, 6, 'geoDisjoint', 'geoDisjoint', 'Represents spatial relations in which two geometries (or the places they represent) are topologically disjoint: \"they have no point in common. They form a set of disconnected geometries.\" (A symmetric relationship, as defined in [DE-9IM](https://en.wikipedia.org/wiki/DE-9IM).)'),
(1501, 1, 6, 'unsaturatedFatContent', 'unsaturatedFatContent', 'The number of grams of unsaturated fat.'),
(1502, 1, 6, 'schemaVersion', 'schemaVersion', 'Indicates (by URL or string) a particular version of a schema used in some CreativeWork. This property was created primarily to\n    indicate the use of a specific schema.org release, e.g. ```10.0``` as a simple string, or more explicitly via URL, ```https://schema.org/docs/releases.html#v10.0```. There may be situations in which other schemas might usefully be referenced this way, e.g. ```http://dublincore.org/specifications/dublin-core/dces/1999-07-02/``` but this has not been carefully explored in the community.'),
(1503, 1, 6, 'speechToTextMarkup', 'speechToTextMarkup', 'Form of markup used. eg. [SSML](https://www.w3.org/TR/speech-synthesis11) or [IPA](https://www.wikidata.org/wiki/Property:P898).'),
(1504, 1, 6, 'reviewCount', 'reviewCount', 'The count of total number of reviews.'),
(1505, 1, 6, 'sourcedFrom', 'sourcedFrom', 'The neurological pathway that originates the neurons.'),
(1506, 1, 6, 'videoFrameSize', 'videoFrameSize', 'The frame size of the video.'),
(1507, 1, 6, 'inProductGroupWithID', 'inProductGroupWithID', 'Indicates the [[productGroupID]] for a [[ProductGroup]] that this product [[isVariantOf]]. '),
(1508, 1, 6, 'numberOfDoors', 'numberOfDoors', 'The number of doors.\\n\\nTypical unit code(s): C62'),
(1509, 1, 6, 'issuedBy', 'issuedBy', 'The organization issuing the ticket or permit.'),
(1510, 1, 6, 'orderItemStatus', 'orderItemStatus', 'The current status of the order item.'),
(1511, 1, 6, 'healthPlanNetworkTier', 'healthPlanNetworkTier', 'The tier(s) for this network.'),
(1512, 1, 6, 'copyrightHolder', 'copyrightHolder', 'The party holding the legal copyright to the CreativeWork.'),
(1513, 1, 6, 'accessibilitySummary', 'accessibilitySummary', 'A human-readable summary of specific accessibility features or deficiencies, consistent with the other accessibility metadata but expressing subtleties such as \"short descriptions are present but long descriptions will be needed for non-visual users\" or \"short descriptions are present and no long descriptions are needed.\"'),
(1514, 1, 6, 'monthsOfExperience', 'monthsOfExperience', 'Indicates the minimal number of months of experience required for a position.'),
(1515, 1, 6, 'primaryImageOfPage', 'primaryImageOfPage', 'Indicates the main image on the page.'),
(1516, 1, 6, 'transcript', 'transcript', 'If this MediaObject is an AudioObject or VideoObject, the transcript of that object.');
INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1517, 1, 6, 'accountOverdraftLimit', 'accountOverdraftLimit', 'An overdraft is an extension of credit from a lending institution when an account reaches zero. An overdraft allows the individual to continue withdrawing money even if the account has no funds in it. Basically the bank allows people to borrow a set amount of money.'),
(1518, 1, 6, 'cvdNumICUBeds', 'cvdNumICUBeds', 'numicubeds - ICU BEDS: Total number of staffed inpatient intensive care unit (ICU) beds.'),
(1519, 1, 6, 'contactType', 'contactType', 'A person or organization can have different contact points, for different purposes. For example, a sales contact point, a PR contact point and so on. This property is used to specify the kind of contact point.'),
(1520, 1, 6, 'timeRequired', 'timeRequired', 'Approximate or typical time it takes to work with or through this learning resource for the typical intended target audience, e.g. \'PT30M\', \'PT1H25M\'.'),
(1521, 1, 6, 'endorsee', 'endorsee', 'A sub property of participant. The person/organization being supported.'),
(1522, 1, 6, 'relatedLink', 'relatedLink', 'A link related to this web page, for example to other related web pages.'),
(1523, 1, 6, 'tickerSymbol', 'tickerSymbol', 'The exchange traded instrument associated with a Corporation object. The tickerSymbol is expressed as an exchange and an instrument name separated by a space character. For the exchange component of the tickerSymbol attribute, we recommend using the controlled vocabulary of Market Identifier Codes (MIC) specified in ISO 15022.'),
(1524, 1, 6, 'url', 'url', 'URL of the item.'),
(1525, 1, 6, 'associatedArticle', 'associatedArticle', 'A NewsArticle associated with the Media Object.'),
(1526, 1, 6, 'coverageEndTime', 'coverageEndTime', 'The time when the live blog will stop covering the Event. Note that coverage may continue after the Event concludes.'),
(1527, 1, 6, 'publisher', 'publisher', 'The publisher of the creative work.'),
(1528, 1, 6, 'interactivityType', 'interactivityType', 'The predominant mode of learning supported by the learning resource. Acceptable values are \'active\', \'expositive\', or \'mixed\'.'),
(1529, 1, 6, 'studySubject', 'studySubject', 'A subject of the study, i.e. one of the medical conditions, therapies, devices, drugs, etc. investigated by the study.'),
(1530, 1, 6, 'mechanismOfAction', 'mechanismOfAction', 'The specific biochemical interaction through which this drug or supplement produces its pharmacological effect.'),
(1531, 1, 6, 'educationalFramework', 'educationalFramework', 'The framework to which the resource being described is aligned.'),
(1532, 1, 6, 'accessModeSufficient', 'accessModeSufficient', 'A list of single or combined accessModes that are sufficient to understand all the intellectual content of a resource. Values should be drawn from the [approved vocabulary](https://www.w3.org/2021/a11y-discov-vocab/latest/#accessModeSufficient-vocabulary).'),
(1533, 1, 6, 'cookingMethod', 'cookingMethod', 'The method of cooking, such as Frying, Steaming, ...'),
(1534, 1, 6, 'xpath', 'xpath', 'An XPath, e.g. of a [[SpeakableSpecification]] or [[WebPageElement]]. In the latter case, multiple matches within a page can constitute a single conceptual \"Web page element\".'),
(1535, 1, 6, 'printColumn', 'printColumn', 'The number of the column in which the NewsArticle appears in the print edition.'),
(1536, 1, 6, 'surface', 'surface', 'A material used as a surface in some artwork, e.g. Canvas, Paper, Wood, Board, etc.'),
(1537, 1, 6, 'artworkSurface', 'artworkSurface', 'The supporting materials for the artwork, e.g. Canvas, Paper, Wood, Board, etc.'),
(1538, 1, 6, 'trainName', 'trainName', 'The name of the train (e.g. The Orient Express).'),
(1539, 1, 6, 'broadcastFrequencyValue', 'broadcastFrequencyValue', 'The frequency in MHz for a particular broadcast.'),
(1540, 1, 6, 'distance', 'distance', 'The distance travelled, e.g. exercising or travelling.'),
(1541, 1, 6, 'totalJobOpenings', 'totalJobOpenings', 'The number of positions open for this job posting. Use a positive integer. Do not use if the number of positions is unclear or not known.'),
(1542, 1, 6, 'opens', 'opens', 'The opening hour of the place or service on the given day(s) of the week.'),
(1543, 1, 6, 'availableThrough', 'availableThrough', 'After this date, the item will no longer be available for pickup.'),
(1544, 1, 6, 'cheatCode', 'cheatCode', 'Cheat codes to the game.'),
(1545, 1, 6, 'cholesterolContent', 'cholesterolContent', 'The number of milligrams of cholesterol.'),
(1546, 1, 6, 'departurePlatform', 'departurePlatform', 'The platform from which the train departs.'),
(1547, 1, 6, 'upvoteCount', 'upvoteCount', 'The number of upvotes this question, answer or comment has received from the community.'),
(1548, 1, 6, 'termsPerYear', 'termsPerYear', 'The number of times terms of study are offered per year. Semesters and quarters are common units for term. For example, if the student can only take 2 semesters for the program in one year, then termsPerYear should be 2.'),
(1549, 1, 6, 'deliveryStatus', 'deliveryStatus', 'New entry added as the package passes through each leg of its journey (from shipment to final delivery).'),
(1550, 1, 6, 'releaseNotes', 'releaseNotes', 'Description of what changed in this version.'),
(1551, 1, 6, 'warning', 'warning', 'Any FDA or other warnings about the drug (text or URL).'),
(1552, 1, 6, 'businessFunction', 'businessFunction', 'The business function (e.g. sell, lease, repair, dispose) of the offer or component of a bundle (TypeAndQuantityNode). The default is http://purl.org/goodrelations/v1#Sell.'),
(1553, 1, 6, 'hasEnergyConsumptionDetails', 'hasEnergyConsumptionDetails', 'Defines the energy efficiency Category (also known as \"class\" or \"rating\") for a product according to an international energy efficiency standard.'),
(1554, 1, 6, 'device', 'device', 'Device required to run the application. Used in cases where a specific make/model is required to run the application.'),
(1555, 1, 6, 'availableOnDevice', 'availableOnDevice', 'Device required to run the application. Used in cases where a specific make/model is required to run the application.'),
(1556, 1, 6, 'numberOfPages', 'numberOfPages', 'The number of pages in the book.'),
(1557, 1, 6, 'requiredMaxAge', 'requiredMaxAge', 'Audiences defined by a person\'s maximum age.'),
(1558, 1, 6, 'ticketNumber', 'ticketNumber', 'The unique identifier for the ticket.'),
(1559, 1, 6, 'clincalPharmacology', 'clincalPharmacology', 'Description of the absorption and elimination of drugs, including their concentration (pharmacokinetics, pK) and biological effects (pharmacodynamics, pD).'),
(1560, 1, 6, 'clinicalPharmacology', 'clinicalPharmacology', 'Description of the absorption and elimination of drugs, including their concentration (pharmacokinetics, pK) and biological effects (pharmacodynamics, pD).'),
(1561, 1, 6, 'softwareHelp', 'softwareHelp', 'Software application help.'),
(1562, 1, 6, 'securityScreening', 'securityScreening', 'The type of security screening the passenger is subject to.'),
(1563, 1, 6, 'downloadUrl', 'downloadUrl', 'If the file can be downloaded, URL to download the binary.'),
(1564, 1, 6, 'incentives', 'incentives', 'Description of bonus and commission compensation aspects of the job.'),
(1565, 1, 6, 'incentiveCompensation', 'incentiveCompensation', 'Description of bonus and commission compensation aspects of the job.'),
(1566, 1, 6, 'deathPlace', 'deathPlace', 'The place where the person died.'),
(1567, 1, 6, 'connectedTo', 'connectedTo', 'Other anatomical structures to which this structure is connected.'),
(1568, 1, 6, 'specialty', 'specialty', 'One of the domain specialities to which this web page\'s content applies.'),
(1569, 1, 6, 'accommodationFloorPlan', 'accommodationFloorPlan', 'A floorplan of some [[Accommodation]].'),
(1570, 1, 6, 'jobStartDate', 'jobStartDate', 'The date on which a successful applicant for this job would be expected to start work. Choose a specific date in the future or use the jobImmediateStart property to indicate the position is to be filled as soon as possible.'),
(1571, 1, 6, 'hasDeliveryMethod', 'hasDeliveryMethod', 'Method used for delivery or shipping.'),
(1572, 1, 6, 'procedureType', 'procedureType', 'The type of procedure, for example Surgical, Noninvasive, or Percutaneous.'),
(1573, 1, 6, 'liveBlogUpdate', 'liveBlogUpdate', 'An update to the LiveBlog.'),
(1574, 1, 6, 'license', 'license', 'A license document that applies to this content, typically indicated by URL.'),
(1575, 1, 6, 'iso6523Code', 'iso6523Code', 'An organization identifier as defined in ISO 6523(-1). Note that many existing organization identifiers such as [leiCode](https://schema.org/leiCode), [duns](https://schema.org/duns) and [vatID](https://schema.org/vatID) can be expressed as an ISO 6523 identifier by setting the ICD part of the ISO 6523 identifier accordingly. '),
(1576, 1, 6, 'expectedPrognosis', 'expectedPrognosis', 'The likely outcome in either the short term or long term of the medical condition.'),
(1577, 1, 6, 'programmingLanguage', 'programmingLanguage', 'The computer programming language.'),
(1578, 1, 6, 'contentSize', 'contentSize', 'File size in (mega/kilo)bytes.'),
(1579, 1, 6, 'tocContinuation', 'tocContinuation', 'A [[HyperTocEntry]] can have a [[tocContinuation]] indicated, which is another [[HyperTocEntry]] that would be the default next item to play or render.'),
(1580, 1, 6, 'contentRating', 'contentRating', 'Official rating of a piece of content&#x2014;for example, \'MPAA PG-13\'.'),
(1581, 1, 6, 'albumProductionType', 'albumProductionType', 'Classification of the album by its type of content: soundtrack, live album, studio album, etc.'),
(1582, 1, 6, 'articleBody', 'articleBody', 'The actual body of the article.'),
(1583, 1, 6, 'accountId', 'accountId', 'The identifier for the account the payment will be applied to.'),
(1584, 1, 6, 'paymentMethodId', 'paymentMethodId', 'An identifier for the method of payment used (e.g. the last 4 digits of the credit card).'),
(1585, 1, 6, 'weight', 'weight', 'The weight of the product or person.'),
(1586, 1, 6, 'potentialAction', 'potentialAction', 'Indicates a potential Action, which describes an idealized action in which this thing would play an \'object\' role.'),
(1587, 1, 6, 'suggestedMeasurement', 'suggestedMeasurement', 'A suggested range of body measurements for the intended audience or person, for example inseam between 32 and 34 inches or height between 170 and 190 cm. Typically found on a size chart for wearable products.'),
(1588, 1, 6, 'softwareVersion', 'softwareVersion', 'Version of the software instance.'),
(1589, 1, 6, 'streetAddress', 'streetAddress', 'The street address. For example, 1600 Amphitheatre Pkwy.'),
(1590, 1, 6, 'serviceSmsNumber', 'serviceSmsNumber', 'The number to access the service by text message.'),
(1591, 1, 6, 'webCheckinTime', 'webCheckinTime', 'The time when a passenger can check into the flight online.'),
(1592, 1, 6, 'tributary', 'tributary', 'The anatomical or organ system that the vein flows into; a larger structure that the vein connects to.'),
(1593, 1, 6, 'discussionUrl', 'discussionUrl', 'A link to the page containing the comments of the CreativeWork.'),
(1594, 1, 6, 'parentTaxon', 'parentTaxon', 'Closest parent taxon of the taxon in question.'),
(1595, 1, 6, 'childTaxon', 'childTaxon', 'Closest child taxa of the taxon in question.'),
(1596, 1, 6, 'subjectOf', 'subjectOf', 'A CreativeWork or Event about this Thing.'),
(1597, 1, 6, 'about', 'about', 'The subject matter of the content.'),
(1598, 1, 6, 'holdingArchive', 'holdingArchive', '[[ArchiveOrganization]] that holds, keeps or maintains the [[ArchiveComponent]].'),
(1599, 1, 6, 'archiveHeld', 'archiveHeld', 'Collection, [fonds](https://en.wikipedia.org/wiki/Fonds), or item held, kept or maintained by an [[ArchiveOrganization]].'),
(1600, 1, 6, 'dataset', 'dataset', 'A dataset contained in this catalog.'),
(1601, 1, 6, 'offeredBy', 'offeredBy', 'A pointer to the organization or person making the offer.'),
(1602, 1, 6, 'makesOffer', 'makesOffer', 'A pointer to products or services offered by the organization or person.'),
(1603, 1, 6, 'offers', 'offers', 'An offer to provide this item&#x2014;for example, an offer to sell a product, rent the DVD of a movie, perform a service, or give away tickets to an event. Use [[businessFunction]] to indicate the kind of transaction offered, i.e. sell, lease, etc. This property can also be used to describe a [[Demand]]. While this property is listed as expected on a number of common types, it can be used in others. In that case, using a second type, such as Product or a subtype of Product, can clarify the nature of the offer.\n      '),
(1604, 1, 6, 'itemOffered', 'itemOffered', 'An item being offered (or demanded). The transactional nature of the offer or demand is documented using [[businessFunction]], e.g. sell, lease etc. While several common expected types are listed explicitly in this definition, others can be used. Using a second type, such as Product or a subtype of Product, can clarify the nature of the offer.'),
(1605, 1, 6, 'mainEntityOfPage', 'mainEntityOfPage', 'Indicates a page (or other CreativeWork) for which this thing is the main entity being described. See [background notes](/docs/datamodel.html#mainEntityBackground) for details.'),
(1606, 1, 6, 'mainEntity', 'mainEntity', 'Indicates the primary entity described in some page or other CreativeWork.'),
(1607, 1, 6, 'hasBioChemEntityPart', 'hasBioChemEntityPart', 'Indicates a BioChemEntity that (in some sense) has this BioChemEntity as a part. '),
(1608, 1, 6, 'isPartOfBioChemEntity', 'isPartOfBioChemEntity', 'Indicates a BioChemEntity that is (in some sense) a part of this BioChemEntity. '),
(1609, 1, 6, 'funding', 'funding', 'A [[Grant]] that directly or indirectly provide funding or sponsorship for this item. See also [[ownershipFundingInfo]].'),
(1610, 1, 6, 'fundedItem', 'fundedItem', 'Indicates something directly or indirectly funded or sponsored through a [[Grant]]. See also [[ownershipFundingInfo]].'),
(1611, 1, 6, 'isEncodedByBioChemEntity', 'isEncodedByBioChemEntity', 'Another BioChemEntity encoding by this one.'),
(1612, 1, 6, 'encodesBioChemEntity', 'encodesBioChemEntity', 'Another BioChemEntity encoded by this one. '),
(1613, 1, 6, 'providesBroadcastService', 'providesBroadcastService', 'The BroadcastService offered on this channel.'),
(1614, 1, 6, 'hasBroadcastChannel', 'hasBroadcastChannel', 'A broadcast channel of a broadcast service.'),
(1615, 1, 6, 'recordedAs', 'recordedAs', 'An audio recording of the work.'),
(1616, 1, 6, 'recordingOf', 'recordingOf', 'The composition this track is a recording of.'),
(1617, 1, 6, 'releaseOf', 'releaseOf', 'The album this is a release of.'),
(1618, 1, 6, 'albumRelease', 'albumRelease', 'A release of this album.'),
(1619, 1, 6, 'partOfTrip', 'partOfTrip', 'Identifies that this [[Trip]] is a subTrip of another Trip.  For example Day 1, Day 2, etc. of a multi-day trip.'),
(1620, 1, 6, 'subTrip', 'subTrip', 'Identifies a [[Trip]] that is a subTrip of this Trip.  For example Day 1, Day 2, etc. of a multi-day trip.'),
(1621, 1, 6, 'encodesCreativeWork', 'encodesCreativeWork', 'The CreativeWork encoded by this media object.'),
(1622, 1, 6, 'subOrganization', 'subOrganization', 'A relationship between two organizations where the first includes the second, e.g., as a subsidiary. See also: the more specific \'department\' property.'),
(1623, 1, 6, 'isVariantOf', 'isVariantOf', 'Indicates the kind of product that this is a variant of. In the case of [[ProductModel]], this is a pointer (from a ProductModel) to a base product from which this product is a variant. It is safe to infer that the variant inherits all product features from the base model, unless defined locally. This is not transitive. In the case of a [[ProductGroup]], the group description also serves as a template, representing a set of Products that vary on explicitly defined, specific dimensions only (so it defines both a set of variants, as well as which values distinguish amongst those variants). When used with [[ProductGroup]], this property can apply to any [[Product]] included in the group.'),
(1624, 1, 6, 'hasVariant', 'hasVariant', 'Indicates a [[Product]] that is a member of this [[ProductGroup]] (or [[ProductModel]]).'),
(1625, 1, 6, 'gameServer', 'gameServer', 'The server on which  it is possible to play the game.'),
(1626, 1, 6, 'game', 'game', 'Video game which is played on this server.'),
(1627, 1, 6, 'containsSeason', 'containsSeason', 'A season that is part of the media series.'),
(1628, 1, 6, 'workTranslation', 'workTranslation', 'A work that is a translation of the content of this work. E.g. 西遊記 has an English workTranslation “Journey to the West”, a German workTranslation “Monkeys Pilgerfahrt” and a Vietnamese  translation Tây du ký bình khảo.'),
(1629, 1, 6, 'translationOfWork', 'translationOfWork', 'The work that this work has been translated from. E.g. 物种起源 is a translationOf “On the Origin of Species”.'),
(1630, 1, 6, 'alumniOf', 'alumniOf', 'An organization that the person is an alumni of.'),
(1631, 1, 6, 'alumni', 'alumni', 'Alumni of an organization.'),
(1632, 1, 6, 'recordedAt', 'recordedAt', 'The Event where the CreativeWork was recorded. The CreativeWork may capture all or part of the event.'),
(1633, 1, 6, 'recordedIn', 'recordedIn', 'The CreativeWork that captured all or part of this Event.'),
(1634, 1, 6, 'containsPlace', 'containsPlace', 'The basic containment relation between a place and another that it contains.'),
(1635, 1, 6, 'exampleOfWork', 'exampleOfWork', 'A creative work that this work is an example/instance/realization/derivation of.'),
(1636, 1, 6, 'contentLocation', 'contentLocation', 'The location depicted or described in the content. For example, the location in a photograph or painting.'),
(1637, 1, 6, 'superEvent', 'superEvent', 'An event that this event is a part of. For example, a collection of individual music performances might each have a music festival as their superEvent.'),
(1638, 1, 7, 'attributionName', 'attributionName', NULL),
(1639, 1, 7, 'attributionURL', 'attributionURL', NULL),
(1640, 1, 7, 'deprecatedOn', 'deprecated on', NULL),
(1641, 1, 7, 'jurisdiction', 'jurisdiction', NULL),
(1642, 1, 7, 'legalcode', 'legalcode', NULL),
(1643, 1, 7, 'license', 'has license', NULL),
(1644, 1, 7, 'morePermissions', 'morePermissions', NULL),
(1645, 1, 7, 'permits', 'permits', NULL),
(1646, 1, 7, 'prohibits', 'prohibits', NULL),
(1647, 1, 7, 'requires', 'requires', NULL),
(1648, 1, 7, 'useGuidelines', 'useGuidelines', NULL),
(1649, 1, 8, 'descriptionLevel', 'Description level', NULL),
(1650, 1, 8, 'identifiedBy', 'Identifier', NULL),
(1651, 1, 8, 'identifies', 'Resource identified', NULL),
(1652, 1, 8, 'adminMetadata', 'Administrative metadata', NULL),
(1653, 1, 8, 'adminMetadataFor', 'Administrative metadata for', NULL),
(1654, 1, 8, 'noteFor', 'Note for', NULL),
(1655, 1, 8, 'place', 'Place', 'Suggested value - bf:Place or madsrdf:Geographic'),
(1656, 1, 8, 'agent', 'Associated agent', 'Suggested value - bf:Agent or foaf:Agent'),
(1657, 1, 8, 'agentOf', 'Associated agent of', 'Suggested use - With bf:Agent or foaf:Agent'),
(1658, 1, 8, 'unit', 'Type of unit', NULL),
(1659, 1, 8, 'assigner', 'Assigner', 'Suggested value - bf:Organization or bf:Assigner'),
(1660, 1, 8, 'source', 'Source', 'Suggested value - bf:Organization or bf:Assigner'),
(1661, 1, 8, 'note', 'Note', NULL),
(1662, 1, 8, 'status', 'Status', NULL),
(1663, 1, 8, 'language', 'Language information', 'Suggested value - bf:Language or madsrdf:Language'),
(1664, 1, 8, 'content', 'Content type', 'Suggested value - bf:Content or skos:Concept'),
(1665, 1, 8, 'media', 'Media type', 'Suggested use - With Work or Instance'),
(1666, 1, 8, 'carrier', 'Carrier type', 'Suggested value - bf:Carrier or skos:Concept'),
(1667, 1, 8, 'genreForm', 'Genre/form', 'Suggested use - With Work, Instance or Item'),
(1668, 1, 8, 'title', 'Title resource', 'Suggested use - With Work, Instance, Item or Event'),
(1669, 1, 8, 'titleOf', 'Title of', 'Suggested value - Work, Instance, Item or Event'),
(1670, 1, 8, 'originPlace', 'Origin place', 'Suggested use - With Work or Instance'),
(1671, 1, 8, 'musicMedium', 'Music medium of performance', NULL),
(1672, 1, 8, 'instrument', 'Instrument', NULL),
(1673, 1, 8, 'ensemble', 'Ensemble', NULL),
(1674, 1, 8, 'voice', 'Voice', NULL),
(1675, 1, 8, 'geographicCoverage', 'Geographic coverage', 'Suggested value - bf:GeographicCoverage or bf:Place or madsrdf:Geographic'),
(1676, 1, 8, 'intendedAudience', 'Intended audience', 'Suggested use - With Work or Instance'),
(1677, 1, 8, 'collectionArrangement', 'Collection Organization and arrangement', 'Suggested use - With Work or Instance'),
(1678, 1, 8, 'collectionArrangementOf', 'Organization and arrangement of Collection', 'Suggested value - Work or Instance'),
(1679, 1, 8, 'dissertation', 'Dissertation Information', 'Suggested use - With Work or Instance'),
(1680, 1, 8, 'grantingInstitution', 'Degree issuing institution', NULL),
(1681, 1, 8, 'summary', 'Summary content', 'Suggested use - With Work or Instance'),
(1682, 1, 8, 'capture', 'Capture of content', 'Suggested use - With Work or Instance'),
(1683, 1, 8, 'notation', 'Notation system', 'Suggested use - With Work or Instance'),
(1684, 1, 8, 'contentAccessibility', 'Content accessibility information', 'Suggested use - With Work or Instance'),
(1685, 1, 8, 'illustrativeContent', 'Illustrative content information', 'Suggested use - With Work or Instance'),
(1686, 1, 8, 'supplementaryContent', 'Supplementary material', 'Suggested use - With Work or Instance'),
(1687, 1, 8, 'colorContent', 'Color content', 'Suggested use - With Work, Instance or Item'),
(1688, 1, 8, 'soundContent', 'Sound content', 'Suggested use - With Work or Instance'),
(1689, 1, 8, 'aspectRatio', 'Aspect ratio', 'Suggested use - With Work or Instance'),
(1690, 1, 8, 'musicFormat', 'Format of notated music', 'Suggested use - With Work or Instance'),
(1691, 1, 8, 'scale', 'Scale', 'Suggested use - With Work or Instance'),
(1692, 1, 8, 'cartographicAttributes', 'Cartographic data', 'Suggested use - With Work or Instance'),
(1693, 1, 8, 'projection', 'Cartographic projection', NULL),
(1694, 1, 8, 'subject', 'Subject', 'Suggested use - With Work, Instance, Item or Event'),
(1695, 1, 8, 'subjectOf', 'Subject of', 'Suggested use - With bf:Agent or bf:Topic or bf:Hub'),
(1696, 1, 8, 'classification', 'Classification', 'Suggested use - With Work, Instance or Item'),
(1697, 1, 8, 'pubFrequency', 'Publication frequency', 'Suggested use - With Work or Instance'),
(1698, 1, 8, 'frequency', 'Frequency', NULL),
(1699, 1, 8, 'issuance', 'Mode of issuance', 'Suggested use - With Work or Instance'),
(1700, 1, 8, 'provisionActivity', 'Provision activity', NULL),
(1701, 1, 8, 'acquisitionSource', 'Source of acquisition', 'Suggested use - With Work or Instance'),
(1702, 1, 8, 'copyrightRegistration', 'Copyright registration information', 'Suggested use - With Work or Instance'),
(1703, 1, 8, 'coverArt', 'Cover art', 'Suggested use - With Work or Instance'),
(1704, 1, 8, 'review', 'Review content', 'Suggested use - With Work or Instance'),
(1705, 1, 8, 'tableOfContents', 'Table of contents content', 'Suggested use - With Work or Instance'),
(1706, 1, 8, 'relief', 'Relief', NULL),
(1707, 1, 8, 'extent', 'Extent', NULL),
(1708, 1, 8, 'material', 'Material', 'Suggested use - With Work, Instance or Item'),
(1709, 1, 8, 'materialOf', 'Material of', 'Suggested use - With Work, Instance or Item'),
(1710, 1, 8, 'baseMaterial', 'Base material', 'Suggested use - With Work, Instance or Item'),
(1711, 1, 8, 'baseMaterialOf', 'Base material of', NULL),
(1712, 1, 8, 'appliedMaterial', 'Applied material', 'Suggested use - With Work, Instance or Item'),
(1713, 1, 8, 'appliedMaterialOf', 'Appllied material of', NULL),
(1714, 1, 8, 'emulsion', 'Emulsion', NULL),
(1715, 1, 8, 'mount', 'Mount material or object', NULL),
(1716, 1, 8, 'productionMethod', 'Production method', NULL),
(1717, 1, 8, 'generation', 'Generation', NULL),
(1718, 1, 8, 'layout', 'Layout', NULL),
(1719, 1, 8, 'bookFormat', 'Book format', NULL),
(1720, 1, 8, 'fontSize', 'Font size', NULL),
(1721, 1, 8, 'polarity', 'Polarity', NULL),
(1722, 1, 8, 'reductionRatio', 'Reduction ratio', NULL),
(1723, 1, 8, 'soundCharacteristic', 'Sound characteristic', NULL),
(1724, 1, 8, 'projectionCharacteristic', 'Projection characteristic', NULL),
(1725, 1, 8, 'videoCharacteristic', 'Video characteristic', NULL),
(1726, 1, 8, 'digitalCharacteristic', 'Digital characteristic', NULL),
(1727, 1, 8, 'systemRequirement', 'Equipment or system requirements', NULL),
(1728, 1, 8, 'binding', 'Binding method', NULL),
(1729, 1, 8, 'enumerationAndChronology', 'Numbering or other enumeration and dates associated with issues or items held.', NULL),
(1730, 1, 8, 'heldBy', 'Held by', NULL),
(1731, 1, 8, 'sublocation', 'Held in sublocation', NULL),
(1732, 1, 8, 'shelfMark', 'Shelf mark', NULL),
(1733, 1, 8, 'electronicLocator', 'Electronic location', NULL),
(1734, 1, 8, 'usageAndAccessPolicy', 'Use and access condition', 'Suggested use - With Work, Instance or Item'),
(1735, 1, 8, 'immediateAcquisition', 'Immediate acquisition', NULL),
(1736, 1, 8, 'hasInstance', 'Instance of Work', NULL),
(1737, 1, 8, 'instanceOf', 'Instance of', NULL),
(1738, 1, 8, 'hasExpression', 'Expressed as', 'Suggested use - With Work or Hub'),
(1739, 1, 8, 'expressionOf', 'Expression of', 'Suggested use - With Work or Hub'),
(1740, 1, 8, 'itemOf', 'Holding for', NULL),
(1741, 1, 8, 'associatedResource', 'Associated resource', 'Suggested value - With Work or Hub'),
(1742, 1, 8, 'hasItem', 'Has holding', NULL),
(1743, 1, 8, 'relation', 'Relation', 'Suggested use - With Work, Instance or Item'),
(1744, 1, 8, 'relationship', 'Relationship', NULL),
(1745, 1, 8, 'eventContent', 'Event content', NULL),
(1746, 1, 8, 'eventContentOf', 'Has event content', NULL),
(1747, 1, 8, 'hasPart', 'Has part', 'Suggested use - With Work, Instance, Item or Event'),
(1748, 1, 8, 'partOf', 'Is part of', 'Suggested use - With Work, Instance, Item or Event'),
(1749, 1, 8, 'accompaniedBy', 'Accompanied by', 'Suggested use - With Work, Instance or Item'),
(1750, 1, 8, 'accompanies', 'Accompanies', 'Suggested use - With Work, Instance or Item'),
(1751, 1, 8, 'hasDerivative', 'Has derivative', 'Suggested use - With Work or Instance'),
(1752, 1, 8, 'derivativeOf', 'Is derivative of', 'Suggested use - With Work or Instance'),
(1753, 1, 8, 'precededBy', 'Preceded by', 'Suggested use - With Work or Instance'),
(1754, 1, 8, 'succeededBy', 'Succeeded by', 'Suggested use - With Work or Instance'),
(1755, 1, 8, 'references', 'References', 'Suggested use - With Work, Instance or Item'),
(1756, 1, 8, 'referencedBy', 'Referenced by', 'Suggested use - With Work, Instance or Item'),
(1757, 1, 8, 'hasReproduction', 'Reproduced as', NULL),
(1758, 1, 8, 'reproductionOf', 'Reproduction of', NULL),
(1759, 1, 8, 'dataSource', 'Data source', 'Suggested use - With Work or Instance'),
(1760, 1, 8, 'hasSeries', 'In series', 'Suggested use - With Work or Instance'),
(1761, 1, 8, 'seriesOf', 'Series container of', 'Suggested use - With Work or Instance'),
(1762, 1, 8, 'hasSubseries', 'Subseries', 'Suggested use - With Work or Instance'),
(1763, 1, 8, 'subseriesOf', 'Subseries of', 'Suggested use - With Work or Instance'),
(1764, 1, 8, 'supplement', 'Supplement', 'Suggested use - With Work or Instance'),
(1765, 1, 8, 'supplementTo', 'Supplement to', 'Suggested use - With Work or Instance'),
(1766, 1, 8, 'arrangement', 'Arrangement', NULL),
(1767, 1, 8, 'arrangementOf', 'Arrangement of', NULL),
(1768, 1, 8, 'translation', 'Translation as', 'Suggested use - With Work or Instance'),
(1769, 1, 8, 'translationOf', 'Translation of', 'Suggested use - With Work or Instance'),
(1770, 1, 8, 'originalVersion', 'Original version', 'Suggested use - With Work or Instance'),
(1771, 1, 8, 'originalVersionOf', 'Original version of', 'Suggested use - With Work or Instance'),
(1772, 1, 8, 'index', 'Has index', 'Suggested use - With Work or Instance'),
(1773, 1, 8, 'indexOf', 'Index to', 'Suggested use - With Work or Instance'),
(1774, 1, 8, 'findingAid', 'Finding aid', 'Suggested use - With Work or Instance'),
(1775, 1, 8, 'findingAidOf', 'Finding aid for', 'Suggested use - With Work or Instance'),
(1776, 1, 8, 'separatedFrom', 'Separated from', 'Suggested use - With Work or Instance'),
(1777, 1, 8, 'splitInto', 'Split into', 'Suggested use - With Work or Instance'),
(1778, 1, 8, 'replacementOf', 'Replacement of', 'Suggested use - With Work or Instance'),
(1779, 1, 8, 'replacedBy', 'Replaced by', 'Suggested use - With Work or Instance'),
(1780, 1, 8, 'mergerOf', 'Merger of', 'Suggested use - With Work or Instance'),
(1781, 1, 8, 'mergedToForm', 'Merged to form', 'Suggested use - With Work or Instance'),
(1782, 1, 8, 'continues', 'Continuation of', 'Suggested use - With Work or Instance'),
(1783, 1, 8, 'continuesInPart', 'Continuation in part of', 'Suggested use - With Work or Instance'),
(1784, 1, 8, 'absorbed', 'Absorption of', 'Suggested use - With Work or Instance'),
(1785, 1, 8, 'absorbedBy', 'Absorbed by', 'Suggested use - With Work or Instance'),
(1786, 1, 8, 'continuedBy', 'Continued by', 'Suggested use - With Work or Instance'),
(1787, 1, 8, 'continuedInPartBy', 'Continued in part by', 'Suggested use - With Work or Instance'),
(1788, 1, 8, 'contribution', 'Contributor and role', 'Suggested use - With Work, Instance or Item'),
(1789, 1, 8, 'contributionOf', 'Contribution of', 'Suggested value - Work, Instance or Item'),
(1790, 1, 8, 'role', 'Contributor role', NULL),
(1791, 1, 8, 'derivedFrom', 'Source metadata', NULL),
(1792, 1, 8, 'descriptionConventions', 'Description conventions', NULL),
(1793, 1, 8, 'descriptionLanguage', 'Description language', NULL),
(1794, 1, 8, 'generationProcess', 'Description generation', NULL),
(1795, 1, 8, 'descriptionModifier', 'Description modifier', NULL),
(1796, 1, 8, 'descriptionAuthentication', 'Description authentication', NULL),
(1797, 1, 8, 'qualifier', 'Qualifier', NULL),
(1798, 1, 8, 'date', 'Date', NULL),
(1799, 1, 8, 'count', 'Number of units', NULL),
(1800, 1, 8, 'code', 'Code', NULL),
(1801, 1, 8, 'part', 'Part', NULL),
(1802, 1, 8, 'mainTitle', 'Main title', NULL),
(1803, 1, 8, 'subtitle', 'Subtitle', NULL),
(1804, 1, 8, 'partNumber', 'Part number', NULL),
(1805, 1, 8, 'partName', 'Part title', NULL),
(1806, 1, 8, 'variantType', 'Variant title type', NULL),
(1807, 1, 8, 'originDate', 'Origin date', NULL),
(1808, 1, 8, 'historyOfWork', 'History of the work', NULL),
(1809, 1, 8, 'instrumentalType', 'Instrument role', NULL),
(1810, 1, 8, 'ensembleType', 'Ensemble type', NULL),
(1811, 1, 8, 'voiceType', 'Type of voice', NULL),
(1812, 1, 8, 'musicSerialNumber', 'Music serial number', NULL),
(1813, 1, 8, 'musicOpusNumber', 'Music opus number', NULL),
(1814, 1, 8, 'musicThematicNumber', 'Music thematic number', NULL),
(1815, 1, 8, 'musicKey', 'Music key', NULL),
(1816, 1, 8, 'legalDate', 'Date of legal work', NULL),
(1817, 1, 8, 'version', 'Version', NULL),
(1818, 1, 8, 'validDate', 'Valid date', NULL),
(1819, 1, 8, 'natureOfContent', 'Content nature', 'Suggested use - With Work or Instance'),
(1820, 1, 8, 'temporalCoverage', 'Temporal coverage', NULL),
(1821, 1, 8, 'pattern', 'Arrangement of material', NULL),
(1822, 1, 8, 'hierarchicalLevel', 'Hierarchical level of material', NULL),
(1823, 1, 8, 'collectionOrganization', 'Organization of material', NULL),
(1824, 1, 8, 'degree', 'Degree', NULL),
(1825, 1, 8, 'duration', 'Duration', 'Suggested use - With Work or Instance'),
(1826, 1, 8, 'ascensionAndDeclination', 'Cartographic ascension and declination', NULL),
(1827, 1, 8, 'coordinates', 'Cartographic coordinates', NULL),
(1828, 1, 8, 'equinox', 'Cartographic equinox', NULL),
(1829, 1, 8, 'exclusionGRing', 'Cartographic G ring area excluded', NULL),
(1830, 1, 8, 'outerGRing', 'Cartographic outer G ring area covered', NULL),
(1831, 1, 8, 'awards', 'Award note', 'Suggested use - With Work or Instance'),
(1832, 1, 8, 'credits', 'Credits note', 'Suggested use - With Work or Instance'),
(1833, 1, 8, 'schedulePart', 'Classification designation', NULL),
(1834, 1, 8, 'edition', 'Classification scheme edition', NULL),
(1835, 1, 8, 'itemPortion', 'Classification item number', NULL),
(1836, 1, 8, 'classificationPortion', 'Classification number', NULL),
(1837, 1, 8, 'spanEnd', 'Classification number span end', NULL),
(1838, 1, 8, 'table', 'Classification table identification', NULL),
(1839, 1, 8, 'tableSeq', 'Classification table sequence number', NULL),
(1840, 1, 8, 'responsibilityStatement', 'Creative responsibility statement', NULL),
(1841, 1, 8, 'editionStatement', 'Edition statement', NULL),
(1842, 1, 8, 'editionEnumeration', 'Edition enumeration', NULL),
(1843, 1, 8, 'provisionActivityStatement', 'Provider statement', NULL),
(1844, 1, 8, 'seriesStatement', 'Series statement', NULL),
(1845, 1, 8, 'seriesEnumeration', 'Series enumeration', 'Suggested use - With Work or Instance'),
(1846, 1, 8, 'subseriesStatement', 'Subseries statement', NULL),
(1847, 1, 8, 'subseriesEnumeration', 'Subseries enumeration', NULL),
(1848, 1, 8, 'distributionStatement', 'Distribution statement', NULL),
(1849, 1, 8, 'manufactureStatement', 'Manufacture statement', NULL),
(1850, 1, 8, 'productionStatement', 'Production statement', NULL),
(1851, 1, 8, 'publicationStatement', 'Publication statement', NULL),
(1852, 1, 8, 'preferredCitation', 'Preferred citation', 'Suggested use - With Work or Instance'),
(1853, 1, 8, 'firstIssue', 'Multipart first issue', NULL),
(1854, 1, 8, 'lastIssue', 'Multipart last issue', NULL),
(1855, 1, 8, 'copyrightDate', 'Copyright date', 'Suggested use - With Work or Instance'),
(1856, 1, 8, 'custodialHistory', 'Custodial history', 'Suggested use - With Work, Instance or Item'),
(1857, 1, 8, 'acquisitionTerms', 'Terms of acquisition', 'Suggested use - With Work or Instance'),
(1858, 1, 8, 'dimensions', 'Dimensions', NULL),
(1859, 1, 8, 'physicalLocation', 'Storing or shelving location', NULL),
(1860, 1, 8, 'noteType', 'Note type', NULL),
(1861, 1, 8, 'changeDate', 'Description change date', NULL),
(1862, 1, 8, 'creationDate', 'Description creation date', NULL),
(1863, 1, 8, 'generationDate', 'Date generated', NULL),
(1864, 1, 8, 'relatedTo', 'Related resource', NULL),
(1865, 1, 8, 'hasEquivalent', 'Equivalence', 'Suggested use - With Work, Instance or Item'),
(1866, 1, 8, 'issuedWith', 'Issued with', 'Suggested use - With Work or Instance'),
(1867, 1, 8, 'otherPhysicalFormat', 'Has other physical format', 'Suggested use - With Work or Instance'),
(1868, 1, 8, 'otherEdition', 'Other edition', 'Suggested use - With Work or Instance'),
(1869, 1, 9, 'abbreviatedName', 'Abbreviated name', NULL),
(1870, 1, 9, 'abbreviatedNameForTheConferenceOrEvent', 'Abbreviated name for the conference or event', NULL),
(1871, 1, 9, 'abbreviatedNameForTheCorporateBody', 'Abbreviated name for the corporate body', NULL),
(1872, 1, 9, 'abbreviatedNameForThePlaceOrGeographicName', 'Abbreviated name for the place or geographic name', NULL),
(1873, 1, 9, 'abbreviatedNameForTheWork', 'Abbreviated name for the work', NULL),
(1874, 1, 9, 'marc21equivalent', 'MARC 21 equivalent', 'Expresses the MARC 21 equivalent for this element in the GND MARC\n      format.'),
(1875, 1, 9, 'preferredName', 'Preferred name', NULL),
(1876, 1, 9, 'preferredNameForTheConferenceOrEvent', 'Preferred name for the conference or event', NULL),
(1877, 1, 9, 'preferredNameForTheCorporateBody', 'Preferred name for the corporate body', NULL),
(1878, 1, 9, 'preferredNameForTheFamily', 'Preferred name for the family', NULL),
(1879, 1, 9, 'preferredNameForThePerson', 'Preferred name for the person', NULL),
(1880, 1, 9, 'preferredNameForThePlaceOrGeographicName', 'Preferred name for the place or geographic name', NULL),
(1881, 1, 9, 'preferredNameForTheSubjectHeading', 'Preferred name for the subject heading', NULL),
(1882, 1, 9, 'preferredNameForTheWork', 'Preferred name for the work', NULL),
(1883, 1, 9, 'titleWithOtherTitleInformation', 'Title with other title information ', NULL),
(1884, 1, 9, 'variantName', 'Variant name', NULL),
(1885, 1, 9, 'variantNameForTheConferenceOrEvent', 'Variant name for the conference or event', NULL),
(1886, 1, 9, 'variantNameForTheCorporateBody', 'Variant name for the corporate body', NULL),
(1887, 1, 9, 'variantNameForTheFamily', 'Variant name for the family', NULL),
(1888, 1, 9, 'variantNameForThePerson', 'Variant name for the person', NULL),
(1889, 1, 9, 'variantNameForThePlaceOrGeographicName', 'Variant name for the place or geographic name', NULL),
(1890, 1, 9, 'variantNameForTheSubjectHeading', 'Variant name for the subject heading', NULL),
(1891, 1, 9, 'variantNameForTheWork', 'Variant name for the work', NULL),
(1892, 1, 9, 'accordingWork', 'According work', NULL),
(1893, 1, 9, 'accreditedArtist', 'Accredited artist', 'An author, artist, etc., relating him/her to a resource for which there is or once was substantial authority for designating that person as author, creator, etc. of the work'),
(1894, 1, 9, 'accreditedAuthor', 'Accredited author', 'An author, artist, etc., relating him/her to a resource for which there is or once was substantial authority for designating that person as author, creator, etc. of the work'),
(1895, 1, 9, 'accreditedComposer', 'Accredited composer', 'An author, artist, etc., relating him/her to a resource for which there is or once was substantial authority for designating that person as author, creator, etc. of the work'),
(1896, 1, 9, 'acquaintanceshipOrFriendship', 'Acquaintanceship or friendship', 'Relationship between a person, family, or corporate body and another person, family, or corporate body which cannot be specified more closely'),
(1897, 1, 9, 'addressee', 'Addressee', 'A person, family, or organization to whom the correspondence in a work is addressed.'),
(1898, 1, 9, 'affiliation', 'Affiliation', 'A corporate body associated with a person or group of persons.'),
(1899, 1, 9, 'annotator', 'Annotator', 'A person who makes manuscript annotations on an item.'),
(1900, 1, 9, 'architect', 'Architect', 'A person, family, or organization responsible for creating an\n		architectural design, including a pictorial representation intended to show how a building,\n		etc., will look when completed. It also oversees the construction of structures.'),
(1901, 1, 9, 'arranger', 'Arranger', 'A person, family, or organization contributing to a musical\n		work by rewriting the composition for a medium of performance different from that\n		for which the work was originally intended, or modifying the work for the same\n		medium of performance, etc., such that the musical substance of the original\n		composition remains essentially unchanged. For extensive modification that effectively\n		results in the creation of a new musical work, see composer.'),
(1902, 1, 9, 'artist', 'Artist', NULL),
(1903, 1, 9, 'associatedPlace', 'Associated place', NULL),
(1904, 1, 9, 'author', 'Author', 'A person, family, or organization responsible for creating a work that is primarily textual in content, regardless of media type (e.g., printed text, spoken word, electronic text, tactile text) or genre (e.g., poems, novels, screenplays, blogs). Use also for persons, etc., creating a new work by paraphrasing, rewriting, or adapting works by another creator such that the modification has substantially changed the nature and content of the original or changed the medium of expression'),
(1905, 1, 9, 'benefactor', 'Benefactor', 'A person, family, or corporate body being the benefactor of a work, a thing, or a corporate body'),
(1906, 1, 9, 'bookbinder', 'Bookbinder', 'A person who binds an item'),
(1907, 1, 9, 'bookdesigner', 'Bookdesigner', 'A person or organization involved in manufacturing a manifestation by being responsible for the entire graphic design of a book, including arrangement of type and illustration, choice of materials, and process used'),
(1908, 1, 9, 'broaderMapping', 'Broader mapping', 'The term represents a concept having a wider meaning than the GND concept.'),
(1909, 1, 9, 'broaderTerm', 'Broader term', 'Use broader term general instead'),
(1910, 1, 9, 'broaderTermGeneral', 'Broader term (general)', 'Broader term'),
(1911, 1, 9, 'broaderTermGeneric', 'Broader term (generic)', 'The generic relation is a semantic relation between two concepts\n      where the intension of one of the concepts includes that of the other concepts and at least\n      one additional delimiting characteristic is added.'),
(1912, 1, 9, 'broaderTermInstantial', 'Broader term (instantial)', 'The instance relationship links a general concept such as a class of\n      things or events, and an individual instance oft hat class, which is often represented by a\n      proper name.'),
(1913, 1, 9, 'broaderTermPartitive', 'Broader term (partitive)', 'The hierarchical whole-part relationship covers a limited range of\n      situations in which a part of an entity or system belongs uniquely to a particular possessing\n      whole. When applied to persons, this is the relation between a single person (particularly gods)\n	  and hierarchically broader groups of gods and mythologic entities.'),
(1914, 1, 9, 'broaderTermWithMoreThanOneElement', 'Broader term (with more than one element)', NULL),
(1915, 1, 9, 'broderTermGeneral', 'Broader term (general)', 'Use gndo:broaderTermGeneral instead'),
(1916, 1, 9, 'buildingOwner', 'Building owner', 'A person, family, or corporate body in charge of financing and constructing a building'),
(1917, 1, 9, 'cartographer', 'Cartographer', 'A person, family, or organization responsible for creating a map, atlas, globe, or other cartographic work'),
(1918, 1, 9, 'celebratedCorporateBody', 'Celebrated corporate body', NULL),
(1919, 1, 9, 'celebratedFamily', 'Celebrated family', NULL),
(1920, 1, 9, 'celebratedPerson', 'Celebrated person', NULL),
(1921, 1, 9, 'celebratedTopic', 'Celebrated topic', NULL),
(1922, 1, 9, 'characteristicPlace', 'Characteristic place', 'A significant place for a person or family'),
(1923, 1, 9, 'choreographer', 'Choreographer', 'A person responsible for creating or contributing to a work of movement'),
(1924, 1, 9, 'citedArtist', 'Cited artist', 'A person or organization whose work is largely quoted or extracted in works to which he or she did not contribute directly. Such quotations are found particularly in exhibition catalogs, collections of photographs, etc.'),
(1925, 1, 9, 'citedAuthor', 'Cited author', 'A person or organization whose work is largely quoted or extracted in works to which he or she did not contribute directly. Such quotations are found particularly in exhibition catalogs, collections of photographs, etc.'),
(1926, 1, 9, 'citedComposer', 'Cited composer', 'A person or organization whose work is largely quoted or extracted in works to which he or she did not contribute directly. Such quotations are found particularly in exhibition catalogs, collections of photographs, etc.'),
(1927, 1, 9, 'collector', 'Collector', 'A curator who brings together items from various sources that are then arranged, described, and cataloged as a collection. A collector is neither the creator of the material nor a person to whom manuscripts in the collection may have been addressed'),
(1928, 1, 9, 'compiler', 'Compiler', 'A person, family, or organization responsible for creating a new work (e.g., a bibliography, a directory) through the act of compilation, e.g., selecting, arranging, aggregating, and editing data, information, etc'),
(1929, 1, 9, 'complexSeeReferenceSubject', 'Complex see reference - subject', NULL),
(1930, 1, 9, 'composer', 'Composer', 'A person, family, or organization responsible for creating or contributing to a musical resource by adding music to a work that originally lacked it or supplements it'),
(1931, 1, 9, 'conferrer', 'Conferrer', 'A person or organization permitting the temporary use of a book, manuscript, etc., such as for photocopying or microfilming'),
(1932, 1, 9, 'contributinFamily', 'Contributing family', 'Use contributingFamily instead.'),
(1933, 1, 9, 'contributingFamily', 'Contributing family', NULL),
(1934, 1, 9, 'contributingCorporateBody', 'Contributing corporate body', NULL),
(1935, 1, 9, 'contributingPerson', 'Contributing person', NULL),
(1936, 1, 9, 'contributingPlaceOrGeographicName', 'Contributing place or geographic name', NULL),
(1937, 1, 9, 'copist', 'Copist', 'A person or family who is known as scribe or copyist.'),
(1938, 1, 9, 'corporateBodyIsMember', 'Corporate body is member', NULL),
(1939, 1, 9, 'correspondent', 'Correspondent', 'A person or organization who was either the writer or recipient of a letter or other communication'),
(1940, 1, 9, 'creator', 'Creator', 'A person or organization performing the work, i.e., the name of a person or organization associated with the intellectual content of the work. This category does not include the publisher or personal affiliation, or sponsor except where it is also the corporate author'),
(1941, 1, 9, 'cumulativeCompoundEquivalence', 'cumulative compound equivalence', 'The cumulation of two or more terms represents the GND concept.'),
(1942, 1, 9, 'curator', 'Curator', 'A person, family, or organization conceiving, aggregating, and/or organizing an exhibition, collection, or other item'),
(1943, 1, 9, 'dedicatee', 'Dedicatee', 'A person, family, or organization to whom a resource is dedicated'),
(1944, 1, 9, 'descriptionLevel', 'GND Description Level', 'Expressing the level of completness of the description on the scale of GND Description Level values. More information on this scale at https://wiki.dnb.de/download/attachments/50759357/005.pdf (in german)'),
(1945, 1, 9, 'designer', 'Designer', 'A person, family, or organization responsible for creating a design for an object'),
(1946, 1, 9, 'director', 'Director', 'A person responsible for the general management and supervision of a filmed performance, a radio or television program, etc.'),
(1947, 1, 9, 'directorOfPhotography', 'Director of photography', 'A person in charge of photographing a motion picture, who plans the technical aspets of lighting and photographing of scenes, and often assists the director in the choice of angles, camera setups, and lighting moods. He or she may also supervise the further processing of filmed material up to the completion of the work print. Cinematographer is also referred to as director of photography. Do not confuse with videographer'),
(1948, 1, 9, 'doubtfulArtist', 'Doubtful artist', 'A person or organization to which authorship has been dubiously or incorrectly ascribed'),
(1949, 1, 9, 'doubtfulAuthor', 'Doubtful author', 'A person or organization to which authorship has been dubiously or incorrectly ascribed'),
(1950, 1, 9, 'doubtfulComposer', 'Doubtful composer', 'A person or organization to which authorship has been dubiously or incorrectly ascribed'),
(1951, 1, 9, 'editor', 'Editor', 'A person, family, or organization contributing to a resource by revising or elucidating the content, e.g., adding an introduction, notes, or other critical matter. An editor may also prepare a resource for production, publication, or distribution. For major revisions, adaptations, etc., that substantially change the nature and content of the original work, resulting in a new work, see author'),
(1952, 1, 9, 'engraver', 'Engraver', 'A person or organization who cuts letters, figures, etc. on a surface, such as a wooden or metal plate used for printing'),
(1953, 1, 9, 'equivalence', 'Equivalence', 'Concepts of mapped vocabularies are most closely matching.'),
(1954, 1, 9, 'etcher', 'Etcher', 'A person or organization who produces text or images for printing by subjecting metal, glass, or some other surface to acid or the corrosive action of some other substance'),
(1955, 1, 9, 'exactEquivalence', 'exact equivalence', 'Concepts of mapped vocabularies are exactly the same.'),
(1956, 1, 9, 'exhibitor', 'Exhibitor', 'A person, family, or corporate body in charge of an exhibition.'),
(1957, 1, 9, 'familialRelationship', 'Familial relationship', 'A family relationship between a person or family and another person or family'),
(1958, 1, 9, 'fictitiousAuthor', 'Fictitious author', 'A fictitious person, family, or corporate body ascertained to be the author'),
(1959, 1, 9, 'fieldOfActivity', 'Field of activity', 'Field of activity of a person, corporate body, conference or event.'),
(1960, 1, 9, 'fieldOfStudy', 'Field of study', 'A person’s field of study'),
(1961, 1, 9, 'firstArtist', 'First artist', 'A person or organization that takes primary responsibility for a particular activity or endeavor. May be combined with another relator term or code to show the greater importance this person or organization has regarding that particular role. If more than one relator is assigned to a heading, use the Lead relator only if it applies to all the relators'),
(1962, 1, 9, 'firstAuthor', 'First author', 'A person or organization that takes primary responsibility for a\n		particular activity or endeavor. May be combined with another relator term or code to\n		show the greater importance this person or organization has regarding that particular role.\n		If more than one relator is assigned to a heading, use the Lead relator only if it applies\n		to all the relators.'),
(1963, 1, 9, 'firstComposer', 'First composer', 'A person or organization that takes primary responsibility for a particular activity or endeavor. May be combined with another relator term or code to show the greater importance this person or organization has regarding that particular role. If more than one relator is assigned to a heading, use the Lead relator only if it applies to all the relators'),
(1964, 1, 9, 'formerOwner', 'Former owner', 'A person, family, or organization formerly having legal possession of an item'),
(1965, 1, 9, 'formOfWorkAndExpression', 'Form of work and expression', NULL),
(1966, 1, 9, 'founder', 'Founder', 'A person, family, or corporate body being a founder of an enterprise, an event, or an ensemble of buildings'),
(1967, 1, 9, 'functionOrRole', 'Function or role', 'This property is equivalent to gndo:functionOrRoleAsLiteral but points to a subject heading instead of giving a literal value.'),
(1968, 1, 9, 'gender', 'Gender', NULL),
(1969, 1, 9, 'geographicAreaCode', 'Geographic Area Code', NULL),
(1970, 1, 9, 'gndSubjectCategory', 'GND subject category', NULL),
(1971, 1, 9, 'hasRelationship', 'has relationship', NULL);
INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1972, 1, 9, 'hierarchicalSuperior', 'Hierarchical superior', NULL),
(1973, 1, 9, 'hierarchicalSuperiorOfPlaceOrGeographicName', 'Hierarchical superior of place or geographic name', 'A hierarchically superordinate unit (corporate body, conference, jurisdiction) of the described unit (corporate body, conference, jurisdiction).'),
(1974, 1, 9, 'hierarchicalSuperiorOfTheConferenceOrEvent', 'Hierarchical superior of the conference or event', NULL),
(1975, 1, 9, 'hierarchicalSuperiorOfTheCorporateBody', 'Hierarchical superior of the corporate body', NULL),
(1976, 1, 9, 'homepage', 'Homepage', NULL),
(1977, 1, 9, 'illustratorOrIlluminator', 'Illustrator or illuminator', 'A person, family, or organization contributing to a resource by supplementing the primary content with drawings, diagrams, photographs, etc. If the work is primarily the artistic content created by this entity, use artist or photographer'),
(1978, 1, 9, 'inexactEquivalence', 'inexact equivalence', 'Concepts of mapped vocabularies are most closely matching but not exactly the same.'),
(1979, 1, 9, 'initiator', 'Initiator', 'A person, family, or corporate body who initiated a work'),
(1980, 1, 9, 'instrument', 'Instrument', 'A musical instrument, a device to perform music with'),
(1981, 1, 9, 'instrumentalist', 'Instrumentalist', 'A performer contributing to a resource by playing a musical instrument'),
(1982, 1, 9, 'intersectingCompoundEquivalence', 'intersecting compound equivalence', 'The intersection of two or more terms represents the GND concept.'),
(1983, 1, 9, 'inventor', 'Inventor', 'A person, family, or organization responsible for creating a new device or process'),
(1984, 1, 9, 'language', 'Language', 'A language used by a person or family or in which a work was written'),
(1985, 1, 9, 'languageCode', 'Language code', NULL),
(1986, 1, 9, 'librettist', 'Librettist', 'An author of a libretto of an opera or other stage work, or an oratorio'),
(1987, 1, 9, 'literarySource', 'Literary source', 'The described entity is a realization of the related work'),
(1988, 1, 9, 'lithographer', 'Lithographer', 'A person or organization who prepares the stone or plate for lithographic printing, including a graphic artist creating a design directly on the surface from which printing will be done.'),
(1989, 1, 9, 'manufacturer', 'Manufacturer', 'A person or organization responsible for printing, duplicating, casting, etc. a resource'),
(1990, 1, 9, 'member', 'Member', 'A person or family being a member of (another) family'),
(1991, 1, 9, 'memberOfTheFamily', 'Member of the family', 'Die beschriebene Person (Subjekt) ist ein bedeutendes \n	Mitglied der verknüpften Familie (Objekt). Für Göttergruppen und Gruppen\n	mythologischer Gestalten wird gndo:broaderTermPartitive verwendet.'),
(1992, 1, 9, 'musician', 'Musician', 'A person or organization who performs music or contributes to the musical content of a work when it is not possible or desirable to identify the function more precisely'),
(1993, 1, 9, 'narrator', 'Narrator', 'A performer contributing to a resource by reading or speaking in order to give an account of an act, occurrence, course of events, etc'),
(1994, 1, 9, 'narrowerMapping', 'Narrower mapping', 'The term represents a concept having a narrower meaning than the GND concept.'),
(1995, 1, 9, 'narrowerTermGeneral', 'Narrower term (general)', NULL),
(1996, 1, 9, 'narrowerTermGeneric', 'Narrower term (generic)', 'The generic relation is a semantic relation between two concepts\n      where the intension of one of the concepts includes that of the other concepts and at least\n      one additional delimiting characteristic is added.'),
(1997, 1, 9, 'narrowerTermInstantial', 'Narrower term (instantial)', 'The instance relationship links a general concept such as a class of\n      things or events, and an individual instance oft hat class, which is often represented by a\n      proper name.'),
(1998, 1, 9, 'narrowerTermPartitive', 'Narrower term (partitive)', 'The hierarchical whole-part relationship covers a limited range of\n      situations in which a part of an entity or system belongs uniquely to a particular possessing\n      whole. When applied to persons, this is the relation between a single person (particularly gods)\n	  and hierarchically superior groups of gods and mythologic entities.'),
(1999, 1, 9, 'noMapping', 'No mapping', 'There is no relationship to the other vocabulary.'),
(2000, 1, 9, 'occasion', 'Occasion', 'Reason of the entity, e.g. a work or a historic event\n		is the reason of a conference, or a conference is the reason of a work.'),
(2001, 1, 9, 'occasionOfTheSubjectHeading', 'Occasion of the subject heading', NULL),
(2002, 1, 9, 'occasionOfTheWork', 'Occasion of the work', NULL),
(2003, 1, 9, 'mediumOfPerformance', 'Medium of performance', NULL),
(2004, 1, 9, 'organizerOrHost', 'Organizer or host', 'A person, family, or organization organizing the exhibit, event, conference, etc., which gave rise to a resource'),
(2005, 1, 9, 'otherPlace', 'Other place', NULL),
(2006, 1, 9, 'owner', 'Owner', 'A person, family, or organization that currently owns an item or collection, i.e. has legal possession of a resource'),
(2007, 1, 9, 'painter', 'Painter', 'A person or family who paints'),
(2008, 1, 9, 'photographer', 'Photographer', 'A person, family, or organization responsible for creating a photographic work'),
(2009, 1, 9, 'place', 'Place', 'A country, state, province, etc., or place where an organization has its headquarters'),
(2010, 1, 9, 'placeOfActivity', 'Place of activity', 'A person’s or family’s place of activity'),
(2011, 1, 9, 'placeOfBirth', 'Place of Birth', 'A person’s place of birth'),
(2012, 1, 9, 'placeOfBusiness', 'Place of business', NULL),
(2013, 1, 9, 'placeOfConferenceOrEvent', 'Place of conference or event', 'A place where an event such as a conference or a concert took place'),
(2014, 1, 9, 'placeOfCustody', 'Place of custody', 'A place where something is kept'),
(2015, 1, 9, 'placeOfDeath', 'Place of death', 'A person’s place of death'),
(2016, 1, 9, 'placeOfDiscovery', 'Place of discovery', 'A place where a work or thing was found'),
(2017, 1, 9, 'placeOfExile', 'Place of Exile', 'A place where a person or family dwelt in exile (lived in exile)'),
(2018, 1, 9, 'placeOfManufacture', 'Place of manufacture', 'A place where a work or thing was manufactured'),
(2019, 1, 9, 'placeOrGeographicNameIsMember', 'Place or geographic name is member', NULL),
(2020, 1, 9, 'playedInstrument', 'Played instrument', NULL),
(2021, 1, 9, 'poet', 'Poet', 'An author of the words of a non-dramatic musical work (e.g. the text of a song), except for oratorios'),
(2022, 1, 9, 'precedingConferenceOrEvent', 'Preceding conference or event', NULL),
(2023, 1, 9, 'precedingCorporateBody', 'Preceding corporate body', NULL),
(2024, 1, 9, 'precedingPlaceOrGeographicName', 'Preceding place or geographic name', NULL),
(2025, 1, 9, 'precedingSubject', 'Preceding subject heading', NULL),
(2026, 1, 9, 'precedingWork', 'Preceding work', NULL),
(2027, 1, 9, 'predecessor', 'Predecessor', 'A corporate body or a work being the predecessor of another corporate body or work'),
(2028, 1, 9, 'preferredNameEntityForThePerson', 'Preferred name entity for the person', NULL),
(2029, 1, 9, 'printer', 'Printer', 'A person, family, or organization involved in manufacturing a manifestation of printed text, notated music, etc., from type or plates, such as a book, newspaper, magazine, broadside, score, etc'),
(2030, 1, 9, 'professionOrOccupation', 'Profession or occupation', 'A profession or occupation practiced by a person or family'),
(2031, 1, 9, 'professionalRelationship', 'Professional relationship', 'An occupational relationship between a person or family and another person or family'),
(2032, 1, 9, 'pseudonym', 'Pseudonym', 'Links a person\'s real identity to an identity under which one or more persons act, e. g. write, compose or create art, but that is not the person\'s real name (i. e. a pseudonym).'),
(2033, 1, 9, 'realIdentity', 'Real identity', 'Links an identity under which one or more persons act, e. g. write, compose or create art, but that is not their real name (i. e. a pseudonym) to their real identity.'),
(2034, 1, 9, 'relatedConferenceOrEvent', 'Related conference or event', NULL),
(2035, 1, 9, 'relatedCorporateBody', 'Related Corporate Body', NULL),
(2036, 1, 9, 'relatedDdcWithDegreeOfDeterminacy1', 'Related Dewey Decimal Classification with degree of determinacy\n      1', 'The connotation scope of the GND entity corresponds to a small part\n      to the connotation scope of the assigned DDC class.'),
(2037, 1, 9, 'relatedDdcWithDegreeOfDeterminacy2', 'Related Dewey Decimal Classification with degree of determinacy\n      2', 'The connotation scope of the GND entity is identical or nearly\n      identical to the connotation scope of a topic that is logically part of the class but is less\n      extensive in scope than the concept represented by the class number.'),
(2038, 1, 9, 'relatedDdcWithDegreeOfDeterminacy3', 'Related Dewey Decimal Classification with degree of determinacy\n      3', 'The connotation scope of the GND entity is identical or nearly\n      identical to the connotation scope of a topic that approximates the whole of the assigned DDC\n      class. According to DDC terms, topics that are nearly coextensive with the full meaning of a\n      class or cover more than half of the content of the class approximate the whole of the DDC\n      class.'),
(2039, 1, 9, 'relatedDdcWithDegreeOfDeterminacy4', 'Related Dewey Decimal Classification with degree of determinacy\n      4', 'The connotation scope of the GND entity is identical to the\n      connotation scope of the topic emphasized in the DDC class heading.'),
(2040, 1, 9, 'relatedFamily', 'Related family', NULL),
(2041, 1, 9, 'relatedMapping', 'Related mapping', 'The term labels an associated concept that is not synonym and not broader or narrower than the GND concept.'),
(2042, 1, 9, 'relatedPerson', 'Related person', NULL),
(2043, 1, 9, 'relatedPlaceOrGeographicName', 'Related place or geographic name', NULL),
(2044, 1, 9, 'relatedSubjecHeading', 'Related subject heading', 'Use relatedSubjectHeading (\'subject\', not \'subjec\') instead'),
(2045, 1, 9, 'relatedSubjectHeading', 'Related subject heading', NULL),
(2046, 1, 9, 'relatedTerm', 'Related Term', 'The associative relationship covers associations between pairs of\n      concepts that are not related hierarchically, but are semantically or concetually associated\n      to such an extent that the link between them needs to be made explicit in the thesaurus. '),
(2047, 1, 9, 'relatedWork', 'Related work', NULL),
(2048, 1, 9, 'restorer', 'Restorer', 'A person, family, or organization responsible for the set of technical, editorial, and intellectual procedures aimed at compensating for the degradation of an item by bringing it back to a state as close as possible to its original condition'),
(2049, 1, 9, 'revisor', 'Revisor', 'A person or organization who 1) reworks a musical composition, usually for a different medium, or 2) rewrites novels or stories for motion pictures or other audiovisual medium.'),
(2050, 1, 9, 'screenwriter', 'Screenwriter', 'An author of a screenplay, script, or scene'),
(2051, 1, 9, 'scriptorium', 'Scriptorium', 'A scriptorium in a monastery'),
(2052, 1, 9, 'sculptor', 'Sculptor', 'An artist responsible for creating a three-dimensional work by modeling, carving, or similar technique'),
(2053, 1, 9, 'singer', 'Singer', 'A performer contributing to a resource by using his/her/their voice, with or without instrumental accompaniment, to produce music. A singer\'s performance may or may not include actual words'),
(2054, 1, 9, 'sponsorOrPatron', 'Sponsor or patron', 'A person, family, or organization sponsoring some aspect of a resource, e.g., funding research, sponsoring an event'),
(2055, 1, 9, 'subeditor', 'Subeditor', 'A person or organization who writes or develops the framework for an item without being intellectually responsible for its content'),
(2056, 1, 9, 'succeedingConferenceOrEvent', 'Succeeding conference or event', NULL),
(2057, 1, 9, 'succeedingCorporateBody', 'Succeeding corporate body', NULL),
(2058, 1, 9, 'succeedingPlaceOrGeographicName', 'Succeeding place or geographic name', NULL),
(2059, 1, 9, 'succeedingSubjectHeading', 'Succeeding subject heading', NULL),
(2060, 1, 9, 'succeedingWork', 'Succeeding work', NULL),
(2061, 1, 9, 'spatialAreaOfActivity', 'Spatial area of activity', 'Geographic field of activity'),
(2062, 1, 9, 'StartingOrFinalPointOfADistance', 'Starting or final point of a distance', 'Use startingOrFinalPointOfADistance (with a minor s) instead'),
(2063, 1, 9, 'startingOrFinalPointOfADistance', 'Starting or final point of a distance', NULL),
(2064, 1, 9, 'superPropertyOf', 'Super-property of', 'P1 gnd:superPropertyOf P2 states that P2 is a subproperty of P1. The\n      gndo:superPropertyOf property is transitive.'),
(2065, 1, 9, 'successor', 'Successor', NULL),
(2066, 1, 9, 'temporaryName', 'Temporary name', NULL),
(2067, 1, 9, 'temporaryNameOfTheConferenceOrEvent', 'Temporary name of the conference or event', NULL),
(2068, 1, 9, 'temporaryNameOfTheCorporateBody', 'Temporary name of the corporate body', NULL),
(2069, 1, 9, 'temporaryNameOfThePlaceOrGeographicName', 'Temporary name of the place or geographic name', NULL),
(2070, 1, 9, 'titleOfNobility', 'Title of nobility', 'A title of nobility held by a person or family.'),
(2071, 1, 9, 'topic', 'Topic', 'Topic that is related to a corporate body, conference, person, family, subject heading or work.'),
(2072, 1, 9, 'translator', 'Translator', 'A person or organization who renders a text from one language into another, or from an older form of a language into the modern form'),
(2073, 1, 9, 'typeOfCoordinates', 'Type of coordinates', NULL),
(2074, 1, 9, 'variantNameEntityForThePerson', 'Variant name entity for the person', NULL),
(2075, 1, 9, 'writerOfAddedCommentary', 'Writer of added commentary', 'A person or organization responsible for the commentary or explanatory notes about a text. For the writer of manuscript annotations in a printed book, use Annotator'),
(2076, 1, 9, 'academicDegree', 'Academic degree', 'An academic degree.'),
(2077, 1, 9, 'addition', 'Addition', NULL),
(2078, 1, 9, 'affiliationAsLiteral', 'Affiliation (Literal)', 'A corporate body associated with a person or group of persons.\n		This property is equivalent to gndo:affiliation but gives a literal instead of\n		a URI.'),
(2079, 1, 9, 'alternativeMediumOfPerformance', 'Alternative medium of performance', NULL),
(2080, 1, 9, 'associatedDate', 'Associated date', NULL),
(2081, 1, 9, 'biographicalOrHistoricalInformation', 'Biographical or historical information', 'Summary of the essential biographical, historical, or other\n      information about the described entity.'),
(2082, 1, 9, 'coordinates', 'Coordinates', NULL),
(2083, 1, 9, 'counting', 'Counting', NULL),
(2084, 1, 9, 'dateOfBirth', 'Date of birth', 'The birth date of a person. This can be a year, a year-month combination or a full date.'),
(2085, 1, 9, 'dateOfBirthAndDeath', 'Date of birth and death', NULL),
(2086, 1, 9, 'dateOfConferenceOrEvent', 'Date of conference or event', 'Date of a conference'),
(2087, 1, 9, 'dateOfDeath', 'Date of death', 'The death date of a person. This can be a year, a year-month combination or a full date.'),
(2088, 1, 9, 'dateOfDiscovery', 'Date of discovery', 'Date or year in which an object was found (not to be used in connection with persons, families and corporate bodies)'),
(2089, 1, 9, 'dateOfEstablishment', 'Date of establishment', NULL),
(2090, 1, 9, 'dateOfEstablishmentAndTermination', 'Date of establishment and termination', NULL),
(2091, 1, 9, 'dateOfProduction', 'Date of production', 'Date (year) in which a written historical document was created or a building constructed'),
(2092, 1, 9, 'dateOfPublication', 'Date of publication', 'Date of publication of the first expression of a work'),
(2093, 1, 9, 'dateOfTermination', 'Date of termination', NULL),
(2094, 1, 9, 'definition', 'Definition', NULL),
(2095, 1, 9, 'easternmostLongitude', 'Easternmost longitude', NULL),
(2096, 1, 9, 'epithetGenericNameTitleOrTerritory', 'Epithet, generic name, title or territory', NULL),
(2097, 1, 9, 'forename', 'Forename', NULL),
(2098, 1, 9, 'functionOrRoleAsLiteral', 'Function or role (Literal)', 'This property is equivalent to gndo:functionOrRole but gives a literal instead of a URI'),
(2099, 1, 9, 'gndIdentifier', 'GND-Identifier', NULL),
(2100, 1, 9, 'keyOfTheVersion', 'Key of the version', NULL),
(2101, 1, 9, 'keyOfTheWork', 'Key of the work', NULL),
(2102, 1, 9, 'mediumOfPerformanceAsLiteral', 'Medium of performance (Literal)', NULL),
(2103, 1, 9, 'nameAddition', 'Name addition', NULL),
(2104, 1, 9, 'northernmostLatitude', 'Northernmost latitude', NULL),
(2105, 1, 9, 'numberOfEnsemblesOfTheSameType', 'Number of ensembles of the same type', NULL),
(2106, 1, 9, 'numberOfPerformersOfTheSameMedium', 'Number of perfomers of the same medium', NULL),
(2107, 1, 9, 'oldAuthorityNumber', 'Old authority number', NULL),
(2108, 1, 9, 'opusNumericDesignationOfMusicalWork', 'Opus numeric designation of musical work', NULL),
(2109, 1, 9, 'beginningOfPeriod', 'Beginning of a period', NULL),
(2110, 1, 9, 'endOfPeriod', 'End of a period', NULL),
(2111, 1, 9, 'originalScriptNameOfThePerson', 'Original script form of the name of the person', NULL),
(2112, 1, 9, 'periodOfActivity', 'Period of activity', 'A person’s known period of activity'),
(2113, 1, 9, 'personalName', 'Personal name', NULL),
(2114, 1, 9, 'placeOfBirthAsLiteral', 'Place of Birth (Literal)', 'This property is equivalent to gndo:placeOfBirth but gives a literal instead of\n		a reference to a geographic entity'),
(2115, 1, 9, 'placeOfDeathAsLiteral', 'Place of death (Literal)', 'This property is equivalent to gndo:placeOfDeath but gives a literal instead of\n		a reference to a geographic entity'),
(2116, 1, 9, 'professionOrOccupationAsLiteral', 'Profession or occupation (Literal)', 'This property is equivalent to gndo:professionOrOccupation but gives a literal instead of\n		a reference to a subject heading'),
(2117, 1, 9, 'prefix', 'Prefix', NULL),
(2118, 1, 9, 'publication', 'Publication', NULL),
(2119, 1, 9, 'serialNumericDesignationOfMusicalWork', 'Serial numeric designation of musical work', NULL),
(2120, 1, 9, 'southernmostLatitude', 'Southernmost latitude', NULL),
(2121, 1, 9, 'surname', 'Surname', NULL),
(2122, 1, 9, 'thematicIndexNumericDesignationOfMusicalWork', 'Thematic index numeric designation of musical work', NULL),
(2123, 1, 9, 'titleOfNobilityAsLiteral', 'Title of nobility (Literal)', 'A title of nobility held by a person or family.\n		This property is equivalent to gndo:titleOfNobility\n		but gives a literal instead of a reference to a subject heading.'),
(2124, 1, 9, 'totalNumberOfEnsembles', 'Total number of ensembles', NULL),
(2125, 1, 9, 'totalNumberOfPerformers', 'Total number of performers', NULL),
(2126, 1, 9, 'udkCode', 'UDK-Code', 'Date, expressed as UDK code'),
(2127, 1, 9, 'usingInstructions', 'Using Instructions', NULL),
(2128, 1, 9, 'westernmostLongitude', 'Westernmost longitude', NULL),
(2129, 1, 10, 'access', 'Access', 'Define an access to the resource.'),
(2130, 1, 10, 'featured', 'Featured', 'Mark the resource as a featured one as soon as a value is set, whatever it is.'),
(2131, 1, 10, 'new', 'New', 'Mark the resource as a new one as soon as a value is set, whatever it is.'),
(2132, 1, 10, 'reserved', 'Reserved', 'Define the resource as a restricted access one as soon a value is set, whatever it is.'),
(2133, 1, 10, 'selected', 'Selected', 'Mark the resource as a selected one as soon as a value is set, whatever it is.'),
(2134, 1, 10, 'category', 'Category', 'A topic that can be used for some purposes.'),
(2135, 1, 10, 'collection', 'Collection', 'A way to group resources.'),
(2136, 1, 10, 'set', 'Set', 'A set to group resources together.'),
(2137, 1, 10, 'subject', 'Subject', 'A subject to describe the resource.'),
(2138, 1, 10, 'tag', 'Tag', 'Tag that can be used for some purposes or for upgrade from Omeka Classic.'),
(2139, 1, 10, 'theme', 'Theme', 'A domain that can be used for some purposes.'),
(2140, 1, 10, 'type', 'Type', 'A type that can be used for some purposes.'),
(2141, 1, 10, 'coordinates', 'Coordinates', 'Numerical coordinates related to the resource, generaly the geographic position.'),
(2142, 1, 10, 'data', 'Data', 'Any data that can be used for any purpose.'),
(2143, 1, 10, 'start', 'Start', 'A start related to the resource, for example the start of an embargo.'),
(2144, 1, 10, 'end', 'End', 'A end related to the resource, for example the end of an embargo.'),
(2145, 1, 10, 'location', 'Location', 'A location related to the resource, for example the place of publication.'),
(2146, 1, 10, 'note', 'Note', 'A specific or generic information on a resource, generally for internal purposes.'),
(2147, 1, 10, 'number', 'Number', 'A number related to the resource.'),
(2148, 1, 10, 'rank', 'Rank', 'A rank or a position related to the resource.'),
(2149, 1, 10, 'status', 'Status', 'The status of the resource, generally for internal purposes.');

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE `resource` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `resource_template_id` int DEFAULT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `resource_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`id`, `owner_id`, `resource_class_id`, `resource_template_id`, `thumbnail_id`, `title`, `is_public`, `created`, `modified`, `resource_type`) VALUES
(1, 1, 40, NULL, NULL, 'First item', 1, '2023-02-15 16:05:58', '2023-02-28 14:46:08', 'Omeka\\Entity\\Item'),
(2, 1, 692, NULL, NULL, 'CC-Licenses Collection', 1, '2023-11-30 18:54:06', '2023-11-30 18:54:06', 'Omeka\\Entity\\ItemSet'),
(3, 1, 1000, 2, NULL, 'Creative Common license - CC-BY-NC', 1, '2023-11-30 18:57:24', '2023-11-30 19:00:07', 'Omeka\\Entity\\Item'),
(4, 1, 1000, 2, NULL, 'Creative Common license - CC-BY', 1, '2023-11-30 18:58:55', '2023-11-30 18:59:56', 'Omeka\\Entity\\Item');

-- --------------------------------------------------------

--
-- Table structure for table `resource_class`
--

CREATE TABLE `resource_class` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_class`
--

INSERT INTO `resource_class` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1, NULL, 1, 'Agent', 'Agent', 'A resource that acts or has the power to act.'),
(2, NULL, 1, 'AgentClass', 'Agent Class', 'A group of agents.'),
(3, NULL, 1, 'BibliographicResource', 'Bibliographic Resource', 'A book, article, or other documentary resource.'),
(4, NULL, 1, 'FileFormat', 'File Format', 'A digital resource format.'),
(5, NULL, 1, 'Frequency', 'Frequency', 'A rate at which something recurs.'),
(6, NULL, 1, 'Jurisdiction', 'Jurisdiction', 'The extent or range of judicial, law enforcement, or other authority.'),
(7, NULL, 1, 'LicenseDocument', 'License Document', 'A legal document giving official permission to do something with a Resource.'),
(8, NULL, 1, 'LinguisticSystem', 'Linguistic System', 'A system of signs, symbols, sounds, gestures, or rules used in communication.'),
(9, NULL, 1, 'Location', 'Location', 'A spatial region or named place.'),
(10, NULL, 1, 'LocationPeriodOrJurisdiction', 'Location, Period, or Jurisdiction', 'A location, period of time, or jurisdiction.'),
(11, NULL, 1, 'MediaType', 'Media Type', 'A file format or physical medium.'),
(12, NULL, 1, 'MediaTypeOrExtent', 'Media Type or Extent', 'A media type or extent.'),
(13, NULL, 1, 'MethodOfInstruction', 'Method of Instruction', 'A process that is used to engender knowledge, attitudes, and skills.'),
(14, NULL, 1, 'MethodOfAccrual', 'Method of Accrual', 'A method by which resources are added to a collection.'),
(15, NULL, 1, 'PeriodOfTime', 'Period of Time', 'An interval of time that is named or defined by its start and end dates.'),
(16, NULL, 1, 'PhysicalMedium', 'Physical Medium', 'A physical material or carrier.'),
(17, NULL, 1, 'PhysicalResource', 'Physical Resource', 'A material thing.'),
(18, NULL, 1, 'Policy', 'Policy', 'A plan or course of action by an authority, intended to influence and determine decisions, actions, and other matters.'),
(19, NULL, 1, 'ProvenanceStatement', 'Provenance Statement', 'A statement of any changes in ownership and custody of a resource since its creation that are significant for its authenticity, integrity, and interpretation.'),
(20, NULL, 1, 'RightsStatement', 'Rights Statement', 'A statement about the intellectual property rights (IPR) held in or over a Resource, a legal document giving official permission to do something with a resource, or a statement about access rights.'),
(21, NULL, 1, 'SizeOrDuration', 'Size or Duration', 'A dimension or extent, or a time taken to play or execute.'),
(22, NULL, 1, 'Standard', 'Standard', 'A basis for comparison; a reference point against which other things can be evaluated.'),
(23, NULL, 2, 'Collection', 'Collection', 'An aggregation of resources.'),
(24, NULL, 2, 'Dataset', 'Dataset', 'Data encoded in a defined structure.'),
(25, NULL, 2, 'Event', 'Event', 'A non-persistent, time-based occurrence.'),
(26, NULL, 2, 'Image', 'Image', 'A visual representation other than text.'),
(27, NULL, 2, 'InteractiveResource', 'Interactive Resource', 'A resource requiring interaction from the user to be understood, executed, or experienced.'),
(28, NULL, 2, 'Service', 'Service', 'A system that provides one or more functions.'),
(29, NULL, 2, 'Software', 'Software', 'A computer program in source or compiled form.'),
(30, NULL, 2, 'Sound', 'Sound', 'A resource primarily intended to be heard.'),
(31, NULL, 2, 'Text', 'Text', 'A resource consisting primarily of words for reading.'),
(32, NULL, 2, 'PhysicalObject', 'Physical Object', 'An inanimate, three-dimensional object or substance.'),
(33, NULL, 2, 'StillImage', 'Still Image', 'A static visual representation.'),
(34, NULL, 2, 'MovingImage', 'Moving Image', 'A series of visual representations imparting an impression of motion when shown in succession.'),
(35, NULL, 3, 'AcademicArticle', 'Academic Article', 'A scholarly academic article, typically published in a journal.'),
(36, NULL, 3, 'Article', 'Article', 'A written composition in prose, usually nonfiction, on a specific topic, forming an independent part of a book or other publication, as a newspaper or magazine.'),
(37, NULL, 3, 'AudioDocument', 'audio document', 'An audio document; aka record.'),
(38, NULL, 3, 'AudioVisualDocument', 'audio-visual document', 'An audio-visual document; film, video, and so forth.'),
(39, NULL, 3, 'Bill', 'Bill', 'Draft legislation presented for discussion to a legal body.'),
(40, NULL, 3, 'Book', 'Book', 'A written or printed work of fiction or nonfiction, usually on sheets of paper fastened or bound together within covers.'),
(41, NULL, 3, 'BookSection', 'Book Section', 'A section of a book.'),
(42, NULL, 3, 'Brief', 'Brief', 'A written argument submitted to a court.'),
(43, NULL, 3, 'Chapter', 'Chapter', 'A chapter of a book.'),
(44, NULL, 3, 'Code', 'Code', 'A collection of statutes.'),
(45, NULL, 3, 'CollectedDocument', 'Collected Document', 'A document that simultaneously contains other documents.'),
(46, NULL, 3, 'Collection', 'Collection', 'A collection of Documents or Collections'),
(47, NULL, 3, 'Conference', 'Conference', 'A meeting for consultation or discussion.'),
(48, NULL, 3, 'CourtReporter', 'Court Reporter', 'A collection of legal cases.'),
(49, NULL, 3, 'Document', 'Document', 'A document (noun) is a bounded physical representation of body of information designed with the capacity (and usually intent) to communicate. A document may manifest symbolic, diagrammatic or sensory-representational information.'),
(50, NULL, 3, 'DocumentPart', 'document part', 'a distinct part of a larger document or collected document.'),
(51, NULL, 3, 'DocumentStatus', 'Document Status', 'The status of the publication of a document.'),
(52, NULL, 3, 'EditedBook', 'Edited Book', 'An edited book.'),
(53, NULL, 3, 'Email', 'EMail', 'A written communication addressed to a person or organization and transmitted electronically.'),
(54, NULL, 3, 'Event', 'Event', NULL),
(55, NULL, 3, 'Excerpt', 'Excerpt', 'A passage selected from a larger work.'),
(56, NULL, 3, 'Film', 'Film', 'aka movie.'),
(57, NULL, 3, 'Hearing', 'Hearing', 'An instance or a session in which testimony and arguments are presented, esp. before an official, as a judge in a lawsuit.'),
(58, NULL, 3, 'Image', 'Image', 'A document that presents visual or diagrammatic information.'),
(59, NULL, 3, 'Interview', 'Interview', 'A formalized discussion between two or more people.'),
(60, NULL, 3, 'Issue', 'Issue', 'something that is printed or published and distributed, esp. a given number of a periodical'),
(61, NULL, 3, 'Journal', 'Journal', 'A periodical of scholarly journal Articles.'),
(62, NULL, 3, 'LegalCaseDocument', 'Legal Case Document', 'A document accompanying a legal case.'),
(63, NULL, 3, 'LegalDecision', 'Decision', 'A document containing an authoritative determination (as a decree or judgment) made after consideration of facts or law.'),
(64, NULL, 3, 'LegalDocument', 'Legal Document', 'A legal document; for example, a court decision, a brief, and so forth.'),
(65, NULL, 3, 'Legislation', 'Legislation', 'A legal document proposing or enacting a law or a group of laws.'),
(66, NULL, 3, 'Letter', 'Letter', 'A written or printed communication addressed to a person or organization and usually transmitted by mail.'),
(67, NULL, 3, 'Magazine', 'Magazine', 'A periodical of magazine Articles. A magazine is a publication that is issued periodically, usually bound in a paper cover, and typically contains essays, stories, poems, etc., by many writers, and often photographs and drawings, frequently specializing in a particular subject or area, as hobbies, news, or sports.'),
(68, NULL, 3, 'Manual', 'Manual', 'A small reference book, especially one giving instructions.'),
(69, NULL, 3, 'Manuscript', 'Manuscript', 'An unpublished Document, which may also be submitted to a publisher for publication.'),
(70, NULL, 3, 'Map', 'Map', 'A graphical depiction of geographic features.'),
(71, NULL, 3, 'MultiVolumeBook', 'Multivolume Book', 'A loose, thematic, collection of Documents, often Books.'),
(72, NULL, 3, 'Newspaper', 'Newspaper', 'A periodical of documents, usually issued daily or weekly, containing current news, editorials, feature articles, and usually advertising.'),
(73, NULL, 3, 'Note', 'Note', 'Notes or annotations about a resource.'),
(74, NULL, 3, 'Patent', 'Patent', 'A document describing the exclusive right granted by a government to an inventor to manufacture, use, or sell an invention for a certain number of years.'),
(75, NULL, 3, 'Performance', 'Performance', 'A public performance.'),
(76, NULL, 3, 'Periodical', 'Periodical', 'A group of related documents issued at regular intervals.'),
(77, NULL, 3, 'PersonalCommunication', 'Personal Communication', 'A communication between an agent and one or more specific recipients.'),
(78, NULL, 3, 'PersonalCommunicationDocument', 'Personal Communication Document', 'A personal communication manifested in some document.'),
(79, NULL, 3, 'Proceedings', 'Proceedings', 'A compilation of documents published from an event, such as a conference.'),
(80, NULL, 3, 'Quote', 'Quote', 'An excerpted collection of words.'),
(81, NULL, 3, 'ReferenceSource', 'Reference Source', 'A document that presents authoritative reference information, such as a dictionary or encylopedia .'),
(82, NULL, 3, 'Report', 'Report', 'A document describing an account or statement describing in detail an event, situation, or the like, usually as the result of observation, inquiry, etc..'),
(83, NULL, 3, 'Series', 'Series', 'A loose, thematic, collection of Documents, often Books.'),
(84, NULL, 3, 'Slide', 'Slide', 'A slide in a slideshow'),
(85, NULL, 3, 'Slideshow', 'Slideshow', 'A presentation of a series of slides, usually presented in front of an audience with written text and images.'),
(86, NULL, 3, 'Standard', 'Standard', 'A document describing a standard'),
(87, NULL, 3, 'Statute', 'Statute', 'A bill enacted into law.'),
(88, NULL, 3, 'Thesis', 'Thesis', 'A document created to summarize research findings associated with the completion of an academic degree.'),
(89, NULL, 3, 'ThesisDegree', 'Thesis degree', 'The academic degree of a Thesis'),
(90, NULL, 3, 'Webpage', 'Webpage', 'A web page is an online document available (at least initially) on the world wide web. A web page is written first and foremost to appear on the web, as distinct from other online resources such as books, manuscripts or audio documents which use the web primarily as a distribution mechanism alongside other more traditional methods such as print.'),
(91, NULL, 3, 'Website', 'Website', 'A group of Webpages accessible on the Web.'),
(92, NULL, 3, 'Workshop', 'Workshop', 'A seminar, discussion group, or the like, that emphasizes zxchange of ideas and the demonstration and application of techniques, skills, etc.'),
(93, NULL, 4, 'LabelProperty', 'Label Property', 'A foaf:LabelProperty is any RDF property with texual values that serve as labels.'),
(94, NULL, 4, 'Person', 'Person', 'A person.'),
(95, NULL, 4, 'Document', 'Document', 'A document.'),
(96, NULL, 4, 'Organization', 'Organization', 'An organization.'),
(97, NULL, 4, 'Group', 'Group', 'A class of Agents.'),
(98, NULL, 4, 'Agent', 'Agent', 'An agent (eg. person, group, software or physical artifact).'),
(99, NULL, 4, 'Project', 'Project', 'A project (a collective endeavour of some kind).'),
(100, NULL, 4, 'Image', 'Image', 'An image.'),
(101, NULL, 4, 'PersonalProfileDocument', 'PersonalProfileDocument', 'A personal profile RDF document.'),
(102, NULL, 4, 'OnlineAccount', 'Online Account', 'An online account.'),
(103, NULL, 4, 'OnlineGamingAccount', 'Online Gaming Account', 'An online gaming account.'),
(104, NULL, 4, 'OnlineEcommerceAccount', 'Online E-commerce Account', 'An online e-commerce account.'),
(105, NULL, 4, 'OnlineChatAccount', 'Online Chat Account', 'An online chat account.'),
(106, 1, 6, 'HinduTemple', 'HinduTemple', 'A Hindu temple.'),
(107, 1, 6, 'FMRadioChannel', 'FMRadioChannel', 'A radio channel that uses FM.'),
(108, 1, 6, 'BikeStore', 'BikeStore', 'A bike store.'),
(109, 1, 6, 'HVACBusiness', 'HVACBusiness', 'A business that provides Heating, Ventilation and Air Conditioning services.'),
(110, 1, 6, 'ChildrensEvent', 'ChildrensEvent', 'Event type: Children\'s event.'),
(111, 1, 6, 'TireShop', 'TireShop', 'A tire shop.'),
(112, 1, 6, 'ComedyEvent', 'ComedyEvent', 'Event type: Comedy event.'),
(113, 1, 6, 'HardwareStore', 'HardwareStore', 'A hardware store.'),
(114, 1, 6, 'SpreadsheetDigitalDocument', 'SpreadsheetDigitalDocument', 'A spreadsheet file.'),
(115, 1, 6, 'PreventionIndication', 'PreventionIndication', 'An indication for preventing an underlying condition, symptom, etc.'),
(116, 1, 6, 'Hotel', 'Hotel', 'A hotel is an establishment that provides lodging paid on a short-term basis (source: Wikipedia, the free encyclopedia, see http://en.wikipedia.org/wiki/Hotel).\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(117, 1, 6, 'ReviewNewsArticle', 'ReviewNewsArticle', 'A [[NewsArticle]] and [[CriticReview]] providing a professional critic\'s assessment of a service, product, performance, or artistic or literary work.'),
(118, 1, 6, 'ScheduleAction', 'ScheduleAction', 'Scheduling future actions, events, or tasks.\\n\\nRelated actions:\\n\\n* [[ReserveAction]]: Unlike ReserveAction, ScheduleAction allocates future actions (e.g. an event, a task, etc) towards a time slot / spatial allocation.'),
(119, 1, 6, 'AutoBodyShop', 'AutoBodyShop', 'Auto body shop.'),
(120, 1, 6, 'ToyStore', 'ToyStore', 'A toy store.'),
(121, 1, 6, 'ReportageNewsArticle', 'ReportageNewsArticle', 'The [[ReportageNewsArticle]] type is a subtype of [[NewsArticle]] representing\n news articles which are the result of journalistic news reporting conventions.\n\nIn practice many news publishers produce a wide variety of article types, many of which might be considered a [[NewsArticle]] but not a [[ReportageNewsArticle]]. For example, opinion pieces, reviews, analysis, sponsored or satirical articles, or articles that combine several of these elements.\n\nThe [[ReportageNewsArticle]] type is based on a stricter ideal for \"news\" as a work of journalism, with articles based on factual information either observed or verified by the author, or reported and verified from knowledgeable sources.  This often includes perspectives from multiple viewpoints on a particular issue (distinguishing news reports from public relations or propaganda).  News reports in the [[ReportageNewsArticle]] sense de-emphasize the opinion of the author, with commentary and value judgements typically expressed elsewhere.\n\nA [[ReportageNewsArticle]] which goes deeper into analysis can also be marked with an additional type of [[AnalysisNewsArticle]].\n'),
(122, 1, 6, 'AnalysisNewsArticle', 'AnalysisNewsArticle', 'An AnalysisNewsArticle is a [[NewsArticle]] that, while based on factual reporting, incorporates the expertise of the author/producer, offering interpretations and conclusions.'),
(123, 1, 6, 'Dentist', 'Dentist', 'A dentist.'),
(124, 1, 6, 'SubscribeAction', 'SubscribeAction', 'The act of forming a personal connection with someone/something (object) unidirectionally/asymmetrically to get updates pushed to.\\n\\nRelated actions:\\n\\n* [[FollowAction]]: Unlike FollowAction, SubscribeAction implies that the subscriber acts as a passive agent being constantly/actively pushed for updates.\\n* [[RegisterAction]]: Unlike RegisterAction, SubscribeAction implies that the agent is interested in continuing receiving updates from the object.\\n* [[JoinAction]]: Unlike JoinAction, SubscribeAction implies that the agent is interested in continuing receiving updates from the object.'),
(125, 1, 6, 'BowlingAlley', 'BowlingAlley', 'A bowling alley.'),
(126, 1, 6, 'InvestmentFund', 'InvestmentFund', 'A company or fund that gathers capital from a number of investors to create a pool of money that is then re-invested into stocks, bonds and other assets.'),
(127, 1, 6, 'RadioSeason', 'RadioSeason', 'Season dedicated to radio broadcast and associated online delivery.'),
(128, 1, 6, 'MovieClip', 'MovieClip', 'A short segment/part of a movie.'),
(129, 1, 6, 'OfferForPurchase', 'OfferForPurchase', 'An [[OfferForPurchase]] in Schema.org represents an [[Offer]] to sell something, i.e. an [[Offer]] whose\n  [[businessFunction]] is [sell](http://purl.org/goodrelations/v1#Sell.). See [Good Relations](https://en.wikipedia.org/wiki/GoodRelations) for\n  background on the underlying concepts.\n  '),
(130, 1, 6, 'ImageObjectSnapshot', 'ImageObjectSnapshot', 'A specific and exact (byte-for-byte) version of an [[ImageObject]]. Two byte-for-byte identical files, for the purposes of this type, considered identical. If they have different embedded metadata (e.g. XMP, EXIF) the files will differ. Different external facts about the files, e.g. creator or dateCreated that aren\'t represented in their actual content, do not affect this notion of identity.'),
(131, 1, 6, 'NailSalon', 'NailSalon', 'A nail salon.'),
(132, 1, 6, 'WPHeader', 'WPHeader', 'The header section of the page.'),
(133, 1, 6, 'DryCleaningOrLaundry', 'DryCleaningOrLaundry', 'A dry-cleaning business.'),
(134, 1, 6, 'RiverBodyOfWater', 'RiverBodyOfWater', 'A river (for example, the broad majestic Shannon).'),
(135, 1, 6, 'UnRegisterAction', 'UnRegisterAction', 'The act of un-registering from a service.\\n\\nRelated actions:\\n\\n* [[RegisterAction]]: antonym of UnRegisterAction.\\n* [[LeaveAction]]: Unlike LeaveAction, UnRegisterAction implies that you are unregistering from a service you were previously registered, rather than leaving a team/group of people.'),
(136, 1, 6, 'Drawing', 'Drawing', 'A picture or diagram made with a pencil, pen, or crayon rather than paint.'),
(137, 1, 6, 'MedicalRiskCalculator', 'MedicalRiskCalculator', 'A complex mathematical calculation requiring an online calculator, used to assess prognosis. Note: use the url property of Thing to record any URLs for online calculators.'),
(138, 1, 6, 'RadioStation', 'RadioStation', 'A radio station.'),
(139, 1, 6, 'BackgroundNewsArticle', 'BackgroundNewsArticle', 'A [[NewsArticle]] providing historical context, definition and detail on a specific topic (aka \"explainer\" or \"backgrounder\"). For example, an in-depth article or frequently-asked-questions ([FAQ](https://en.wikipedia.org/wiki/FAQ)) document on topics such as Climate Change or the European Union. Other kinds of background material from a non-news setting are often described using [[Book]] or [[Article]], in particular [[ScholarlyArticle]]. See also [[NewsArticle]] for related vocabulary from a learning/education perspective.'),
(140, 1, 6, 'DiscussionForumPosting', 'DiscussionForumPosting', 'A posting to a discussion forum.'),
(141, 1, 6, 'UserTweets', 'UserTweets', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(142, 1, 6, 'Festival', 'Festival', 'Event type: Festival.'),
(143, 1, 6, 'ResearchOrganization', 'ResearchOrganization', 'A Research Organization (e.g. scientific institute, research company).'),
(144, 1, 6, 'Mountain', 'Mountain', 'A mountain, like Mount Whitney or Mount Everest.'),
(145, 1, 6, 'Motorcycle', 'Motorcycle', 'A motorcycle or motorbike is a single-track, two-wheeled motor vehicle.'),
(146, 1, 6, 'VeterinaryCare', 'VeterinaryCare', 'A vet\'s office.'),
(147, 1, 6, 'FoodService', 'FoodService', 'A food service, like breakfast, lunch, or dinner.'),
(148, 1, 6, 'MobilePhoneStore', 'MobilePhoneStore', 'A store that sells mobile phones and related accessories.'),
(149, 1, 6, 'ApprovedIndication', 'ApprovedIndication', 'An indication for a medical therapy that has been formally specified or approved by a regulatory body that regulates use of the therapy; for example, the US FDA approves indications for most drugs in the US.'),
(150, 1, 6, 'TelevisionChannel', 'TelevisionChannel', 'A unique instance of a television BroadcastService on a CableOrSatelliteService lineup.'),
(151, 1, 6, 'DiagnosticProcedure', 'DiagnosticProcedure', 'A medical procedure intended primarily for diagnostic, as opposed to therapeutic, purposes.'),
(152, 1, 6, 'Statement', 'Statement', 'A statement about something, for example a fun or interesting fact. If known, the main entity this statement is about can be indicated using mainEntity. For more formal claims (e.g. in Fact Checking), consider using [[Claim]] instead. Use the [[text]] property to capture the text of the statement.'),
(153, 1, 6, 'Cemetery', 'Cemetery', 'A graveyard.'),
(154, 1, 6, 'TravelAgency', 'TravelAgency', 'A travel agency.'),
(155, 1, 6, 'BusinessEvent', 'BusinessEvent', 'Event type: Business event.'),
(156, 1, 6, 'CurrencyConversionService', 'CurrencyConversionService', 'A service to convert funds from one currency to another currency.'),
(157, 1, 6, 'UserPlusOnes', 'UserPlusOnes', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(158, 1, 6, 'Reservoir', 'Reservoir', 'A reservoir of water, typically an artificially created lake, like the Lake Kariba reservoir.'),
(159, 1, 6, 'SuspendAction', 'SuspendAction', 'The act of momentarily pausing a device or application (e.g. pause music playback or pause a timer).'),
(160, 1, 6, 'LiquorStore', 'LiquorStore', 'A shop that sells alcoholic drinks such as wine, beer, whisky and other spirits.'),
(161, 1, 6, 'IceCreamShop', 'IceCreamShop', 'An ice cream shop.'),
(162, 1, 6, 'DaySpa', 'DaySpa', 'A day spa.'),
(163, 1, 6, 'RegisterAction', 'RegisterAction', 'The act of registering to be a user of a service, product or web page.\\n\\nRelated actions:\\n\\n* [[JoinAction]]: Unlike JoinAction, RegisterAction implies you are registering to be a user of a service, *not* a group/team of people.\\n* [[FollowAction]]: Unlike FollowAction, RegisterAction doesn\'t imply that the agent is expecting to poll for updates from the object.\\n* [[SubscribeAction]]: Unlike SubscribeAction, RegisterAction doesn\'t imply that the agent is expecting updates from the object.'),
(164, 1, 6, 'PostOffice', 'PostOffice', 'A post office.'),
(165, 1, 6, 'CafeOrCoffeeShop', 'CafeOrCoffeeShop', 'A cafe or coffee shop.'),
(166, 1, 6, 'PsychologicalTreatment', 'PsychologicalTreatment', 'A process of care relying upon counseling, dialogue and communication  aimed at improving a mental health condition without use of drugs.'),
(167, 1, 6, 'BookSeries', 'BookSeries', 'A series of books. Included books can be indicated with the hasPart property.'),
(168, 1, 6, 'AgreeAction', 'AgreeAction', 'The act of expressing a consistency of opinion with the object. An agent agrees to/about an object (a proposition, topic or theme) with participants.'),
(169, 1, 6, 'GolfCourse', 'GolfCourse', 'A golf course.'),
(170, 1, 6, 'ArriveAction', 'ArriveAction', 'The act of arriving at a place. An agent arrives at a destination from a fromLocation, optionally with participants.'),
(171, 1, 6, 'TheaterEvent', 'TheaterEvent', 'Event type: Theater performance.'),
(172, 1, 6, 'CampingPitch', 'CampingPitch', 'A [[CampingPitch]] is an individual place for overnight stay in the outdoors, typically being part of a larger camping site, or [[Campground]].\\n\\n\nIn British English a campsite, or campground, is an area, usually divided into a number of pitches, where people can camp overnight using tents or camper vans or caravans; this British English use of the word is synonymous with the American English expression campground. In American English the term campsite generally means an area where an individual, family, group, or military unit can pitch a tent or park a camper; a campground may contain many campsites.\n(Source: Wikipedia, see [https://en.wikipedia.org/wiki/Campsite](https://en.wikipedia.org/wiki/Campsite).)\\n\\n\nSee also the dedicated [document on the use of schema.org for marking up hotels and other forms of accommodations](/docs/hotels.html).\n'),
(173, 1, 6, 'InternetCafe', 'InternetCafe', 'An internet cafe.'),
(174, 1, 6, 'ClothingStore', 'ClothingStore', 'A clothing store.'),
(175, 1, 6, 'MovingCompany', 'MovingCompany', 'A moving company.'),
(176, 1, 6, 'MotorcycleDealer', 'MotorcycleDealer', 'A motorcycle dealer.'),
(177, 1, 6, 'Researcher', 'Researcher', 'Researchers.'),
(178, 1, 6, 'DepositAccount', 'DepositAccount', 'A type of Bank Account with a main purpose of depositing funds to gain interest or other benefits.'),
(179, 1, 6, 'PodcastSeason', 'PodcastSeason', 'A single season of a podcast. Many podcasts do not break down into separate seasons. In that case, PodcastSeries should be used.'),
(180, 1, 6, 'OnlineStore', 'OnlineStore', 'An eCommerce site.'),
(181, 1, 6, 'LikeAction', 'LikeAction', 'The act of expressing a positive sentiment about the object. An agent likes an object (a proposition, topic or theme) with participants.'),
(182, 1, 6, 'WPFooter', 'WPFooter', 'The footer section of the page.'),
(183, 1, 6, 'ExhibitionEvent', 'ExhibitionEvent', 'Event type: Exhibition event, e.g. at a museum, library, archive, tradeshow, ...'),
(184, 1, 6, 'RecyclingCenter', 'RecyclingCenter', 'A recycling center.'),
(185, 1, 6, 'HealthClub', 'HealthClub', 'A health club.'),
(186, 1, 6, 'CovidTestingFacility', 'CovidTestingFacility', 'A CovidTestingFacility is a [[MedicalClinic]] where testing for the COVID-19 Coronavirus\n      disease is available. If the facility is being made available from an established [[Pharmacy]], [[Hotel]], or other\n      non-medical organization, multiple types can be listed. This makes it easier to re-use existing schema.org information\n      about that place, e.g. contact info, address, opening hours. Note that in an emergency, such information may not always be reliable.\n      '),
(187, 1, 6, 'NightClub', 'NightClub', 'A nightclub or discotheque.'),
(188, 1, 6, 'UserBlocks', 'UserBlocks', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(189, 1, 6, 'OnDemandEvent', 'OnDemandEvent', 'A publication event, e.g. catch-up TV or radio podcast, during which a program is available on-demand.'),
(190, 1, 6, 'ListenAction', 'ListenAction', 'The act of consuming audio content.'),
(191, 1, 6, 'ProfessionalService', 'ProfessionalService', 'Original definition: \"provider of professional services.\"\\n\\nThe general [[ProfessionalService]] type for local businesses was deprecated due to confusion with [[Service]]. For reference, the types that it included were: [[Dentist]],\n        [[AccountingService]], [[Attorney]], [[Notary]], as well as types for several kinds of [[HomeAndConstructionBusiness]]: [[Electrician]], [[GeneralContractor]],\n        [[HousePainter]], [[Locksmith]], [[Plumber]], [[RoofingContractor]]. [[LegalService]] was introduced as a more inclusive supertype of [[Attorney]].'),
(192, 1, 6, 'MovieRentalStore', 'MovieRentalStore', 'A movie rental store.'),
(193, 1, 6, 'BarOrPub', 'BarOrPub', 'A bar or pub.'),
(194, 1, 6, 'AutoPartsStore', 'AutoPartsStore', 'An auto parts store.'),
(195, 1, 6, 'CreditCard', 'CreditCard', 'A card payment method of a particular brand or name.  Used to mark up a particular payment method and/or the financial product/service that supplies the card account.\\n\\nCommonly used values:\\n\\n* http://purl.org/goodrelations/v1#AmericanExpress\\n* http://purl.org/goodrelations/v1#DinersClub\\n* http://purl.org/goodrelations/v1#Discover\\n* http://purl.org/goodrelations/v1#JCB\\n* http://purl.org/goodrelations/v1#MasterCard\\n* http://purl.org/goodrelations/v1#VISA\n       '),
(196, 1, 6, 'OceanBodyOfWater', 'OceanBodyOfWater', 'An ocean (for example, the Pacific).'),
(197, 1, 6, 'AutoDealer', 'AutoDealer', 'An car dealership.'),
(198, 1, 6, 'PhysicalTherapy', 'PhysicalTherapy', 'A process of progressive physical care and rehabilitation aimed at improving a health condition.'),
(199, 1, 6, 'PodcastEpisode', 'PodcastEpisode', 'A single episode of a podcast series.'),
(200, 1, 6, 'WorkersUnion', 'WorkersUnion', 'A Workers Union (also known as a Labor Union, Labour Union, or Trade Union) is an organization that promotes the interests of its worker members by collectively bargaining with management, organizing, and political lobbying.'),
(201, 1, 6, 'QuoteAction', 'QuoteAction', 'An agent quotes/estimates/appraises an object/product/service with a price at a location/store.'),
(202, 1, 6, 'Zoo', 'Zoo', 'A zoo.'),
(203, 1, 6, 'FundingScheme', 'FundingScheme', 'A FundingScheme combines organizational, project and policy aspects of grant-based funding\n    that sets guidelines, principles and mechanisms to support other kinds of projects and activities.\n    Funding is typically organized via [[Grant]] funding. Examples of funding schemes: Swiss Priority Programmes (SPPs); EU Framework 7 (FP7); Horizon 2020; the NIH-R01 Grant Program; Wellcome institutional strategic support fund. For large scale public sector funding, the management and administration of grant awards is often handled by other, dedicated, organizations - [[FundingAgency]]s such as ERC, REA, ...'),
(204, 1, 6, 'AutomatedTeller', 'AutomatedTeller', 'ATM/cash machine.'),
(205, 1, 6, 'CompleteDataFeed', 'CompleteDataFeed', 'A [[CompleteDataFeed]] is a [[DataFeed]] whose standard representation includes content for every item currently in the feed.\n\nThis is the equivalent of Atom\'s element as defined in Feed Paging and Archiving [RFC 5005](https://tools.ietf.org/html/rfc5005), for example (and as defined for Atom), when using data from a feed that represents a collection of items that varies over time (e.g. \"Top Twenty Records\") there is no need to have newer entries mixed in alongside older, obsolete entries. By marking this feed as a CompleteDataFeed, old entries can be safely discarded when the feed is refreshed, since we can assume the feed has provided descriptions for all current items.'),
(206, 1, 6, 'NoteDigitalDocument', 'NoteDigitalDocument', 'A file containing a note, primarily for the author.'),
(207, 1, 6, 'TelevisionStation', 'TelevisionStation', 'A television station.'),
(208, 1, 6, 'SportingGoodsStore', 'SportingGoodsStore', 'A sporting goods store.'),
(209, 1, 6, 'BloodTest', 'BloodTest', 'A medical test performed on a sample of a patient\'s blood.'),
(210, 1, 6, 'SaleEvent', 'SaleEvent', 'Event type: Sales event.'),
(211, 1, 6, 'AutoRental', 'AutoRental', 'A car rental business.'),
(212, 1, 6, 'MusicVenue', 'MusicVenue', 'A music venue.'),
(213, 1, 6, 'Pond', 'Pond', 'A pond.'),
(214, 1, 6, 'PrependAction', 'PrependAction', 'The act of inserting at the beginning if an ordered collection.'),
(215, 1, 6, 'AMRadioChannel', 'AMRadioChannel', 'A radio channel that uses AM.'),
(216, 1, 6, 'Casino', 'Casino', 'A casino.'),
(217, 1, 6, 'UserDownloads', 'UserDownloads', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(218, 1, 6, 'Volcano', 'Volcano', 'A volcano, like Fujisan.'),
(219, 1, 6, 'AmpStory', 'AmpStory', 'A creative work with a visual storytelling format intended to be viewed online, particularly on mobile devices.'),
(220, 1, 6, 'Notary', 'Notary', 'A notary.'),
(221, 1, 6, 'HowToTip', 'HowToTip', 'An explanation in the instructions for how to achieve a result. It provides supplementary information about a technique, supply, author\'s preference, etc. It can explain what could be done, or what should not be done, but doesn\'t specify what should be done (see HowToDirection).'),
(222, 1, 6, 'Campground', 'Campground', 'A camping site, campsite, or [[Campground]] is a place used for overnight stay in the outdoors, typically containing individual [[CampingPitch]] locations. \\n\\n\nIn British English a campsite is an area, usually divided into a number of pitches, where people can camp overnight using tents or camper vans or caravans; this British English use of the word is synonymous with the American English expression campground. In American English the term campsite generally means an area where an individual, family, group, or military unit can pitch a tent or park a camper; a campground may contain many campsites (source: Wikipedia, see [https://en.wikipedia.org/wiki/Campsite](https://en.wikipedia.org/wiki/Campsite)).\\n\\n\n\nSee also the dedicated [document on the use of schema.org for marking up hotels and other forms of accommodations](/docs/hotels.html).\n'),
(223, 1, 6, 'SchoolDistrict', 'SchoolDistrict', 'A School District is an administrative area for the administration of schools.'),
(224, 1, 6, 'WearAction', 'WearAction', 'The act of dressing oneself in clothing.'),
(225, 1, 6, 'WPSideBar', 'WPSideBar', 'A sidebar section of the page.'),
(226, 1, 6, 'PublicToilet', 'PublicToilet', 'A public toilet is a room or small building containing one or more toilets (and possibly also urinals) which is available for use by the general public, or by customers or employees of certain businesses.'),
(227, 1, 6, 'ReserveAction', 'ReserveAction', 'Reserving a concrete object.\\n\\nRelated actions:\\n\\n* [[ScheduleAction]]: Unlike ScheduleAction, ReserveAction reserves concrete objects (e.g. a table, a hotel) towards a time slot / spatial allocation.'),
(228, 1, 6, 'TrainReservation', 'TrainReservation', 'A reservation for train travel.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use [[Offer]].'),
(229, 1, 6, 'DeleteAction', 'DeleteAction', 'The act of editing a recipient by removing one of its objects.'),
(230, 1, 6, 'AmusementPark', 'AmusementPark', 'An amusement park.'),
(231, 1, 6, 'Painting', 'Painting', 'A painting.'),
(232, 1, 6, 'UserCheckins', 'UserCheckins', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(233, 1, 6, 'BoatReservation', 'BoatReservation', 'A reservation for boat travel.\n\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use [[Offer]].'),
(234, 1, 6, 'FAQPage', 'FAQPage', 'A [[FAQPage]] is a [[WebPage]] presenting one or more \"[Frequently asked questions](https://en.wikipedia.org/wiki/FAQ)\" (see also [[QAPage]]).'),
(235, 1, 6, 'TattooParlor', 'TattooParlor', 'A tattoo parlor.'),
(236, 1, 6, 'GovernmentPermit', 'GovernmentPermit', 'A permit issued by a government agency.'),
(237, 1, 6, 'Barcode', 'Barcode', 'An image of a visual machine-readable code such as a barcode or QR code.'),
(238, 1, 6, 'DiscoverAction', 'DiscoverAction', 'The act of discovering/finding an object.'),
(239, 1, 6, 'CatholicChurch', 'CatholicChurch', 'A Catholic church.'),
(240, 1, 6, 'DrinkAction', 'DrinkAction', 'The act of swallowing liquids.'),
(241, 1, 6, 'ResearchProject', 'ResearchProject', 'A Research project.'),
(242, 1, 6, 'DislikeAction', 'DislikeAction', 'The act of expressing a negative sentiment about the object. An agent dislikes an object (a proposition, topic or theme) with participants.'),
(243, 1, 6, 'LibrarySystem', 'LibrarySystem', 'A [[LibrarySystem]] is a collaborative system amongst several libraries.'),
(244, 1, 6, 'UserPlays', 'UserPlays', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(245, 1, 6, 'ConfirmAction', 'ConfirmAction', 'The act of notifying someone that a future event/action is going to happen as expected.\\n\\nRelated actions:\\n\\n* [[CancelAction]]: The antonym of ConfirmAction.'),
(246, 1, 6, 'LandmarksOrHistoricalBuildings', 'LandmarksOrHistoricalBuildings', 'An historical landmark or building.'),
(247, 1, 6, 'OpinionNewsArticle', 'OpinionNewsArticle', 'An [[OpinionNewsArticle]] is a [[NewsArticle]] that primarily expresses opinions rather than journalistic reporting of news and events. For example, a [[NewsArticle]] consisting of a column or [[Blog]]/[[BlogPosting]] entry in the Opinions section of a news publication. '),
(248, 1, 6, 'Restaurant', 'Restaurant', 'A restaurant.'),
(249, 1, 6, 'PreOrderAction', 'PreOrderAction', 'An agent orders a (not yet released) object/product/service to be delivered/sent.'),
(250, 1, 6, 'MotorcycleRepair', 'MotorcycleRepair', 'A motorcycle repair shop.'),
(251, 1, 6, 'ConvenienceStore', 'ConvenienceStore', 'A convenience store.'),
(252, 1, 6, 'HighSchool', 'HighSchool', 'A high school.'),
(253, 1, 6, 'Museum', 'Museum', 'A museum.'),
(254, 1, 6, 'PublicSwimmingPool', 'PublicSwimmingPool', 'A public swimming pool.'),
(255, 1, 6, 'Park', 'Park', 'A park.'),
(256, 1, 6, 'SatiricalArticle', 'SatiricalArticle', 'An [[Article]] whose content is primarily [[satirical]](https://en.wikipedia.org/wiki/Satire) in nature, i.e. unlikely to be literally true. A satirical article is sometimes but not necessarily also a [[NewsArticle]]. [[ScholarlyArticle]]s are also sometimes satirized.'),
(257, 1, 6, 'ComedyClub', 'ComedyClub', 'A comedy club.'),
(258, 1, 6, 'OfficeEquipmentStore', 'OfficeEquipmentStore', 'An office equipment store.'),
(259, 1, 6, 'RadiationTherapy', 'RadiationTherapy', 'A process of care using radiation aimed at improving a health condition.'),
(260, 1, 6, 'PresentationDigitalDocument', 'PresentationDigitalDocument', 'A file containing slides or used for a presentation.'),
(261, 1, 6, 'HousePainter', 'HousePainter', 'A house painting service.'),
(262, 1, 6, 'BookmarkAction', 'BookmarkAction', 'An agent bookmarks/flags/labels/tags/marks an object.'),
(263, 1, 6, 'DisagreeAction', 'DisagreeAction', 'The act of expressing a difference of opinion with the object. An agent disagrees to/about an object (a proposition, topic or theme) with participants.'),
(264, 1, 6, 'InstallAction', 'InstallAction', 'The act of installing an application.'),
(265, 1, 6, 'MarryAction', 'MarryAction', 'The act of marrying a person.'),
(266, 1, 6, 'PawnShop', 'PawnShop', 'A shop that will buy, or lend money against the security of, personal possessions.'),
(267, 1, 6, 'VisualArtsEvent', 'VisualArtsEvent', 'Event type: Visual arts event.'),
(268, 1, 6, 'Playground', 'Playground', 'A playground.'),
(269, 1, 6, 'CheckOutAction', 'CheckOutAction', 'The act of an agent communicating (service provider, social media, etc) their departure of a previously reserved service (e.g. flight check-in) or place (e.g. hotel).\\n\\nRelated actions:\\n\\n* [[CheckInAction]]: The antonym of CheckOutAction.\\n* [[DepartAction]]: Unlike DepartAction, CheckOutAction implies that the agent is informing/confirming the end of a previously reserved service.\\n* [[CancelAction]]: Unlike CancelAction, CheckOutAction implies that the agent is informing/confirming the end of a previously reserved service.'),
(270, 1, 6, 'FurnitureStore', 'FurnitureStore', 'A furniture store.'),
(271, 1, 6, 'JewelryStore', 'JewelryStore', 'A jewelry store.'),
(272, 1, 6, 'Waterfall', 'Waterfall', 'A waterfall, like Niagara.'),
(273, 1, 6, 'Synagogue', 'Synagogue', 'A synagogue.'),
(274, 1, 6, 'Quiz', 'Quiz', 'Quiz: A test of knowledge, skills and abilities.'),
(275, 1, 6, 'BefriendAction', 'BefriendAction', 'The act of forming a personal connection with someone (object) mutually/bidirectionally/symmetrically.\\n\\nRelated actions:\\n\\n* [[FollowAction]]: Unlike FollowAction, BefriendAction implies that the connection is reciprocal.'),
(276, 1, 6, 'Hackathon', 'Hackathon', 'A [hackathon](https://en.wikipedia.org/wiki/Hackathon) event.'),
(277, 1, 6, 'State', 'State', 'A state or province of a country.'),
(278, 1, 6, 'CityHall', 'CityHall', 'A city hall.'),
(279, 1, 6, 'BrokerageAccount', 'BrokerageAccount', 'An account that allows an investor to deposit funds and place investment orders with a licensed broker or brokerage firm.'),
(280, 1, 6, 'TennisComplex', 'TennisComplex', 'A tennis complex.'),
(281, 1, 6, 'CheckAction', 'CheckAction', 'An agent inspects, determines, investigates, inquires, or examines an object\'s accuracy, quality, condition, or state.'),
(282, 1, 6, 'WPAdBlock', 'WPAdBlock', 'An advertising section of the page.'),
(283, 1, 6, 'WantAction', 'WantAction', 'The act of expressing a desire about the object. An agent wants an object.'),
(284, 1, 6, 'ComicCoverArt', 'ComicCoverArt', 'The artwork on the cover of a comic.'),
(285, 1, 6, 'City', 'City', 'A city or town.'),
(286, 1, 6, 'Mosque', 'Mosque', 'A mosque.'),
(287, 1, 6, 'PaymentService', 'PaymentService', 'A Service to transfer funds from a person or organization to a beneficiary person or organization.'),
(288, 1, 6, 'VideoObjectSnapshot', 'VideoObjectSnapshot', 'A specific and exact (byte-for-byte) version of a [[VideoObject]]. Two byte-for-byte identical files, for the purposes of this type, considered identical. If they have different embedded metadata the files will differ. Different external facts about the files, e.g. creator or dateCreated that aren\'t represented in their actual content, do not affect this notion of identity.'),
(289, 1, 6, 'DeactivateAction', 'DeactivateAction', 'The act of stopping or deactivating a device or application (e.g. stopping a timer or turning off a flashlight).'),
(290, 1, 6, 'OccupationalTherapy', 'OccupationalTherapy', 'A treatment of people with physical, emotional, or social problems, using purposeful activity to help them overcome or learn to deal with their problems.'),
(291, 1, 6, 'EndorsementRating', 'EndorsementRating', 'An EndorsementRating is a rating that expresses some level of endorsement, for example inclusion in a \"critic\'s pick\" blog, a\n\"Like\" or \"+1\" on a social network. It can be considered the [[result]] of an [[EndorseAction]] in which the [[object]] of the action is rated positively by\nsome [[agent]]. As is common elsewhere in schema.org, it is sometimes more useful to describe the results of such an action without explicitly describing the [[Action]].\n\nAn [[EndorsementRating]] may be part of a numeric scale or organized system, but this is not required: having an explicit type for indicating a positive,\nendorsement rating is particularly useful in the absence of numeric scales as it helps consumers understand that the rating is broadly positive.\n'),
(292, 1, 6, 'UserPageVisits', 'UserPageVisits', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(293, 1, 6, 'TieAction', 'TieAction', 'The act of reaching a draw in a competitive activity.'),
(294, 1, 6, 'Distillery', 'Distillery', 'A distillery.'),
(295, 1, 6, 'ImageGallery', 'ImageGallery', 'Web page type: Image gallery page.'),
(296, 1, 6, 'Poster', 'Poster', 'A large, usually printed placard, bill, or announcement, often illustrated, that is posted to advertise or publicize something.'),
(297, 1, 6, 'ViewAction', 'ViewAction', 'The act of consuming static visual content.'),
(298, 1, 6, 'QAPage', 'QAPage', 'A QAPage is a WebPage focussed on a specific Question and its Answer(s), e.g. in a question answering site or documenting Frequently Asked Questions (FAQs).'),
(299, 1, 6, 'ContactPage', 'ContactPage', 'Web page type: Contact page.'),
(300, 1, 6, 'EmailMessage', 'EmailMessage', 'An email message.'),
(301, 1, 6, 'FundingAgency', 'FundingAgency', 'A FundingAgency is an organization that implements one or more [[FundingScheme]]s and manages\n    the granting process (via [[Grant]]s, typically [[MonetaryGrant]]s).\n    A funding agency is not always required for grant funding, e.g. philanthropic giving, corporate sponsorship etc.\n    \nExamples of funding agencies include ERC, REA, NIH, Bill and Melinda Gates Foundation, ...\n    '),
(302, 1, 6, 'AudioObjectSnapshot', 'AudioObjectSnapshot', 'A specific and exact (byte-for-byte) version of an [[AudioObject]]. Two byte-for-byte identical files, for the purposes of this type, considered identical. If they have different embedded metadata the files will differ. Different external facts about the files, e.g. creator or dateCreated that aren\'t represented in their actual content, do not affect this notion of identity.'),
(303, 1, 6, 'SearchRescueOrganization', 'SearchRescueOrganization', 'A Search and Rescue organization of some kind.'),
(304, 1, 6, 'GatedResidenceCommunity', 'GatedResidenceCommunity', 'Residence type: Gated community.'),
(305, 1, 6, 'GardenStore', 'GardenStore', 'A garden store.'),
(306, 1, 6, 'Ligament', 'Ligament', 'A short band of tough, flexible, fibrous connective tissue that functions to connect multiple bones, cartilages, and structurally support joints.'),
(307, 1, 6, 'ComicSeries', 'ComicSeries', 'A sequential publication of comic stories under a\n    	unifying title, for example \"The Amazing Spider-Man\" or \"Groo the\n    	Wanderer\".'),
(308, 1, 6, 'InsuranceAgency', 'InsuranceAgency', 'An Insurance agency.'),
(309, 1, 6, 'Taxi', 'Taxi', 'A taxi.'),
(310, 1, 6, 'Sculpture', 'Sculpture', 'A piece of sculpture.'),
(311, 1, 6, 'AdvertiserContentArticle', 'AdvertiserContentArticle', 'An [[Article]] that an external entity has paid to place or to produce to its specifications. Includes [advertorials](https://en.wikipedia.org/wiki/Advertorial), sponsored content, native advertising and other paid content.'),
(312, 1, 6, 'Crematorium', 'Crematorium', 'A crematorium.'),
(313, 1, 6, 'SeaBodyOfWater', 'SeaBodyOfWater', 'A sea (for example, the Caspian sea).'),
(314, 1, 6, 'Plumber', 'Plumber', 'A plumbing service.'),
(315, 1, 6, 'MedicalSymptom', 'MedicalSymptom', 'Any complaint sensed and expressed by the patient (therefore defined as subjective)  like stomachache, lower-back pain, or fatigue.'),
(316, 1, 6, 'ShareAction', 'ShareAction', 'The act of distributing content to people for their amusement or edification.'),
(317, 1, 6, 'ParkingFacility', 'ParkingFacility', 'A parking lot or other parking facility.'),
(318, 1, 6, 'SurgicalProcedure', 'SurgicalProcedure', 'A medical procedure involving an incision with instruments; performed for diagnose, or therapeutic purposes.'),
(319, 1, 6, 'Bridge', 'Bridge', 'A bridge.'),
(320, 1, 6, 'ElectronicsStore', 'ElectronicsStore', 'An electronics store.'),
(321, 1, 6, 'UserReview', 'UserReview', 'A review created by an end-user (e.g. consumer, purchaser, attendee etc.), in contrast with [[CriticReview]].'),
(322, 1, 6, 'Attorney', 'Attorney', 'Professional service: Attorney. \\n\\nThis type is deprecated - [[LegalService]] is more inclusive and less ambiguous.'),
(323, 1, 6, 'MusicVideoObject', 'MusicVideoObject', 'A music video file.'),
(324, 1, 6, 'MeetingRoom', 'MeetingRoom', 'A meeting room, conference room, or conference hall is a room provided for singular events such as business conferences and meetings (source: Wikipedia, the free encyclopedia, see <a href=\"http://en.wikipedia.org/wiki/Conference_hall\">http://en.wikipedia.org/wiki/Conference_hall</a>).\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(325, 1, 6, 'GovernmentOrganization', 'GovernmentOrganization', 'A governmental organization or agency.'),
(326, 1, 6, 'ReadAction', 'ReadAction', 'The act of consuming written content.'),
(327, 1, 6, 'Winery', 'Winery', 'A winery.'),
(328, 1, 6, 'HairSalon', 'HairSalon', 'A hair salon.'),
(329, 1, 6, 'ArtGallery', 'ArtGallery', 'An art gallery.'),
(330, 1, 6, 'Library', 'Library', 'A library.'),
(331, 1, 6, 'EventVenue', 'EventVenue', 'An event venue.'),
(332, 1, 6, 'ShoppingCenter', 'ShoppingCenter', 'A shopping center or mall.'),
(333, 1, 6, 'MensClothingStore', 'MensClothingStore', 'A men\'s clothing store.'),
(334, 1, 6, 'Consortium', 'Consortium', 'A Consortium is a membership [[Organization]] whose members are typically Organizations.'),
(335, 1, 6, 'Code', 'Code', 'Computer programming source code. Example: Full (compile ready) solutions, code snippet samples, scripts, templates.'),
(336, 1, 6, 'ShortStory', 'ShortStory', 'Short story or tale. A brief work of literature, usually written in narrative prose.'),
(337, 1, 6, 'VideoGameClip', 'VideoGameClip', 'A short segment/part of a video game.'),
(338, 1, 6, 'Optician', 'Optician', 'A store that sells reading glasses and similar devices for improving vision.'),
(339, 1, 6, 'ActivateAction', 'ActivateAction', 'The act of starting or activating a device or application (e.g. starting a timer or turning on a flashlight).'),
(340, 1, 6, 'RVPark', 'RVPark', 'A place offering space for \"Recreational Vehicles\", Caravans, mobile homes and the like.'),
(341, 1, 6, 'Manuscript', 'Manuscript', 'A book, document, or piece of music written by hand rather than typed or printed.'),
(342, 1, 6, 'OfferForLease', 'OfferForLease', 'An [[OfferForLease]] in Schema.org represents an [[Offer]] to lease out something, i.e. an [[Offer]] whose\n  [[businessFunction]] is [lease out](http://purl.org/goodrelations/v1#LeaseOut.). See [Good Relations](https://en.wikipedia.org/wiki/GoodRelations) for\n  background on the underlying concepts.\n  '),
(343, 1, 6, 'MusicEvent', 'MusicEvent', 'Event type: Music event.'),
(344, 1, 6, 'Newspaper', 'Newspaper', 'A publication containing information about varied topics that are pertinent to general information, a geographic area, or a specific subject matter (i.e. business, culture, education). Often published daily.'),
(345, 1, 6, 'ChildCare', 'ChildCare', 'A Childcare center.'),
(346, 1, 6, 'BedAndBreakfast', 'BedAndBreakfast', 'Bed and breakfast.\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(347, 1, 6, 'PaintAction', 'PaintAction', 'The act of producing a painting, typically with paint and canvas as instruments.');
INSERT INTO `resource_class` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(348, 1, 6, 'CheckInAction', 'CheckInAction', 'The act of an agent communicating (service provider, social media, etc) their arrival by registering/confirming for a previously reserved service (e.g. flight check-in) or at a place (e.g. hotel), possibly resulting in a result (boarding pass, etc).\\n\\nRelated actions:\\n\\n* [[CheckOutAction]]: The antonym of CheckInAction.\\n* [[ArriveAction]]: Unlike ArriveAction, CheckInAction implies that the agent is informing/confirming the start of a previously reserved service.\\n* [[ConfirmAction]]: Unlike ConfirmAction, CheckInAction implies that the agent is informing/confirming the *start* of a previously reserved service rather than its validity/existence.'),
(349, 1, 6, 'SiteNavigationElement', 'SiteNavigationElement', 'A navigation element of the page.'),
(350, 1, 6, 'AssignAction', 'AssignAction', 'The act of allocating an action/event/task to some destination (someone or something).'),
(351, 1, 6, 'AcceptAction', 'AcceptAction', 'The act of committing to/adopting an object.\\n\\nRelated actions:\\n\\n* [[RejectAction]]: The antonym of AcceptAction.'),
(352, 1, 6, 'GroceryStore', 'GroceryStore', 'A grocery store.'),
(353, 1, 6, 'Float', 'Float', 'Data type: Floating number.'),
(354, 1, 6, 'Season', 'Season', 'A media season, e.g. TV, radio, video game etc.'),
(355, 1, 6, 'School', 'School', 'A school.'),
(356, 1, 6, 'Continent', 'Continent', 'One of the continents (for example, Europe or Africa).'),
(357, 1, 6, 'VitalSign', 'VitalSign', 'Vital signs are measures of various physiological functions in order to assess the most basic body functions.'),
(358, 1, 6, 'DanceEvent', 'DanceEvent', 'Event type: A social dance.'),
(359, 1, 6, 'Conversation', 'Conversation', 'One or more messages between organizations or people on a particular topic. Individual messages can be linked to the conversation with isPartOf or hasPart properties.'),
(360, 1, 6, 'Beach', 'Beach', 'Beach.'),
(361, 1, 6, 'MusicStore', 'MusicStore', 'A music store.'),
(362, 1, 6, 'SheetMusic', 'SheetMusic', 'Printed music, as opposed to performed or recorded music.'),
(363, 1, 6, 'TheaterGroup', 'TheaterGroup', 'A theater group or company, for example, the Royal Shakespeare Company or Druid Theatre.'),
(364, 1, 6, 'AutoWash', 'AutoWash', 'A car wash business.'),
(365, 1, 6, 'MotorizedBicycle', 'MotorizedBicycle', 'A motorized bicycle is a bicycle with an attached motor used to power the vehicle, or to assist with pedaling.'),
(366, 1, 6, 'DrawAction', 'DrawAction', 'The act of producing a visual/graphical representation of an object, typically with a pen/pencil and paper as instruments.'),
(367, 1, 6, 'IgnoreAction', 'IgnoreAction', 'The act of intentionally disregarding the object. An agent ignores an object.'),
(368, 1, 6, 'MedicalGuidelineContraindication', 'MedicalGuidelineContraindication', 'A guideline contraindication that designates a process as harmful and where quality of the data supporting the contraindication is sound.'),
(369, 1, 6, 'SearchResultsPage', 'SearchResultsPage', 'Web page type: Search results page.'),
(370, 1, 6, 'RadioEpisode', 'RadioEpisode', 'A radio episode which can be part of a series or season.'),
(371, 1, 6, 'BusReservation', 'BusReservation', 'A reservation for bus travel. \\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use [[Offer]].'),
(372, 1, 6, 'ShoeStore', 'ShoeStore', 'A shoe store.'),
(373, 1, 6, 'FireStation', 'FireStation', 'A fire station. With firemen.'),
(374, 1, 6, 'Pharmacy', 'Pharmacy', 'A pharmacy or drugstore.'),
(375, 1, 6, 'ApplyAction', 'ApplyAction', 'The act of registering to an organization/service without the guarantee to receive it.\\n\\nRelated actions:\\n\\n* [[RegisterAction]]: Unlike RegisterAction, ApplyAction has no guarantees that the application will be accepted.'),
(376, 1, 6, 'Aquarium', 'Aquarium', 'Aquarium.'),
(377, 1, 6, 'LegislativeBuilding', 'LegislativeBuilding', 'A legislative building&#x2014;for example, the state capitol.'),
(378, 1, 6, 'Preschool', 'Preschool', 'A preschool.'),
(379, 1, 6, 'DefenceEstablishment', 'DefenceEstablishment', 'A defence establishment, such as an army or navy base.'),
(380, 1, 6, 'Hostel', 'Hostel', 'A hostel - cheap accommodation, often in shared dormitories.\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(381, 1, 6, 'EatAction', 'EatAction', 'The act of swallowing solid objects.'),
(382, 1, 6, 'LiteraryEvent', 'LiteraryEvent', 'Event type: Literary event.'),
(383, 1, 6, 'BookStore', 'BookStore', 'A bookstore.'),
(384, 1, 6, 'EmployerReview', 'EmployerReview', 'An [[EmployerReview]] is a review of an [[Organization]] regarding its role as an employer, written by a current or former employee of that organization.'),
(385, 1, 6, 'ComputerStore', 'ComputerStore', 'A computer store.'),
(386, 1, 6, 'RoofingContractor', 'RoofingContractor', 'A roofing contractor.'),
(387, 1, 6, 'RadioBroadcastService', 'RadioBroadcastService', 'A delivery service through which radio content is provided via broadcast over the air or online.'),
(388, 1, 6, 'AutoRepair', 'AutoRepair', 'Car repair business.'),
(389, 1, 6, 'WholesaleStore', 'WholesaleStore', 'A wholesale store.'),
(390, 1, 6, 'Bone', 'Bone', 'Rigid connective tissue that comprises up the skeletal structure of the human body.'),
(391, 1, 6, 'PetStore', 'PetStore', 'A pet store.'),
(392, 1, 6, 'BuddhistTemple', 'BuddhistTemple', 'A Buddhist temple.'),
(393, 1, 6, 'EmployerAggregateRating', 'EmployerAggregateRating', 'An aggregate rating of an Organization related to its role as an employer.'),
(394, 1, 6, 'AskPublicNewsArticle', 'AskPublicNewsArticle', 'A [[NewsArticle]] expressing an open call by a [[NewsMediaOrganization]] asking the public for input, insights, clarifications, anecdotes, documentation, etc., on an issue, for reporting purposes.'),
(395, 1, 6, 'ItemPage', 'ItemPage', 'A page devoted to a single item, such as a particular product or hotel.'),
(396, 1, 6, 'PoliceStation', 'PoliceStation', 'A police station.'),
(397, 1, 6, 'Courthouse', 'Courthouse', 'A courthouse.'),
(398, 1, 6, 'TreatmentIndication', 'TreatmentIndication', 'An indication for treating an underlying condition, symptom, etc.'),
(399, 1, 6, 'DownloadAction', 'DownloadAction', 'The act of downloading an object.'),
(400, 1, 6, 'DepartmentStore', 'DepartmentStore', 'A department store.'),
(401, 1, 6, 'Play', 'Play', 'A play is a form of literature, usually consisting of dialogue between characters, intended for theatrical performance rather than just reading. Note: A performance of a Play would be a [[TheaterEvent]] or [[BroadcastEvent]] - the *Play* being the [[workPerformed]].'),
(402, 1, 6, 'VideoGallery', 'VideoGallery', 'Web page type: Video gallery page.'),
(403, 1, 6, 'Brewery', 'Brewery', 'Brewery.'),
(404, 1, 6, 'NGO', 'NGO', 'Organization: Non-governmental Organization.'),
(405, 1, 6, 'MiddleSchool', 'MiddleSchool', 'A middle school (typically for children aged around 11-14, although this varies somewhat).'),
(406, 1, 6, 'Electrician', 'Electrician', 'An electrician.'),
(407, 1, 6, 'CollegeOrUniversity', 'CollegeOrUniversity', 'A college, university, or other third-level educational institution.'),
(408, 1, 6, 'PerformingArtsTheater', 'PerformingArtsTheater', 'A theater or other performing art center.'),
(409, 1, 6, 'Florist', 'Florist', 'A florist.'),
(410, 1, 6, 'AccountingService', 'AccountingService', 'Accountancy business.\\n\\nAs a [[LocalBusiness]] it can be described as a [[provider]] of one or more [[Service]]\\(s).\n      '),
(411, 1, 6, 'CheckoutPage', 'CheckoutPage', 'Web page type: Checkout page.'),
(412, 1, 6, 'SubwayStation', 'SubwayStation', 'A subway station.'),
(413, 1, 6, 'UserLikes', 'UserLikes', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(414, 1, 6, 'WatchAction', 'WatchAction', 'The act of consuming dynamic/moving visual content.'),
(415, 1, 6, 'Table', 'Table', 'A table on a Web page.'),
(416, 1, 6, 'ProfilePage', 'ProfilePage', 'Web page type: Profile page.'),
(417, 1, 6, 'PalliativeProcedure', 'PalliativeProcedure', 'A medical procedure intended primarily for palliative purposes, aimed at relieving the symptoms of an underlying health condition.'),
(418, 1, 6, 'GeneralContractor', 'GeneralContractor', 'A general contractor.'),
(419, 1, 6, 'GasStation', 'GasStation', 'A gas station.'),
(420, 1, 6, 'Motel', 'Motel', 'A motel.\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(421, 1, 6, 'SocialEvent', 'SocialEvent', 'Event type: Social event.'),
(422, 1, 6, 'Atlas', 'Atlas', 'A collection or bound volume of maps, charts, plates or tables, physical or in media form illustrating any subject.'),
(423, 1, 6, 'CancelAction', 'CancelAction', 'The act of asserting that a future event/action is no longer going to happen.\\n\\nRelated actions:\\n\\n* [[ConfirmAction]]: The antonym of CancelAction.'),
(424, 1, 6, 'FastFoodRestaurant', 'FastFoodRestaurant', 'A fast-food restaurant.'),
(425, 1, 6, 'TouristInformationCenter', 'TouristInformationCenter', 'A tourist information center.'),
(426, 1, 6, 'EventReservation', 'EventReservation', 'A reservation for an event like a concert, sporting event, or lecture.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use [[Offer]].'),
(427, 1, 6, 'HobbyShop', 'HobbyShop', 'A store that sells materials useful or necessary for various hobbies.'),
(428, 1, 6, 'EmploymentAgency', 'EmploymentAgency', 'An employment agency.'),
(429, 1, 6, 'SelfStorage', 'SelfStorage', 'A self-storage facility.'),
(430, 1, 6, 'TakeAction', 'TakeAction', 'The act of gaining ownership of an object from an origin. Reciprocal of GiveAction.\\n\\nRelated actions:\\n\\n* [[GiveAction]]: The reciprocal of TakeAction.\\n* [[ReceiveAction]]: Unlike ReceiveAction, TakeAction implies that ownership has been transferred.'),
(431, 1, 6, 'ReportedDoseSchedule', 'ReportedDoseSchedule', 'A patient-reported or observed dosing schedule for a drug or supplement.'),
(432, 1, 6, 'RejectAction', 'RejectAction', 'The act of rejecting to/adopting an object.\\n\\nRelated actions:\\n\\n* [[AcceptAction]]: The antonym of RejectAction.'),
(433, 1, 6, 'BeautySalon', 'BeautySalon', 'Beauty salon.'),
(434, 1, 6, 'ElementarySchool', 'ElementarySchool', 'An elementary school.'),
(435, 1, 6, 'ResumeAction', 'ResumeAction', 'The act of resuming a device or application which was formerly paused (e.g. resume music playback or resume a timer).'),
(436, 1, 6, 'RadioClip', 'RadioClip', 'A short radio program or a segment/part of a radio program.'),
(437, 1, 6, 'DepartAction', 'DepartAction', 'The act of  departing from a place. An agent departs from a fromLocation for a destination, optionally with participants.'),
(438, 1, 6, 'Locksmith', 'Locksmith', 'A locksmith.'),
(439, 1, 6, 'PhotographAction', 'PhotographAction', 'The act of capturing still images of objects using a camera.'),
(440, 1, 6, 'SportsClub', 'SportsClub', 'A sports club.'),
(441, 1, 6, 'StadiumOrArena', 'StadiumOrArena', 'A stadium.'),
(442, 1, 6, 'TextDigitalDocument', 'TextDigitalDocument', 'A file composed primarily of text.'),
(443, 1, 6, 'FilmAction', 'FilmAction', 'The act of capturing sound and moving images on film, video, or digitally.'),
(444, 1, 6, 'Bakery', 'Bakery', 'A bakery.'),
(445, 1, 6, 'Embassy', 'Embassy', 'An embassy.'),
(446, 1, 6, 'OutletStore', 'OutletStore', 'An outlet store.'),
(447, 1, 6, 'EventSeries', 'EventSeries', 'A series of [[Event]]s. Included events can relate with the series using the [[superEvent]] property.\n\nAn EventSeries is a collection of events that share some unifying characteristic. For example, \"The Olympic Games\" is a series, which\nis repeated regularly. The \"2012 London Olympics\" can be presented both as an [[Event]] in the series \"Olympic Games\", and as an\n[[EventSeries]] that included a number of sporting competitions as Events.\n\nThe nature of the association between the events in an [[EventSeries]] can vary, but typical examples could\ninclude a thematic event series (e.g. topical meetups or classes), or a series of regular events that share a location, attendee group and/or organizers.\n\nEventSeries has been defined as a kind of Event to make it easy for publishers to use it in an Event context without\nworrying about which kinds of series are really event-like enough to call an Event. In general an EventSeries\nmay seem more Event-like when the period of time is compact and when aspects such as location are fixed, but\nit may also sometimes prove useful to describe a longer-term series as an Event.\n   '),
(448, 1, 6, 'ExerciseGym', 'ExerciseGym', 'A gym.'),
(449, 1, 6, 'DanceGroup', 'DanceGroup', 'A dance group&#x2014;for example, the Alvin Ailey Dance Theater or Riverdance.'),
(450, 1, 6, 'SkiResort', 'SkiResort', 'A ski resort.'),
(451, 1, 6, 'LakeBodyOfWater', 'LakeBodyOfWater', 'A lake (for example, Lake Pontrachain).'),
(452, 1, 6, 'AppendAction', 'AppendAction', 'The act of inserting at the end if an ordered collection.'),
(453, 1, 6, 'AdultEntertainment', 'AdultEntertainment', 'An adult entertainment establishment.'),
(454, 1, 6, 'TaxiStand', 'TaxiStand', 'A taxi stand.'),
(455, 1, 6, 'Canal', 'Canal', 'A canal, like the Panama Canal.'),
(456, 1, 6, 'HomeGoodsStore', 'HomeGoodsStore', 'A home goods store.'),
(457, 1, 6, 'AnimalShelter', 'AnimalShelter', 'Animal shelter.'),
(458, 1, 6, 'URL', 'URL', 'Data type: URL.'),
(459, 1, 6, 'Diet', 'Diet', 'A strategy of regulating the intake of food to achieve or maintain a specific health-related goal.'),
(460, 1, 6, 'Organization', 'Organization', 'An organization such as a school, NGO, corporation, club, etc.'),
(461, 1, 6, 'StructuredValue', 'StructuredValue', 'Structured values are used when the value of a property has a more complex structure than simply being a textual value or a reference to another thing.'),
(462, 1, 6, 'MediaReviewItem', 'MediaReviewItem', 'Represents an item or group of closely related items treated as a unit for the sake of evaluation in a [[MediaReview]]. Authorship etc. apply to the items rather than to the curation/grouping or reviewing party.'),
(463, 1, 6, 'MusicRelease', 'MusicRelease', 'A MusicRelease is a specific release of a music album.'),
(464, 1, 6, 'Answer', 'Answer', 'An answer offered to a question; perhaps correct, perhaps opinionated or wrong.'),
(465, 1, 6, 'Ticket', 'Ticket', 'Used to describe a ticket to an event, a flight, a bus ride, etc.'),
(466, 1, 6, 'ReactAction', 'ReactAction', 'The act of responding instinctively and emotionally to an object, expressing a sentiment.'),
(467, 1, 6, 'MedicalProcedureType', 'MedicalProcedureType', 'An enumeration that describes different types of medical procedures.'),
(468, 1, 6, 'FinancialProduct', 'FinancialProduct', 'A product provided to consumers and businesses by financial institutions such as banks, insurance companies, brokerage firms, consumer finance companies, and investment companies which comprise the financial services industry.'),
(469, 1, 6, 'ReplyAction', 'ReplyAction', 'The act of responding to a question/message asked/sent by the object. Related to [[AskAction]].\\n\\nRelated actions:\\n\\n* [[AskAction]]: Appears generally as an origin of a ReplyAction.'),
(470, 1, 6, 'ChemicalSubstance', 'ChemicalSubstance', 'A chemical substance is \'a portion of matter of constant composition, composed of molecular entities of the same type or of different types\' (source: [ChEBI:59999](https://www.ebi.ac.uk/chebi/searchId.do?chebiId=59999)).'),
(471, 1, 6, 'Language', 'Language', 'Natural languages such as Spanish, Tamil, Hindi, English, etc. Formal language code tags expressed in [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag) can be used via the [[alternateName]] property. The Language type previously also covered programming languages such as Scheme and Lisp, which are now best represented using [[ComputerLanguage]].'),
(472, 1, 6, 'HyperToc', 'HyperToc', 'A HyperToc represents a hypertext table of contents for complex media objects, such as [[VideoObject]], [[AudioObject]]. Items in the table of contents are indicated using the [[tocEntry]] property, and typed [[HyperTocEntry]]. For cases where the same larger work is split into multiple files, [[associatedMedia]] can be used on individual [[HyperTocEntry]] items.'),
(473, 1, 6, 'Person', 'Person', 'A person (alive, dead, undead, or fictional).'),
(474, 1, 6, 'BodyMeasurementTypeEnumeration', 'BodyMeasurementTypeEnumeration', 'Enumerates types (or dimensions) of a person\'s body measurements, for example for fitting of clothes.'),
(475, 1, 6, 'Observation', 'Observation', 'Instances of the class [[Observation]] are used to specify observations about an entity (which may or may not be an instance of a [[StatisticalPopulation]]), at a particular time. The principal properties of an [[Observation]] are [[observedNode]], [[measuredProperty]], [[measuredValue]] (or [[median]], etc.) and [[observationDate]] ([[measuredProperty]] properties can, but need not always, be W3C RDF Data Cube \"measure properties\", as in the [lifeExpectancy example](https://www.w3.org/TR/vocab-data-cube/#dsd-example)).\nSee also [[StatisticalPopulation]], and the [data and datasets](/docs/data-and-datasets.html) overview for more details.\n  '),
(476, 1, 6, 'QuantitativeValueDistribution', 'QuantitativeValueDistribution', 'A statistical distribution of values.'),
(477, 1, 6, 'ReplaceAction', 'ReplaceAction', 'The act of editing a recipient by replacing an old object with a new object.'),
(478, 1, 6, 'FlightReservation', 'FlightReservation', 'A reservation for air travel.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use [[Offer]].'),
(479, 1, 6, 'CommunicateAction', 'CommunicateAction', 'The act of conveying information to another person via a communication medium (instrument) such as speech, email, or telephone conversation.'),
(480, 1, 6, 'Vehicle', 'Vehicle', 'A vehicle is a device that is designed or used to transport people or cargo over land, water, air, or through space.'),
(481, 1, 6, 'TouristTrip', 'TouristTrip', 'A tourist trip. A created itinerary of visits to one or more places of interest ([[TouristAttraction]]/[[TouristDestination]]) often linked by a similar theme, geographic area, or interest to a particular [[touristType]]. The [UNWTO](http://www2.unwto.org/) defines tourism trip as the Trip taken by visitors.\n  (See examples below.)'),
(482, 1, 6, 'Report', 'Report', 'A Report generated by governmental or non-governmental organization.'),
(483, 1, 6, 'Taxon', 'Taxon', 'A set of organisms asserted to represent a natural cohesive biological unit.'),
(484, 1, 6, 'ArchiveOrganization', 'ArchiveOrganization', 'An organization with archival holdings. An organization which keeps and preserves archival material and typically makes it accessible to the public.'),
(485, 1, 6, 'DataFeedItem', 'DataFeedItem', 'A single item within a larger data feed.'),
(486, 1, 6, 'HowToItem', 'HowToItem', 'An item used as either a tool or supply when performing the instructions for how to achieve a result.'),
(487, 1, 6, 'PriceTypeEnumeration', 'PriceTypeEnumeration', 'Enumerates different price types, for example list price, invoice price, and sale price.'),
(488, 1, 6, 'ExerciseAction', 'ExerciseAction', 'The act of participating in exertive activity for the purposes of improving health and fitness.'),
(489, 1, 6, 'ScreeningEvent', 'ScreeningEvent', 'A screening of a movie or other video.'),
(490, 1, 6, 'PronounceableText', 'PronounceableText', 'Data type: PronounceableText.'),
(491, 1, 6, 'SportsOrganization', 'SportsOrganization', 'Represents the collection of all sports organizations, including sports teams, governing bodies, and sports associations.'),
(492, 1, 6, 'ActionStatusType', 'ActionStatusType', 'The status of an Action.'),
(493, 1, 6, 'IndividualProduct', 'IndividualProduct', 'A single, identifiable product instance (e.g. a laptop with a particular serial number).'),
(494, 1, 6, 'InteractionCounter', 'InteractionCounter', 'A summary of how users have interacted with this CreativeWork. In most cases, authors will use a subtype to specify the specific type of interaction.'),
(495, 1, 6, 'Event', 'Event', 'An event happening at a certain time and location, such as a concert, lecture, or festival. Ticketing information may be added via the [[offers]] property. Repeated events may be structured as separate Event objects.'),
(496, 1, 6, 'CookAction', 'CookAction', 'The act of producing/preparing food.'),
(497, 1, 6, 'HealthPlanCostSharingSpecification', 'HealthPlanCostSharingSpecification', 'A description of costs to the patient under a given network or formulary.'),
(498, 1, 6, 'EnergyStarEnergyEfficiencyEnumeration', 'EnergyStarEnergyEfficiencyEnumeration', 'Used to indicate whether a product is EnergyStar certified.'),
(499, 1, 6, 'MedicalAudienceType', 'MedicalAudienceType', 'Target audiences types for medical web pages. Enumerated type.'),
(500, 1, 6, 'SendAction', 'SendAction', 'The act of physically/electronically dispatching an object for transfer from an origin to a destination. Related actions:\\n\\n* [[ReceiveAction]]: The reciprocal of SendAction.\\n* [[GiveAction]]: Unlike GiveAction, SendAction does not imply the transfer of ownership (e.g. I can send you my laptop, but I\'m not necessarily giving it to you).'),
(501, 1, 6, 'RentAction', 'RentAction', 'The act of giving money in return for temporary use, but not ownership, of an object such as a vehicle or property. For example, an agent rents a property from a landlord in exchange for a periodic payment.'),
(502, 1, 6, 'Thesis', 'Thesis', 'A thesis or dissertation document submitted in support of candidature for an academic degree or professional qualification.'),
(503, 1, 6, 'EducationalOccupationalProgram', 'EducationalOccupationalProgram', 'A program offered by an institution which determines the learning progress to achieve an outcome, usually a credential like a degree or certificate. This would define a discrete set of opportunities (e.g., job, courses) that together constitute a program with a clear start, end, set of requirements, and transition to a new occupational opportunity (e.g., a job), or sometimes a higher educational opportunity (e.g., an advanced degree).'),
(504, 1, 6, 'OrderItem', 'OrderItem', 'An order item is a line of an order. It includes the quantity and shipping details of a bought offer.'),
(505, 1, 6, 'Audiobook', 'Audiobook', 'An audiobook.'),
(506, 1, 6, 'Duration', 'Duration', 'Quantity: Duration (use [ISO 8601 duration format](http://en.wikipedia.org/wiki/ISO_8601)).'),
(507, 1, 6, 'CreateAction', 'CreateAction', 'The act of deliberately creating/producing/generating/building a result out of the agent.'),
(508, 1, 6, 'MedicalRiskFactor', 'MedicalRiskFactor', 'A risk factor is anything that increases a person\'s likelihood of developing or contracting a disease, medical condition, or complication.'),
(509, 1, 6, 'MenuItem', 'MenuItem', 'A food or drink item listed in a menu or menu section.'),
(510, 1, 6, 'PaymentStatusType', 'PaymentStatusType', 'A specific payment status. For example, PaymentDue, PaymentComplete, etc.'),
(511, 1, 6, 'MedicalDevicePurpose', 'MedicalDevicePurpose', 'Categories of medical devices, organized by the purpose or intended use of the device.'),
(512, 1, 6, 'PriceSpecification', 'PriceSpecification', 'A structured value representing a price or price range. Typically, only the subclasses of this type are used for markup. It is recommended to use [[MonetaryAmount]] to describe independent amounts of money such as a salary, credit card limits, etc.'),
(513, 1, 6, 'InvestmentOrDeposit', 'InvestmentOrDeposit', 'A type of financial product that typically requires the client to transfer funds to a financial service in return for potential beneficial financial return.'),
(514, 1, 6, 'AdministrativeArea', 'AdministrativeArea', 'A geographical region, typically under the jurisdiction of a particular government.'),
(515, 1, 6, 'CategoryCode', 'CategoryCode', 'A Category Code.'),
(516, 1, 6, 'Distance', 'Distance', 'Properties that take Distances as values are of the form \'&lt;Number&gt; &lt;Length unit of measure&gt;\'. E.g., \'7 ft\'.'),
(517, 1, 6, 'InfectiousDisease', 'InfectiousDisease', 'An infectious disease is a clinically evident human disease resulting from the presence of pathogenic microbial agents, like pathogenic viruses, pathogenic bacteria, fungi, protozoa, multicellular parasites, and prions. To be considered an infectious disease, such pathogens are known to be able to cause this disease.'),
(518, 1, 6, 'SizeSystemEnumeration', 'SizeSystemEnumeration', 'Enumerates common size systems for different categories of products, for example \"EN-13402\" or \"UK\" for wearables or \"Imperial\" for screws.'),
(519, 1, 6, 'AboutPage', 'AboutPage', 'Web page type: About page.'),
(520, 1, 6, 'MedicalSign', 'MedicalSign', 'Any physical manifestation of a person\'s medical condition discoverable by objective diagnostic tests or physical examination.'),
(521, 1, 6, 'HomeAndConstructionBusiness', 'HomeAndConstructionBusiness', 'A construction business.\\n\\nA HomeAndConstructionBusiness is a [[LocalBusiness]] that provides services around homes and buildings.\\n\\nAs a [[LocalBusiness]] it can be described as a [[provider]] of one or more [[Service]]\\(s).'),
(522, 1, 6, 'MedicalOrganization', 'MedicalOrganization', 'A medical organization (physical or not), such as hospital, institution or clinic.'),
(523, 1, 6, 'PlayGameAction', 'PlayGameAction', 'The act of playing a video game.'),
(524, 1, 6, 'Comment', 'Comment', 'A comment on an item - for example, a comment on a blog post. The comment\'s content is expressed via the [[text]] property, and its topic via [[about]], properties shared with all CreativeWorks.'),
(525, 1, 6, 'Class', 'Class', 'A class, also often called a \'Type\'; equivalent to rdfs:Class.'),
(526, 1, 6, 'BrainStructure', 'BrainStructure', 'Any anatomical structure which pertains to the soft nervous tissue functioning as the coordinating center of sensation and intellectual and nervous activity.'),
(527, 1, 6, 'RsvpResponseType', 'RsvpResponseType', 'RsvpResponseType is an enumeration type whose instances represent responding to an RSVP request.'),
(528, 1, 6, 'MusicRecording', 'MusicRecording', 'A music recording (track), usually a single song.'),
(529, 1, 6, 'BankAccount', 'BankAccount', 'A product or service offered by a bank whereby one may deposit, withdraw or transfer money and in some cases be paid interest.'),
(530, 1, 6, 'LegalValueLevel', 'LegalValueLevel', 'A list of possible levels for the legal validity of a legislation.'),
(531, 1, 6, 'WebContent', 'WebContent', 'WebContent is a type representing all [[WebPage]], [[WebSite]] and [[WebPageElement]] content. It is sometimes the case that detailed distinctions between Web pages, sites and their parts are not always important or obvious. The  [[WebContent]] type makes it easier to describe Web-addressable content without requiring such distinctions to always be stated. (The intent is that the existing types [[WebPage]], [[WebSite]] and [[WebPageElement]] will eventually be declared as subtypes of [[WebContent]].)'),
(532, 1, 6, 'AchieveAction', 'AchieveAction', 'The act of accomplishing something via previous efforts. It is an instantaneous action rather than an ongoing process.'),
(533, 1, 6, 'DefinedRegion', 'DefinedRegion', 'A DefinedRegion is a geographic area defined by potentially arbitrary (rather than political, administrative or natural geographical) criteria. Properties are provided for defining a region by reference to sets of postal codes.\n\nExamples: a delivery destination when shopping. Region where regional pricing is configured.\n\nRequirement 1:\nCountry: US\nStates: \"NY\", \"CA\"\n\nRequirement 2:\nCountry: US\nPostalCode Set: { [94000-94585], [97000, 97999], [13000, 13599]}\n{ [12345, 12345], [78945, 78945], }\nRegion = state, canton, prefecture, autonomous community...\n'),
(534, 1, 6, 'Artery', 'Artery', 'A type of blood vessel that specifically carries blood away from the heart.'),
(535, 1, 6, 'Accommodation', 'Accommodation', 'An accommodation is a place that can accommodate human beings, e.g. a hotel room, a camping pitch, or a meeting room. Many accommodations are for overnight stays, but this is not a mandatory requirement.\nFor more specific types of accommodations not defined in schema.org, one can use additionalType with external vocabularies.\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(536, 1, 6, 'ComicStory', 'ComicStory', 'The term \"story\" is any indivisible, re-printable\n    	unit of a comic, including the interior stories, covers, and backmatter. Most\n    	comics have at least two stories: a cover (ComicCoverArt) and an interior story.'),
(537, 1, 6, 'UserInteraction', 'UserInteraction', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(538, 1, 6, 'FloorPlan', 'FloorPlan', 'A FloorPlan is an explicit representation of a collection of similar accommodations, allowing the provision of common information (room counts, sizes, layout diagrams) and offers for rental or sale. In typical use, some [[ApartmentComplex]] has an [[accommodationFloorPlan]] which is a [[FloorPlan]].  A FloorPlan is always in the context of a particular place, either a larger [[ApartmentComplex]] or a single [[Apartment]]. The visual/spatial aspects of a floor plan (i.e. room layout, [see wikipedia](https://en.wikipedia.org/wiki/Floor_plan)) can be indicated using [[image]]. '),
(539, 1, 6, 'CategoryCodeSet', 'CategoryCodeSet', 'A set of Category Code values.'),
(540, 1, 6, 'GovernmentOffice', 'GovernmentOffice', 'A government office&#x2014;for example, an IRS or DMV office.'),
(541, 1, 6, 'Corporation', 'Corporation', 'Organization: A business corporation.'),
(542, 1, 6, 'MedicalObservationalStudyDesign', 'MedicalObservationalStudyDesign', 'Design models for observational medical studies. Enumerated type.'),
(543, 1, 6, 'NLNonprofitType', 'NLNonprofitType', 'NLNonprofitType: Non-profit organization type originating from the Netherlands.'),
(544, 1, 6, 'LendAction', 'LendAction', 'The act of providing an object under an agreement that it will be returned at a later date. Reciprocal of BorrowAction.\\n\\nRelated actions:\\n\\n* [[BorrowAction]]: Reciprocal of LendAction.'),
(545, 1, 6, 'AudioObject', 'AudioObject', 'An audio file.'),
(546, 1, 6, 'AdultOrientedEnumeration', 'AdultOrientedEnumeration', 'Enumeration of considerations that make a product relevant or potentially restricted for adults only.'),
(547, 1, 6, 'AnatomicalStructure', 'AnatomicalStructure', 'Any part of the human body, typically a component of an anatomical system. Organs, tissues, and cells are all anatomical structures.'),
(548, 1, 6, 'Boolean', 'Boolean', 'Boolean: True or False.'),
(549, 1, 6, 'MedicalCondition', 'MedicalCondition', 'Any condition of the human body that affects the normal functioning of a person, whether physically or mentally. Includes diseases, injuries, disabilities, disorders, syndromes, etc.'),
(550, 1, 6, 'PublicationEvent', 'PublicationEvent', 'A PublicationEvent corresponds indifferently to the event of publication for a CreativeWork of any type, e.g. a broadcast event, an on-demand event, a book/journal publication via a variety of delivery media.'),
(551, 1, 6, 'MedicalGuideline', 'MedicalGuideline', 'Any recommendation made by a standard society (e.g. ACC/AHA) or consensus statement that denotes how to diagnose and treat a particular condition. Note: this type should be used to tag the actual guideline recommendation; if the guideline recommendation occurs in a larger scholarly article, use MedicalScholarlyArticle to tag the overall article, not this type. Note also: the organization making the recommendation should be captured in the recognizingAuthority base property of MedicalEntity.'),
(552, 1, 6, 'ChooseAction', 'ChooseAction', 'The act of expressing a preference from a set of options or a large or unbounded set of choices/options.'),
(553, 1, 6, 'RefundTypeEnumeration', 'RefundTypeEnumeration', 'Enumerates several kinds of product return refund types.'),
(554, 1, 6, 'GeoShape', 'GeoShape', 'The geographic shape of a place. A GeoShape can be described using several properties whose values are based on latitude/longitude pairs. Either whitespace or commas can be used to separate latitude and longitude; whitespace should be used when writing a list of several such points.'),
(555, 1, 6, 'AllocateAction', 'AllocateAction', 'The act of organizing tasks/objects/events by associating resources to it.'),
(556, 1, 6, 'InviteAction', 'InviteAction', 'The act of asking someone to attend an event. Reciprocal of RsvpAction.'),
(557, 1, 6, 'ExchangeRateSpecification', 'ExchangeRateSpecification', 'A structured value representing exchange rate.'),
(558, 1, 6, 'GovernmentBenefitsType', 'GovernmentBenefitsType', 'GovernmentBenefitsType enumerates several kinds of government benefits to support the COVID-19 situation. Note that this structure may not capture all benefits offered.'),
(559, 1, 6, 'PublicationIssue', 'PublicationIssue', 'A part of a successively published publication such as a periodical or publication volume, often numbered, usually containing a grouping of works such as articles.\\n\\nSee also [blog post](http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html).'),
(560, 1, 6, 'PhysicalActivity', 'PhysicalActivity', 'Any bodily activity that enhances or maintains physical fitness and overall health and wellness. Includes activity that is part of daily living and routine, structured exercise, and exercise prescribed as part of a medical treatment or recovery plan.'),
(561, 1, 6, 'MedicalSpecialty', 'MedicalSpecialty', 'Any specific branch of medical science or practice. Medical specialities include clinical specialties that pertain to particular organ systems and their respective disease states, as well as allied health specialties. Enumerated type.'),
(562, 1, 6, 'LoanOrCredit', 'LoanOrCredit', 'A financial product for the loaning of an amount of money, or line of credit, under agreed terms and charges.'),
(563, 1, 6, 'MedicalProcedure', 'MedicalProcedure', 'A process of care used in either a diagnostic, therapeutic, preventive or palliative capacity that relies on invasive (surgical), non-invasive, or other techniques.'),
(564, 1, 6, 'DrugClass', 'DrugClass', 'A class of medical drugs, e.g., statins. Classes can represent general pharmacological class, common mechanisms of action, common physiological effects, etc.'),
(565, 1, 6, 'TrainTrip', 'TrainTrip', 'A trip on a commercial train line.'),
(566, 1, 6, 'MerchantReturnEnumeration', 'MerchantReturnEnumeration', 'Enumerates several kinds of product return policies.'),
(567, 1, 6, 'OnlineBusiness', 'OnlineBusiness', 'A particular online business, either standalone or the online part of a broader organization. Examples include an eCommerce site, an online travel booking site, an online learning site, an online logistics and shipping provider, an online (virtual) doctor, etc.'),
(568, 1, 6, 'ReturnAction', 'ReturnAction', 'The act of returning to the origin that which was previously received (concrete objects) or taken (ownership).'),
(569, 1, 6, 'SomeProducts', 'SomeProducts', 'A placeholder for multiple similar products of the same kind.'),
(570, 1, 6, 'Course', 'Course', 'A description of an educational course which may be offered as distinct instances which take place at different times or take place at different locations, or be offered through different media or modes of study. An educational course is a sequence of one or more educational events and/or creative works which aims to build knowledge, competence or ability of learners.'),
(571, 1, 6, 'ProductCollection', 'ProductCollection', 'A set of products (either [[ProductGroup]]s or specific variants) that are listed together e.g. in an [[Offer]].'),
(572, 1, 6, 'DrugLegalStatus', 'DrugLegalStatus', 'The legal availability status of a medical drug.'),
(573, 1, 6, 'WearableSizeSystemEnumeration', 'WearableSizeSystemEnumeration', 'Enumerates common size systems specific for wearable products'),
(574, 1, 6, 'BusinessEntityType', 'BusinessEntityType', 'A business entity type is a conceptual entity representing the legal form, the size, the main line of business, the position in the value chain, or any combination thereof, of an organization or business person.\\n\\nCommonly used values:\\n\\n* http://purl.org/goodrelations/v1#Business\\n* http://purl.org/goodrelations/v1#Enduser\\n* http://purl.org/goodrelations/v1#PublicInstitution\\n* http://purl.org/goodrelations/v1#Reseller\n	  '),
(575, 1, 6, 'HealthPlanFormulary', 'HealthPlanFormulary', 'For a given health insurance plan, the specification for costs and coverage of prescription drugs. '),
(576, 1, 6, 'CDCPMDRecord', 'CDCPMDRecord', 'A CDCPMDRecord is a data structure representing a record in a CDC tabular data format\n      used for hospital data reporting. See [documentation](/docs/cdc-covid.html) for details, and the linked CDC materials for authoritative\n      definitions used as the source here.\n      '),
(577, 1, 6, 'WarrantyScope', 'WarrantyScope', 'A range of services that will be provided to a customer free of charge in case of a defect or malfunction of a product.\\n\\nCommonly used values:\\n\\n* http://purl.org/goodrelations/v1#Labor-BringIn\\n* http://purl.org/goodrelations/v1#PartsAndLabor-BringIn\\n* http://purl.org/goodrelations/v1#PartsAndLabor-PickUp\n      '),
(578, 1, 6, 'Invoice', 'Invoice', 'A statement of the money due for goods or services; a bill.'),
(579, 1, 6, 'AssessAction', 'AssessAction', 'The act of forming one\'s opinion, reaction or sentiment.'),
(580, 1, 6, 'LegislationObject', 'LegislationObject', 'A specific object or file containing a Legislation. Note that the same Legislation can be published in multiple files. For example, a digitally signed PDF, a plain PDF and an HTML version.'),
(581, 1, 6, 'MovieSeries', 'MovieSeries', 'A series of movies. Included movies can be indicated with the hasPart property.'),
(582, 1, 6, 'ShippingDeliveryTime', 'ShippingDeliveryTime', 'ShippingDeliveryTime provides various pieces of information about delivery times for shipping.'),
(583, 1, 6, 'Occupation', 'Occupation', 'A profession, may involve prolonged training and/or a formal qualification.'),
(584, 1, 6, 'MediaGallery', 'MediaGallery', 'Web page type: Media gallery page. A mixed-media page that can contain media such as images, videos, and other multimedia.'),
(585, 1, 6, 'RecommendedDoseSchedule', 'RecommendedDoseSchedule', 'A recommended dosing schedule for a drug or supplement as prescribed or recommended by an authority or by the drug/supplement\'s manufacturer. Capture the recommending authority in the recognizingAuthority property of MedicalEntity.'),
(586, 1, 6, 'MedicalTest', 'MedicalTest', 'Any medical test, typically performed for diagnostic purposes.'),
(587, 1, 6, 'SoftwareSourceCode', 'SoftwareSourceCode', 'Computer programming source code. Example: Full (compile ready) solutions, code snippet samples, scripts, templates.'),
(588, 1, 6, 'ReservationPackage', 'ReservationPackage', 'A group of multiple reservations with common values for all sub-reservations.'),
(589, 1, 6, 'MediaManipulationRatingEnumeration', 'MediaManipulationRatingEnumeration', ' Codes for use with the [[mediaAuthenticityCategory]] property, indicating the authenticity of a media object (in the context of how it was published or shared). In general these codes are not mutually exclusive, although some combinations (such as \'original\' versus \'transformed\', \'edited\' and \'staged\') would be contradictory if applied in the same [[MediaReview]]. Note that the application of these codes is with regard to a piece of media shared or published in a particular context.'),
(590, 1, 6, 'LegalService', 'LegalService', 'A LegalService is a business that provides legally-oriented services, advice and representation, e.g. law firms.\\n\\nAs a [[LocalBusiness]] it can be described as a [[provider]] of one or more [[Service]]\\(s).'),
(591, 1, 6, 'ReturnLabelSourceEnumeration', 'ReturnLabelSourceEnumeration', 'Enumerates several types of return labels for product returns.'),
(592, 1, 6, 'TouristAttraction', 'TouristAttraction', 'A tourist attraction.  In principle any Thing can be a [[TouristAttraction]], from a [[Mountain]] and [[LandmarksOrHistoricalBuildings]] to a [[LocalBusiness]].  This Type can be used on its own to describe a general [[TouristAttraction]], or be used as an [[additionalType]] to add tourist attraction properties to any other type.  (See examples below)'),
(593, 1, 6, 'AnatomicalSystem', 'AnatomicalSystem', 'An anatomical system is a group of anatomical structures that work together to perform a certain task. Anatomical systems, such as organ systems, are one organizing principle of anatomy, and can include circulatory, digestive, endocrine, integumentary, immune, lymphatic, muscular, nervous, reproductive, respiratory, skeletal, urinary, vestibular, and other systems.'),
(594, 1, 6, 'ControlAction', 'ControlAction', 'An agent controls a device or application.'),
(595, 1, 6, 'RealEstateAgent', 'RealEstateAgent', 'A real-estate agent.'),
(596, 1, 6, 'Action', 'Action', 'An action performed by a direct agent and indirect participants upon a direct object. Optionally happens at a location with the help of an inanimate instrument. The execution of the action may produce a result. Specific action sub-type documentation specifies the exact expectation of each argument/role.\\n\\nSee also [blog post](http://blog.schema.org/2014/04/announcing-schemaorg-actions.html) and [Actions overview document](https://schema.org/docs/actions.html).'),
(597, 1, 6, 'WorkBasedProgram', 'WorkBasedProgram', 'A program with both an educational and employment component. Typically based at a workplace and structured around work-based learning, with the aim of instilling competencies related to an occupation. WorkBasedProgram is used to distinguish programs such as apprenticeships from school, college or other classroom based educational programs.'),
(598, 1, 6, 'PaymentChargeSpecification', 'PaymentChargeSpecification', 'The costs of settling the payment using a particular payment method.'),
(599, 1, 6, 'WarrantyPromise', 'WarrantyPromise', 'A structured value representing the duration and scope of services that will be provided to a customer free of charge in case of a defect or malfunction of a product.'),
(600, 1, 6, 'SpecialAnnouncement', 'SpecialAnnouncement', 'A SpecialAnnouncement combines a simple date-stamped textual information update\n      with contextualized Web links and other structured data.  It represents an information update made by a\n      locally-oriented organization, for example schools, pharmacies, healthcare providers,  community groups, police,\n      local government.\n\nFor work in progress guidelines on Coronavirus-related markup see [this doc](https://docs.google.com/document/d/14ikaGCKxo50rRM7nvKSlbUpjyIk2WMQd3IkB1lItlrM/edit#).\n\nThe motivating scenario for SpecialAnnouncement is the [Coronavirus pandemic](https://en.wikipedia.org/wiki/2019%E2%80%9320_coronavirus_pandemic), and the initial vocabulary is oriented to this urgent situation. Schema.org\nexpect to improve the markup iteratively as it is deployed and as feedback emerges from use. In addition to our\nusual [Github entry](https://github.com/schemaorg/schemaorg/issues/2490), feedback comments can also be provided in [this document](https://docs.google.com/document/d/1fpdFFxk8s87CWwACs53SGkYv3aafSxz_DTtOQxMrBJQ/edit#).\n\n\nWhile this schema is designed to communicate urgent crisis-related information, it is not the same as an emergency warning technology like [CAP](https://en.wikipedia.org/wiki/Common_Alerting_Protocol), although there may be overlaps. The intent is to cover\nthe kinds of everyday practical information being posted to existing websites during an emergency situation.\n\nSeveral kinds of information can be provided:\n\nWe encourage the provision of \"name\", \"text\", \"datePosted\", \"expires\" (if appropriate), \"category\" and\n\"url\" as a simple baseline. It is important to provide a value for \"category\" where possible, most ideally as a well known\nURL from Wikipedia or Wikidata. In the case of the 2019-2020 Coronavirus pandemic, this should be \"https://en.wikipedia.org/w/index.php?title=2019-20\\_coronavirus\\_pandemic\" or \"https://www.wikidata.org/wiki/Q81068910\".\n\nFor many of the possible properties, values can either be simple links or an inline description, depending on whether a summary is available. For a link, provide just the URL of the appropriate page as the property\'s value. For an inline description, use a [[WebContent]] type, and provide the url as a property of that, alongside at least a simple \"[[text]]\" summary of the page. It is\nunlikely that a single SpecialAnnouncement will need all of the possible properties simultaneously.\n\nWe expect that in many cases the page referenced might contain more specialized structured data, e.g. contact info, [[openingHours]], [[Event]], [[FAQPage]] etc. By linking to those pages from a [[SpecialAnnouncement]] you can help make it clearer that the events are related to the situation (e.g. Coronavirus) indicated by the [[category]] property of the [[SpecialAnnouncement]].\n\nMany [[SpecialAnnouncement]]s will relate to particular regions and to identifiable local organizations. Use [[spatialCoverage]] for the region, and [[announcementLocation]] to indicate specific [[LocalBusiness]]es and [[CivicStructure]]s. If the announcement affects both a particular region and a specific location (for example, a library closure that serves an entire region), use both [[spatialCoverage]] and [[announcementLocation]].\n\nThe [[about]] property can be used to indicate entities that are the focus of the announcement. We now recommend using [[about]] only\nfor representing non-location entities (e.g. a [[Course]] or a [[RadioStation]]). For places, use [[announcementLocation]] and [[spatialCoverage]]. Consumers of this markup should be aware that the initial design encouraged the use of [[about]] for locations too.\n\nThe basic content of [[SpecialAnnouncement]] is similar to that of an [RSS](https://en.wikipedia.org/wiki/RSS) or [Atom](https://en.wikipedia.org/wiki/Atom_(Web_standard)) feed. For publishers without such feeds, basic feed-like information can be shared by posting\n[[SpecialAnnouncement]] updates in a page, e.g. using JSON-LD. For sites with Atom/RSS functionality, you can point to a feed\nwith the [[webFeed]] property. This can be a simple URL, or an inline [[DataFeed]] object, with [[encodingFormat]] providing\nmedia type information, e.g. \"application/rss+xml\" or \"application/atom+xml\".\n'),
(601, 1, 6, 'Claim', 'Claim', 'A [[Claim]] in Schema.org represents a specific, factually-oriented claim that could be the [[itemReviewed]] in a [[ClaimReview]]. The content of a claim can be summarized with the [[text]] property. Variations on well known claims can have their common identity indicated via [[sameAs]] links, and summarized with a [[name]]. Ideally, a [[Claim]] description includes enough contextual information to minimize the risk of ambiguity or inclarity. In practice, many claims are better understood in the context in which they appear or the interpretations provided by claim reviews.\n\n  Beyond [[ClaimReview]], the Claim type can be associated with related creative works - for example a [[ScholarlyArticle]] or [[Question]] might be [[about]] some [[Claim]].\n\n  At this time, Schema.org does not define any types of relationship between claims. This is a natural area for future exploration.\n  '),
(602, 1, 6, 'BedDetails', 'BedDetails', 'An entity holding detailed information about the available bed types, e.g. the quantity of twin beds for a hotel room. For the single case of just one bed of a certain type, you can use bed directly with a text. See also [[BedType]] (under development).'),
(603, 1, 6, 'Blog', 'Blog', 'A [blog](https://en.wikipedia.org/wiki/Blog), sometimes known as a \"weblog\". Note that the individual posts ([[BlogPosting]]s) in a [[Blog]] are often colloquially referred to by the same term.'),
(604, 1, 6, 'ReturnMethodEnumeration', 'ReturnMethodEnumeration', 'Enumerates several types of product return methods.'),
(605, 1, 6, 'DateTime', 'DateTime', 'A combination of date and time of day in the form [-]CCYY-MM-DDThh:mm:ss[Z|(+|-)hh:mm] (see Chapter 5.4 of ISO 8601).'),
(606, 1, 6, 'MedicalEntity', 'MedicalEntity', 'The most generic type of entity related to health and the practice of medicine.'),
(607, 1, 6, 'DataType', 'DataType', 'The basic data types such as Integers, Strings, etc.'),
(608, 1, 6, 'PriceComponentTypeEnumeration', 'PriceComponentTypeEnumeration', 'Enumerates different price components that together make up the total price for an offered product.');
INSERT INTO `resource_class` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(609, 1, 6, 'ComicIssue', 'ComicIssue', 'Individual comic issues are serially published as\n    	part of a larger series. For the sake of consistency, even one-shot issues\n    	belong to a series comprised of a single issue. All comic issues can be\n    	uniquely identified by: the combination of the name and volume number of the\n    	series to which the issue belongs; the issue number; and the variant\n    	description of the issue (if any).'),
(610, 1, 6, 'MoveAction', 'MoveAction', 'The act of an agent relocating to a place.\\n\\nRelated actions:\\n\\n* [[TransferAction]]: Unlike TransferAction, the subject of the move is a living Person or Organization rather than an inanimate object.'),
(611, 1, 6, 'TaxiService', 'TaxiService', 'A service for a vehicle for hire with a driver for local travel. Fares are usually calculated based on distance traveled.'),
(612, 1, 6, 'DatedMoneySpecification', 'DatedMoneySpecification', 'A DatedMoneySpecification represents monetary values with optional start and end dates. For example, this could represent an employee\'s salary over a specific period of time. __Note:__ This type has been superseded by [[MonetaryAmount]], use of that type is recommended.'),
(613, 1, 6, 'TravelAction', 'TravelAction', 'The act of traveling from a fromLocation to a destination by a specified mode of transport, optionally with participants.'),
(614, 1, 6, 'Time', 'Time', 'A point in time recurring on multiple days in the form hh:mm:ss[Z|(+|-)hh:mm] (see [XML schema for details](http://www.w3.org/TR/xmlschema-2/#time)).'),
(615, 1, 6, 'MedicalObservationalStudy', 'MedicalObservationalStudy', 'An observational study is a type of medical study that attempts to infer the possible effect of a treatment through observation of a cohort of subjects over a period of time. In an observational study, the assignment of subjects into treatment groups versus control groups is outside the control of the investigator. This is in contrast with controlled studies, such as the randomized controlled trials represented by MedicalTrial, where each subject is randomly assigned to a treatment group or a control group before the start of the treatment.'),
(616, 1, 6, 'Chapter', 'Chapter', 'One of the sections into which a book is divided. A chapter usually has a section number or a name.'),
(617, 1, 6, 'DrugCostCategory', 'DrugCostCategory', 'Enumerated categories of medical drug costs.'),
(618, 1, 6, 'PodcastSeries', 'PodcastSeries', 'A podcast is an episodic series of digital audio or video files which a user can download and listen to.'),
(619, 1, 6, 'Flight', 'Flight', 'An airline flight.'),
(620, 1, 6, 'MusicReleaseFormatType', 'MusicReleaseFormatType', 'Format of this release (the type of recording media used, i.e. compact disc, digital media, LP, etc.).'),
(621, 1, 6, 'CriticReview', 'CriticReview', 'A [[CriticReview]] is a more specialized form of Review written or published by a source that is recognized for its reviewing activities. These can include online columns, travel and food guides, TV and radio shows, blogs and other independent Web sites. [[CriticReview]]s are typically more in-depth and professionally written. For simpler, casually written user/visitor/viewer/customer reviews, it is more appropriate to use the [[UserReview]] type. Review aggregator sites such as Metacritic already separate out the site\'s user reviews from selected critic reviews that originate from third-party sources.'),
(622, 1, 6, 'MediaReview', 'MediaReview', 'A [[MediaReview]] is a more specialized form of Review dedicated to the evaluation of media content online, typically in the context of fact-checking and misinformation.\n    For more general reviews of media in the broader sense, use [[UserReview]], [[CriticReview]] or other [[Review]] types. This definition is\n    a work in progress. While the [[MediaManipulationRatingEnumeration]] list reflects significant community review amongst fact-checkers and others working\n    to combat misinformation, the specific structures for representing media objects, their versions and publication context, are still evolving. Similarly, best practices for the relationship between [[MediaReview]] and [[ClaimReview]] markup have not yet been finalized.'),
(623, 1, 6, 'EmergencyService', 'EmergencyService', 'An emergency service, such as a fire station or ER.'),
(624, 1, 6, 'PayAction', 'PayAction', 'An agent pays a price to a participant.'),
(625, 1, 6, 'Map', 'Map', 'A map.'),
(626, 1, 6, 'Protein', 'Protein', 'Protein is here used in its widest possible definition, as classes of amino acid based molecules. Amyloid-beta Protein in human (UniProt P05067), eukaryota (e.g. an OrthoDB group) or even a single molecule that one can point to are all of type schema:Protein. A protein can thus be a subclass of another protein, e.g. schema:Protein as a UniProt record can have multiple isoforms inside it which would also be schema:Protein. They can be imagined, synthetic, hypothetical or naturally occurring.'),
(627, 1, 6, 'ConsumeAction', 'ConsumeAction', 'The act of ingesting information/resources/food.'),
(628, 1, 6, 'MedicalImagingTechnique', 'MedicalImagingTechnique', 'Any medical imaging modality typically used for diagnostic purposes. Enumerated type.'),
(629, 1, 6, 'SolveMathAction', 'SolveMathAction', 'The action that takes in a math expression and directs users to a page potentially capable of solving/simplifying that expression.'),
(630, 1, 6, 'DriveWheelConfigurationValue', 'DriveWheelConfigurationValue', 'A value indicating which roadwheels will receive torque.'),
(631, 1, 6, 'MedicalClinic', 'MedicalClinic', 'A facility, often associated with a hospital or medical school, that is devoted to the specific diagnosis and/or healthcare. Previously limited to outpatients but with evolution it may be open to inpatients as well.'),
(632, 1, 6, 'Question', 'Question', 'A specific question - e.g. from a user seeking answers online, or collected in a Frequently Asked Questions (FAQ) document.'),
(633, 1, 6, 'BroadcastFrequencySpecification', 'BroadcastFrequencySpecification', 'The frequency in MHz and the modulation used for a particular BroadcastService.'),
(634, 1, 6, 'DeliveryMethod', 'DeliveryMethod', 'A delivery method is a standardized procedure for transferring the product or service to the destination of fulfillment chosen by the customer. Delivery methods are characterized by the means of transportation used, and by the organization or group that is the contracting party for the sending organization or person.\\n\\nCommonly used values:\\n\\n* http://purl.org/goodrelations/v1#DeliveryModeDirectDownload\\n* http://purl.org/goodrelations/v1#DeliveryModeFreight\\n* http://purl.org/goodrelations/v1#DeliveryModeMail\\n* http://purl.org/goodrelations/v1#DeliveryModeOwnFleet\\n* http://purl.org/goodrelations/v1#DeliveryModePickUp\\n* http://purl.org/goodrelations/v1#DHL\\n* http://purl.org/goodrelations/v1#FederalExpress\\n* http://purl.org/goodrelations/v1#UPS\n        '),
(635, 1, 6, 'Drug', 'Drug', 'A chemical or biologic substance, used as a medical therapy, that has a physiological effect on an organism. Here the term drug is used interchangeably with the term medicine although clinical knowledge makes a clear difference between them.'),
(636, 1, 6, 'ItemList', 'ItemList', 'A list of items of any sort&#x2014;for example, Top 10 Movies About Weathermen, or Top 100 Party Songs. Not to be confused with HTML lists, which are often used only for formatting.'),
(637, 1, 6, 'PerformAction', 'PerformAction', 'The act of participating in performance arts.'),
(638, 1, 6, 'DigitalDocumentPermission', 'DigitalDocumentPermission', 'A permission for a particular person or group to access a particular file.'),
(639, 1, 6, 'Guide', 'Guide', '[[Guide]] is a page or article that recommends specific products or services, or aspects of a thing for a user to consider. A [[Guide]] may represent a Buying Guide and detail aspects of products or services for a user to consider. A [[Guide]] may represent a Product Guide and recommend specific products or services. A [[Guide]] may represent a Ranked List and recommend specific products or services with ranking.'),
(640, 1, 6, 'SocialMediaPosting', 'SocialMediaPosting', 'A post to a social media platform, including blog posts, tweets, Facebook posts, etc.'),
(641, 1, 6, 'TherapeuticProcedure', 'TherapeuticProcedure', 'A medical procedure intended primarily for therapeutic purposes, aimed at improving a health condition.'),
(642, 1, 6, 'BoatTerminal', 'BoatTerminal', 'A terminal for boats, ships, and other water vessels.'),
(643, 1, 6, 'Quotation', 'Quotation', 'A quotation. Often but not necessarily from some written work, attributable to a real world author and - if associated with a fictional character - to any fictional Person. Use [[isBasedOn]] to link to source/origin. The [[recordedIn]] property can be used to reference a Quotation from an [[Event]].'),
(644, 1, 6, 'PublicationVolume', 'PublicationVolume', 'A part of a successively published publication such as a periodical or multi-volume work, often numbered. It may represent a time span, such as a year.\\n\\nSee also [blog post](http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html).'),
(645, 1, 6, 'WebApplication', 'WebApplication', 'Web applications.'),
(646, 1, 6, 'Substance', 'Substance', 'Any matter of defined composition that has discrete existence, whose origin may be biological, mineral or chemical.'),
(647, 1, 6, 'CssSelectorType', 'CssSelectorType', 'Text representing a CSS selector.'),
(648, 1, 6, 'BroadcastService', 'BroadcastService', 'A delivery service through which content is provided via broadcast over the air or online.'),
(649, 1, 6, 'Place', 'Place', 'Entities that have a somewhat fixed, physical extension.'),
(650, 1, 6, 'MaximumDoseSchedule', 'MaximumDoseSchedule', 'The maximum dosing schedule considered safe for a drug or supplement as recommended by an authority or by the drug/supplement\'s manufacturer. Capture the recommending authority in the recognizingAuthority property of MedicalEntity.'),
(651, 1, 6, 'UKNonprofitType', 'UKNonprofitType', 'UKNonprofitType: Non-profit organization type originating from the United Kingdom.'),
(652, 1, 6, 'DrugPregnancyCategory', 'DrugPregnancyCategory', 'Categories that represent an assessment of the risk of fetal injury due to a drug or pharmaceutical used as directed by the mother during pregnancy.'),
(653, 1, 6, 'EmployeeRole', 'EmployeeRole', 'A subclass of OrganizationRole used to describe employee relationships.'),
(654, 1, 6, 'Mass', 'Mass', 'Properties that take Mass as values are of the form \'&lt;Number&gt; &lt;Mass unit of measure&gt;\'. E.g., \'7 kg\'.'),
(655, 1, 6, 'MedicalTestPanel', 'MedicalTestPanel', 'Any collection of tests commonly ordered together.'),
(656, 1, 6, 'FinancialService', 'FinancialService', 'Financial services business.'),
(657, 1, 6, 'CarUsageType', 'CarUsageType', 'A value indicating a special usage of a car, e.g. commercial rental, driving school, or as a taxi.'),
(658, 1, 6, 'DietarySupplement', 'DietarySupplement', 'A product taken by mouth that contains a dietary ingredient intended to supplement the diet. Dietary ingredients may include vitamins, minerals, herbs or other botanicals, amino acids, and substances such as enzymes, organ tissues, glandulars and metabolites.'),
(659, 1, 6, 'StatusEnumeration', 'StatusEnumeration', 'Lists or enumerations dealing with status types.'),
(660, 1, 6, 'InteractAction', 'InteractAction', 'The act of interacting with another person or organization.'),
(661, 1, 6, 'CivicStructure', 'CivicStructure', 'A public structure, such as a town hall or concert hall.'),
(662, 1, 6, 'MedicalContraindication', 'MedicalContraindication', 'A condition or factor that serves as a reason to withhold a certain medical therapy. Contraindications can be absolute (there are no reasonable circumstances for undertaking a course of action) or relative (the patient is at higher risk of complications, but these risks may be outweighed by other considerations or mitigated by other measures).'),
(663, 1, 6, 'LeaveAction', 'LeaveAction', 'An agent leaves an event / group with participants/friends at a location.\\n\\nRelated actions:\\n\\n* [[JoinAction]]: The antonym of LeaveAction.\\n* [[UnRegisterAction]]: Unlike UnRegisterAction, LeaveAction implies leaving a group/team of people rather than a service.'),
(664, 1, 6, 'AskAction', 'AskAction', 'The act of posing a question / favor to someone.\\n\\nRelated actions:\\n\\n* [[ReplyAction]]: Appears generally as a response to AskAction.'),
(665, 1, 6, 'OrderStatus', 'OrderStatus', 'Enumerated status values for Order.'),
(666, 1, 6, 'CorrectionComment', 'CorrectionComment', 'A [[comment]] that corrects [[CreativeWork]].'),
(667, 1, 6, 'RestrictedDiet', 'RestrictedDiet', 'A diet restricted to certain foods or preparations for cultural, religious, health or lifestyle reasons. '),
(668, 1, 6, 'Text', 'Text', 'Data type: Text.'),
(669, 1, 6, 'CollectionPage', 'CollectionPage', 'Web page type: Collection page.'),
(670, 1, 6, 'MusicComposition', 'MusicComposition', 'A musical composition.'),
(671, 1, 6, 'LodgingBusiness', 'LodgingBusiness', 'A lodging business, such as a motel, hotel, or inn.'),
(672, 1, 6, 'OrderAction', 'OrderAction', 'An agent orders an object/product/service to be delivered/sent.'),
(673, 1, 6, 'VideoObject', 'VideoObject', 'A video file.'),
(674, 1, 6, 'MedicalCause', 'MedicalCause', 'The causative agent(s) that are responsible for the pathophysiologic process that eventually results in a medical condition, symptom or sign. In this schema, unless otherwise specified this is meant to be the proximate cause of the medical condition, symptom or sign. The proximate cause is defined as the causative agent that most directly results in the medical condition, symptom or sign. For example, the HIV virus could be considered a cause of AIDS. Or in a diagnostic context, if a patient fell and sustained a hip fracture and two days later sustained a pulmonary embolism which eventuated in a cardiac arrest, the cause of the cardiac arrest (the proximate cause) would be the pulmonary embolism and not the fall. Medical causes can include cardiovascular, chemical, dermatologic, endocrine, environmental, gastroenterologic, genetic, hematologic, gynecologic, iatrogenic, infectious, musculoskeletal, neurologic, nutritional, obstetric, oncologic, otolaryngologic, pharmacologic, psychiatric, pulmonary, renal, rheumatologic, toxic, traumatic, or urologic causes; medical conditions can be causes as well.'),
(675, 1, 6, 'TouristDestination', 'TouristDestination', 'A tourist destination. In principle any [[Place]] can be a [[TouristDestination]] from a [[City]], Region or [[Country]] to an [[AmusementPark]] or [[Hotel]]. This Type can be used on its own to describe a general [[TouristDestination]], or be used as an [[additionalType]] to add tourist relevant properties to any other [[Place]].  A [[TouristDestination]] is defined as a [[Place]] that contains, or is colocated with, one or more [[TouristAttraction]]s, often linked by a similar theme or interest to a particular [[touristType]]. The [UNWTO](http://www2.unwto.org/) defines Destination (main destination of a tourism trip) as the place visited that is central to the decision to take the trip.\n  (See examples below.)'),
(676, 1, 6, 'PhysicalExam', 'PhysicalExam', 'A type of physical examination of a patient performed by a physician. '),
(677, 1, 6, 'LegalForceStatus', 'LegalForceStatus', 'A list of possible statuses for the legal force of a legislation.'),
(678, 1, 6, 'ItemListOrderType', 'ItemListOrderType', 'Enumerated for values for itemListOrder for indicating how an ordered ItemList is organized.'),
(679, 1, 6, 'SportsEvent', 'SportsEvent', 'Event type: Sports event.'),
(680, 1, 6, 'WearableMeasurementTypeEnumeration', 'WearableMeasurementTypeEnumeration', 'Enumerates common types of measurement for wearables products.'),
(681, 1, 6, 'Patient', 'Patient', 'A patient is any person recipient of health care services.'),
(682, 1, 6, 'Store', 'Store', 'A retail good store.'),
(683, 1, 6, 'NonprofitType', 'NonprofitType', 'NonprofitType enumerates several kinds of official non-profit types of which a non-profit organization can be.'),
(684, 1, 6, '3DModel', '3DModel', 'A 3D model represents some kind of 3D content, which may have [[encoding]]s in one or more [[MediaObject]]s. Many 3D formats are available (e.g. see [Wikipedia](https://en.wikipedia.org/wiki/Category:3D_graphics_file_formats)); specific encoding formats can be represented using the [[encodingFormat]] property applied to the relevant [[MediaObject]]. For the\ncase of a single file published after Zip compression, the convention of appending \'+zip\' to the [[encodingFormat]] can be used. Geospatial, AR/VR, artistic/animation, gaming, engineering and scientific content can all be represented using [[3DModel]].'),
(685, 1, 6, 'Car', 'Car', 'A car is a wheeled, self-powered motor vehicle used for transportation.'),
(686, 1, 6, 'DayOfWeek', 'DayOfWeek', 'The day of the week, e.g. used to specify to which day the opening hours of an OpeningHoursSpecification refer.\n\nOriginally, URLs from [GoodRelations](http://purl.org/goodrelations/v1) were used (for [[Monday]], [[Tuesday]], [[Wednesday]], [[Thursday]], [[Friday]], [[Saturday]], [[Sunday]] plus a special entry for [[PublicHolidays]]); these have now been integrated directly into schema.org.\n      '),
(687, 1, 6, 'TypeAndQuantityNode', 'TypeAndQuantityNode', 'A structured value indicating the quantity, unit of measurement, and business function of goods included in a bundle offer.'),
(688, 1, 6, 'ShippingRateSettings', 'ShippingRateSettings', 'A ShippingRateSettings represents re-usable pieces of shipping information. It is designed for publication on an URL that may be referenced via the [[shippingSettingsLink]] property of an [[OfferShippingDetails]]. Several occurrences can be published, distinguished and matched (i.e. identified/referenced) by their different values for [[shippingLabel]].'),
(689, 1, 6, 'PaymentCard', 'PaymentCard', 'A payment method using a credit, debit, store or other card to associate the payment with an account.'),
(690, 1, 6, 'MedicalStudy', 'MedicalStudy', 'A medical study is an umbrella type covering all kinds of research studies relating to human medicine or health, including observational studies and interventional trials and registries, randomized, controlled or not. When the specific type of study is known, use one of the extensions of this type, such as MedicalTrial or MedicalObservationalStudy. Also, note that this type should be used to mark up data that describes the study itself; to tag an article that publishes the results of a study, use MedicalScholarlyArticle. Note: use the code property of MedicalEntity to store study IDs, e.g. clinicaltrials.gov ID.'),
(691, 1, 6, 'MortgageLoan', 'MortgageLoan', 'A loan in which property or real estate is used as collateral. (A loan securitized against some real estate.)'),
(692, 1, 6, 'Collection', 'Collection', 'A collection of items, e.g. creative works or products.'),
(693, 1, 6, 'InfectiousAgentClass', 'InfectiousAgentClass', 'Classes of agents or pathogens that transmit infectious diseases. Enumerated type.'),
(694, 1, 6, 'APIReference', 'APIReference', 'Reference documentation for application programming interfaces (APIs).'),
(695, 1, 6, 'Country', 'Country', 'A country.'),
(696, 1, 6, 'PropertyValue', 'PropertyValue', 'A property-value pair, e.g. representing a feature of a product or place. Use the \'name\' property for the name of the property. If there is an additional human-readable version of the value, put that into the \'description\' property.\\n\\n Always use specific schema.org properties when a) they exist and b) you can populate them. Using PropertyValue as a substitute will typically not trigger the same effect as using the original, specific property.\n    '),
(697, 1, 6, 'HowToSupply', 'HowToSupply', 'A supply consumed when performing the instructions for how to achieve a result.'),
(698, 1, 6, 'StatisticalPopulation', 'StatisticalPopulation', 'A StatisticalPopulation is a set of instances of a certain given type that satisfy some set of constraints. The property [[populationType]] is used to specify the type. Any property that can be used on instances of that type can appear on the statistical population. For example, a [[StatisticalPopulation]] representing all [[Person]]s with a [[homeLocation]] of East Podunk California would be described by applying the appropriate [[homeLocation]] and [[populationType]] properties to a [[StatisticalPopulation]] item that stands for that set of people.\nThe properties [[numConstraints]] and [[constrainingProperty]] are used to specify which of the populations properties are used to specify the population. Note that the sense of \"population\" used here is the general sense of a statistical\npopulation, and does not imply that the population consists of people. For example, a [[populationType]] of [[Event]] or [[NewsArticle]] could be used. See also [[Observation]], and the [data and datasets](/docs/data-and-datasets.html) overview for more details.\n  '),
(699, 1, 6, 'Periodical', 'Periodical', 'A publication in any medium issued in successive parts bearing numerical or chronological designations and intended to continue indefinitely, such as a magazine, scholarly journal, or newspaper.\\n\\nSee also [blog post](http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html).'),
(700, 1, 6, 'Hospital', 'Hospital', 'A hospital.'),
(701, 1, 6, 'WebAPI', 'WebAPI', 'An application programming interface accessible over Web/Internet technologies.'),
(702, 1, 6, 'ActionAccessSpecification', 'ActionAccessSpecification', 'A set of requirements that must be fulfilled in order to perform an Action.'),
(703, 1, 6, 'QualitativeValue', 'QualitativeValue', 'A predefined value for a product characteristic, e.g. the power cord plug type \'US\' or the garment sizes \'S\', \'M\', \'L\', and \'XL\'.'),
(704, 1, 6, 'BroadcastChannel', 'BroadcastChannel', 'A unique instance of a BroadcastService on a CableOrSatelliteService lineup.'),
(705, 1, 6, 'WriteAction', 'WriteAction', 'The act of authoring written creative content.'),
(706, 1, 6, 'Rating', 'Rating', 'A rating is an evaluation on a numeric scale, such as 1 to 5 stars.'),
(707, 1, 6, 'Trip', 'Trip', 'A trip or journey. An itinerary of visits to one or more places.'),
(708, 1, 6, 'TradeAction', 'TradeAction', 'The act of participating in an exchange of goods and services for monetary compensation. An agent trades an object, product or service with a participant in exchange for a one time or periodic payment.'),
(709, 1, 6, 'GeospatialGeometry', 'GeospatialGeometry', '(Eventually to be defined as) a supertype of GeoShape designed to accommodate definitions from Geo-Spatial best practices.'),
(710, 1, 6, 'EnergyEfficiencyEnumeration', 'EnergyEfficiencyEnumeration', 'Enumerates energy efficiency levels (also known as \"classes\" or \"ratings\") and certifications that are part of several international energy efficiency standards.'),
(711, 1, 6, 'DataDownload', 'DataDownload', 'All or part of a [[Dataset]] in downloadable form. '),
(712, 1, 6, 'ReturnFeesEnumeration', 'ReturnFeesEnumeration', 'Enumerates several kinds of policies for product return fees.'),
(713, 1, 6, 'LinkRole', 'LinkRole', 'A Role that represents a Web link, e.g. as expressed via the \'url\' property. Its linkRelationship property can indicate URL-based and plain textual link types, e.g. those in IANA link registry or others such as \'amphtml\'. This structure provides a placeholder where details from HTML\'s link element can be represented outside of HTML, e.g. in JSON-LD feeds.'),
(714, 1, 6, 'NewsArticle', 'NewsArticle', 'A NewsArticle is an article whose content reports news, or provides background context and supporting materials for understanding the news.\n\nA more detailed overview of [schema.org News markup](/docs/news.html) is also available.\n'),
(715, 1, 6, 'Game', 'Game', 'The Game type represents things which are games. These are typically rule-governed recreational activities, e.g. role-playing games in which players assume the role of characters in a fictional setting.'),
(716, 1, 6, 'ParcelDelivery', 'ParcelDelivery', 'The delivery of a parcel either via the postal service or a commercial service.'),
(717, 1, 6, 'GameServerStatus', 'GameServerStatus', 'Status of a game server.'),
(718, 1, 6, 'Demand', 'Demand', 'A demand entity represents the public, not necessarily binding, not necessarily exclusive, announcement by an organization or person to seek a certain type of goods or services. For describing demand using this type, the very same properties used for Offer apply.'),
(719, 1, 6, 'MathSolver', 'MathSolver', 'A math solver which is capable of solving a subset of mathematical problems.'),
(720, 1, 6, 'WebPageElement', 'WebPageElement', 'A web page element, like a table or an image.'),
(721, 1, 6, 'MedicalGuidelineRecommendation', 'MedicalGuidelineRecommendation', 'A guideline recommendation that is regarded as efficacious and where quality of the data supporting the recommendation is sound.'),
(722, 1, 6, 'TVSeason', 'TVSeason', 'Season dedicated to TV broadcast and associated online delivery.'),
(723, 1, 6, 'SearchAction', 'SearchAction', 'The act of searching for an object.\\n\\nRelated actions:\\n\\n* [[FindAction]]: SearchAction generally leads to a FindAction, but not necessarily.'),
(724, 1, 6, 'CableOrSatelliteService', 'CableOrSatelliteService', 'A service which provides access to media programming like TV or radio. Access may be via cable or satellite.'),
(725, 1, 6, 'MonetaryAmountDistribution', 'MonetaryAmountDistribution', 'A statistical distribution of monetary amounts.'),
(726, 1, 6, 'BusStop', 'BusStop', 'A bus stop.'),
(727, 1, 6, 'ExercisePlan', 'ExercisePlan', 'Fitness-related activity designed for a specific health-related purpose, including defined exercise routines as well as activity prescribed by a clinician.'),
(728, 1, 6, 'Photograph', 'Photograph', 'A photograph.'),
(729, 1, 6, 'MenuSection', 'MenuSection', 'A sub-grouping of food or drink items in a menu. E.g. courses (such as \'Dinner\', \'Breakfast\', etc.), specific type of dishes (such as \'Meat\', \'Vegan\', \'Drinks\', etc.), or some other classification made by the menu provider.'),
(730, 1, 6, 'Order', 'Order', 'An order is a confirmation of a transaction (a receipt), which can contain multiple line items, each represented by an Offer that has been accepted by the customer.'),
(731, 1, 6, 'AlignmentObject', 'AlignmentObject', 'An intangible item that describes an alignment between a learning resource and a node in an educational framework.\n\nShould not be used where the nature of the alignment can be described using a simple property, for example to express that a resource [[teaches]] or [[assesses]] a competency.'),
(732, 1, 6, 'Legislation', 'Legislation', 'A legal document such as an act, decree, bill, etc. (enforceable or not) or a component of a legal act (like an article).'),
(733, 1, 6, 'ApartmentComplex', 'ApartmentComplex', 'Residence type: Apartment complex.'),
(734, 1, 6, 'WearableSizeGroupEnumeration', 'WearableSizeGroupEnumeration', 'Enumerates common size groups (also known as \"size types\") for wearable products.'),
(735, 1, 6, 'Project', 'Project', 'An enterprise (potentially individual but typically collaborative), planned to achieve a particular aim.\nUse properties from [[Organization]], [[subOrganization]]/[[parentOrganization]] to indicate project sub-structures. \n   '),
(736, 1, 6, 'DefinedTermSet', 'DefinedTermSet', 'A set of defined terms, for example a set of categories or a classification scheme, a glossary, dictionary or enumeration.'),
(737, 1, 6, 'SteeringPositionValue', 'SteeringPositionValue', 'A value indicating a steering position.'),
(738, 1, 6, 'BusTrip', 'BusTrip', 'A trip on a commercial bus line.'),
(739, 1, 6, 'DeliveryTimeSettings', 'DeliveryTimeSettings', 'A DeliveryTimeSettings represents re-usable pieces of shipping information, relating to timing. It is designed for publication on an URL that may be referenced via the [[shippingSettingsLink]] property of an [[OfferShippingDetails]]. Several occurrences can be published, distinguished (and identified/referenced) by their different values for [[transitTimeLabel]].'),
(740, 1, 6, 'OfferCatalog', 'OfferCatalog', 'An OfferCatalog is an ItemList that contains related Offers and/or further OfferCatalogs that are offeredBy the same provider.'),
(741, 1, 6, 'MedicalTrialDesign', 'MedicalTrialDesign', 'Design models for medical trials. Enumerated type.'),
(742, 1, 6, 'CoverArt', 'CoverArt', 'The artwork on the outer surface of a CreativeWork.'),
(743, 1, 6, 'PhysicalActivityCategory', 'PhysicalActivityCategory', 'Categories of physical activity, organized by physiologic classification.'),
(744, 1, 6, 'Product', 'Product', 'Any offered product or service. For example: a pair of shoes; a concert ticket; the rental of a car; a haircut; or an episode of a TV show streamed online.'),
(745, 1, 6, 'InsertAction', 'InsertAction', 'The act of adding at a specific location in an ordered collection.'),
(746, 1, 6, 'BuyAction', 'BuyAction', 'The act of giving money to a seller in exchange for goods or services rendered. An agent buys an object, product, or service from a seller for a price. Reciprocal of SellAction.'),
(747, 1, 6, 'MoneyTransfer', 'MoneyTransfer', 'The act of transferring money from one place to another place. This may occur electronically or physically.'),
(748, 1, 6, 'MapCategoryType', 'MapCategoryType', 'An enumeration of several kinds of Map.'),
(749, 1, 6, 'SoftwareApplication', 'SoftwareApplication', 'A software application.'),
(750, 1, 6, 'BreadcrumbList', 'BreadcrumbList', 'A BreadcrumbList is an ItemList consisting of a chain of linked Web pages, typically described using at least their URL and their name, and typically ending with the current page.\\n\\nThe [[position]] property is used to reconstruct the order of the items in a BreadcrumbList. The convention is that a breadcrumb list has an [[itemListOrder]] of [[ItemListOrderAscending]] (lower values listed first), and that the first items in this list correspond to the \"top\" or beginning of the breadcrumb trail, e.g. with a site or section homepage. The specific values of \'position\' are not assigned meaning for a BreadcrumbList, but they should be integers, e.g. beginning with \'1\' for the first item in the list.\n      '),
(751, 1, 6, 'ItemAvailability', 'ItemAvailability', 'A list of possible product availability options.'),
(752, 1, 6, 'Airline', 'Airline', 'An organization that provides flights for passengers.'),
(753, 1, 6, 'BoatTrip', 'BoatTrip', 'A trip on a commercial ferry line.'),
(754, 1, 6, 'SpeakableSpecification', 'SpeakableSpecification', 'A SpeakableSpecification indicates (typically via [[xpath]] or [[cssSelector]]) sections of a document that are highlighted as particularly [[speakable]]. Instances of this type are expected to be used primarily as values of the [[speakable]] property.'),
(755, 1, 6, 'HealthAndBeautyBusiness', 'HealthAndBeautyBusiness', 'Health and beauty.'),
(756, 1, 6, 'MonetaryGrant', 'MonetaryGrant', 'A monetary grant.'),
(757, 1, 6, 'Article', 'Article', 'An article, such as a news article or piece of investigative report. Newspapers and magazines have articles of many different types and this is intended to cover them all.\\n\\nSee also [blog post](http://blog.schema.org/2014/09/schemaorg-support-for-bibliographic_2.html).'),
(758, 1, 6, 'OpeningHoursSpecification', 'OpeningHoursSpecification', 'A structured value providing information about the opening hours of a place or a certain service inside a place.\\n\\n\nThe place is __open__ if the [[opens]] property is specified, and __closed__ otherwise.\\n\\nIf the value for the [[closes]] property is less than the value for the [[opens]] property then the hour range is assumed to span over the next day.\n      '),
(759, 1, 6, 'Audience', 'Audience', 'Intended audience for an item, i.e. the group for whom the item was created.'),
(760, 1, 6, 'ClaimReview', 'ClaimReview', 'A fact-checking review of claims made (or reported) in some creative work (referenced via itemReviewed).'),
(761, 1, 6, 'EducationalOrganization', 'EducationalOrganization', 'An educational organization.'),
(762, 1, 6, 'LodgingReservation', 'LodgingReservation', 'A reservation for lodging at a hotel, motel, inn, etc.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations.'),
(763, 1, 6, 'DataFeed', 'DataFeed', 'A single feed providing structured information about one or more entities or topics.'),
(764, 1, 6, 'HealthPlanNetwork', 'HealthPlanNetwork', 'A US-style health insurance plan network. '),
(765, 1, 6, 'HowToDirection', 'HowToDirection', 'A direction indicating a single action to do in the instructions for how to achieve a result.'),
(766, 1, 6, 'MedicalAudience', 'MedicalAudience', 'Target audiences for medical web pages.'),
(767, 1, 6, 'BioChemEntity', 'BioChemEntity', 'Any biological, chemical, or biochemical thing. For example: a protein; a gene; a chemical; a synthetic chemical.'),
(768, 1, 6, 'SellAction', 'SellAction', 'The act of taking money from a buyer in exchange for goods or services rendered. An agent sells an object, product, or service to a buyer for a price. Reciprocal of BuyAction.'),
(769, 1, 6, 'OccupationalExperienceRequirements', 'OccupationalExperienceRequirements', 'Indicates employment-related experience requirements, e.g. [[monthsOfExperience]].'),
(770, 1, 6, 'TechArticle', 'TechArticle', 'A technical article - Example: How-to (task) topics, step-by-step, procedural troubleshooting, specifications, etc.'),
(771, 1, 6, 'Schedule', 'Schedule', 'A schedule defines a repeating time period used to describe a regularly occurring [[Event]]. At a minimum a schedule will specify [[repeatFrequency]] which describes the interval between occurrences of the event. Additional information can be provided to specify the schedule more precisely.\n      This includes identifying the day(s) of the week or month when the recurring event will take place, in addition to its start and end time. Schedules may also\n      have start and end dates to indicate when they are active, e.g. to define a limited calendar of events.'),
(772, 1, 6, 'ArchiveComponent', 'ArchiveComponent', 'An intangible type to be applied to any archive content, carrying with it a set of properties required to describe archival items and collections.'),
(773, 1, 6, 'Permit', 'Permit', 'A permit issued by an organization, e.g. a parking pass.'),
(774, 1, 6, 'QuantitativeValue', 'QuantitativeValue', ' A point value or interval for product characteristics and other purposes.'),
(775, 1, 6, 'RepaymentSpecification', 'RepaymentSpecification', 'A structured value representing repayment.'),
(776, 1, 6, 'OwnershipInfo', 'OwnershipInfo', 'A structured value providing information about when a certain organization or person owned a certain product.'),
(777, 1, 6, 'Gene', 'Gene', 'A discrete unit of inheritance which affects one or more biological traits (Source: [https://en.wikipedia.org/wiki/Gene](https://en.wikipedia.org/wiki/Gene)). Examples include FOXP2 (Forkhead box protein P2), SCARNA21 (small Cajal body-specific RNA 21), A- (agouti genotype).'),
(778, 1, 6, 'Resort', 'Resort', 'A resort is a place used for relaxation or recreation, attracting visitors for holidays or vacations. Resorts are places, towns or sometimes commercial establishments operated by a single company (source: Wikipedia, the free encyclopedia, see <a href=\"http://en.wikipedia.org/wiki/Resort\">http://en.wikipedia.org/wiki/Resort</a>).\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n    '),
(779, 1, 6, 'UnitPriceSpecification', 'UnitPriceSpecification', 'The price asked for a given offer by the respective organization or person.'),
(780, 1, 6, 'HowToStep', 'HowToStep', 'A step in the instructions for how to achieve a result. It is an ordered list with HowToDirection and/or HowToTip items.'),
(781, 1, 6, 'RsvpAction', 'RsvpAction', 'The act of notifying an event organizer as to whether you expect to attend the event.'),
(782, 1, 6, 'TVSeries', 'TVSeries', 'CreativeWorkSeries dedicated to TV broadcast and associated online delivery.'),
(783, 1, 6, 'DigitalPlatformEnumeration', 'DigitalPlatformEnumeration', 'Enumerates some common technology platforms, for use with properties such as [[actionPlatform]]. It is not supposed to be comprehensive - when a suitable code is not enumerated here, textual or URL values can be used instead. These codes are at a fairly high level and do not deal with versioning and other nuance. Additional codes can be suggested [in github](https://github.com/schemaorg/schemaorg/issues/3057). '),
(784, 1, 6, 'USNonprofitType', 'USNonprofitType', 'USNonprofitType: Non-profit organization type originating from the United States.'),
(785, 1, 6, 'MedicalWebPage', 'MedicalWebPage', 'A web page that provides medical information.'),
(786, 1, 6, 'FollowAction', 'FollowAction', 'The act of forming a personal connection with someone/something (object) unidirectionally/asymmetrically to get updates polled from.\\n\\nRelated actions:\\n\\n* [[BefriendAction]]: Unlike BefriendAction, FollowAction implies that the connection is *not* necessarily reciprocal.\\n* [[SubscribeAction]]: Unlike SubscribeAction, FollowAction implies that the follower acts as an active agent constantly/actively polling for updates.\\n* [[RegisterAction]]: Unlike RegisterAction, FollowAction implies that the agent is interested in continuing receiving updates from the object.\\n* [[JoinAction]]: Unlike JoinAction, FollowAction implies that the agent is interested in getting updates from the object.\\n* [[TrackAction]]: Unlike TrackAction, FollowAction refers to the polling of updates of all aspects of animate objects rather than the location of inanimate objects (e.g. you track a package, but you don\'t follow it).'),
(787, 1, 6, 'Movie', 'Movie', 'A movie.'),
(788, 1, 6, 'Dataset', 'Dataset', 'A body of structured information describing some topic(s) of interest.'),
(789, 1, 6, 'Offer', 'Offer', 'An offer to transfer some rights to an item or to provide a service — for example, an offer to sell tickets to an event, to rent the DVD of a movie, to stream a TV show over the internet, to repair a motorcycle, or to loan a book.\\n\\nNote: As the [[businessFunction]] property, which identifies the form of offer (e.g. sell, lease, repair, dispose), defaults to http://purl.org/goodrelations/v1#Sell; an Offer without a defined businessFunction value can be assumed to be an offer to sell.\\n\\nFor [GTIN](http://www.gs1.org/barcodes/technical/idkeys/gtin)-related fields, see [Check Digit calculator](http://www.gs1.org/barcodes/support/check_digit_calculator) and [validation guide](http://www.gs1us.org/resources/standards/gtin-validation-guide) from [GS1](http://www.gs1.org/).'),
(790, 1, 6, 'Book', 'Book', 'A book.'),
(791, 1, 6, 'NewsMediaOrganization', 'NewsMediaOrganization', 'A News/Media organization such as a newspaper or TV station.'),
(792, 1, 6, 'PaymentMethod', 'PaymentMethod', 'A payment method is a standardized procedure for transferring the monetary amount for a purchase. Payment methods are characterized by the legal and technical structures used, and by the organization or group carrying out the transaction.\\n\\nCommonly used values:\\n\\n* http://purl.org/goodrelations/v1#ByBankTransferInAdvance\\n* http://purl.org/goodrelations/v1#ByInvoice\\n* http://purl.org/goodrelations/v1#Cash\\n* http://purl.org/goodrelations/v1#CheckInAdvance\\n* http://purl.org/goodrelations/v1#COD\\n* http://purl.org/goodrelations/v1#DirectDebit\\n* http://purl.org/goodrelations/v1#GoogleCheckout\\n* http://purl.org/goodrelations/v1#PayPal\\n* http://purl.org/goodrelations/v1#PaySwarm\n        '),
(793, 1, 6, 'CompoundPriceSpecification', 'CompoundPriceSpecification', 'A compound price specification is one that bundles multiple prices that all apply in combination for different dimensions of consumption. Use the name property of the attached unit price specification for indicating the dimension of a price component (e.g. \"electricity\" or \"final cleaning\").'),
(794, 1, 6, 'BusStation', 'BusStation', 'A bus station.'),
(795, 1, 6, 'DrugStrength', 'DrugStrength', 'A specific strength in which a medical drug is available in a specific country.'),
(796, 1, 6, 'Brand', 'Brand', 'A brand is a name used by an organization or business person for labeling a product, product group, or similar.'),
(797, 1, 6, 'BoardingPolicyType', 'BoardingPolicyType', 'A type of boarding policy used by an airline.'),
(798, 1, 6, 'PerformingGroup', 'PerformingGroup', 'A performance group, such as a band, an orchestra, or a circus.'),
(799, 1, 6, 'Service', 'Service', 'A service provided by an organization, e.g. delivery service, print services, etc.'),
(800, 1, 6, 'TrackAction', 'TrackAction', 'An agent tracks an object for updates.\\n\\nRelated actions:\\n\\n* [[FollowAction]]: Unlike FollowAction, TrackAction refers to the interest on the location of innanimates objects.\\n* [[SubscribeAction]]: Unlike SubscribeAction, TrackAction refers to  the interest on the location of innanimate objects.'),
(801, 1, 6, 'GovernmentService', 'GovernmentService', 'A service provided by a government organization, e.g. food stamps, veterans benefits, etc.'),
(802, 1, 6, 'MovieTheater', 'MovieTheater', 'A movie theater.'),
(803, 1, 6, 'MonetaryAmount', 'MonetaryAmount', 'A monetary value or range. This type can be used to describe an amount of money such as $50 USD, or a range as in describing a bank account being suitable for a balance between £1,000 and £1,000,000 GBP, or the value of a salary, etc. It is recommended to use [[PriceSpecification]] Types to describe the price of an Offer, Invoice, etc.'),
(804, 1, 6, 'MedicineSystem', 'MedicineSystem', 'Systems of medical practice.'),
(805, 1, 6, 'MerchantReturnPolicySeasonalOverride', 'MerchantReturnPolicySeasonalOverride', 'A seasonal override of a return policy, for example used for holidays.'),
(806, 1, 6, 'BankOrCreditUnion', 'BankOrCreditUnion', 'Bank or credit union.'),
(807, 1, 6, 'HyperTocEntry', 'HyperTocEntry', 'A HyperToEntry is an item within a [[HyperToc]], which represents a hypertext table of contents for complex media objects, such as [[VideoObject]], [[AudioObject]]. The media object itself is indicated using [[associatedMedia]]. Each section of interest within that content can be described with a [[HyperTocEntry]], with associated [[startOffset]] and [[endOffset]]. When several entries are all from the same file, [[associatedMedia]] is used on the overarching [[HyperTocEntry]]; if the content has been split into multiple files, they can be referenced using [[associatedMedia]] on each [[HyperTocEntry]].'),
(808, 1, 6, 'PostalCodeRangeSpecification', 'PostalCodeRangeSpecification', 'Indicates a range of postal codes, usually defined as the set of valid codes between [[postalCodeBegin]] and [[postalCodeEnd]], inclusively.'),
(809, 1, 6, 'GovernmentBuilding', 'GovernmentBuilding', 'A government building.'),
(810, 1, 6, 'ContactPointOption', 'ContactPointOption', 'Enumerated options related to a ContactPoint.'),
(811, 1, 6, 'Message', 'Message', 'A single message from a sender to one or more organizations or people.'),
(812, 1, 6, 'Role', 'Role', 'Represents additional information about a relationship or property. For example a Role can be used to say that a \'member\' role linking some SportsTeam to a player occurred during a particular time period. Or that a Person\'s \'actor\' role in a Movie was for some particular characterName. Such properties can be attached to a Role entity, which is then associated with the main entities using ordinary properties like \'member\' or \'actor\'.\\n\\nSee also [blog post](http://blog.schema.org/2014/06/introducing-role.html).'),
(813, 1, 6, 'LearningResource', 'LearningResource', 'The LearningResource type can be used to indicate [[CreativeWork]]s (whether physical or digital) that have a particular and explicit orientation towards learning, education, skill acquisition, and other educational purposes.\n\n[[LearningResource]] is expected to be used as an addition to a primary type such as [[Book]], [[VideoObject]], [[Product]] etc.\n\n[[EducationEvent]] serves a similar purpose for event-like things (e.g. a [[Trip]]). A [[LearningResource]] may be created as a result of an [[EducationEvent]], for example by recording one.'),
(814, 1, 6, 'BedType', 'BedType', 'A type of bed. This is used for indicating the bed or beds available in an accommodation.'),
(815, 1, 6, 'MusicAlbumReleaseType', 'MusicAlbumReleaseType', 'The kind of release which this album is: single, EP or album.'),
(816, 1, 6, 'MerchantReturnPolicy', 'MerchantReturnPolicy', 'A MerchantReturnPolicy provides information about product return policies associated with an [[Organization]], [[Product]], or [[Offer]].'),
(817, 1, 6, 'GameServer', 'GameServer', 'Server that provides game interaction in a multiplayer game.'),
(818, 1, 6, 'PlaceOfWorship', 'PlaceOfWorship', 'Place of worship, such as a church, synagogue, or mosque.'),
(819, 1, 6, 'UseAction', 'UseAction', 'The act of applying an object to its intended purpose.'),
(820, 1, 6, 'Grant', 'Grant', 'A grant, typically financial or otherwise quantifiable, of resources. Typically a [[funder]] sponsors some [[MonetaryAmount]] to an [[Organization]] or [[Person]],\n    sometimes not necessarily via a dedicated or long-lived [[Project]], resulting in one or more outputs, or [[fundedItem]]s. For financial sponsorship, indicate the [[funder]] of a [[MonetaryGrant]]. For non-financial support, indicate [[sponsor]] of [[Grant]]s of resources (e.g. office space).\n\nGrants support  activities directed towards some agreed collective goals, often but not always organized as [[Project]]s. Long-lived projects are sometimes sponsored by a variety of grants over time, but it is also common for a project to be associated with a single grant.\n\nThe amount of a [[Grant]] is represented using [[amount]] as a [[MonetaryAmount]].\n    '),
(821, 1, 6, 'PerformanceRole', 'PerformanceRole', 'A PerformanceRole is a Role that some entity places with regard to a theatrical performance, e.g. in a Movie, TVSeries etc.'),
(822, 1, 6, 'SportsActivityLocation', 'SportsActivityLocation', 'A sports location, such as a playing field.'),
(823, 1, 6, 'MedicalRiskScore', 'MedicalRiskScore', 'A simple system that adds up the number of risk factors to yield a score that is associated with prognosis, e.g. CHAD score, TIMI risk score.'),
(824, 1, 6, 'Seat', 'Seat', 'Used to describe a seat, such as a reserved seat in an event reservation.'),
(825, 1, 6, 'PropertyValueSpecification', 'PropertyValueSpecification', 'A Property value specification.'),
(826, 1, 6, 'Recipe', 'Recipe', 'A recipe. For dietary restrictions covered by the recipe, a few common restrictions are enumerated via [[suitableForDiet]]. The [[keywords]] property can also be used to add more detail.'),
(827, 1, 6, 'LocationFeatureSpecification', 'LocationFeatureSpecification', 'Specifies a location feature by providing a structured value representing a feature of an accommodation as a property-value pair of varying degrees of formality.'),
(828, 1, 6, 'CreativeWorkSeason', 'CreativeWorkSeason', 'A media season, e.g. TV, radio, video game etc.'),
(829, 1, 6, 'LymphaticVessel', 'LymphaticVessel', 'A type of blood vessel that specifically carries lymph fluid unidirectionally toward the heart.'),
(830, 1, 6, 'JoinAction', 'JoinAction', 'An agent joins an event/group with participants/friends at a location.\\n\\nRelated actions:\\n\\n* [[RegisterAction]]: Unlike RegisterAction, JoinAction refers to joining a group/team of people.\\n* [[SubscribeAction]]: Unlike SubscribeAction, JoinAction does not imply that you\'ll be receiving updates.\\n* [[FollowAction]]: Unlike FollowAction, JoinAction does not imply that you\'ll be polling for updates.'),
(831, 1, 6, 'PathologyTest', 'PathologyTest', 'A medical test performed by a laboratory that typically involves examination of a tissue sample by a pathologist.'),
(832, 1, 6, 'GiveAction', 'GiveAction', 'The act of transferring ownership of an object to a destination. Reciprocal of TakeAction.\\n\\nRelated actions:\\n\\n* [[TakeAction]]: Reciprocal of GiveAction.\\n* [[SendAction]]: Unlike SendAction, GiveAction implies that ownership is being transferred (e.g. I may send my laptop to you, but that doesn\'t mean I\'m giving it to you).'),
(833, 1, 6, 'ScholarlyArticle', 'ScholarlyArticle', 'A scholarly article.'),
(834, 1, 6, 'AuthorizeAction', 'AuthorizeAction', 'The act of granting permission to an object.'),
(835, 1, 6, 'TipAction', 'TipAction', 'The act of giving money voluntarily to a beneficiary in recognition of services rendered.'),
(836, 1, 6, 'Vessel', 'Vessel', 'A component of the human body circulatory system comprised of an intricate network of hollow tubes that transport blood throughout the entire body.'),
(837, 1, 6, 'TaxiReservation', 'TaxiReservation', 'A reservation for a taxi.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, use [[Offer]].'),
(838, 1, 6, 'ImagingTest', 'ImagingTest', 'Any medical imaging modality typically used for diagnostic purposes.'),
(839, 1, 6, 'MedicalIndication', 'MedicalIndication', 'A condition or factor that indicates use of a medical therapy, including signs, symptoms, risk factors, anatomical states, etc.');
INSERT INTO `resource_class` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(840, 1, 6, 'DDxElement', 'DDxElement', 'An alternative, closely-related condition typically considered later in the differential diagnosis process along with the signs that are used to distinguish it.'),
(841, 1, 6, 'SingleFamilyResidence', 'SingleFamilyResidence', 'Residence type: Single-family home.'),
(842, 1, 6, 'GenderType', 'GenderType', 'An enumeration of genders.'),
(843, 1, 6, 'GameAvailabilityEnumeration', 'GameAvailabilityEnumeration', 'For a [[VideoGame]], such as used with a [[PlayGameAction]], an enumeration of the kind of game availability offered. '),
(844, 1, 6, 'Reservation', 'Reservation', 'Describes a reservation for travel, dining or an event. Some reservations require tickets. \\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations. For offers of tickets, restaurant reservations, flights, or rental cars, use [[Offer]].'),
(845, 1, 6, 'DonateAction', 'DonateAction', 'The act of providing goods, services, or money without compensation, often for philanthropic reasons.'),
(846, 1, 6, 'Vein', 'Vein', 'A type of blood vessel that specifically carries blood to the heart.'),
(847, 1, 6, 'MusicAlbum', 'MusicAlbum', 'A collection of music tracks.'),
(848, 1, 6, 'GamePlayMode', 'GamePlayMode', 'Indicates whether this game is multi-player, co-op or single-player.'),
(849, 1, 6, 'MeasurementTypeEnumeration', 'MeasurementTypeEnumeration', 'Enumeration of common measurement types (or dimensions), for example \"chest\" for a person, \"inseam\" for pants, \"gauge\" for screws, or \"wheel\" for bicycles.'),
(850, 1, 6, 'MolecularEntity', 'MolecularEntity', 'Any constitutionally or isotopically distinct atom, molecule, ion, ion pair, radical, radical ion, complex, conformer etc., identifiable as a separately distinguishable entity.'),
(851, 1, 6, 'EducationalOccupationalCredential', 'EducationalOccupationalCredential', 'An educational or occupational credential. A diploma, academic degree, certification, qualification, badge, etc., that may be awarded to a person or other entity that meets the requirements defined by the credentialer.'),
(852, 1, 6, 'EducationEvent', 'EducationEvent', 'Event type: Education event.'),
(853, 1, 6, 'Joint', 'Joint', 'The anatomical location at which two or more bones make contact.'),
(854, 1, 6, 'ReceiveAction', 'ReceiveAction', 'The act of physically/electronically taking delivery of an object that has been transferred from an origin to a destination. Reciprocal of SendAction.\\n\\nRelated actions:\\n\\n* [[SendAction]]: The reciprocal of ReceiveAction.\\n* [[TakeAction]]: Unlike TakeAction, ReceiveAction does not imply that the ownership has been transferred (e.g. I can receive a package, but it does not mean the package is now mine).'),
(855, 1, 6, 'DeliveryChargeSpecification', 'DeliveryChargeSpecification', 'The price for the delivery of an offer using a particular delivery method.'),
(856, 1, 6, 'ListItem', 'ListItem', 'An list item, e.g. a step in a checklist or how-to description.'),
(857, 1, 6, 'XPathType', 'XPathType', 'Text representing an XPath (typically but not necessarily version 1.0).'),
(858, 1, 6, 'VideoGame', 'VideoGame', 'A video game is an electronic game that involves human interaction with a user interface to generate visual feedback on a video device.'),
(859, 1, 6, 'WinAction', 'WinAction', 'The act of achieving victory in a competitive activity.'),
(860, 1, 6, 'BodyOfWater', 'BodyOfWater', 'A body of water, such as a sea, ocean, or lake.'),
(861, 1, 6, 'EnergyConsumptionDetails', 'EnergyConsumptionDetails', 'EnergyConsumptionDetails represents information related to the energy efficiency of a product that consumes energy. The information that can be provided is based on international regulations such as for example [EU directive 2017/1369](https://eur-lex.europa.eu/eli/reg/2017/1369/oj) for energy labeling and the [Energy labeling rule](https://www.ftc.gov/enforcement/rules/rulemaking-regulatory-reform-proceedings/energy-water-use-labeling-consumer) under the Energy Policy and Conservation Act (EPCA) in the US.'),
(862, 1, 6, 'EntryPoint', 'EntryPoint', 'An entry point, within some Web-based protocol.'),
(863, 1, 6, 'TVEpisode', 'TVEpisode', 'A TV episode which can be part of a series or season.'),
(864, 1, 6, 'MedicalSignOrSymptom', 'MedicalSignOrSymptom', 'Any feature associated or not with a medical condition. In medicine a symptom is generally subjective while a sign is objective.'),
(865, 1, 6, 'OfferItemCondition', 'OfferItemCondition', 'A list of possible conditions for the item.'),
(866, 1, 6, 'DeliveryEvent', 'DeliveryEvent', 'An event involving the delivery of an item.'),
(867, 1, 6, 'PlanAction', 'PlanAction', 'The act of planning the execution of an event/task/action/reservation/plan to a future date.'),
(868, 1, 6, 'Nerve', 'Nerve', 'A common pathway for the electrochemical nerve impulses that are transmitted along each of the axons.'),
(869, 1, 6, 'HowToTool', 'HowToTool', 'A tool used (but not consumed) when performing instructions for how to achieve a result.'),
(870, 1, 6, 'Review', 'Review', 'A review of an item - for example, of a restaurant, movie, or store.'),
(871, 1, 6, 'EUEnergyEfficiencyEnumeration', 'EUEnergyEfficiencyEnumeration', 'Enumerates the EU energy efficiency classes A-G as well as A+, A++, and A+++ as defined in EU directive 2017/1369.'),
(872, 1, 6, 'FoodEstablishment', 'FoodEstablishment', 'A food-related business.'),
(873, 1, 6, 'ParentAudience', 'ParentAudience', 'A set of characteristics describing parents, who can be interested in viewing some content.'),
(874, 1, 6, 'AggregateRating', 'AggregateRating', 'The average rating based on multiple ratings or reviews.'),
(875, 1, 6, 'CreativeWork', 'CreativeWork', 'The most generic kind of creative work, including books, movies, photographs, software programs, etc.'),
(876, 1, 6, 'HowToSection', 'HowToSection', 'A sub-grouping of steps in the instructions for how to achieve a result (e.g. steps for making a pie crust within a pie recipe).'),
(877, 1, 6, 'TrainStation', 'TrainStation', 'A train station.'),
(878, 1, 6, 'ReservationStatusType', 'ReservationStatusType', 'Enumerated status values for Reservation.'),
(879, 1, 6, 'HealthTopicContent', 'HealthTopicContent', '[[HealthTopicContent]] is [[WebContent]] that is about some aspect of a health topic, e.g. a condition, its symptoms or treatments. Such content may be comprised of several parts or sections and use different types of media. Multiple instances of [[WebContent]] (and hence [[HealthTopicContent]]) can be related using [[hasPart]] / [[isPartOf]] where there is some kind of content hierarchy, and their content described with [[about]] and [[mentions]] e.g. building upon the existing [[MedicalCondition]] vocabulary.\n  '),
(880, 1, 6, 'AutomotiveBusiness', 'AutomotiveBusiness', 'Car repair, sales, or parts.'),
(881, 1, 6, 'Residence', 'Residence', 'The place where a person lives.'),
(882, 1, 6, 'ImageObject', 'ImageObject', 'An image file.'),
(883, 1, 6, 'MedicalEnumeration', 'MedicalEnumeration', 'Enumerations related to health and the practice of medicine: A concept that is used to attribute a quality to another concept, as a qualifier, a collection of items or a listing of all of the elements of a set in medicine practice.'),
(884, 1, 6, 'MediaSubscription', 'MediaSubscription', 'A subscription which allows a user to access media including audio, video, books, etc.'),
(885, 1, 6, 'House', 'House', 'A house is a building or structure that has the ability to be occupied for habitation by humans or other creatures (source: Wikipedia, the free encyclopedia, see <a href=\"http://en.wikipedia.org/wiki/House\">http://en.wikipedia.org/wiki/House</a>).'),
(886, 1, 6, 'MedicalConditionStage', 'MedicalConditionStage', 'A stage of a medical condition, such as \'Stage IIIa\'.'),
(887, 1, 6, 'LocalBusiness', 'LocalBusiness', 'A particular physical business or branch of an organization. Examples of LocalBusiness include a restaurant, a particular branch of a restaurant chain, a branch of a bank, a medical practice, a club, a bowling alley, etc.'),
(888, 1, 6, 'Date', 'Date', 'A date value in [ISO 8601 date format](http://en.wikipedia.org/wiki/ISO_8601).'),
(889, 1, 6, 'LiveBlogPosting', 'LiveBlogPosting', 'A [[LiveBlogPosting]] is a [[BlogPosting]] intended to provide a rolling textual coverage of an ongoing event through continuous updates.'),
(890, 1, 6, 'RentalCarReservation', 'RentalCarReservation', 'A reservation for a rental car.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations.'),
(891, 1, 6, 'Apartment', 'Apartment', 'An apartment (in American English) or flat (in British English) is a self-contained housing unit (a type of residential real estate) that occupies only part of a building (source: Wikipedia, the free encyclopedia, see <a href=\"http://en.wikipedia.org/wiki/Apartment\">http://en.wikipedia.org/wiki/Apartment</a>).'),
(892, 1, 6, 'MobileApplication', 'MobileApplication', 'A software application designed specifically to work well on a mobile device such as a telephone.'),
(893, 1, 6, 'Property', 'Property', 'A property, used to indicate attributes and relationships of some Thing; equivalent to rdf:Property.'),
(894, 1, 6, 'ProductGroup', 'ProductGroup', 'A ProductGroup represents a group of [[Product]]s that vary only in certain well-described ways, such as by [[size]], [[color]], [[material]] etc.\n\nWhile a ProductGroup itself is not directly offered for sale, the various varying products that it represents can be. The ProductGroup serves as a prototype or template, standing in for all of the products who have an [[isVariantOf]] relationship to it. As such, properties (including additional types) can be applied to the ProductGroup to represent characteristics shared by each of the (possibly very many) variants. Properties that reference a ProductGroup are not included in this mechanism; neither are the following specific properties [[variesBy]], [[hasVariant]], [[url]]. '),
(895, 1, 6, 'DataCatalog', 'DataCatalog', 'A collection of datasets.'),
(896, 1, 6, 'Muscle', 'Muscle', 'A muscle is an anatomical structure consisting of a contractile form of tissue that animals use to effect movement.'),
(897, 1, 6, 'Recommendation', 'Recommendation', '[[Recommendation]] is a type of [[Review]] that suggests or proposes something as the best option or best course of action. Recommendations may be for products or services, or other concrete things, as in the case of a ranked list or product guide. A [[Guide]] may list multiple recommendations for different categories. For example, in a [[Guide]] about which TVs to buy, the author may have several [[Recommendation]]s.'),
(898, 1, 6, 'SeekToAction', 'SeekToAction', 'This is the [[Action]] of navigating to a specific [[startOffset]] timestamp within a [[VideoObject]], typically represented with a URL template structure.'),
(899, 1, 6, 'Menu', 'Menu', 'A structured representation of food or drink items available from a FoodEstablishment.'),
(900, 1, 6, 'OrganizationRole', 'OrganizationRole', 'A subclass of Role used to describe roles within organizations.'),
(901, 1, 6, 'EventAttendanceModeEnumeration', 'EventAttendanceModeEnumeration', 'An EventAttendanceModeEnumeration value is one of potentially several modes of organising an event, relating to whether it is online or offline.'),
(902, 1, 6, 'Enumeration', 'Enumeration', 'Lists or enumerations—for example, a list of cuisines or music genres, etc.'),
(903, 1, 6, 'HealthAspectEnumeration', 'HealthAspectEnumeration', 'HealthAspectEnumeration enumerates several aspects of health content online, each of which might be described using [[hasHealthAspect]] and [[HealthTopicContent]].'),
(904, 1, 6, 'PeopleAudience', 'PeopleAudience', 'A set of characteristics belonging to people, e.g. who compose an item\'s target audience.'),
(905, 1, 6, 'BusinessFunction', 'BusinessFunction', 'The business function specifies the type of activity or access (i.e., the bundle of rights) offered by the organization or business person through the offer. Typical are sell, rental or lease, maintenance or repair, manufacture / produce, recycle / dispose, engineering / construction, or installation. Proprietary specifications of access rights are also instances of this class.\\n\\nCommonly used values:\\n\\n* http://purl.org/goodrelations/v1#ConstructionInstallation\\n* http://purl.org/goodrelations/v1#Dispose\\n* http://purl.org/goodrelations/v1#LeaseOut\\n* http://purl.org/goodrelations/v1#Maintain\\n* http://purl.org/goodrelations/v1#ProvideService\\n* http://purl.org/goodrelations/v1#Repair\\n* http://purl.org/goodrelations/v1#Sell\\n* http://purl.org/goodrelations/v1#Buy\n        '),
(906, 1, 6, 'EventStatusType', 'EventStatusType', 'EventStatusType is an enumeration type whose instances represent several states that an Event may be in.'),
(907, 1, 6, 'Landform', 'Landform', 'A landform or physical feature.  Landform elements include mountains, plains, lakes, rivers, seascape and oceanic waterbody interface features such as bays, peninsulas, seas and so forth, including sub-aqueous terrain features such as submersed mountain ranges, volcanoes, and the great ocean basins.'),
(908, 1, 6, 'FindAction', 'FindAction', 'The act of finding an object.\\n\\nRelated actions:\\n\\n* [[SearchAction]]: FindAction is generally lead by a SearchAction, but not necessarily.'),
(909, 1, 6, 'RadioChannel', 'RadioChannel', 'A unique instance of a radio BroadcastService on a CableOrSatelliteService lineup.'),
(910, 1, 6, 'MedicalEvidenceLevel', 'MedicalEvidenceLevel', 'Level of evidence for a medical guideline. Enumerated type.'),
(911, 1, 6, 'MusicAlbumProductionType', 'MusicAlbumProductionType', 'Classification of the album by its type of content: soundtrack, live album, studio album, etc.'),
(912, 1, 6, 'Airport', 'Airport', 'An airport.'),
(913, 1, 6, 'HealthInsurancePlan', 'HealthInsurancePlan', 'A US-style health insurance plan, including PPOs, EPOs, and HMOs. '),
(914, 1, 6, 'AddAction', 'AddAction', 'The act of editing by adding an object to a collection.'),
(915, 1, 6, 'MedicalStudyStatus', 'MedicalStudyStatus', 'The status of a medical study. Enumerated type.'),
(916, 1, 6, 'TransferAction', 'TransferAction', 'The act of transferring/moving (abstract or concrete) animate or inanimate objects from one place to another.'),
(917, 1, 6, 'EndorseAction', 'EndorseAction', 'An agent approves/certifies/likes/supports/sanctions an object.'),
(918, 1, 6, 'DiagnosticLab', 'DiagnosticLab', 'A medical laboratory that offers on-site or off-site diagnostic services.'),
(919, 1, 6, 'WebPage', 'WebPage', 'A web page. Every web page is implicitly assumed to be declared to be of type WebPage, so the various properties about that webpage, such as <code>breadcrumb</code> may be used. We recommend explicit declaration if these properties are specified, but if they are found outside of an itemscope, they will be assumed to be about the page.'),
(920, 1, 6, 'Number', 'Number', 'Data type: Number.\\n\\nUsage guidelines:\\n\\n* Use values from 0123456789 (Unicode \'DIGIT ZERO\' (U+0030) to \'DIGIT NINE\' (U+0039)) rather than superficially similar Unicode symbols.\\n* Use \'.\' (Unicode \'FULL STOP\' (U+002E)) rather than \',\' to indicate a decimal point. Avoid using these symbols as a readability separator.'),
(921, 1, 6, 'InformAction', 'InformAction', 'The act of notifying someone of information pertinent to them, with no expectation of a response.'),
(922, 1, 6, 'Suite', 'Suite', 'A suite in a hotel or other public accommodation, denotes a class of luxury accommodations, the key feature of which is multiple rooms (source: Wikipedia, the free encyclopedia, see <a href=\"http://en.wikipedia.org/wiki/Suite_(hotel)\">http://en.wikipedia.org/wiki/Suite_(hotel)</a>).\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(923, 1, 6, 'DoseSchedule', 'DoseSchedule', 'A specific dosing schedule for a drug or supplement.'),
(924, 1, 6, 'VisualArtwork', 'VisualArtwork', 'A work of art that is primarily visual in character.'),
(925, 1, 6, 'GeoCircle', 'GeoCircle', 'A GeoCircle is a GeoShape representing a circular geographic area. As it is a GeoShape\n          it provides the simple textual property \'circle\', but also allows the combination of postalCode alongside geoRadius.\n          The center of the circle can be indicated via the \'geoMidpoint\' property, or more approximately using \'address\', \'postalCode\'.\n       '),
(926, 1, 6, 'MediaObject', 'MediaObject', 'A media object, such as an image, video, or audio object embedded in a web page or a downloadable dataset, i.e. DataDownload. Note that a creative work may have many media objects associated with it on the same web page. For example, a page about a single song (MusicRecording) may have a music video (VideoObject), and a high and low bandwidth audio stream (2 [[AudioObject]]s).'),
(927, 1, 6, 'GeoCoordinates', 'GeoCoordinates', 'The geographic coordinates of a place or event.'),
(928, 1, 6, 'MedicalScholarlyArticle', 'MedicalScholarlyArticle', 'A scholarly article in the medical domain.'),
(929, 1, 6, 'MedicalCode', 'MedicalCode', 'A code for a medical entity.'),
(930, 1, 6, 'DigitalDocumentPermissionType', 'DigitalDocumentPermissionType', 'A type of permission which can be granted for accessing a digital document.'),
(931, 1, 6, 'JobPosting', 'JobPosting', 'A listing that describes a job opening in a certain organization.'),
(932, 1, 6, 'DrugCost', 'DrugCost', 'The cost per unit of a medical drug. Note that this type is not meant to represent the price in an offer of a drug for sale; see the Offer type for that. This type will typically be used to tag wholesale or average retail cost of a drug, or maximum reimbursable cost. Costs of medical drugs vary widely depending on how and where they are paid for, so while this type captures some of the variables, costs should be used with caution by consumers of this schema\'s markup.'),
(933, 1, 6, 'DrugPrescriptionStatus', 'DrugPrescriptionStatus', 'Indicates whether this drug is available by prescription or over-the-counter.'),
(934, 1, 6, 'NutritionInformation', 'NutritionInformation', 'Nutritional information about the recipe.'),
(935, 1, 6, 'PostalAddress', 'PostalAddress', 'The mailing address.'),
(936, 1, 6, 'Thing', 'Thing', 'The most generic type of item.'),
(937, 1, 6, 'BroadcastEvent', 'BroadcastEvent', 'An over the air or online broadcast event.'),
(938, 1, 6, 'ServiceChannel', 'ServiceChannel', 'A means for accessing a service, e.g. a government office location, web site, or phone number.'),
(939, 1, 6, 'LoseAction', 'LoseAction', 'The act of being defeated in a competitive activity.'),
(940, 1, 6, 'BlogPosting', 'BlogPosting', 'A blog post.'),
(941, 1, 6, 'ReviewAction', 'ReviewAction', 'The act of producing a balanced opinion about the object for an audience. An agent reviews an object with participants resulting in a review.'),
(942, 1, 6, 'RadioSeries', 'RadioSeries', 'CreativeWorkSeries dedicated to radio broadcast and associated online delivery.'),
(943, 1, 6, 'HotelRoom', 'HotelRoom', 'A hotel room is a single room in a hotel.\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(944, 1, 6, 'Specialty', 'Specialty', 'Any branch of a field in which people typically develop specific expertise, usually after significant study, time, and effort.'),
(945, 1, 6, 'MusicGroup', 'MusicGroup', 'A musical group, such as a band, an orchestra, or a choir. Can also be a solo musician.'),
(946, 1, 6, 'ProductModel', 'ProductModel', 'A datasheet or vendor specification of a product (in the sense of a prototypical description).'),
(947, 1, 6, 'Intangible', 'Intangible', 'A utility class that serves as the umbrella for a number of \'intangible\' things such as quantities, structured values, etc.'),
(948, 1, 6, 'Integer', 'Integer', 'Data type: Integer.'),
(949, 1, 6, 'EngineSpecification', 'EngineSpecification', 'Information about the engine of the vehicle. A vehicle can have multiple engines represented by multiple engine specification entities.'),
(950, 1, 6, 'AggregateOffer', 'AggregateOffer', 'When a single product is associated with multiple offers (for example, the same pair of shoes is offered by different merchants), then AggregateOffer can be used.\\n\\nNote: AggregateOffers are normally expected to associate multiple offers that all share the same defined [[businessFunction]] value, or default to http://purl.org/goodrelations/v1#Sell if businessFunction is not explicitly defined.'),
(951, 1, 6, 'ComputerLanguage', 'ComputerLanguage', 'This type covers computer programming languages such as Scheme and Lisp, as well as other language-like computer representations. Natural languages are best represented with the [[Language]] type.'),
(952, 1, 6, 'MedicalIntangible', 'MedicalIntangible', 'A utility class that serves as the umbrella for a number of \'intangible\' things in the medical space.'),
(953, 1, 6, 'HowTo', 'HowTo', 'Instructions that explain how to achieve a result by performing a sequence of steps.'),
(954, 1, 6, 'Series', 'Series', 'A Series in schema.org is a group of related items, typically but not necessarily of the same kind. See also [[CreativeWorkSeries]], [[EventSeries]].'),
(955, 1, 6, 'OfferShippingDetails', 'OfferShippingDetails', 'OfferShippingDetails represents information about shipping destinations.\n\nMultiple of these entities can be used to represent different shipping rates for different destinations:\n\nOne entity for Alaska/Hawaii. A different one for continental US. A different one for all France.\n\nMultiple of these entities can be used to represent different shipping costs and delivery times.\n\nTwo entities that are identical but differ in rate and time:\n\nE.g. Cheaper and slower: $5 in 5-7 days\nor Fast and expensive: $15 in 1-2 days.'),
(956, 1, 6, 'LifestyleModification', 'LifestyleModification', 'A process of care involving exercise, changes to diet, fitness routines, and other lifestyle changes aimed at improving a health condition.'),
(957, 1, 6, 'BookFormatType', 'BookFormatType', 'The publication format of the book.'),
(958, 1, 6, 'EducationalAudience', 'EducationalAudience', 'An EducationalAudience.'),
(959, 1, 6, 'CommentAction', 'CommentAction', 'The act of generating a comment about a subject.'),
(960, 1, 6, 'MedicalDevice', 'MedicalDevice', 'Any object used in a medical capacity, such as to diagnose or treat a patient.'),
(961, 1, 6, 'DefinedTerm', 'DefinedTerm', 'A word, name, acronym, phrase, etc. with a formal definition. Often used in the context of category or subject classification, glossaries or dictionaries, product or creative work types, etc. Use the name property for the term being defined, use termCode if the term has an alpha-numeric code allocated, use description to provide the definition of the term.'),
(962, 1, 6, 'VideoGameSeries', 'VideoGameSeries', 'A video game series.'),
(963, 1, 6, 'MedicalTherapy', 'MedicalTherapy', 'Any medical intervention designed to prevent, treat, and cure human diseases and medical conditions, including both curative and palliative therapies. Medical therapies are typically processes of care relying upon pharmacotherapy, behavioral therapy, supportive therapy (with fluid or nutrition for example), or detoxification (e.g. hemodialysis) aimed at improving or preventing a health condition.'),
(964, 1, 6, 'OrganizeAction', 'OrganizeAction', 'The act of manipulating/administering/supervising/controlling one or more objects.'),
(965, 1, 6, 'RealEstateListing', 'RealEstateListing', 'A [[RealEstateListing]] is a listing that describes one or more real-estate [[Offer]]s (whose [[businessFunction]] is typically to lease out, or to sell).\n  The [[RealEstateListing]] type itself represents the overall listing, as manifested in some [[WebPage]].\n  '),
(966, 1, 6, 'MedicalBusiness', 'MedicalBusiness', 'A particular physical or virtual business of an organization for medical purposes. Examples of MedicalBusiness include different businesses run by health professionals.'),
(967, 1, 6, 'UpdateAction', 'UpdateAction', 'The act of managing by changing/editing the state of the object.'),
(968, 1, 6, 'BorrowAction', 'BorrowAction', 'The act of obtaining an object under an agreement to return it at a later date. Reciprocal of LendAction.\\n\\nRelated actions:\\n\\n* [[LendAction]]: Reciprocal of BorrowAction.'),
(969, 1, 6, 'MedicalTrial', 'MedicalTrial', 'A medical trial is a type of medical study that uses a scientific process to compare the safety and efficacy of medical therapies or medical procedures. In general, medical trials are controlled and subjects are allocated at random to the different treatment and/or control groups.'),
(970, 1, 6, 'VirtualLocation', 'VirtualLocation', 'An online or virtual location for attending events. For example, one may attend an online seminar or educational event. While a virtual location may be used as the location of an event, virtual locations should not be confused with physical locations in the real world.'),
(971, 1, 6, 'SizeSpecification', 'SizeSpecification', 'Size related properties of a product, typically a size code ([[name]]) and optionally a [[sizeSystem]], [[sizeGroup]], and product measurements ([[hasMeasurement]]). In addition, the intended audience can be defined through [[suggestedAge]], [[suggestedGender]], and suggested body measurements ([[suggestedMeasurement]]).'),
(972, 1, 6, 'Physician', 'Physician', 'A doctor\'s office.'),
(973, 1, 6, 'SuperficialAnatomy', 'SuperficialAnatomy', 'Anatomical features that can be observed by sight (without dissection), including the form and proportions of the human body as well as surface landmarks that correspond to deeper subcutaneous structures. Superficial anatomy plays an important role in sports medicine, phlebotomy, and other medical specialties as underlying anatomical structures can be identified through surface palpation. For example, during back surgery, superficial anatomy can be used to palpate and count vertebrae to find the site of incision. Or in phlebotomy, superficial anatomy can be used to locate an underlying vein; for example, the median cubital vein can be located by palpating the borders of the cubital fossa (such as the epicondyles of the humerus) and then looking for the superficial signs of the vein, such as size, prominence, ability to refill after depression, and feel of surrounding tissue support. As another example, in a subluxation (dislocation) of the glenohumeral joint, the bony structure becomes pronounced with the deltoid muscle failing to cover the glenohumeral joint allowing the edges of the scapula to be superficially visible. Here, the superficial anatomy is the visible edges of the scapula, implying the underlying dislocation of the joint (the related anatomical structure).'),
(974, 1, 6, 'ProgramMembership', 'ProgramMembership', 'Used to describe membership in a loyalty programs (e.g. \"StarAliance\"), traveler clubs (e.g. \"AAA\"), purchase clubs (\"Safeway Club\"), etc.'),
(975, 1, 6, 'UserComments', 'UserComments', 'UserInteraction and its subtypes is an old way of talking about users interacting with pages. It is generally better to use [[Action]]-based vocabulary, alongside types such as [[Comment]].'),
(976, 1, 6, 'EntertainmentBusiness', 'EntertainmentBusiness', 'A business providing entertainment.'),
(977, 1, 6, 'SizeGroupEnumeration', 'SizeGroupEnumeration', 'Enumerates common size groups for various product categories.'),
(978, 1, 6, 'Episode', 'Episode', 'A media episode (e.g. TV, radio, video game) which can be part of a series or season.'),
(979, 1, 6, 'CourseInstance', 'CourseInstance', 'An instance of a [[Course]] which is distinct from other instances because it is offered at a different time or location or through different media or modes of study or to a specific section of students.'),
(980, 1, 6, 'Room', 'Room', 'A room is a distinguishable space within a structure, usually separated from other spaces by interior walls (source: Wikipedia, the free encyclopedia, see <a href=\"http://en.wikipedia.org/wiki/Room\">http://en.wikipedia.org/wiki/Room</a>).\n<br /><br />\nSee also the <a href=\"/docs/hotels.html\">dedicated document on the use of schema.org for marking up hotels and other forms of accommodations</a>.\n'),
(981, 1, 6, 'Energy', 'Energy', 'Properties that take Energy as values are of the form \'&lt;Number&gt; &lt;Energy unit of measure&gt;\'.'),
(982, 1, 6, 'FoodEstablishmentReservation', 'FoodEstablishmentReservation', 'A reservation to dine at a food-related business.\\n\\nNote: This type is for information about actual reservations, e.g. in confirmation emails or HTML pages with individual confirmations of reservations.'),
(983, 1, 6, 'BusOrCoach', 'BusOrCoach', 'A bus (also omnibus or autobus) is a road vehicle designed to carry passengers. Coaches are luxury busses, usually in service for long distance travel.'),
(984, 1, 6, 'Clip', 'Clip', 'A short TV or radio program or a segment/part of a program.'),
(985, 1, 6, 'MedicalRiskEstimator', 'MedicalRiskEstimator', 'Any rule set or interactive tool for estimating the risk of developing a complication or condition.'),
(986, 1, 6, 'Church', 'Church', 'A church.'),
(987, 1, 6, 'SportsTeam', 'SportsTeam', 'Organization: Sports team.'),
(988, 1, 6, 'FoodEvent', 'FoodEvent', 'Event type: Food event.'),
(989, 1, 6, 'TVClip', 'TVClip', 'A short TV program or a segment/part of a TV program.'),
(990, 1, 6, 'MusicPlaylist', 'MusicPlaylist', 'A collection of music tracks in playlist form.'),
(991, 1, 6, 'CreativeWorkSeries', 'CreativeWorkSeries', 'A CreativeWorkSeries in schema.org is a group of related items, typically but not necessarily of the same kind. CreativeWorkSeries are usually organized into some order, often chronological. Unlike [[ItemList]] which is a general purpose data structure for lists of things, the emphasis with CreativeWorkSeries is on published materials (written e.g. books and periodicals, or media such as TV, radio and games).\\n\\nSpecific subtypes are available for describing [[TVSeries]], [[RadioSeries]], [[MovieSeries]], [[BookSeries]], [[Periodical]] and [[VideoGameSeries]]. In each case, the [[hasPart]] / [[isPartOf]] properties can be used to relate the CreativeWorkSeries to its parts. The general CreativeWorkSeries type serves largely just to organize these more specific and practical subtypes.\\n\\nIt is common for properties applicable to an item from the series to be usefully applied to the containing group. Schema.org attempts to anticipate some of these cases, but publishers should be free to apply properties of the series parts to the series as a whole wherever they seem appropriate.\n	  '),
(992, 1, 6, 'BusinessAudience', 'BusinessAudience', 'A set of characteristics belonging to businesses, e.g. who compose an item\'s target audience.'),
(993, 1, 6, 'Quantity', 'Quantity', 'Quantities such as distance, time, mass, weight, etc. Particular instances of say Mass are entities like \'3 kg\' or \'4 milligrams\'.'),
(994, 1, 6, 'PlayAction', 'PlayAction', 'The act of playing/exercising/training/performing for enjoyment, leisure, recreation, competition or exercise.\\n\\nRelated actions:\\n\\n* [[ListenAction]]: Unlike ListenAction (which is under ConsumeAction), PlayAction refers to performing for an audience or at an event, rather than consuming music.\\n* [[WatchAction]]: Unlike WatchAction (which is under ConsumeAction), PlayAction refers to showing/displaying for an audience or at an event, rather than consuming visual content.'),
(995, 1, 6, 'WebSite', 'WebSite', 'A WebSite is a set of related web pages and other items typically served from a single web domain and accessible via URLs.'),
(996, 1, 6, 'DigitalDocument', 'DigitalDocument', 'An electronic file or document.'),
(997, 1, 6, 'ContactPoint', 'ContactPoint', 'A contact point&#x2014;for example, a Customer Complaints department.'),
(998, 1, 6, 'VoteAction', 'VoteAction', 'The act of expressing a preference from a fixed/finite/structured set of choices/options.'),
(999, 1, 7, 'Jurisdiction', 'Jurisdiction', 'the legal jurisdiction of a license'),
(1000, 1, 7, 'License', 'License', 'a set of requests/permissions to users of a Work, e.g. a copyright license, the public domain, information for distributors'),
(1001, 1, 7, 'Permission', 'Permission', 'an action that may or may not be allowed or desired'),
(1002, 1, 7, 'Prohibition', 'Prohibition', 'something you may be asked not to do'),
(1003, 1, 7, 'Requirement', 'Requirement', 'an action that may or may not be requested of you'),
(1004, 1, 7, 'Work', 'Work', 'a potentially copyrightable work'),
(1005, 1, 8, 'DescriptionLevel', 'Description level', NULL),
(1006, 1, 8, 'Relationship', 'Relationship', NULL),
(1007, 1, 8, 'Work', 'Work', NULL),
(1008, 1, 8, 'Instance', 'Instance', NULL),
(1009, 1, 8, 'Item', 'Item', NULL),
(1010, 1, 8, 'Hub', 'Hub', NULL),
(1011, 1, 8, 'Text', 'Text', NULL),
(1012, 1, 8, 'Cartography', 'Cartography', NULL),
(1013, 1, 8, 'Audio', 'Audio', NULL),
(1014, 1, 8, 'NotatedMusic', 'Notated music', NULL),
(1015, 1, 8, 'NotatedMovement', 'Notated movement', NULL),
(1016, 1, 8, 'Dataset', 'Dataset', NULL),
(1017, 1, 8, 'StillImage', 'Still image', NULL),
(1018, 1, 8, 'MovingImage', 'Moving image', NULL),
(1019, 1, 8, 'Object', 'Three-dimensional object', NULL),
(1020, 1, 8, 'Multimedia', 'Software or multimedia', NULL),
(1021, 1, 8, 'MixedMaterial', 'Mixed material', NULL),
(1022, 1, 8, 'Print', 'Printed', NULL),
(1023, 1, 8, 'Manuscript', 'Manuscript', NULL),
(1024, 1, 8, 'Archival', 'Archival controlled', NULL),
(1025, 1, 8, 'Tactile', 'Tactile material', NULL),
(1026, 1, 8, 'Collection', 'Collection', NULL),
(1027, 1, 8, 'Electronic', 'Electronic', NULL),
(1028, 1, 8, 'Arrangement', 'Arrangement', NULL),
(1029, 1, 8, 'MusicAudio', 'Music audio', NULL),
(1030, 1, 8, 'NonMusicAudio', 'Non-music audio', NULL),
(1031, 1, 8, 'Integrating', 'Integrating resource', NULL),
(1032, 1, 8, 'Kit', 'Kit', NULL),
(1033, 1, 8, 'Monograph', 'Monograph', NULL),
(1034, 1, 8, 'Serial', 'Serial', NULL),
(1035, 1, 8, 'Series', 'Series', NULL),
(1036, 1, 8, 'Microform', 'Microform', NULL),
(1037, 1, 8, 'Note', 'Note', NULL),
(1038, 1, 8, 'Identifier', 'Identifier', NULL),
(1039, 1, 8, 'Unit', 'Unit', NULL),
(1040, 1, 8, 'Role', 'Role', NULL),
(1041, 1, 8, 'Source', 'Source', NULL),
(1042, 1, 8, 'Status', 'Status', NULL),
(1043, 1, 8, 'Relation', 'Relation', NULL),
(1044, 1, 8, 'Agent', 'Agent', NULL),
(1045, 1, 8, 'Person', 'Person', NULL),
(1046, 1, 8, 'Family', 'Family', NULL),
(1047, 1, 8, 'Organization', 'Organization', NULL),
(1048, 1, 8, 'Jurisdiction', 'Jurisdiction', NULL),
(1049, 1, 8, 'Meeting', 'Meeting', NULL),
(1050, 1, 8, 'Topic', 'Topic', NULL),
(1051, 1, 8, 'Temporal', 'Temporal concept', NULL),
(1052, 1, 8, 'Place', 'Place', NULL),
(1053, 1, 8, 'Event', 'Event entity', NULL),
(1054, 1, 8, 'Contribution', 'Contribution', NULL),
(1055, 1, 8, 'PrimaryContribution', 'Primary contribution', NULL),
(1056, 1, 8, 'Content', 'Content type', NULL),
(1057, 1, 8, 'Media', 'Media type', NULL),
(1058, 1, 8, 'Carrier', 'Carrier type', NULL),
(1059, 1, 8, 'GenreForm', 'Genre/form', NULL),
(1060, 1, 8, 'Title', 'Title entity', NULL),
(1061, 1, 8, 'VariantTitle', 'Title variation', NULL),
(1062, 1, 8, 'KeyTitle', 'Key title', NULL),
(1063, 1, 8, 'AbbreviatedTitle', 'Abbreviated title', NULL),
(1064, 1, 8, 'ParallelTitle', 'Parallel title proper', NULL),
(1065, 1, 8, 'CollectiveTitle', 'Collective title', NULL),
(1066, 1, 8, 'TransliteratedTitle', 'Transliterated title', NULL),
(1067, 1, 8, 'Language', 'Language entity', NULL),
(1068, 1, 8, 'MusicMedium', 'Music medium information', NULL),
(1069, 1, 8, 'MusicInstrument', 'Musical instrument', NULL),
(1070, 1, 8, 'Ensemble', 'Ensemble', NULL),
(1071, 1, 8, 'MusicEnsemble', 'Music ensemble', NULL),
(1072, 1, 8, 'MusicVoice', 'Music voice', NULL),
(1073, 1, 8, 'GeographicCoverage', 'Geographic coverage', NULL),
(1074, 1, 8, 'IntendedAudience', 'Intended audience information', NULL),
(1075, 1, 8, 'CollectionArrangement', 'Organization of materials information', NULL),
(1076, 1, 8, 'Dissertation', 'Dissertation information', NULL),
(1077, 1, 8, 'Summary', 'Summary', NULL),
(1078, 1, 8, 'Capture', 'Capture of content', NULL),
(1079, 1, 8, 'Notation', 'Notation', NULL),
(1080, 1, 8, 'ContentAccessibility', 'Content accessibility information', NULL),
(1081, 1, 8, 'Script', 'Script', NULL),
(1082, 1, 8, 'MusicNotation', 'Music notation', NULL),
(1083, 1, 8, 'TactileNotation', 'Tactile notation', NULL),
(1084, 1, 8, 'MovementNotation', 'Movement notation', NULL),
(1085, 1, 8, 'Illustration', 'Illustrative content', NULL),
(1086, 1, 8, 'SupplementaryContent', 'Supplementary material', NULL),
(1087, 1, 8, 'ColorContent', 'Color content', NULL),
(1088, 1, 8, 'SoundContent', 'Sound content', NULL),
(1089, 1, 8, 'AspectRatio', 'Aspect ratio', NULL),
(1090, 1, 8, 'MusicFormat', 'Notated music format', NULL),
(1091, 1, 8, 'Scale', 'Scale', NULL),
(1092, 1, 8, 'Cartographic', 'Cartographic information', NULL),
(1093, 1, 8, 'Projection', 'Projection', NULL),
(1094, 1, 8, 'Classification', 'Classification entity', NULL),
(1095, 1, 8, 'ClassificationDdc', 'DDC Classification', NULL),
(1096, 1, 8, 'ClassificationLcc', 'LCC Classification', NULL),
(1097, 1, 8, 'ClassificationUdc', 'UDC Classification', NULL),
(1098, 1, 8, 'ClassificationNlm', 'NLM classification', NULL),
(1099, 1, 8, 'ClassificationNal', 'NAL classification', NULL),
(1100, 1, 8, 'Frequency', 'Frequency', NULL),
(1101, 1, 8, 'PubFrequency', 'Publication Frequency', NULL),
(1102, 1, 8, 'Issuance', 'Mode of issuance', NULL),
(1103, 1, 8, 'ProvisionActivity', 'Provider entity', NULL),
(1104, 1, 8, 'Distribution', 'Distributor', NULL),
(1105, 1, 8, 'Manufacture', 'Manufacturer', NULL),
(1106, 1, 8, 'Publication', 'Publisher', NULL),
(1107, 1, 8, 'Production', 'Producer', NULL),
(1108, 1, 8, 'Modification', 'Modification', NULL),
(1109, 1, 8, 'AcquisitionSource', 'Acquisition source', NULL),
(1110, 1, 8, 'CopyrightRegistration', 'Copyright registration', NULL),
(1111, 1, 8, 'CoverArt', 'Cover art', NULL),
(1112, 1, 8, 'Review', 'Review', NULL),
(1113, 1, 8, 'TableOfContents', 'Table of contents', NULL),
(1114, 1, 8, 'Relief', 'Relief', NULL),
(1115, 1, 8, 'CaptureStorage', 'Capture and Storage Technique', NULL),
(1116, 1, 8, 'Extent', 'Extent', NULL),
(1117, 1, 8, 'Material', 'Material', NULL),
(1118, 1, 8, 'BaseMaterial', 'Base material', NULL),
(1119, 1, 8, 'AppliedMaterial', 'Applied material', NULL),
(1120, 1, 8, 'Emulsion', 'Emulsion', NULL),
(1121, 1, 8, 'Mount', 'Mount', NULL),
(1122, 1, 8, 'ProductionMethod', 'Production method', NULL),
(1123, 1, 8, 'Generation', 'Generation', NULL),
(1124, 1, 8, 'Layout', 'Layout', NULL),
(1125, 1, 8, 'BookFormat', 'Book format', NULL),
(1126, 1, 8, 'FontSize', 'Font size', NULL),
(1127, 1, 8, 'Polarity', 'Polarity', NULL),
(1128, 1, 8, 'ReductionRatio', 'Reduction ratio', NULL),
(1129, 1, 8, 'Binding', 'Binding method', NULL),
(1130, 1, 8, 'SoundCharacteristic', 'Sound characteristic', NULL),
(1131, 1, 8, 'RecordingMethod', 'Type of recording', NULL),
(1132, 1, 8, 'RecordingMedium', 'Recording medium', NULL),
(1133, 1, 8, 'PlayingSpeed', 'Playing speed', NULL),
(1134, 1, 8, 'GrooveCharacteristic', 'Groove characteristic', NULL),
(1135, 1, 8, 'TrackConfig', 'Track configuration', NULL),
(1136, 1, 8, 'TapeConfig', 'Tape configuration', NULL),
(1137, 1, 8, 'PlaybackChannels', 'Configuration of playback channels', NULL),
(1138, 1, 8, 'PlaybackCharacteristic', 'Special playback characteristics', NULL),
(1139, 1, 8, 'ProjectionCharacteristic', 'Projection characteristic', NULL),
(1140, 1, 8, 'PresentationFormat', 'Presentation format', NULL),
(1141, 1, 8, 'ProjectionSpeed', 'Projection speed', NULL),
(1142, 1, 8, 'VideoCharacteristic', 'Video characteristic', NULL),
(1143, 1, 8, 'VideoFormat', 'Video format', NULL),
(1144, 1, 8, 'BroadcastStandard', 'Broadcast standard', NULL),
(1145, 1, 8, 'DigitalCharacteristic', 'Digital characteristic', NULL),
(1146, 1, 8, 'FileType', 'File type', NULL),
(1147, 1, 8, 'EncodingFormat', 'Encoding format', NULL),
(1148, 1, 8, 'FileSize', 'File size', NULL),
(1149, 1, 8, 'Resolution', 'Resolution', NULL),
(1150, 1, 8, 'RegionalEncoding', 'Regional encoding', NULL),
(1151, 1, 8, 'EncodedBitrate', 'Encoded bitrate', NULL),
(1152, 1, 8, 'CartographicDataType', 'Digital cartographic data type', NULL),
(1153, 1, 8, 'CartographicObjectType', 'Digital cartographic object type', NULL),
(1154, 1, 8, 'ObjectCount', 'Digital cartographic object count', NULL),
(1155, 1, 8, 'SystemRequirement', 'System Requirement', NULL),
(1156, 1, 8, 'EnumerationAndChronology', 'Enumeration and chronology', NULL),
(1157, 1, 8, 'Enumeration', 'Enumeration', NULL),
(1158, 1, 8, 'Chronology', 'Chronology', NULL),
(1159, 1, 8, 'Sublocation', 'Sublocation', NULL),
(1160, 1, 8, 'ShelfMark', 'Shelf location', NULL),
(1161, 1, 8, 'ShelfMarkDdc', 'DDC call number', NULL),
(1162, 1, 8, 'ShelfMarkLcc', 'LCC call number', NULL),
(1163, 1, 8, 'ShelfMarkUdc', 'UDC call number', NULL),
(1164, 1, 8, 'ShelfMarkNlm', 'NLM call number', NULL),
(1165, 1, 8, 'UsageAndAccessPolicy', 'Use and access conditions', NULL),
(1166, 1, 8, 'AccessPolicy', 'Access policy', NULL),
(1167, 1, 8, 'UsePolicy', 'Use policy', NULL),
(1168, 1, 8, 'RetentionPolicy', 'Retention policy', NULL),
(1169, 1, 8, 'ImmediateAcquisition', 'Immediate acquisition', NULL),
(1170, 1, 8, 'AccessionNumber', 'Accession number', NULL),
(1171, 1, 8, 'Ansi', 'ANSI number', NULL),
(1172, 1, 8, 'AudioIssueNumber', 'Audio issue number', NULL),
(1173, 1, 8, 'AudioTake', 'Audio recording take', NULL),
(1174, 1, 8, 'Barcode', 'Barcode', NULL),
(1175, 1, 8, 'Coden', 'CODEN', NULL),
(1176, 1, 8, 'CopyrightNumber', 'Copyright-legal deposit number', NULL),
(1177, 1, 8, 'DissertationIdentifier', 'Dissertation Identifier', NULL),
(1178, 1, 8, 'Doi', 'DOI', NULL),
(1179, 1, 8, 'Ean', 'EAN', NULL),
(1180, 1, 8, 'Eidr', 'EIDR', NULL),
(1181, 1, 8, 'Fingerprint', 'Fingerprint identifier', NULL),
(1182, 1, 8, 'Gtin14Number', 'Global Trade Item Number 14', NULL),
(1183, 1, 8, 'Hdl', 'Handle', NULL),
(1184, 1, 8, 'Isan', 'ISAN', NULL),
(1185, 1, 8, 'Isbn', 'ISBN', NULL),
(1186, 1, 8, 'Ismn', 'ISMN', NULL),
(1187, 1, 8, 'Isni', 'ISNI', NULL),
(1188, 1, 8, 'Iso', 'ISO number', NULL),
(1189, 1, 8, 'Isrc', 'ISRC', NULL),
(1190, 1, 8, 'Issn', 'ISSN', NULL),
(1191, 1, 8, 'IssnL', 'ISSN-L', NULL),
(1192, 1, 8, 'Istc', 'ISTC', NULL),
(1193, 1, 8, 'Iswc', 'ISWC', NULL),
(1194, 1, 8, 'LcOverseasAcq', 'LC acquisition program', NULL),
(1195, 1, 8, 'Lccn', 'LCCN', NULL),
(1196, 1, 8, 'Local', 'Local identifier', NULL),
(1197, 1, 8, 'MatrixNumber', 'Audio matrix number', NULL),
(1198, 1, 8, 'MusicDistributorNumber', 'Music distributor number', NULL),
(1199, 1, 8, 'MusicPlate', 'Music plate number', NULL),
(1200, 1, 8, 'MusicPublisherNumber', 'Music publisher number', NULL),
(1201, 1, 8, 'Nbn', 'NBN', NULL),
(1202, 1, 8, 'OclcNumber', 'OCLC number', NULL),
(1203, 1, 8, 'PostalRegistration', 'Postal registration number', NULL),
(1204, 1, 8, 'PublisherNumber', 'Publisher number', NULL),
(1205, 1, 8, 'ReportNumber', 'Technical report number', NULL),
(1206, 1, 8, 'Sici', 'SICI', NULL),
(1207, 1, 8, 'StockNumber', 'Stock number', NULL),
(1208, 1, 8, 'Strn', 'STRN', NULL),
(1209, 1, 8, 'StudyNumber', 'Study number', NULL),
(1210, 1, 8, 'Upc', 'UPC', NULL),
(1211, 1, 8, 'Urn', 'URN', NULL),
(1212, 1, 8, 'VideoRecordingNumber', 'Video recording number', NULL),
(1213, 1, 8, 'AdminMetadata', 'Administrative metadata', NULL),
(1214, 1, 8, 'DescriptionConventions', 'Description conventions', NULL),
(1215, 1, 8, 'GenerationProcess', 'Generation process', NULL),
(1216, 1, 8, 'DescriptionAuthentication', 'Metadata authentication', NULL),
(1217, 1, 9, 'ConferenceOrEvent', 'Conference or Event', NULL),
(1218, 1, 9, 'CorporateBody', 'Corporate Body', NULL),
(1219, 1, 9, 'DifferentiatedPerson', 'Differentiated person', NULL),
(1220, 1, 9, 'Family', 'Family', NULL),
(1221, 1, 9, 'PlaceOrGeographicName', 'Place or geographic name', NULL),
(1222, 1, 9, 'SubjectHeading', 'Subject heading', NULL),
(1223, 1, 9, 'Work', 'Work', NULL),
(1224, 1, 9, 'AdministrativeUnit', 'Administrative unit', NULL),
(1225, 1, 9, 'AuthorityResource', 'Authority Resource', NULL),
(1226, 1, 9, 'BuildingOrMemorial', 'Building or memorial', NULL),
(1227, 1, 9, 'CharactersOrMorphemes', 'Characters or morphemes', NULL),
(1228, 1, 9, 'Collection', 'Collection', NULL),
(1229, 1, 9, 'CollectiveManuscript', 'Collective manuscript', NULL),
(1230, 1, 9, 'CollectivePseudonym', 'Collective pseudonym', NULL),
(1231, 1, 9, 'Company', 'Company', NULL),
(1232, 1, 9, 'Country', 'Country', NULL),
(1233, 1, 9, 'EarlierNameOfThePerson', 'Earlier name of the person', 'Der vorliegende abweichende Name ist der frühere Name einer Person,\n		wie beispielsweise der Geburtsname, frühere Ehename usw.'),
(1234, 1, 9, 'EthnographicName', 'Ethnographic name', NULL),
(1235, 1, 9, 'Expression', 'Expression', NULL),
(1236, 1, 9, 'ExtraterrestrialTerritory', 'Extraterrestrial territory', NULL),
(1237, 1, 9, 'FictiveCorporateBody', 'Fictive corporate body', NULL),
(1238, 1, 9, 'FictivePlace', 'Fictive place', NULL),
(1239, 1, 9, 'Fictive_term', 'Fictive term', 'Use FictiveTerm instead'),
(1240, 1, 9, 'FictiveTerm', 'Fictive term', NULL),
(1241, 1, 9, 'FullerFormOfNameOfThePerson', 'Fuller form of the name of the person', 'The complete or a fuller form of name of a person, family or corporate body'),
(1242, 1, 9, 'Gods', 'Gods', NULL),
(1243, 1, 9, 'GroupOfPersons', 'Group of persons', NULL),
(1244, 1, 9, 'HistoricSingleEventOrEra', 'Historic single event or era', NULL),
(1245, 1, 9, 'Language', 'Language', NULL),
(1246, 1, 9, 'LaterNameOfThePerson', 'Later name of the person', 'Die vorliegende abweichende Namensform ist der spätere Name einer Person, wie der \n		Ehename etc., der nicht als bevorzugter Name gewählt wird.'),
(1247, 1, 9, 'LiteraryOrLegendaryCharacter', 'Literary or legendary character', NULL),
(1248, 1, 9, 'Manuscript', 'Manuscript', NULL),
(1249, 1, 9, 'MeansOfTransportWithIndividualName', 'Means of transport with individual name', NULL),
(1250, 1, 9, 'MeansOfTransportWithIndividual_name', 'Means of transport with individual name', 'Use gndo:MeansOfTransportWithIndividualName'),
(1251, 1, 9, 'MemberState', 'Member state', NULL),
(1252, 1, 9, 'MusicalCorporateBody', 'Musical corporate body', NULL),
(1253, 1, 9, 'MusicalWork', 'Musical work', NULL),
(1254, 1, 9, 'NameOfSmallGeographicUnitLyingWithinAnotherGeographicUnit', 'Name of small geographic unit lying within another geographic\n      unit', NULL),
(1255, 1, 9, 'NameOfThePerson', 'Name of the person', NULL),
(1256, 1, 9, 'NaturalGeographicUnit', 'Natural geographic unit', NULL),
(1257, 1, 9, 'NomenclatureInBiologyOrChemistry', 'Nomenclature in biology or chemistry', NULL),
(1258, 1, 9, 'OrganOfCorporateBody', 'Organ of corporate body', NULL),
(1259, 1, 9, 'Person', 'Person', NULL),
(1260, 1, 9, 'PreferredNameOfThePerson', 'Preferred name of the person', NULL),
(1261, 1, 9, 'ProductNameOrBrandName', 'Product name or brand name', NULL),
(1262, 1, 9, 'ProjectOrProgram', 'Project or program', NULL),
(1263, 1, 9, 'ProvenanceCharacteristic', 'Provenance characteristic', 'Provenienzmerkmale bezeichnen spuren, die\n	Vorbesitzer (Personen und Institutionen) in und auf Büchern, Handschriften\n	oder anderen Artefakten hinterlassen haben. Diese Merkmale kennzeichnen\n	Besitz, Lesespuren oder Zensurabsichten.'),
(1264, 1, 9, 'Pseudonym', 'Pseudonym', 'Die vorliegende abweichende Namensform ist der\n			wirkliche Name einer Person, für die als bevorzugter Name ein Pseudonym\n			gewählt wird.'),
(1265, 1, 9, 'PseudonymNameOfThePerson', 'Pseudonym name of the person', NULL),
(1266, 1, 9, 'RealNameOfThePerson', 'Real name of the person', 'The person’s real name'),
(1267, 1, 9, 'Relationship', 'Relationship', 'Class for a relationship in order to relate the resources involved in the relationship to each other and to qualify them further.'),
(1268, 1, 9, 'ReligiousAdministrativeUnit', 'Religious administrative unit', NULL),
(1269, 1, 9, 'ReligiousCorporateBody', 'Religious corporate body', NULL),
(1270, 1, 9, 'ReligiousTerritory', 'Religious territory', NULL),
(1271, 1, 9, 'RoyalOrMemberOfARoyalHouse', 'Royal or member of a royal house', NULL),
(1272, 1, 9, 'SeriesOfConferenceOrEvent', 'Series of conference or event', NULL),
(1273, 1, 9, 'SoftwareProduct', 'Software product', NULL),
(1274, 1, 9, 'Spirits', 'Spirits', NULL),
(1275, 1, 9, 'SubjectHeadingSensoStricto', 'Subject heading sensu stricto', NULL),
(1276, 1, 9, 'TerritorialCorporateBodyOrAdministrativeUnit', 'Territorial corporate body or administrative unit', NULL),
(1277, 1, 9, 'UndifferentiatedPerson', 'Undifferentiated person', NULL),
(1278, 1, 9, 'VariantNameOfThePerson', 'Variant name of the person', NULL),
(1279, 1, 9, 'VersionOfAMusicalWork', 'Version of a musical work', NULL),
(1280, 1, 9, 'WayBorderOrLine', 'Way, border or line', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `resource_template`
--

CREATE TABLE `resource_template` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `title_property_id` int DEFAULT NULL,
  `description_property_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_template`
--

INSERT INTO `resource_template` (`id`, `owner_id`, `resource_class_id`, `title_property_id`, `description_property_id`, `label`) VALUES
(1, NULL, NULL, NULL, NULL, 'Base Resource'),
(2, 1, 1000, 1, 4, 'CC-License'),
(3, 1, 684, 1451, 738, '3-D models'),
(4, 1, 545, 1451, 738, 'Audio'),
(5, 1, 790, 1451, 738, 'Book'),
(6, 1, 692, 1451, 738, 'General Collection'),
(7, 1, 692, 1451, 738, 'Journal Collection'),
(8, 1, 559, 1451, 738, 'Journal Issue'),
(9, 1, 644, 1451, 738, 'Journal Volume'),
(10, 1, 811, 1451, 738, 'Letters'),
(11, 1, 341, 1451, 738, 'Manuscript'),
(12, 1, 296, 1451, 738, 'Plakkaten'),
(13, 1, 924, 1451, 738, 'Visual Art Works');

-- --------------------------------------------------------

--
-- Table structure for table `resource_template_property`
--

CREATE TABLE `resource_template_property` (
  `id` int NOT NULL,
  `resource_template_id` int NOT NULL,
  `property_id` int NOT NULL,
  `alternate_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT NULL,
  `data_type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `is_required` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `default_lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_template_property`
--

INSERT INTO `resource_template_property` (`id`, `resource_template_id`, `property_id`, `alternate_label`, `alternate_comment`, `position`, `data_type`, `is_required`, `is_private`, `default_lang`) VALUES
(1, 1, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(2, 1, 15, NULL, NULL, 2, NULL, 0, 0, NULL),
(3, 1, 8, NULL, NULL, 3, NULL, 0, 0, NULL),
(4, 1, 2, NULL, NULL, 4, NULL, 0, 0, NULL),
(5, 1, 7, NULL, NULL, 5, NULL, 0, 0, NULL),
(6, 1, 4, NULL, NULL, 6, NULL, 0, 0, NULL),
(7, 1, 9, NULL, NULL, 7, NULL, 0, 0, NULL),
(8, 1, 12, NULL, NULL, 8, NULL, 0, 0, NULL),
(9, 1, 40, 'Place', NULL, 9, NULL, 0, 0, NULL),
(10, 1, 5, NULL, NULL, 10, NULL, 0, 0, NULL),
(11, 1, 17, NULL, NULL, 11, NULL, 0, 0, NULL),
(12, 1, 6, NULL, NULL, 12, NULL, 0, 0, NULL),
(13, 1, 25, NULL, NULL, 13, NULL, 0, 0, NULL),
(14, 1, 10, NULL, NULL, 14, NULL, 0, 0, NULL),
(15, 1, 13, NULL, NULL, 15, NULL, 0, 0, NULL),
(16, 1, 29, NULL, NULL, 16, NULL, 0, 0, NULL),
(17, 1, 30, NULL, NULL, 17, NULL, 0, 0, NULL),
(18, 1, 50, NULL, NULL, 18, NULL, 0, 0, NULL),
(19, 1, 3, NULL, NULL, 19, NULL, 0, 0, NULL),
(20, 1, 41, NULL, NULL, 20, NULL, 0, 0, NULL),
(21, 2, 48, 'Short Title / Abbreviation', NULL, 1, '[\"literal\"]', 0, 0, NULL),
(22, 2, 1, NULL, NULL, 2, '[\"literal\"]', 0, 0, NULL),
(23, 2, 4, NULL, NULL, 3, '[\"literal\"]', 0, 0, NULL),
(24, 2, 1639, NULL, NULL, 4, '[\"uri\"]', 0, 0, NULL),
(25, 2, 1645, NULL, NULL, 5, NULL, 0, 0, NULL),
(26, 2, 1646, NULL, NULL, 6, NULL, 0, 0, NULL),
(27, 3, 1451, 'Title', NULL, 1, '[\"literal\"]', 0, 0, NULL),
(28, 3, 1213, 'Creator', NULL, 2, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(29, 3, 922, 'Date', NULL, 3, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(30, 3, 738, 'Description', NULL, 4, '[\"literal\"]', 0, 0, NULL),
(31, 3, 1313, 'Material', NULL, 5, '[\"literal\",\"uri\",\"valuesuggest:getty:aat\"]', 0, 0, NULL),
(32, 3, 1067, 'Physical description', NULL, 6, '[\"literal\"]', 0, 0, NULL),
(33, 3, 1394, 'Call number', NULL, 7, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(34, 3, 1132, 'Link to', NULL, 8, '[\"literal\",\"uri\"]', 0, 0, NULL),
(35, 3, 1574, 'License', NULL, 9, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(36, 3, 1441, 'Access condition', NULL, 10, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(37, 3, 1512, 'Copyright', NULL, 11, '[\"literal\"]', 0, 0, NULL),
(38, 3, 1499, 'Provider', NULL, 12, '[\"literal\",\"valuesuggest:geonames:geonames\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(39, 4, 1451, 'Title', NULL, 1, '[\"literal\"]', 1, 0, NULL),
(40, 4, 738, 'Description', NULL, 2, '[\"literal\"]', 0, 0, NULL),
(41, 4, 1213, 'Creator', NULL, 3, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(42, 4, 1430, 'Editor', NULL, 4, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(43, 4, 1267, 'Composer', NULL, 5, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(44, 4, 1133, 'Broadcaster', NULL, 6, '[\"literal\",\"valuesuggest:ndeterms:wikiall\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(45, 4, 1216, 'Place of publication', NULL, 7, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(46, 4, 556, 'Date', NULL, 8, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(47, 4, 1401, 'Duration', NULL, 9, '[\"literal\"]', 0, 0, NULL),
(48, 4, 767, 'Language', NULL, 10, '[\"literal\",\"valuesuggest:lc:iso6391\"]', 0, 0, NULL),
(49, 4, 1394, 'Call number', NULL, 11, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(50, 4, 1522, 'Link to', NULL, 12, '[\"literal\",\"uri\"]', 0, 0, NULL),
(51, 4, 1132, 'Link to', NULL, 13, '[\"literal\",\"uri\"]', 0, 0, NULL),
(52, 4, 1574, 'License', NULL, 14, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(53, 4, 1441, 'Access condition', NULL, 15, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(54, 4, 1512, 'Copyright', NULL, 16, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(55, 4, 1499, 'Provider', NULL, 17, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(56, 5, 1451, 'Book title', NULL, 1, '[\"literal\"]', 1, 0, NULL),
(57, 5, 903, 'Author', NULL, 2, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(58, 5, 1396, 'Translator', NULL, 3, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(59, 5, 1430, 'Editor', NULL, 4, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(60, 5, 1408, 'Illustrator', NULL, 5, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(61, 5, 562, 'Contributor', NULL, 6, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(62, 5, 738, 'Description', NULL, 7, NULL, 0, 0, NULL),
(63, 5, 1216, 'Place of publication', NULL, 8, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(64, 5, 1527, 'Publisher', NULL, 9, '[\"literal\",\"valuesuggest:ndeterms:wikiall\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(65, 5, 556, 'Year of publication', NULL, 10, '[\"literal\",\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(66, 5, 519, 'Copyright year', NULL, 11, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(67, 5, 791, 'Manufacturer', NULL, 12, '[\"literal\",\"valuesuggest:ndeterms:wikiall\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(68, 5, 116, 'Physical Description', NULL, 13, NULL, 0, 0, NULL),
(69, 5, 767, 'Language', NULL, 14, '[\"valuesuggest:lc:iso6391\",\"customvocab:1\"]', 0, 0, NULL),
(70, 5, 934, 'Edition', NULL, 15, '[\"literal\"]', 0, 0, NULL),
(71, 5, 858, 'Serial Title', NULL, 16, '[\"literal\"]', 0, 0, NULL),
(72, 5, 358, 'Volume', NULL, 17, '[\"literal\"]', 0, 0, NULL),
(73, 5, 276, 'ISBN', NULL, 18, '[\"literal\"]', 0, 0, NULL),
(74, 5, 1394, 'Call number', NULL, 19, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(75, 5, 574, 'Abstract', NULL, 20, '[\"literal\"]', 0, 0, NULL),
(76, 5, 772, 'Keywords', NULL, 21, '[\"literal\"]', 0, 0, NULL),
(77, 5, 1636, 'Geographic depiction', NULL, 22, '[\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(78, 5, 1273, 'Genre', NULL, 23, '[\"valuesuggest:lc:genreForms\"]', 0, 0, NULL),
(79, 5, 1132, 'Link to', 'Links to WorldCat, WikiData or WikiCommons go here.\r\nURL of a reference Web page that unambiguously indicates the item\'s identity. E.g. the URL of the item\'s Wikipedia page, Wikidata entry, or official website.', 24, '[\"uri\"]', 0, 0, NULL),
(80, 5, 800, 'Collection', NULL, 25, '[\"literal\"]', 0, 0, NULL),
(81, 5, 1522, 'Related Item', NULL, 26, '[\"literal\",\"uri\"]', 0, 0, NULL),
(82, 5, 1574, 'License', NULL, 27, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(83, 5, 1441, 'Access condition', NULL, 28, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(84, 5, 1512, 'Copyright', NULL, 29, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(85, 5, 1499, 'Provider', NULL, 30, '[\"literal\",\"valuesuggest:geonames:geonames\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(86, 6, 1451, 'Title', NULL, 1, '[\"literal\"]', 1, 0, NULL),
(87, 6, 738, 'Description', NULL, 2, NULL, 1, 0, NULL),
(88, 6, 556, 'Date', NULL, 3, '[\"literal\"]', 0, 0, NULL),
(89, 6, 903, 'Author', NULL, 4, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(90, 6, 772, 'Keywords', NULL, 5, '[\"literal\"]', 0, 0, NULL),
(91, 6, 1132, 'Link to', NULL, 6, '[\"uri\"]', 0, 0, NULL),
(92, 7, 1451, 'Journal title', NULL, 1, '[\"literal\"]', 0, 0, NULL),
(93, 7, 738, 'Description', 'Description of the journal collection', 2, NULL, 0, 0, NULL),
(94, 7, 1216, 'Place of publication', NULL, 3, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(95, 7, 1527, 'Publisher', NULL, 4, '[\"literal\",\"valuesuggest:ndeterms:wikiall\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(96, 7, 556, 'Year of publication', NULL, 5, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(97, 7, 767, 'Language', NULL, 6, '[\"valuesuggest:lc:iso6391\",\"customvocab:1\"]', 0, 0, NULL),
(98, 7, 358, 'Volume', NULL, 7, '[\"literal\"]', 0, 0, NULL),
(99, 7, 764, 'ISSN', NULL, 8, NULL, 0, 0, NULL),
(100, 7, 574, NULL, NULL, 9, NULL, 0, 0, NULL),
(101, 7, 945, 'Superseded by', NULL, 10, '[\"literal\",\"uri\"]', 0, 0, NULL),
(102, 7, 420, 'Continues', NULL, 11, '[\"literal\",\"uri\"]', 0, 0, NULL),
(103, 7, 1394, 'Call number', NULL, 12, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(104, 7, 1132, 'Links', NULL, 13, '[\"uri\"]', 0, 0, NULL),
(105, 7, 1574, 'License', NULL, 14, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(106, 7, 1441, 'Access condition', NULL, 15, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(107, 7, 1512, 'Copyright', NULL, 16, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(108, 7, 1499, 'Provider', NULL, 17, '[\"literal\",\"valuesuggest:geonames:geonames\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(109, 8, 1451, 'Title', NULL, 1, NULL, 0, 0, NULL),
(110, 8, 738, 'Description', NULL, 2, NULL, 0, 0, NULL),
(111, 8, 242, 'Issue', NULL, 3, NULL, 0, 0, NULL),
(112, 8, 312, 'Date', NULL, 4, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(113, 8, 358, 'Volume', NULL, 5, NULL, 0, 0, NULL),
(114, 8, 1574, 'License', NULL, 6, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(115, 8, 1441, 'Access condition', NULL, 7, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(116, 8, 1512, 'Copyright', NULL, 8, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(117, 9, 1451, 'Volume', 'Enter the name of the volume. E.g.: Observant jaargang 1990-1991', 1, '[\"literal\"]', 1, 0, NULL),
(118, 9, 738, 'Description', NULL, 2, '[\"literal\"]', 0, 0, NULL),
(119, 9, 312, 'Date Issued', 'Year of the first publication', 3, '[\"literal\",\"numeric:interval\"]', 0, 0, NULL),
(120, 10, 1451, 'Title', NULL, 1, '[\"literal\"]', 1, 0, NULL),
(121, 10, 903, 'Author', NULL, 2, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(122, 10, 738, 'Description', NULL, 3, '[\"literal\"]', 0, 0, NULL),
(123, 10, 922, 'Date', NULL, 4, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(124, 10, 377, 'Recipient', NULL, 5, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(125, 10, 767, 'Language', NULL, 6, '[\"valuesuggest:lc:iso6391\"]', 0, 0, NULL),
(126, 10, 1556, 'Pages', NULL, 7, '[\"literal\"]', 0, 0, NULL),
(127, 10, 1132, 'Link to', NULL, 8, '[\"uri\"]', 0, 0, NULL),
(128, 10, 1394, 'Call number', NULL, 9, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(129, 10, 1574, 'License', NULL, 10, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(130, 10, 1441, 'Access condition', NULL, 11, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(131, 10, 1512, 'Copyright', NULL, 12, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(132, 10, 1499, 'Provider', NULL, 13, '[\"literal\",\"valuesuggest:geonames:geonames\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(133, 11, 1451, 'Title', NULL, 1, '[\"literal\"]', 1, 0, NULL),
(134, 11, 903, 'Author', NULL, 2, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(135, 11, 738, 'Description', NULL, 3, '[\"literal\"]', 0, 0, NULL),
(136, 11, 922, 'Date', NULL, 4, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(137, 11, 767, 'Language', NULL, 5, '[\"valuesuggest:lc:iso6391\"]', 0, 0, NULL),
(138, 11, 1132, 'Link to', NULL, 6, '[\"literal\",\"uri\"]', 0, 0, NULL),
(139, 11, 1522, 'Related to', NULL, 7, '[\"literal\"]', 0, 0, NULL),
(140, 11, 1394, 'Call number', NULL, 8, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(141, 11, 1574, 'License', NULL, 9, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(142, 11, 1441, 'Access condition', NULL, 10, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(143, 11, 1512, 'Copyright', NULL, 11, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(144, 11, 1499, 'Provider', NULL, 12, '[\"literal\",\"valuesuggest:geonames:geonames\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(145, 12, 1486, 'Collectie', NULL, 1, NULL, 0, 0, NULL),
(146, 12, 277, 'Volgnummer', NULL, 2, NULL, 0, 0, NULL),
(147, 12, 11, 'Vindplaats', NULL, 3, '[\"literal\"]', 0, 0, NULL),
(148, 12, 1451, 'Kopregest', NULL, 4, NULL, 0, 0, NULL),
(149, 12, 738, 'Regest', NULL, 5, NULL, 0, 0, NULL),
(150, 12, 1212, 'Wetgevende Instantie', NULL, 6, NULL, 0, 0, NULL),
(151, 12, 298, 'Plaats van uitvaardiging', NULL, 7, NULL, 0, 0, NULL),
(152, 12, 921, 'Datum uitvaardiging', NULL, 8, '[\"numeric:timestamp\"]', 0, 0, NULL),
(153, 12, 903, 'Paraaf toezendende instantie', NULL, 9, NULL, 0, 0, NULL),
(154, 12, 1210, 'Signatuur', NULL, 10, NULL, 0, 0, NULL),
(155, 12, 540, 'Contrasignatuur', NULL, 11, NULL, 0, 0, NULL),
(156, 12, 1074, 'Zegel', NULL, 12, NULL, 0, 0, NULL),
(157, 12, 525, 'Vorm', NULL, 13, NULL, 0, 0, NULL),
(158, 12, 767, 'Taal', NULL, 14, NULL, 0, 0, NULL),
(159, 12, 1353, 'Adviserende Instantie', NULL, 15, NULL, 0, 0, NULL),
(160, 12, 539, 'Toezendende instantie', NULL, 16, NULL, 0, 0, NULL),
(161, 12, 1429, 'Plaats van toezending', NULL, 17, NULL, 0, 0, NULL),
(162, 12, 1448, 'Datum van toezending', NULL, 18, '[\"numeric:timestamp\"]', 0, 0, NULL),
(163, 12, 341, 'Paraaf, Signatuur, Contrasignatuur toezendende instantie', NULL, 19, NULL, 0, 0, NULL),
(164, 12, 1622, 'Uitvoerende instantie', 'This organization is installed to execute, supervise or control the goals of  commanding organization ', 20, NULL, 0, 0, NULL),
(165, 12, 699, 'Datum ontvangst', NULL, 21, '[\"numeric:timestamp\"]', 0, 0, NULL),
(166, 12, 388, 'Datum afkondiging', NULL, 22, NULL, 0, 0, NULL),
(167, 12, 545, 'Geldingsgebied', NULL, 23, NULL, 0, 0, NULL),
(168, 12, 451, 'Plaats van uitvoering', NULL, 24, NULL, 0, 0, NULL),
(169, 12, 396, 'Drukker', 'The printing company that printed the poster', 25, NULL, 0, 0, NULL),
(170, 12, 1216, 'Drukplaats', NULL, 26, NULL, 0, 0, NULL),
(171, 12, 1597, 'Bijzonderheden', 'Here: additional information on the subject', 27, NULL, 0, 0, NULL),
(172, 12, 367, 'DJVU Jaar', NULL, 28, NULL, 0, 0, NULL),
(173, 13, 1451, 'Title', NULL, 1, '[\"literal\"]', 1, 0, NULL),
(174, 13, 1213, 'Creator', NULL, 2, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(175, 13, 1408, 'Illustrator', NULL, 3, '[\"literal\",\"valuesuggest:ndeterms:wikipers\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(176, 13, 738, 'Description', NULL, 4, '[\"literal\"]', 0, 0, NULL),
(177, 13, 1527, 'Publisher', NULL, 5, '[\"literal\",\"valuesuggest:ndeterms:wikiall\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(178, 13, 1216, 'Place', NULL, 6, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(179, 13, 922, 'Date', NULL, 7, '[\"numeric:timestamp\",\"numeric:interval\"]', 0, 0, NULL),
(180, 13, 1067, 'Physical description', NULL, 8, '[\"literal\"]', 0, 0, NULL),
(181, 13, 1132, 'Link to', NULL, 9, '[\"literal\",\"uri\"]', 0, 0, NULL),
(182, 13, 1522, 'Related items', NULL, 10, '[\"literal\",\"uri\"]', 0, 0, NULL),
(183, 13, 800, 'Is part of', NULL, 11, '[\"literal\",\"uri\"]', 0, 0, NULL),
(184, 13, 1394, 'Call number', NULL, 12, '[\"literal\",\"valuesuggest:geonames:geonames\"]', 0, 0, NULL),
(185, 13, 1574, 'License', NULL, 13, '[\"literal\",\"customvocab:2\"]', 0, 0, NULL),
(186, 13, 1441, 'Access condition', NULL, 14, '[\"literal\",\"numeric:timestamp\"]', 0, 0, NULL),
(187, 13, 1512, 'Copyright', NULL, 15, '[\"literal\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL),
(188, 13, 1499, 'Provider', NULL, 16, '[\"literal\",\"valuesuggest:geonames:geonames\",\"valuesuggest:oclc:viaf\"]', 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `search_config`
--

CREATE TABLE `search_config` (
  `id` int NOT NULL,
  `engine_id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `form_adapter` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_config`
--

INSERT INTO `search_config` (`id`, `engine_id`, `name`, `path`, `form_adapter`, `settings`, `created`, `modified`) VALUES
(1, 2, 'Default', 'find', 'main', '{\"search\":{\"default_results\":\"default\",\"default_query\":\"\",\"default_query_post\":\"\",\"hidden_query_filters\":[]},\"autosuggest\":{\"suggester\":\"1\",\"url\":\"\",\"url_param_name\":\"\",\"limit\":null},\"form\":{\"filters\":[{\"field\":\"dcterms_title_txt\",\"label\":\"Title\",\"type\":\"\",\"options\":[]},{\"field\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\",\"options\":[]},{\"field\":\"advanced\",\"label\":\"Filters\",\"type\":\"Advanced\",\"options\":[],\"fields\":{\"title\":{\"value\":\"title\",\"label\":\"Title\"},\"author\":{\"value\":\"author\",\"label\":\"Author\"},\"dcterms:creator\":{\"value\":\"dcterms:creator\",\"label\":\"Creator\"},\"dcterms:subject\":{\"value\":\"dcterms:subject\",\"label\":\"Subject\"},\"date\":{\"value\":\"date\",\"label\":\"Date\"},\"description\":{\"value\":\"description\",\"label\":\"Description\"},\"resource_class_id\":{\"value\":\"resource_class_id\",\"label\":\"Class\"}},\"default_number\":1,\"max_number\":\"5\",\"field_joiner\":\"1\",\"field_joiner_not\":\"1\",\"field_operator\":\"1\",\"field_operators\":{\"eq\":\"is exactly\",\"in\":\"contains\",\"sw\":\"starts with\",\"ew\":\"ends with\",\"ex\":\"has any value\",\"res\":\"is resource with ID\"}}],\"attribute_form\":\"0\",\"button_reset\":\"0\",\"button_submit\":\"1\"},\"display\":{\"facets\":\"after\",\"search_filters\":\"header\",\"active_facets\":\"none\",\"total_results\":\"header\",\"paginator\":\"header\",\"per_pages\":\"header\",\"sort\":\"header\",\"grid_list\":\"header\",\"grid_list_mode\":\"auto\"},\"pagination\":{\"per_pages\":{\"10\":\"Results by 10\",\"25\":\"Results by 25\",\"50\":\"Results by 50\",\"100\":\"Results by 100\"}},\"sort\":{\"label\":\"Sort by\",\"fields\":{\"dcterms:title asc\":{\"name\":\"dcterms:title asc\",\"label\":\"Title\"},\"dcterms:title desc\":{\"name\":\"dcterms:title desc\",\"label\":\"Title (from z to a)\"},\"dcterms:date asc\":{\"name\":\"dcterms:date asc\",\"label\":\"Date\"},\"dcterms:date desc\":{\"name\":\"dcterms:date desc\",\"label\":\"Date (most recent first)\"}}},\"facet\":{\"label\":\"Facets\",\"facets\":{\"resource_class_s\":{\"name\":\"resource_class_s\",\"label\":\"Resource class\",\"type\":\"\",\"options\":[]},\"dcterms_creator_s\":{\"name\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\",\"options\":[]}},\"limit\":\"10\",\"order\":\"\",\"languages\":[],\"display_list\":\"available\",\"mode\":\"button\",\"display_submit\":\"above\",\"display_reset\":\"above\",\"label_submit\":\"Apply facets\",\"label_reset\":\"Reset facets\",\"display_active\":\"1\",\"display_count\":\"1\"}}', '2023-02-15 16:01:30', '2023-02-28 14:50:30');

-- --------------------------------------------------------

--
-- Table structure for table `search_engine`
--

CREATE TABLE `search_engine` (
  `id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `adapter` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_engine`
--

INSERT INTO `search_engine` (`id`, `name`, `adapter`, `settings`, `created`, `modified`) VALUES
(1, 'Internal (sql)', 'internal', '{\"resources\":[\"items\",\"item_sets\"],\"adapter\":{\"default_search_partial_word\":false,\"multifields\":{\"title\":{\"name\":\"title\",\"label\":\"Title\",\"fields\":[\"dcterms:title\",\"dcterms:alternative\",\"bibo:shortTitle\"]},\"author\":{\"name\":\"author\",\"label\":\"Author\",\"fields\":[\"dcterms:creator\",\"dcterms:contributor\",\"bibo:authorList\",\"bibo:contributorList\",\"bibo:director\",\"bibo:editor\",\"bibo:editorList\",\"bibo:interviewee\",\"bibo:interviewer\",\"bibo:organizer\",\"bibo:performer\",\"bibo:producer\",\"bibo:recipient\",\"bibo:translator\"]},\"creator\":{\"name\":\"creator\",\"label\":\"Creator\",\"fields\":[\"dcterms:creator\"]},\"contributor\":{\"name\":\"contributor\",\"label\":\"Contributor\",\"fields\":[\"dcterms:contributor\",\"bibo:authorList\",\"bibo:contributorList\",\"bibo:director\",\"bibo:editor\",\"bibo:editorList\",\"bibo:interviewee\",\"bibo:interviewer\",\"bibo:organizer\",\"bibo:performer\",\"bibo:producer\",\"bibo:recipient\",\"bibo:translator\"]},\"subject\":{\"name\":\"subject\",\"label\":\"Subject\",\"fields\":[\"dcterms:subject\"]},\"description\":{\"name\":\"description\",\"label\":\"Description\",\"fields\":[\"dcterms:description\",\"dcterms:abstract\",\"dcterms:tableOfContents\",\"bibo:abstract\",\"bibo:shortDescription\"]},\"publisher\":{\"name\":\"publisher\",\"label\":\"Publisher\",\"fields\":[\"dcterms:publisher\",\"bibo:distributor\",\"bibo:issuer\"]},\"date\":{\"name\":\"date\",\"label\":\"Date\",\"fields\":[\"dcterms:date\",\"dcterms:available\",\"dcterms:created\",\"dcterms:issued\",\"dcterms:modified\",\"dcterms:valid\",\"dcterms:dateAccepted\",\"dcterms:dateCopyrighted\",\"dcterms:dateSubmitted\",\"bibo:argued\"]},\"type\":{\"name\":\"type\",\"label\":\"Type\",\"fields\":[\"dcterms:type\"]},\"format\":{\"name\":\"format\",\"label\":\"Format\",\"fields\":[\"dcterms:format\",\"dcterms:extent\",\"dcterms:medium\"]},\"identifier\":{\"name\":\"identifier\",\"label\":\"Identifier\",\"fields\":[\"dcterms:identifier\",\"dcterms:bibliographicCitation\",\"bibo:asin\",\"bibo:coden\",\"bibo:doi\",\"bibo:eanucc13\",\"bibo:eissn\",\"bibo:gtin14\",\"bibo:handle\",\"bibo:identifier\",\"bibo:isbn\",\"bibo:isbn10\",\"bibo:isbn13\",\"bibo:issn\",\"bibo:oclcnum\",\"bibo:pmid\",\"bibo:sici\",\"bibo:upc\",\"bibo:uri\"]},\"source\":{\"name\":\"source\",\"label\":\"Source\",\"fields\":[\"dcterms:source\"]},\"provenance\":{\"name\":\"provenance\",\"label\":\"Provenance\",\"fields\":[\"dcterms:provenance\"]},\"language\":{\"name\":\"language\",\"label\":\"Language\",\"fields\":[\"dcterms:language\"]},\"relation\":{\"name\":\"relation\",\"label\":\"Relation\",\"fields\":[\"dcterms:relation\",\"dcterms:isVersionOf\",\"dcterms:hasVersion\",\"dcterms:isReplacedBy\",\"dcterms:replaces\",\"dcterms:isRequiredBy\",\"dcterms:requires\",\"dcterms:isPartOf\",\"dcterms:hasPart\",\"dcterms:isReferencedBy\",\"dcterms:references\",\"dcterms:isFormatOf\",\"dcterms:hasFormat\",\"dcterms:conformsTo\",\"bibo:annotates\",\"bibo:citedBy\",\"bibo:cites\",\"bibo:reproducedIn\",\"bibo:reviewOf\",\"bibo:transcriptOf\",\"bibo:translationOf\"]},\"coverage\":{\"name\":\"coverage\",\"label\":\"Coverage\",\"fields\":[\"dcterms:coverage\",\"dcterms:spatial\",\"dcterms:temporal\"]},\"rights\":{\"name\":\"rights\",\"label\":\"Rights\",\"fields\":[\"dcterms:rights\",\"dcterms:accessRights\",\"dcterms:license\"]},\"audience\":{\"name\":\"audience\",\"label\":\"Audience\",\"fields\":[\"dcterms:audience\",\"dcterms:mediator\",\"dcterms:educationLevel\"]},\"rightsHolder\":{\"name\":\"rightsHolder\",\"label\":\"Rights holder\",\"fields\":[\"dcterms:rightsHolder\",\"bibo:owner\"]},\"accrualAndInstructional\":{\"name\":\"accrualAndInstructional\",\"label\":\"Accrual and instructional metadata\",\"fields\":[\"dcterms:accrualMethod\",\"dcterms:accrualPeriodicity\",\"dcterms:accrualPolicy\",\"dcterms:instructionalMethod\"]},\"bibliographicData\":{\"name\":\"bibliographicData\",\"label\":\"Bibliographic data\",\"fields\":[\"bibo:chapter\",\"bibo:edition\",\"bibo:issue\",\"bibo:locator\",\"bibo:numPages\",\"bibo:numVolumes\",\"bibo:number\",\"bibo:pageEnd\",\"bibo:pageStart\",\"bibo:pages\",\"bibo:section\",\"bibo:volume\"]}}}}', '2023-02-15 16:01:30', NULL),
(2, 'Solr', 'solarium', '{\"resources\":[\"items\"],\"adapter\":{\"solr_core_id\":\"1\",\"index_name\":\"\"}}', '2023-02-28 14:42:10', '2023-02-28 14:42:12');

-- --------------------------------------------------------

--
-- Table structure for table `search_suggester`
--

CREATE TABLE `search_suggester` (
  `id` int NOT NULL,
  `engine_id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_suggester`
--

INSERT INTO `search_suggester` (`id`, `engine_id`, `name`, `settings`, `created`, `modified`) VALUES
(1, 1, 'Internal suggester (sql)', '{\"direct\":false,\"mode_index\":\"start\",\"mode_search\":\"start\",\"limit\":25,\"length\":50,\"fields\":[],\"excluded_fields\":[]}', '2023-02-15 16:01:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `search_suggestion`
--

CREATE TABLE `search_suggestion` (
  `id` int NOT NULL,
  `suggester_id` int NOT NULL,
  `text` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_all` int NOT NULL,
  `total_public` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longblob NOT NULL,
  `modified` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('935c272d01d96d5a4f62f5937668c0c3', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313734373732393533352e3135323835333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223736333439383333326665633261353862326162373833303330366562356266223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313734373737303634343b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313734373737323733333b7d733a35393a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4561737941646d696e5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313734373737303636333b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313734373737323733333b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226239383835633732313039383137333664393039313033383264316238393730223b733a33323a226339323736383034336135353063653638666164303134616535366564633638223b7d733a343a2268617368223b733a36353a2263393237363830343361353530636536386661643031346165353665646336382d6239383835633732313039383137333664393039313033383264316238393730223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3536363a7b733a33323a226233653030346264396464366235323236343833666136626666323163646336223b733a33323a223730663266383766646232616464643266333231306638373138653739393330223b733a33323a226466303739646132663065313835663066386262656362643239323831363230223b733a33323a226262616561623735383531393230323931623639383132623462306539313530223b733a33323a223861313062616133376132613737386234626430643763623438613730643665223b733a33323a223264613635616538613638613837653832663034623237616231313363643535223b733a33323a223433313831633062333136656663386465326161323464363664326465623861223b733a33323a226338366636323062323530356435373536303366366434386366643562306361223b733a33323a226437646535663431356361636136313865653738343365326164383732386262223b733a33323a226231383162326361393435336161333834616138356463353030323133333136223b733a33323a223634643333616338373162646261323365653431383465376362653862666131223b733a33323a223366633861333032306364356565343730303636623330623536663038643537223b733a33323a223262356466363663376663343233623366333662626464333166396134633036223b733a33323a223864653863616130393237646635343563633137386533636335353236666630223b733a33323a226262336330393630616537623338303561343232626435663039323036393466223b733a33323a223637613163633134653336313637613830343733356661613061346366396230223b733a33323a226431396137336161313730363666613135393463323862323934353331313963223b733a33323a223662326665343430383636643665383963326638326661356639616630353162223b733a33323a226436343734396636623731363361383238646430356338663064333034646263223b733a33323a223737643632363861373935353233353964323435656639363165316135346633223b733a33323a226137353061646662303730316266356336643434656466343835653563343363223b733a33323a223961636566333762386138386432663637333464383330323535666230353739223b733a33323a223034306665613037623539376239313066363330626332666139343564373031223b733a33323a226261376566353936633631666665663763373232656134666537316364653534223b733a33323a226635326439306637343035353730303039393238663866376635376336313837223b733a33323a223561663638363437366565366134366330356634333632353762346662316338223b733a33323a223334376432653864353532613266666663323735363831363131343466663838223b733a33323a223436383432646232303533336535636531343030316232383735643738353966223b733a33323a223534366334306266623865663731613362653235373837646635366562303630223b733a33323a226238376434343232623631366662363363373039346136313863346631383834223b733a33323a226533623934346438316437313964623435323665353134396263373464346538223b733a33323a223033613066366566353632336235363065326531353565303365366364303366223b733a33323a223330373533643834643436393264623533303161623239356539373732373962223b733a33323a223038613237633936343233313432393137336634613332623131376534653738223b733a33323a223334356665663131623634663234616563633333343766323331306235323534223b733a33323a223532343030663837633439326531313462386630376239356666613763343038223b733a33323a223564356363346262616261333765383834363037613937323837626334323036223b733a33323a223135643339616536663535613265616261393364656231363233353837633237223b733a33323a223234646234306633666565366535646264623132323164626139306463646237223b733a33323a226434653534656434333231613165656363323733356365323261663339376332223b733a33323a223137666163633930666236656639393964303836386563633339376462393730223b733a33323a226238336238353039313963316636663332613437653365653438303061636330223b733a33323a223539646439396530323930383366333266643934623736306335313439393137223b733a33323a226465333832316533326339363039613062366462303434663064666437393131223b733a33323a223839343237303664353566636334383734633465393563666437373835383039223b733a33323a223536356230373563386532356461306534303634373161313464376662333665223b733a33323a223631343533396432353138386639646462636539376130666366333561633137223b733a33323a223863646537343364366332623532353332336435323939323235336233313035223b733a33323a226537343432383565396430343162646336653632363531353135393163613136223b733a33323a226233346465366139313630613061366539326134383564663438306632646337223b733a33323a226365323035636230393736313731363239643932613134313836643462306135223b733a33323a223966316261356166653935323765336430646336343431393666663766363932223b733a33323a223562613134353337646334376265306436633063376463613962663634323936223b733a33323a226238633634623538646565393833633864646661613336333536333863663265223b733a33323a223865363038356361633862386439396566353166333331633765383739626339223b733a33323a226635633335336432353032646466356638343938346438663039613431646366223b733a33323a223835353230323462366165663733366637353662363262356161353037393735223b733a33323a223865356663613431386532323465643739326139343764616235353361633633223b733a33323a223836636339633131373431623135366331386337366131306539613336396162223b733a33323a223637373262316332386263343339666661356662383965623137633062623837223b733a33323a226331383766383438633132326436353134653930363336303363613439343562223b733a33323a226430653238636662373965393839363637386132663638613464343135396366223b733a33323a223761356635613630316432383863646434396165383337306638356166333861223b733a33323a223835613265353232303339303762643566373662626537323532306636663639223b733a33323a226136326364343566636231616135366261353165313035383532343034383839223b733a33323a223730343163386537616466393234666562376431316335316362306361323830223b733a33323a223066303338623136646161336563626130326531656334313431353166613661223b733a33323a223864366161613165653462393466366134653933303965346438306437666432223b733a33323a223361356130613662313964373235613633333738633364633765373463643463223b733a33323a223737343430386332633930653366393839663364396134643339646233626238223b733a33323a223362623364313464316364643163346361323035656635343561636537353737223b733a33323a223965383562303236376466366433373866616437663731323531663066626363223b733a33323a223934666334363736623264633066666464353935346534393933383533373063223b733a33323a223564366233333066643039623235306136373832666162353461363164326666223b733a33323a223766383764306262346538376364343537306166643462333832333037623462223b733a33323a226563393637313461333833353530363030343837666266666431646261363638223b733a33323a226632613763353839323738366633663034636232656536373731366466336366223b733a33323a223462663637386139336562376330366532336431343933393934333236333932223b733a33323a226237393732366663386238313066373065313839326664316138643564333334223b733a33323a223433323431643461346132643639393432393166313534373233636232366533223b733a33323a223566333163613861373832643931356463383161653339353663353131663163223b733a33323a223661386466303638653665303865313335393363343666393533643662613438223b733a33323a223464356663636165393334666230336432356266646437663538313537646538223b733a33323a223230353831613637636236386262353437353431323666373538643736316534223b733a33323a223466333932633635363937363232373534653132303865303034356566616665223b733a33323a226365343935356137623963346434643665366364373630353963663666656637223b733a33323a226166303837323037323731303938333565616365343434663264326666626265223b733a33323a223934363734623163386331353763336364396532373033633337363561616339223b733a33323a226663393933643133623161363764356631663861653863623964343263303230223b733a33323a223065383338323738353634366438336232653033383036653932643538383162223b733a33323a223163373963323238626435393131626539666462343463633461303633643539223b733a33323a226164333534316366393932363837626265306365333134616433346365393064223b733a33323a223135313138636465393263393432623566666536666532666466626466656532223b733a33323a223930646361383933633135633066366462303836653832363639646162313437223b733a33323a226539353134666237326563623963336230373262626531663362653737636466223b733a33323a226232326330643335633263653461623861646137613730356132333265653064223b733a33323a226536306632663738636239646133373566313732326165613134393266653130223b733a33323a223334373036303034383061336363353930643365366161653933393432393866223b733a33323a226363653838616437313035666663643365656538366431323231303365316263223b733a33323a226633616437666661663662653831653032333631653639343839633763396463223b733a33323a223366343635346333363861613138653330386565346237383334323761336133223b733a33323a223931663336343339326330386464633532633234623935376230336462323234223b733a33323a223063663334656362343064333237383134353264323833633763323136373035223b733a33323a226338303836643165663933373263643037626330666233313239346664343339223b733a33323a226266623032386164363530316365383565623063663438656439663233663836223b733a33323a223730643465333134383962393537346464623736396533393061623663393239223b733a33323a226462303534386534333762663138656430653364343538363136346163626537223b733a33323a223966383133383666633662663836333762663634356239333662336430393433223b733a33323a226463336563316534376633633635336235626463343263393066323634393135223b733a33323a223365306164333139623633636135313565353437613638663834386162613561223b733a33323a226632386637373865336531656562643639346163633065623039336462323065223b733a33323a223664323765343537343931333230663731356262343439656661623236653531223b733a33323a226432383730646165643638663837333031383965353163666637363964353135223b733a33323a226230643235363335333738393061633861643133633665303032343530326234223b733a33323a223966346664626230353734646436373739646133343734313366343361316632223b733a33323a223962393163373236313535663939313335393536643662316530646130313733223b733a33323a223239386437346361326132666634323034353731653964643938383137666263223b733a33323a226139626635653232323065646232353534643461643361366630306339353730223b733a33323a223135333532366237303563373936336462376337636132316361633033373538223b733a33323a223738373436313962613365393631656562623532643533386264616138333031223b733a33323a223765653937333937323064663736316239346133393664366437336461663838223b733a33323a226462346166343436663232613563393037383031626362613639306538313532223b733a33323a223131326163643031366666313936663432653565333262613566383636623038223b733a33323a226132366131373565376237343234653835623238396461313834626638633035223b733a33323a223230373630326330613739353235656435353434303736366665386663353233223b733a33323a223438613932653561666639616634313632313138383262383535636234616335223b733a33323a223265383137343063393766623530616532356666383761396135313163636363223b733a33323a226366326636346466326634626438343761663664373635656434343966616264223b733a33323a226664373964333762333835663766663438393562373364653732613832326461223b733a33323a226637343861343132303836396364316230653937623630636565633161633431223b733a33323a226434643930363039373065643936646533326532323463386331616538666531223b733a33323a226465333038376165323533613465663739383439393033326635313864613036223b733a33323a223435643166373732306464366530633835626532633061633061373734353439223b733a33323a226364313762373965636266323430616163346365633130366137343438666639223b733a33323a223432336635333435333134353533393536616337333166646364666161396363223b733a33323a223333383761316232396564336264626430363261306132613766333438396364223b733a33323a223235353662346134356535663130646337663864366537616333363138376432223b733a33323a226335363431313930663161353737653137623861393561633061666633366562223b733a33323a223466363139666462613530386366653465633239333761373034363163636264223b733a33323a223539663164303961656463323431363864626532653135373139363665616363223b733a33323a226231346634346436333261656365666665613435363934353761643562366534223b733a33323a226437643036656538326136316533656432653466363965386133366662666532223b733a33323a223138396262306638363461313939383837633662376266396661653935666561223b733a33323a223235646263323964643732396130623861663035343366643564386638313764223b733a33323a223465346332366531333636333336623365303837623233386461656533643263223b733a33323a223930363832656138396539646561663463646530343733363364346236313663223b733a33323a226261386564363939653934626366623238323439363130326337613533613865223b733a33323a226161333738656335323334313665313331306662383961343066363261303133223b733a33323a226536663532666565363538326138353336336262333036336564666337326135223b733a33323a223133343633383231666332383230636464363537346464636666346639636536223b733a33323a223264653430316162633232653461636334363264396632326361316562343030223b733a33323a226130303836376339383436393765623738343133653165623935343738313638223b733a33323a223136646334383836353033656266613431306666646463653863626261616462223b733a33323a226462303364663339383432616264636332393065396330373735343062333866223b733a33323a223539316536356439646134646232616536323134323538626536343438633262223b733a33323a223036326333613732346439373637343134613565373166616434646531343939223b733a33323a226361303862623634326133323230333732643134376631623435343863633737223b733a33323a223433356330323635346234646461663637656637623263396635366635383336223b733a33323a226433663532306433356166616563383466363432633339313161313437303330223b733a33323a223939383237323436316163356430323738363166626261613262633737393931223b733a33323a226535653961613561616463373234626330353163636337396664666263396264223b733a33323a223261383132613135656439353837346563373137383163336632346362353830223b733a33323a223134303930616537326162623333303864353762633636613139313039336437223b733a33323a223433666664626161613639366438323830636430613837666239383137363365223b733a33323a226161623531303534633038386233376562323465333937653234643436623334223b733a33323a226332306339623334393734663561346633386466383536353161623330383637223b733a33323a226233356536366532316665366362386531623662333561306662623964346139223b733a33323a223065653639323739623337373938353365616237633939333937333431383962223b733a33323a226536393632353030346637306138623239626634613865653866623864383339223b733a33323a223932386633633934386333356431343261616166366361636463333435383434223b733a33323a223231303234323431366535396264376330373566616565633432333833616537223b733a33323a223761623439643131633766373564333131326530626533303531633163656237223b733a33323a226531326630353763643435363038343039306235393539333630613631633030223b733a33323a226362303736633562376163633664343339653338333963306331666663666432223b733a33323a226535376162356132323637323961396631633764353565386366376465613332223b733a33323a226165353334353863306338643463396662303636383966373432363630323436223b733a33323a226238653363646132646136363936636262653961353963336666353334613665223b733a33323a223430633763396666613131633864346536666137353664663734623130343561223b733a33323a223562373561373834656666653635313663306334396535326461636530363939223b733a33323a223637643961656136643936643932633763356537643231636663303663333962223b733a33323a223262303532336563306361386634343937386338633965663330343139626232223b733a33323a223433333561613831666639316565666565303730326437303138346533663139223b733a33323a226335323734666365656532353464366664353962313830356139313635613464223b733a33323a226131386231623538383330656138326637303132363031396539613831323632223b733a33323a223861636631303033393037306630633563613334393732626662346562383337223b733a33323a226438323138333238663339363363633035626539363363306364623662393262223b733a33323a223033626264363265646366316562353062386636353331643032383763633366223b733a33323a223163393935613933653937643430343337343162326165386234393135303931223b733a33323a223335616464373032343862613434323164623061356436316134623034376564223b733a33323a223931343961643130333335643531363730353731346238663730623666636237223b733a33323a226439363664666439666132353439396637666438376234616264323738373833223b733a33323a223035356239346635386164653631646461616236306633383637333063303937223b733a33323a226139653264646238366266323365656433333964313865393765613831343035223b733a33323a226135343234333262333436623363323761306562636537626635613365356662223b733a33323a223564613738376136666237393365313139356135653734376339303665326462223b733a33323a223861633039666637666330666632333064633132393461396162366539623131223b733a33323a223064613033373033623431313239323366653637363332333538383936323736223b733a33323a223139393031633437653933386539383933656531333031663136373162366435223b733a33323a226132353464663236353763643233646439396465363932616363626430306465223b733a33323a223537386163323531663739613137313834663861363837383233663337353166223b733a33323a226665656664393339613839336334393939633539383061646135623862663361223b733a33323a223634623633376435393230313138646137666136633563643337333961623634223b733a33323a226262363230306566646135363465636437633362393738383333626132303933223b733a33323a223464383565353539383039323561376163666638623666663864313033376132223b733a33323a223233656632343563626561373762633166313436636665386463623765386430223b733a33323a223333383433356538633763333264646665366630383666363461396339393030223b733a33323a226139663862646131346537373361346231653232623532346366653961306236223b733a33323a223836653135396564333639613331633363306631393636333032616434373361223b733a33323a223936393036383732663665626539366537656263303631313335383336373633223b733a33323a223031373266356562656134633739396439356230346238363030663363613330223b733a33323a223962313163313339623466636364303861616464316633316138313935346164223b733a33323a223962383561353033316634393161613834303233666436323932366630386161223b733a33323a223965633031653039633238303935656536363738663432633035346261343630223b733a33323a226435393333663234323462306132383865396432326635383863663663376436223b733a33323a226162333464316262353334633434613939366465623162386361306332363430223b733a33323a223732366265333033626637636136356561646566346235323264383562633131223b733a33323a223666363166633762633261656534346362656230643437323734396134653930223b733a33323a223639346466663066306566316164653735633661623764613639666639353339223b733a33323a223461633734633636646336343533323831306432323666333632633935353439223b733a33323a226162313832616130346537636636306538353935323236303737376662313438223b733a33323a223865363061373238326434663130333136343137616232396531636365376537223b733a33323a223066313133633132656563653334653336343838633365623563343964396263223b733a33323a223238323538663538383531393863623235323862363631323163316164646264223b733a33323a226333386633376663613134623465633134623131643733613733656337356564223b733a33323a226566653065643863653365643333643763383365323966396365326162663565223b733a33323a226431323365316231663131383633343463386564626531343035616663656632223b733a33323a223130376639303538326163363663653164313939333766616230313062653137223b733a33323a223534346630306233316166366136633636616438333965313763366436393362223b733a33323a226438646434316539633737623063393931373437396131313039663366613664223b733a33323a223333643635363537633632396434383661333864646333363965623731353733223b733a33323a226131633738346438663463363136356430313938366563393234373730393761223b733a33323a226137343665363530363864396630353262653833333231613536623032373635223b733a33323a223636353537373235393465313937383233376465666134323763396530313139223b733a33323a223131653838653736376562613566363266343631633933303232343562336532223b733a33323a223666306334336665663733643537376234303561343761363236663034663465223b733a33323a223733653230336164396365653132363636343530653162616330633837633266223b733a33323a223730323862313134666337386135376165613262356330363861386531653031223b733a33323a226133633232333631386233333063336235386231343433653437633766336335223b733a33323a223630376665353831656332373062306237313833636463343463626231346539223b733a33323a223536323634623133643835353661323638313738643233386138343061383037223b733a33323a226131303035643866653366623435366137613266363564646438303566626336223b733a33323a226234626538656136393466643934366531666365646232323833353235373665223b733a33323a223765363266313130616565373534356165373633393132373262653932643531223b733a33323a226162666230656432313436393334643835366266356637363264623962396135223b733a33323a223933333937626530613533663363616237646439306336636665346262613662223b733a33323a226437303439323336623335353165663837336132326135333364613937393833223b733a33323a223362343737383235333537373565336339383732626437353338343064353563223b733a33323a226630383639383132386136313065313136376563643966303139343334653834223b733a33323a226637393131346637346539313532616333643261326531303538343033396132223b733a33323a223935613465366130303964626630346263353261653634643930363031643366223b733a33323a226537373533663637373761326531376563666166376239666333313232386537223b733a33323a223634653334363532633931393035633037373666363936383364343432303631223b733a33323a226335656532393533373937346133333231663030353430333938363735663162223b733a33323a226565393632663530326463353338626235313731636365653038653264643039223b733a33323a223632663130336530373437306165363633643138333464633664366230393239223b733a33323a226639313937326366316162663937343936396631363138643831346538313639223b733a33323a226435653934363738626536306564333837313132356534313737303962623834223b733a33323a223461373964353334346636343136346231343265323965656365336135396261223b733a33323a226634316339626162346430306165333066303539613939373738306666363930223b733a33323a226537633134623933613866303665313534666634633731663831383335646365223b733a33323a226165666537333761356564656263626434653065333731353730373436633662223b733a33323a223230663764386563386164386233626564636466636632333937386464346338223b733a33323a226631316265633365346536306335336338626638306363316135333232383265223b733a33323a223134656136653835666366323664323462323038613831633338333263393564223b733a33323a226338396236613264646634363262313763636537343830623363616537646331223b733a33323a223635366266636263346564653430303039373234383633323062313231623764223b733a33323a223830616164353165393235623937626332636231376531326330316362373132223b733a33323a223961356533626636643265383731653065356565333663343639643266303439223b733a33323a223935383362393631323265306464353666346363363135636664666564666232223b733a33323a223934313939323937623766643963333965363234303131613566666533656436223b733a33323a226666663339643765626439316232613038623862653165666135343135643663223b733a33323a223164626132343837643436333035343538646661353639326435656462333431223b733a33323a226266336231323665313537656538383336393335386237393065306436356239223b733a33323a226632343535613533363735306534306431386466643861656362643538373935223b733a33323a223436613831653938373965373137306339326639633935353265626433366162223b733a33323a226263643631353333653532346539386335623465333363366335333362633136223b733a33323a226466326164376135346437393831396438653235306236613334663533633237223b733a33323a223431373133623833363037363130646335623436656563386162363836363530223b733a33323a223934373635653136353930363134633139313231616632666538376462623937223b733a33323a223939343736656230363263343564386634353132373739376638386432396365223b733a33323a223132626538303131333963643131366339316339336163613865343234393664223b733a33323a226131386363643262633065333862356361626266633531663761663664663335223b733a33323a223966366435316335366163336439613364333963363735373865643030366233223b733a33323a226131323530353839353631633962663136313731393165373434633562356431223b733a33323a226332303463323763633664623463663665326163383538326432663034333639223b733a33323a226665356262623162653833666261653530353663643039333333303433636139223b733a33323a223563303761366335323165306162666333326431333661393462653035383032223b733a33323a223131346266653034653066323737356638333235616537633861633365326236223b733a33323a223735646238323233303030623236326136336462356364623631363233616163223b733a33323a223330336138316530363135343534343936333636343361343739306235636135223b733a33323a226663363034393838373466356430346434646466383762356539376334343734223b733a33323a223238353532333634303835393366623338373262343564623831393862663966223b733a33323a223965313437653561366233623738376232393463353736383638613738663563223b733a33323a226538356663316461356163356461643732343837323264356535623639353065223b733a33323a226533353663636436653839373862653833373535343162633431633164613936223b733a33323a226630663632323636626164393863626165646135376535366437656464353631223b733a33323a226330393961383965393238633439393463313865633338313865396332663264223b733a33323a226339663938653166383537353334653563326133393632363861613363346466223b733a33323a226130303439613234633636313861613137353964363332343036356438653230223b733a33323a226437356661353465653865383637393839343463363631383339343864646636223b733a33323a223934323763353835323934333166323936663864313530343530633939393935223b733a33323a223661613062316661313430356162386636313031633734656531303662346461223b733a33323a223536643230613564343565313137353135373161396137643461373666656537223b733a33323a223732323133323830316361373038363439313536366634653065393562336335223b733a33323a226337613463636532306638313530383337393664653333313462383334666366223b733a33323a223438386434626235376366356337303339313134613431366666326433353430223b733a33323a223364336266383230663038373636616637306238613638356665616439333230223b733a33323a223361396336393062663363613430646639613435613362646166633766653465223b733a33323a226430633662393265666664613135343663626465333538383539623630623362223b733a33323a226464656233356664653138626335356535386530326437663731376566323532223b733a33323a226136613161643166313063316363323065393866663061653661356362633836223b733a33323a223039633065616464343433316138623331343566386334343433653832303832223b733a33323a226634323438353964343831303137313431323963636165623832323337346635223b733a33323a226435633262613234363964616363333834633431656463643133376264333038223b733a33323a223938653437663437376532393966376261643364313731663839356363393864223b733a33323a223863656335313166373936633165383964633539626535666236366538363239223b733a33323a226137663466666163383830366136643337613233313834323336363437356236223b733a33323a223365376533613562663134333137376534373864653465353531393561333961223b733a33323a226539326233643963353966366636633065313439666532313131633831373964223b733a33323a226364653066333766396532316630323631353434336234393836623034383137223b733a33323a226536383462636664376338386362323538646336623336613830646438613337223b733a33323a223935376365653030323862333530303066643066363861366630663863333961223b733a33323a223536653235383033373730666539393534666664633262653230656561366632223b733a33323a223133383434346335613532353733373161353431323765633630616630303737223b733a33323a223265313935643434396232393461386662316535396165323465653934353666223b733a33323a226635633232313831313431633032393531646563663938323566386563626561223b733a33323a223738616334616431333637326161376630636230303131343063343632636162223b733a33323a226434383337353262626564396334333630363939303862303135346465653934223b733a33323a223939313830646666333636616237363464346134373432336263316238643061223b733a33323a226565303534383037636164333738336536316366656432663030343331313661223b733a33323a223636636562633732346164616563356564363335323631393065396461353037223b733a33323a223934396361306263653639336639383232323261363561663033323739623461223b733a33323a223338346237646332386336613866333261313163373137373266333932373532223b733a33323a223737653663323563303332366465396231383836663732326466366461643232223b733a33323a226635303261363536316630393963633037633864353731633261313632616138223b733a33323a223035663132646563643433303031303235316639393566373238653762363962223b733a33323a223639633635363361333639313563363931656164623639653238363437383437223b733a33323a223765633039353938656634386631663139636361623533323363366562313665223b733a33323a226433336362646433323935323838366562353931333137333137616634613431223b733a33323a226435643233633734653530313730656663623861383037363637373036363862223b733a33323a223565633935326361383638363064303865623433316536393431363930353863223b733a33323a226436383534646164613361366338303665613730386563613234613962653761223b733a33323a226262623436376664383838623032356230323134316665393233313261666366223b733a33323a223763626437636338353838633631353462346662643763666233666239303132223b733a33323a226631343333646364646630653235306537316233396233343665613039343435223b733a33323a223537653838663032303862623837316162366564633964356163646661336261223b733a33323a223230333264366230333731653163366238383563333961343835343334326665223b733a33323a226439613136646530303334323535303466333339653165346562363866373463223b733a33323a226434636432356431346437623832376664386561363962333930393738303466223b733a33323a223430343936373936656432313938396365633637663365383964346633666337223b733a33323a223137623163313765633533376634373938646633623863393838386539616664223b733a33323a223534373432336635356165353133373937396334653036313034626637626362223b733a33323a226461666162343063383336356134303838316264393437393161393534343061223b733a33323a223436366631346439646531326464653139653161323837383538386636333662223b733a33323a223133616130356633616639376134636439383835376264353864393262623165223b733a33323a223764646138363962393330306464323564343531393235313733653231633336223b733a33323a226534356431656536626336373235633564643764383837303134633138613933223b733a33323a226137646434626137343261356436616531663835363266333638336332636436223b733a33323a223165316466656534653232646530383864303164373962653532353333353365223b733a33323a223761616437323434353662303532376537616239383566383233623636653737223b733a33323a226636363162613735353030356232616436343063333862666630386561653663223b733a33323a223136303438303162653235356132366531633433613162316162633262653461223b733a33323a226538316438323032666230386139343732393430323931643163363465396664223b733a33323a226134633165643536393765306262363765653835356637323438666237323361223b733a33323a223832346235383437626563363531643738336462323062316365633233383638223b733a33323a223738363233353034633939623034323962373063313036356565623966653637223b733a33323a226239306433323534366135376238333164633430383838613433376465393632223b733a33323a223235653037393431623738336335353831373963393061663931626261613333223b733a33323a223935366133333334373666313532613337316132363537346236313264626133223b733a33323a226236636361643436306263373035363161353432333339326531303734363066223b733a33323a223033656265316463393134346130333365393035303863616534373035306564223b733a33323a223133383234363461626534313132313231373630313530323065636666653337223b733a33323a226361373461653963326638646466396531383862653261613638363237343665223b733a33323a223233643735363262623933363335333431626563323935376262633339383537223b733a33323a223862393032346337343239653633643130346566376563346661343535303162223b733a33323a223061336166393766353639376236633666643530386333616237643239646566223b733a33323a223436353737653939633335626438663330336333613635633536316434386433223b733a33323a226164653931646637633130663066386433386639396664303164306461303438223b733a33323a223830396437303630336666643130616239323863393438313030653639303263223b733a33323a226231633031366661663531383665373536303261613034663536333666393330223b733a33323a223637643831666535313133366634613331373835633863386134663266653939223b733a33323a223131393830333364303930313537373061633331323566613939343061346434223b733a33323a226566653265663237616232323338316262333563346439633135653661633361223b733a33323a223564653961336166346461646133613434663638316230383438653533613930223b733a33323a226462393030653764343531306132353164393236653766393763306365333936223b733a33323a223963323833326633353365356332303334373030323764303866326636326535223b733a33323a226438393266623765306138636133656263306533343866383037316364623135223b733a33323a223361663539346164363230393734663335373333363663373164336365623563223b733a33323a226361343837306332396539653835343935636161323333366266386635646264223b733a33323a226265363332623739663431326637363162623838323063363164393765363463223b733a33323a223366303962386336303831383236636366366230626462613731633632303434223b733a33323a223736333362656636636162333034306136366165393261383266626132383739223b733a33323a223937353361346235336265303839366339633866666134356438346232356465223b733a33323a223134616161373036666133653465646135613036616563623631653834396131223b733a33323a226634306563663264343562323962613530656236326632323462653961626438223b733a33323a226466633966383235376437353337373662313134393466653035363534383538223b733a33323a223463323865303264366266306661656663323865303237326634623238366633223b733a33323a223937343739326432643139616236333337396232383765353836333762623761223b733a33323a223964316136616562303563396661666632373230353738373665323365656362223b733a33323a223636626634636134393666643234333036623936643235393936656435636537223b733a33323a223535353733306562323135626439326265353066383666613736653739353664223b733a33323a226435316463343133646238343761396533393661383633316236373734626662223b733a33323a226630656339623230303235373239363933346662666137376337373538326164223b733a33323a226161316236323433653333653632383436353336393134613330623861666336223b733a33323a226663353735323032306666666433306265343861383564356336363530326232223b733a33323a223435663134663061636432613235313031663961316364356562313436373031223b733a33323a223033333836623966613765613032366338643863313866383265393762323666223b733a33323a223662336462316462363834313636343330336231656631313737643966616238223b733a33323a226337323266623636393235323032363333643331353635383134366364303936223b733a33323a223837626435336630353034353838303461396536386437383265313738373334223b733a33323a226631396664643135373665386139373832643364343763643731353137633334223b733a33323a223439346637363566666433353730353631643532353933393838316665643630223b733a33323a223861383264356438313131663661626234383731376662396562366539396535223b733a33323a226332363837633339346461623539373966616362633063653739633432656164223b733a33323a226564353232336232303134666632353963353962383064353661373937373939223b733a33323a223264383634333538356661373734383263613739326634663565633737626234223b733a33323a223036396364643532653435386666306339366434636639366335313730653034223b733a33323a226331333432373764626564636265303664663738356633396261623834366335223b733a33323a226232626536306633323264396231366137386531383330656130353530306338223b733a33323a223833326239613333633835666133313133353631616363336637383463636464223b733a33323a226432373335376230653161646463653533333837333234613661316137393534223b733a33323a223231323835363066613136656562303631353831323666386662333436316436223b733a33323a223232636136633066663139663238386138373231653664333261386530306231223b733a33323a223435643366376636613134386639396331323435396463306263303363373161223b733a33323a223065393766633861646465623764313532666133363233666566353962666334223b733a33323a223439333136636161353730653563663334663765326430613339663762393763223b733a33323a226438643134393535353130336362646135326238396561373766616539393233223b733a33323a223239663562653664636538353134393666636338303635643766323831353537223b733a33323a223135626566303035636337303364323363393731383536663230616536303237223b733a33323a223134646239653038376265353834623464616337626336353631623430323937223b733a33323a223566373337636539323038646464616663306433663763343137616436306339223b733a33323a226261646439623732353731326566633235366333653564326261393463356234223b733a33323a223664613330313535303930353633343633343066373235346231643766616234223b733a33323a223762336133393030356461633231393937643136316531393834326465616338223b733a33323a226132623165626636383739323831353066386437333665616334663561346633223b733a33323a223061326239373734613061636636633031383439383033336366343537386230223b733a33323a226135633834383537643839663837353031653866396638633031386265656136223b733a33323a223666653131653362376635653837376139356231306266303636653536386231223b733a33323a226332373931616138306564343139343331313434663265373435383631306330223b733a33323a223261306462613935363030616639346335626534623835303866386364346135223b733a33323a223635313764383037353537353063306664326565663663386435656234383266223b733a33323a226437336562346561343032336634376531306662626265303062333031393661223b733a33323a223866666566623464653230376535353035366165376162303131636137343939223b733a33323a223839353230373566636131393333383030346361353366356164363965383739223b733a33323a223965316663666564393265616532636161336638666163386537363363343436223b733a33323a226539626265386235353666656133613331336137643462356339356462366462223b733a33323a223332656538636436373837323263313434393662623737323330313037623863223b733a33323a226562356566346338393031633633343034336261303838626538643965393361223b733a33323a223235643639313934356565326231666466346463336362333738663561316235223b733a33323a223261643630386363383939626338623734386461376464303662343931373333223b733a33323a223264343165613239313833323333623035316361636133316436336230373261223b733a33323a223736363835626266663738383039646265373666363361313262333934393334223b733a33323a226665386464663963306331646135623062623333353733643931323235323833223b733a33323a226463373832623565663661336537313830636236646263303234323530373031223b733a33323a226562613962376236623866653735633539663762316134336466383034303765223b733a33323a226633663630356366306364323962653961363165643833376433353766383234223b733a33323a226534643933383735393039373534313265393331343239363231366230323534223b733a33323a223661376334626161356434386161353364323962303162336333353432623835223b733a33323a223736366462386566613437313836313130306638343864323666333631346130223b733a33323a223030366163313165356338306463393038373736616238653035346463633263223b733a33323a223864636438396461653564626266396533333638343563393261633030613733223b733a33323a226462306437323937333439616666336134326431323036373536633965643665223b733a33323a223064396533363037316133393230656464313731326137383934303131613666223b733a33323a223931363339353663336637643662303330316630363338373036643831626238223b733a33323a223739336434626462353336636561353333393566366665656630313165376137223b733a33323a223335323165666364396333323339376338613237323262623561363137313333223b733a33323a223530346533636632303763613831626233373530393866646163343935616232223b733a33323a223363623539376133353034376235393532313638306162363631386339616265223b733a33323a223362383236333662313733313238396233623436356538656434346537656366223b733a33323a223030346562306262303461396362663736643437313336386633363433393131223b733a33323a226364373134646364336537613364656639353365383634386230383265373238223b733a33323a223636333735306138313530396635303533366564613936613865656633666166223b733a33323a223463356463613439356566323432633631366531333639356461306362626661223b733a33323a223039333133323062623535366635613138633830333163623030633965363064223b733a33323a226666363232363833656139333038343965393932363632383730326534333433223b733a33323a226237626639376162353565643234343865666666623731363534643236303231223b733a33323a223961346538323933376564633931333330663238636661373363303435663230223b733a33323a226666323463383032616362383834333937316233653666326536643665366633223b733a33323a226163323864306339663736306333666265653731646436636365316138633964223b733a33323a223862383063393263303530653036373339383963373963616132666165393233223b733a33323a226338663562633332316162363635343239356233633862326664373536616666223b733a33323a223336613632623136663838613736633033366561636337396633616234396235223b733a33323a223563346235393161623662346466653038643530616238333435323930303130223b733a33323a226262373862306437636636306336626433653035643463353932303930646363223b733a33323a223832303465306365623866373034383030326361393234366333326435353038223b733a33323a226230383739663634353862356562636261613339303739396232646434386435223b733a33323a223839343432316137353732653535383435353934633732613162623531356231223b733a33323a223632613831666566623364646238353663323134633234356438663765613235223b733a33323a223762353739636237303931306637663637613965353262326332346530666664223b733a33323a226661303535373161646365373538623964373064306131383663313334633931223b733a33323a223835353630376337373564323935653136353463303139383039636566653533223b733a33323a223236613230653464336366393334353564393631353138383464666338343630223b733a33323a226137633837303630653865363336613736613232643432383766623962623630223b733a33323a226433393131366432333530646566313563323433353932383832383037666366223b733a33323a226335306239666230303235303962346439363134346333323166376165623931223b733a33323a226237373433653736663630393535396264646461336464303733393938656630223b733a33323a223638333266653666316431303063383364393966386163353532626363333432223b733a33323a223639656563373461353634353566303262306530383562396432626331646566223b733a33323a223230356365393833376338636633626666626438363362343564373435336638223b733a33323a223766363731313533353438323362646265323937633762393330656131336663223b733a33323a223032313863333332356539346639653865333463303561333739326538633836223b733a33323a223763383962373635373739303135313035653736663337363562316636343265223b733a33323a226130363035336663336666323134616537653232333061313933653335626363223b733a33323a223939363661663737623736626338623563646164383064306465373738623966223b733a33323a226630626433623061393038393930633664313466376639363664633932363536223b733a33323a223131386535383930623765393561383064626465316439643533656530353263223b733a33323a226636626331333433316536343334643839376262336635353136366264383266223b733a33323a223238316131356635366565393861666638333238393036643366316662323332223b733a33323a223231643631643833383365366163346230353133393733386462306261666339223b733a33323a223935366265386534326536383031376361633638313663336263333865636537223b733a33323a226162656564643930326262306666653534633139663236623761303538313265223b733a33323a223663343162646464643865343265636365643532336530626436326130333363223b733a33323a223131613039316136333837653736363165633530363865646531623964623962223b733a33323a223633393239306537383832373865326461353333313965383062656330353035223b733a33323a223832346534366666353263363833646534343138363162636631326263326636223b733a33323a223462376363343139333837393635333261623930303336376234373332373831223b733a33323a226533623736383236363436663134326336393765316362313134623930316463223b733a33323a223735376132366339306335653133613262656231356432393663643131343036223b733a33323a226533336236633534353633303266303435303735363830366164353365363437223b733a33323a223164333838666137326663363232633239316135316366643330336635303836223b733a33323a223961633163386364333233646439663334663530396666663164363236656636223b733a33323a223530363162376361316433366635316161353536363437393539396637613531223b733a33323a226238383538393434653164353266613839636339633161613263643135643437223b733a33323a226163313734643633663836313562336264373066303961366137616332643964223b733a33323a226430303837613962643032353036346238663732306233373130663539623565223b733a33323a223832323330313762613235626433613031306238313963636235393331613534223b733a33323a223130393162386331383362623433316330303539626466393938346262386234223b733a33323a226535353165303335343437383335616334663864643630346132356635333233223b733a33323a223838663665663565666662333535653965336235326337326538373838386131223b733a33323a226562316564386138616138666565656437336534336431313733613465633061223b733a33323a223837643830616135396530613732326235396633353433396232376138313835223b733a33323a223330343866363536333064313062646532383562386137386136313661326132223b733a33323a223338613337316462326566333465363730616235306533633966343161323266223b733a33323a223538323962666333376336623636656661633639353338643536636230316164223b733a33323a226661316437643238306662613533333866663632356266613330626333396163223b733a33323a226631613664306435326665393266396532303339356661383835353264623963223b733a33323a226332303463633561333166336230613732313032303264313865643964333036223b733a33323a226337306365626336363930313664623464353833386566333962323561363231223b733a33323a223233366334646433323230646366303830366366363264343462373938306165223b733a33323a223164323930633334613832346230333034393031356637333830343538656363223b733a33323a226662646133643661396631643335363366346539363438333065663664353765223b733a33323a223661656164393063343830623836663837613239336637333162383937386265223b733a33323a226366386332393936373139343464653433376236643432343836613039373435223b733a33323a226434396132663632376433366661306166396633336531306561626439626434223b733a33323a223836363533613330303366373336326232383561366439646134613762613230223b733a33323a223265343839613134356131643137333932636162303466326566643939636631223b733a33323a223332653635376563643332643766336566633838633464373131303137626338223b733a33323a226461336466326432306238383235313333636661613330326661333638303538223b733a33323a223430613135333230393062643033363138643734353333663237653431636230223b733a33323a223966343062396264373832313132306231326165306631326535616230363630223b733a33323a226238383065643765636437663537363362363134636262396530353939656131223b733a33323a223737663639393534663464633931383631366662653133353539363634656533223b733a33323a223364383131383538373730363734326332383964373638373834663861393561223b733a33323a226261656637346535663636323235626262666262386161633238383732653337223b733a33323a226365613866343461343833626531633437613133623563373430643363613034223b733a33323a226265333330623062323431336231663731333939383137663531636361313137223b733a33323a223632636337393262663831623039633661323333386233383237613064323437223b733a33323a223434646133646163313136333464353039306131383235653832396232373932223b733a33323a223235356636633764396636376663363034646137343938336561623835396531223b733a33323a223233343639346637366265653261393566326630356436383430363162633662223b733a33323a223638633631303332363763393736373133326565646236366566383131653736223b733a33323a223238646239316162383465303534303462336236663034333739326631643832223b733a33323a226465336631663039626635373431633134643630386261626434626165666631223b733a33323a226365663362306263383163613265613666376634363131326638366436373564223b733a33323a223836303333626332656334323738336331323366343039333531383235656432223b733a33323a226136396265626231393436333866623564333439636238303532326666306366223b733a33323a226639326537313063313632396331396432383836376437383731343562333332223b733a33323a226564646133363362333561663865663564306663336539326336386366356434223b733a33323a223464313537613732376434633031393633373335343933303362376162336631223b733a33323a223239636662376130313437323237323538643164313661313437646437626261223b733a33323a223338393338313561666537636239653565346435343564623563643539313532223b733a33323a223431303035386365656537646634373865383935353864653766633362396633223b733a33323a223934643235643630306435313331633266316139393632353765336338396338223b733a33323a226432366564316562653536613831303430653738373034623630353435383532223b733a33323a226533346566303535336465633332366539343063373838323964663165663438223b733a33323a223462663062323066373262343661633230613435666466383731353731306238223b733a33323a226439303837376634356333643263323366623965313866393763366636623865223b733a33323a226533623062393131343138623065333461366263356635613665623937643136223b733a33323a223966356635316338653538383665643031376335346535346130323633613934223b733a33323a223533313135363633303135633738393166363137333132643663326134333731223b733a33323a223636623838666262353437653931366331313662333831623361646566626633223b733a33323a223638373864643731323432396361326138626666303538336338666438396536223b733a33323a223730633237366430346335343965656234376335313164313239663939663935223b733a33323a223830356437666637336166623566643762313330336430373830393232323837223b733a33323a223036373332613361653735343739616431353136383333393663663762636562223b733a33323a223238313663636365643066653037643439343663623836323336613830613536223b733a33323a223136396532383633623430313138333936323531623063393330363236623538223b733a33323a223030643634653230663262363264326361313139633932383665636362313030223b733a33323a226462353138633834663263646132613536666531393838626431313437613233223b733a33323a226261313261396634396363373132326637383838306463663539373233323861223b733a33323a223763356164383233626661616462306365373863663438333538393165373964223b733a33323a226537386230376238653439623362333662663833383634656633663734643735223b733a33323a226338303733343330363531306162303339363736303338323335666332623933223b733a33323a223632653733393164373037633634656136653362333565393832303333643764223b733a33323a226439633234636162326666343733623834326331386165663061356235363135223b733a33323a226337336531376266346261613562393632626430393631633461313330383838223b733a33323a223534656662613865396631613738396431646431343837303365363563666138223b733a33323a223839373435383630663932356366353536613634383762616363333463326166223b733a33323a223237663964393638613436323166353731646462636432343762346634666432223b733a33323a226134643032396237333563393030353566323136336236386664313334326362223b733a33323a223539373730326462626138646236366239336233306262643131363536363539223b733a33323a226430303065343734353331653733383661316639356366613034343833363335223b733a33323a223139343633383134646165343962663133633564353136636538643630656635223b733a33323a223864646262653239363766336239666631336630383465336538633739633139223b733a33323a223934346333396262316530363438616636326564383862373862396463373863223b733a33323a226138393530633533316237373235333136396236623661623936353066393037223b733a33323a223061363464636637633536636133396361336431333635333137353936336362223b733a33323a223430303063333736343033333162633038336262633833623564373866663331223b733a33323a223066336334306130376131303836643039306136363039663732653464333338223b733a33323a223735626564373036346532393232333166656531653237613134363737323034223b733a33323a223361633265643264356233626565313461666333393639333331663039383064223b733a33323a226335613637343032613566633761303733623766356461346162663661323636223b733a33323a226139393864656263383663306335306364656634313432336466303638613863223b733a33323a226263613232303938663336356636333563643833646237613661303433643337223b733a33323a223765663332316233376461366266386166653635623935316530656563343965223b733a33323a223732643632346637363232333938343437323437363834373631363466666433223b733a33323a223864643433336265633733613336356162323030616663386333303936346465223b733a33323a226539383263366265623362333264303464646164303631616461663836363463223b733a33323a226166336337356536333736316535353439306437636161373230343461663035223b733a33323a223537643666303739636462373939656164613264306132653039636538643038223b733a33323a223065326564666465353866353065313762343139633363376433373862376463223b733a33323a223861623064306436633336376564376164653962326635623761303933393130223b733a33323a223063353564343130613531383335313135376461383761323538386166353735223b733a33323a226362336230376465346461623332356533366565626464333165363030303831223b733a33323a223464616230333665643139663264386635366330613838663863613735396237223b733a33323a223739613265373033366133376561306561363864373564663833353062663938223b733a33323a226232393836353438306565393861646338613739363336636235343235346363223b733a33323a223737363662346335326639373561303636353862653362636261313733326333223b733a33323a223535326233363333633566343033626639643865616137346161633763626262223b733a33323a223065643864396561653639653266376237356238366138323638373864346361223b733a33323a223830636339346332616439386663613163626363336464666136323263376663223b733a33323a226330613436333263386532343831626233306233343064636535373534383836223b733a33323a223434666638346465633935353264356562626635316365393533333631323933223b733a33323a223231393834626365633132303361636662633866313939636232343566353961223b733a33323a223935313665623431343166356638623661396664646530343165303165623463223b733a33323a223664373538666431353263366135313130396232313662623238653837626463223b733a33323a226533373264616261666636666532323263356532636434353836613266626232223b733a33323a223633356538353031646666383835343731633537353532323836363661313533223b733a33323a226438353431303761346530366161303238636566323965363965646433333332223b733a33323a226432653237326339396230346637643666313365616365376363616135393863223b733a33323a223564396632366135643435666636306630306530323534643130383964636138223b733a33323a223064613638306163346639376439383562653236303239626633376561613632223b733a33323a223139623738306164636433643638323635383333663135333930343065373539223b733a33323a223937363731646330303164353737326133323366333839353561386533343065223b733a33323a223633383465643235303161623365343965303632313336373662343437643033223b733a33323a226161663964333865663462636430386665653133373634343638353032396331223b733a33323a223463656562396137383666663062343031303230363537343661643635623161223b733a33323a223834396564306536616662373432653762646236396638383331653566373139223b733a33323a226666623033623365363839636161383863653263633831663862353736393565223b733a33323a226665616330333633393133363432633765336564386538363432666538613735223b733a33323a226365373635663361336136343162643962663139613661313166333633343862223b733a33323a223439313938336138356662323532313530633037646632623866653236316664223b733a33323a223235643539376131373964656135646634306131383135326663313161663133223b733a33323a226566616536373037313937383864663461373861383132356635333636366334223b733a33323a226235616334303032386230353965636362623864333763383161613634383664223b733a33323a223565326261656539366136313163376535646263333162303638363630323634223b733a33323a223330303664303637643739653334343235313561313336633566393266656462223b733a33323a223638393830303066376163326664663336306430393235656465633637333365223b733a33323a223966643063313337643530313730646231373136653563316461343634323663223b733a33323a226161393865613038323438306235643433373931656533373562663935646339223b733a33323a226439353435646138636663636335366164376637396262393938396131626336223b733a33323a223963383463613862386561666237356565323134346265616464343934656661223b733a33323a226165363237323235646431646239373063633362666230653032613938353237223b733a33323a223162623533666432386139663461363139336231383762353634363939393237223b733a33323a223333343266626665316434306465646361333439623561336238346438373865223b733a33323a223538623732653031313830306635373733303439396535646134333764633734223b733a33323a223733636231336538343737643864356165666435623737363437306433613464223b733a33323a226564316462353264623835346139613261643337653434616235306135613934223b733a33323a223034353166616462646631353039666531303664626164343836333964626161223b733a33323a223639366232646333643231303863623530356133633762633736643831386162223b733a33323a223538343630306437333566383265666530653861386337633734323666373431223b733a33323a223232613565393339373532636139313231353639333666316262613662313138223b733a33323a223938633439376565653137663832363430613039326133623634346131353262223b733a33323a223636613431663334366538393230656466356564353466356633613238393134223b733a33323a223134303833353734303462636433666433356538653562356364326161316636223b733a33323a223133353335656237303263663238373861633032356630653932656161653235223b733a33323a223235363030313336363436336265393761623138353434383162336239613531223b733a33323a226665333131666439323264356464666262393236636239616165383931666466223b733a33323a223162306231333963346666363066323230303132356437363135323964383434223b733a33323a223534393837386537663633353761393334363364623535343036663730643539223b733a33323a226566363231336339323135623964303531396163393539633964626435343630223b733a33323a226337336539636162656163656562623063316266383238646235613538663030223b733a33323a223837346536653066636665333261386635343939616436633733626431353636223b733a33323a226166373432373739313561313263653037636537393136623333353439396535223b733a33323a223962623335336333326362363464323932323865306633353630323431323663223b733a33323a226632393865666537306264346235373930363566333937643266313534343462223b733a33323a226665643562646161666633396232333532623732303062316362373632613631223b733a33323a226538636662393266326331303364613636383365323066373431643430623436223b733a33323a223330623165363338616135313465613562393332393539366134343631353139223b733a33323a223135356130616538313432353833383861376633623863373965356137646636223b733a33323a223134643063316335623236633863653337313965656461313163386163333766223b733a33323a226462616330316166623932383030656462613238626465363665373839373763223b733a33323a226336363532353862336235313964643036396331636239373339643030363933223b733a33323a226331383361376330613266353463303731633636386265366538616630313533223b733a33323a226662656132373162633931643139663566376237643833616135353732633266223b733a33323a223161623561636333393435313837386530613163663636303636356435653866223b733a33323a223431336664346331353035626266396262326265386635636161343637633036223b733a33323a226562353930353830626433366164343237633333393434366436373933336333223b733a33323a226536363034643838636433666531656639366334383262343966636233623133223b733a33323a223333386632333961643963636436346331626634633637343831623065623632223b733a33323a226164663432646333623238396437386135633434613632636363613665393437223b733a33323a223631353531343033623266626236646361656464633335356333353939643239223b733a33323a223836663139343630353934643134333762323939326263313034393562636433223b733a33323a223932666630346566323134353765316666333838383336653463343030333064223b733a33323a223866396233656166623861383236623234653032353638303836653036336330223b733a33323a223135326664353662663633333137633065343934396237666661636434363235223b733a33323a223938356539323330326536303137613139363433376536656333616263306665223b733a33323a223034326531636537386633653831333230326132323635353664303965343736223b733a33323a223431626431633534366632633264353739613334393335306637643263333438223b733a33323a223031656138653838303530303639373566376631396531343839633232633761223b733a33323a223735643137393432373732316465653731646166343131633965313438306230223b733a33323a223666613532653266666565303230303130383866363337363830636561396130223b733a33323a226335316562356337333835353637383033333330393165323664653562613962223b733a33323a223732313430646265633531363038363638396536363535336362306438336236223b733a33323a223533306535333834653163646562373431333431663961383638663461393731223b733a33323a223231653463316535363639333732313865343166326365343563303061333335223b733a33323a223761636461396131346633616561343030656266383332323134313661396363223b733a33323a226163316366376530666632636332653762396661396635616462663037393536223b733a33323a223236663133613337653461393033383434313832663862646433643730393737223b733a33323a223263653439323064356537656535326162633764613237663433346534313063223b733a33323a223832366136306664383036343464656465393138396261336536393132326633223b733a33323a226532663338333237373864366163646330363737356136666238343236613934223b733a33323a223866366365666432363639623635653532623561646137376534376130376565223b733a33323a223136366538666331646366663764356137326163666638386338336338333932223b733a33323a223463633263623833643231313336656563616239333937613130653031356337223b733a33323a226330656135643666623730323964366238363164353334303765323435336235223b733a33323a226236363561323436343262393934353338353037636337616435393836333634223b733a33323a226438663664323763626264323464636437633463363439303139663165663665223b733a33323a223738636661306539623566353935616364386234663832626635663461303564223b733a33323a223463353633656139356431623237303161386432633761386161613863343130223b733a33323a226165306430663733663237383466356165356632653566336664633766663138223b733a33323a226561363865303161333739623665323631346539666133366539646166646139223b733a33323a223936636361666639316662346439323535383633356235376565633662666530223b733a33323a223761623264633865656236636231623839633163653963353438626638643830223b733a33323a223933626166366634656335653562323231613461303266303265613838326537223b733a33323a223965623838346331376561326134613435326330663362393061313463303566223b733a33323a226264386634613264636431356438303265366535626435363835366234313735223b733a33323a223464363666656139326566666466663639643161323634616366393963666430223b733a33323a223638363235323832313163396239333935376137306531303661336664666138223b733a33323a223330393034343034653236656339396634366661363839633261396233353635223b733a33323a223362396131343730363132346438356231643262363064366536623630613636223b733a33323a223133633030623235626133323431313861323865633138306538633435643930223b733a33323a223733646264336239623231633732623937613735656662343466343730376665223b733a33323a226137623539336161616637653032663232626464643838663130653161613465223b733a33323a226139323533383961626634643537313930363366363634626239323462616236223b733a33323a223130303765323432623832613031633463623130363138663863313833346132223b733a33323a226435333031353432383666323066636135393231623431306637336332313033223b733a33323a223262393537623037373962366561346238363835626330343433386633353262223b733a33323a223439653939393832376230313933323465323130343631333166626338636333223b733a33323a223861383335383966333338623464393038613930343831326661633035616631223b733a33323a223332343463353331333737316630633637653331393363313633396335333964223b733a33323a226661616332656361343236386134396664306539623932626564326237303233223b733a33323a223830653661353062646430613731373364346361633464653962333437333864223b733a33323a223139336338313862376634333239326566613638653337353631616639366331223b733a33323a223662393439383235616131636430336636373263353966346633666166383863223b733a33323a223761613163646466373231393534386265636163346566316532383837663261223b733a33323a223234376638346535643037376362646164386439333230396434393361393038223b733a33323a223932613761653865363564323038306464323736613964646635306330313564223b733a33323a226165653034303862646538303432353331623837393938373333353462646633223b733a33323a223530386438633538363061623735376532633764383730376138363363333239223b733a33323a223736623439616363396335323663643334633664613162366533396432306334223b733a33323a223266343137356236323263633438323561646331623665306362653366373061223b733a33323a223339653839363038356361313464666438356462393766366638303065396563223b733a33323a226434613736313236613462393037393637616435646362653562346363356131223b733a33323a223532316639613231386533653536356534663461326334396265333135636365223b733a33323a223261646138303131356434366164346361613437633961613535396562373632223b733a33323a223439343064356463316632333938363031643563383362323530643232616632223b733a33323a223735393835346335353439396161663633373964633931393863353139346162223b733a33323a223363346562396633383235656662383132323234623532616166623535626466223b733a33323a223338356434373665313937363534373739636161373662303361336533643161223b733a33323a223938636234356566653838646462653766643162313164386462313966613936223b733a33323a226635633166643161343937326362646532616537646134623139613538633464223b733a33323a226236613036643062363161353865643166663565666138393165356430633262223b733a33323a223562373766616265373039316165303239333665346430363330316162616239223b733a33323a223565353231373562613361373431666237393938366665633863316565653462223b733a33323a223666613762306638363134303166656263646338306336653466376563633365223b733a33323a226364386335383265376532313038636364376362396331613164326637353363223b733a33323a223633353164366439313531373831636331383262313332656161653938323163223b733a33323a226538633062366632303930626561616334646163346636323539336533616364223b733a33323a223766623837373039663461633738356561613263383730326237396537313734223b733a33323a223962313866306165653363313164393136653731326533366663326663356661223b733a33323a226438303863313434356161333064356535393639663833383733613934333164223b733a33323a223634333439633439633263633463636464303762646133346161303139376230223b733a33323a223266363730373130393637313563396330323563386138313632653136386135223b733a33323a226633316662373538326464616161373630663232653932663636663439323633223b733a33323a223634323536343465626632626338306432373434313631653733643038663532223b733a33323a223664636238663266386234336331303333643334303631646436326638643538223b733a33323a223537656631383239393638663334303966353861656238393339636632303133223b733a33323a223734396239366133316365386462376133653732333630393738633064353135223b733a33323a223435373161646439383362333265663934656464336433326438376633383966223b733a33323a223064316538653138366664346465333235653730303764356265636538386564223b733a33323a226366383331303464663864623139316435653066643231623061336363323465223b733a33323a223335303761346166633336306632313230316664313439616537323930656261223b733a33323a226232313438333935383362383934383737373035366232386233363332386661223b733a33323a223931366363323563663362393938663735386535646164303833393265636161223b733a33323a223566356637393830343863633336356438383734623363316463646531373233223b733a33323a223065323863643835633734333035323733313334626264316161666337363135223b733a33323a223531386635633162653366333166323437303333626333646539313139363035223b733a33323a226633656461313166393435633135363365653766376566666664323365326637223b733a33323a226438346239323434363232333339363037666637393236633134333036303462223b733a33323a226534373337613166363266323866333732636238333335363835303565626330223b733a33323a223935383861643464313035383539653438393638396630633137626264303730223b733a33323a223065373666373539376531376238373964383237666339383033653063393434223b733a33323a226437393139306238663535666265663833303765623138303632653136636339223b733a33323a223862353137623039653039666437353466636165626333306538626633653665223b733a33323a223466376133376139626438373966303634353331653939396566343831323834223b733a33323a223739653138636630333663373830323939386661623039356630353065643433223b733a33323a226438326264633538666238353933333730306431616639363835306237643861223b733a33323a223964366461613237613430363563626163353339613464333365663231313334223b733a33323a226535643833313337393166626564356135396138366631633961323936613531223b733a33323a226563633037633738386661363464366663366431333733323961633939323037223b733a33323a223035366664346265333264663335643866343538623265663937313562356164223b733a33323a226362653531626337633831653032616436343731666639383434373562363661223b733a33323a223837366566633836383563326439363930643538333166613737303135636562223b733a33323a223061636438393865643032366635373061623737386361363434653335653735223b733a33323a226434613536336166333462613566393035343231626332373162613238643437223b733a33323a223262383766356562653037316630653162643664323230373434663566323233223b733a33323a223139376163306436323063643736313264626630656637633636653838646366223b733a33323a223835663630313834326335623832346135376364353166313136356662636632223b733a33323a223761356533613339346166333166306136663836393065376339666534373533223b733a33323a223762336535393962633036636165613961303539633630396461396538396437223b733a33323a223862333136383061643636653963373930336637636161613861396133633265223b733a33323a226264303564663136396565313164336332623365343331316162323361663734223b733a33323a223331626664366237646536653539363266326430323563313139633564333839223b733a33323a223364656664303838316666636537323234323830386337346438643636373230223b733a33323a223365656539336233386234343465383939613033333938303864353431646436223b733a33323a223137616339383537356237363239336539323836646532666334313336396133223b733a33323a223461613830663735303532363131343430363831653034316334343365336232223b733a33323a226566393666616133316137666561323731656332313364343039326638386633223b733a33323a223736386263633463613631303930643834383864333135656231343232316365223b733a33323a226230363130626437613730343661303038653638383861383137646464323966223b733a33323a226561366662313463633263313836323137623562643032396337663432323337223b733a33323a223365383834653537376165616631346165613838363436363038653635623362223b733a33323a223732303133333931653037613833353064656365343131303162383039666539223b733a33323a226666356662336163396535353263663161343963386538396435366234306137223b733a33323a223434393732303264626165643361393530303736323830383739366631396635223b733a33323a226336313766306639323765313165393435643635623664313465343564353061223b733a33323a223737666366616231326161643462316565313337393965666263666534643934223b733a33323a223263316232303939666663663836643031303739363166346233643733653762223b733a33323a223432313365616165313962316232366234663539346464336561343364393835223b733a33323a223465323838366261643635613033636365633638383938393565653137386138223b733a33323a223962353062383931376138373131653163333663666664373562373837313535223b733a33323a226232356261343539383932386539633838313864306561316365326333353931223b733a33323a223339386237323630343462373634376430656639313938646636333438643530223b733a33323a223130363434323736376635393835393064376130663832656136313131323531223b733a33323a223733656164663761306361306339313835323333333537653234393337656331223b733a33323a226162323836373664653636303932636230303034306536366336663164373834223b733a33323a223234393034326433333762343562353637633733653663373932303131313633223b733a33323a223134366535313936363338643337646665646161336162313632393031623033223b733a33323a226236333331303366353964623934643866346630353434663163393966333138223b733a33323a223566633765623266613264313064653934326662613564383334326661343638223b733a33323a223535613838343831613761313666383066623534663538353837366366656235223b733a33323a226364656139396263636661333438626661666461616364346536653261666265223b733a33323a226332643834656338356231383835663034376238623537373731663233666464223b733a33323a226637636262656331653963313533656566626538333835363437303834333535223b733a33323a223462343564396134303536333530613163626262343431626231663366363437223b733a33323a226233356338363938396239623733343961373232303136386565636337373334223b733a33323a223565393363663731626261616234393332626437363332366234393535363232223b733a33323a223064323131386630643765386366386230396634303665333061323262663436223b733a33323a226265323736633462306462386535636462653539663639303132336536323332223b733a33323a223033643635366337363034363430303030363064353535636334653930363535223b733a33323a223437386366323962316430316263656639616531373165663630343332303738223b733a33323a223136623465633466356465373634343231663230326565366631363830313134223b733a33323a223135666264623931616334303039363832373465666133653932326163393638223b733a33323a226638343838353235313738653535303439356139616638623033386234333632223b733a33323a223263306130643439613039313064376363373630623466333365353138323631223b733a33323a226461633634653035643866643833356263643130303038653639373562663764223b733a33323a223566323339366366303363616338646132666633376566663535623662303438223b733a33323a223236333833626534313739333066363838373336353039636538666635383862223b733a33323a223533313635313562383865373637623432663866363636363965303331613239223b733a33323a223663636538666461636632306266386138306233636263353066643037333230223b733a33323a226534386663363964633436303365653366633337653561336630323863643462223b733a33323a226430633264643031363333333666653965616430646630376363643538333965223b733a33323a223539333564373339346438653961396630656362663364353763386462353064223b733a33323a226437656637643061356436383665656365613862633362326366316362646637223b733a33323a223862356533393230363562373664336131393334633365623061666361373930223b733a33323a223239613137323461303834666334646563303563333832336465333434343562223b733a33323a223364336535396463393736376536353732623464636537663239383963303665223b733a33323a223465316261353733376534336164366132303335633863333038373434303365223b733a33323a226138356264313832356337383661396138353663326535323539336361343238223b733a33323a226466393962653430366337613764363238333465326463356330626366393963223b733a33323a223035376263323730626431333866346531613135616566396436393163353032223b733a33323a223563353232396430616534326465396464653337356461396535616638303437223b733a33323a226165393432333530653337346333626232656633356432633132316339663930223b733a33323a226133616635383531393465303637373961616463633061653135633939626164223b733a33323a226437353064313064616162393762666563646636383435653439333763343436223b733a33323a223530616533373863336530363935316639623562343862643339313465663765223b733a33323a226230616164646462383361623162613634346530626466653630393034383163223b733a33323a223361363265356638396339326264393530653637353137343138383537636664223b733a33323a226662366232653262306265373461393262343264656162633764356632653435223b733a33323a223965313564663238623531383136363033393961653236656665613865346135223b733a33323a226132623032326362643835653832336531663935383365376262646630653932223b733a33323a223565623835376234666562633533663935316534393332393832613064333339223b733a33323a226165326139633739633162313435343430343536343833313735393766386562223b733a33323a223536346365303533383034656130333830653162616535613732666239663765223b733a33323a223838663537313237376463653132303337663763616635346335373438653031223b733a33323a223463643136636439383161363861313338663933666332633239343961306632223b733a33323a226531666264656636323238616362383339653762316437643433303831316639223b733a33323a223663363266336266626661623966643339613839666465616562613833643662223b733a33323a223437376530656438383831356639656263326361353236313363363662306431223b733a33323a226466633637383565363835363133323834623231366332333039396665343632223b733a33323a223163313438356664386465326139353031323835353538663264366533343265223b733a33323a223662643732623963633035343137366563323266633533353365336131346366223b733a33323a223233323530363366626436356661383236366165313030353261303031363263223b733a33323a226162666431346336343933653662643636626133623537373262383164333135223b733a33323a226233316563306435376461303062323763376434393938663530613862663061223b733a33323a223265373464316439353561663934666533643930623737653533303539663533223b733a33323a223365643564656431643761343536613164646239396137666636396430313331223b733a33323a226633666561663633313262306661386639346536613333363734656135323733223b733a33323a226236666134386430623365613832353738653239643861303865376539623435223b733a33323a226166393462626562303763303034356163333435323533313061633163383361223b733a33323a226339313566303330363535316663626437343463343839643466316565623135223b733a33323a223532356130386131643563316630383766346533376363333339363633646239223b733a33323a226336623566633132326439323366366665346239313565643434373037623932223b733a33323a226432636135353463383533656164353666396561613035363732646164336235223b733a33323a223031373766636264386337366162643839313765653633393466623565663837223b733a33323a223366353436626266613639303235333538346639326633613030363966316335223b733a33323a226131353732393638323466646134343736393930316332666330333165313632223b733a33323a223561353366653531373132383934313833323266613039313737353532356566223b733a33323a223330333062386539306639633865666533356530366631363062373634653063223b733a33323a223530643865393265363933343839636664636230363832633836373264393332223b733a33323a223764386430343537656666336464613839306339616335356539383536393935223b733a33323a223133323464613836376631333462356530346130643732366466356239623233223b733a33323a223834396163373030633432633939303362373838366563386565303162623332223b733a33323a223865336131653263333233623761373430666231356637366334356331326536223b733a33323a223638646631346564633739363139376639663336326435653732336363363734223b733a33323a226165363935373663316334353632326663353362396536366133303439326161223b733a33323a223464643665373636613262666230353461613462306434353437363432336665223b733a33323a223336326637653463346431626166373966376538643539343135313434626161223b733a33323a223134646434386636343330616531353864363031313233646239663964616530223b733a33323a223561376633396365366666313965333230626331653135653564396430383063223b733a33323a223239626335326562663032333331346261646562373036616538396665343462223b733a33323a226263353361376332623237323763396565363063326637353463653131626137223b733a33323a226465623463343236303332306433346464633631383963313366643236393465223b733a33323a226133303966613266663332616630653037313063396464313439643233386230223b733a33323a223833663732633265316263663564323332316332383764623632333361656362223b733a33323a226663373065646433663236373330646336366533333130303639623534663638223b733a33323a226239643835643734346237373564363463326431363139316135653130313961223b733a33323a223531633961363930653161626163363062616335666463343161313462363865223b733a33323a223031393633633665373263323437313438376363653737626131323461343865223b733a33323a223865313933363861353934613631636332336232366664323539663962656536223b733a33323a223937666238306631346562343632346163636539623362333233303765363430223b733a33323a223861343331313530656232643862623239623261646332303138366237333932223b733a33323a226462313830366166303832616131326235393832633961386663333733643963223b733a33323a223331313834626565633565626533343631323032343231356230623832363566223b733a33323a223538313737666237353938633838646633666364316539656165383364613865223b733a33323a226438366666363365646332363132363861396663343838383232666265333364223b733a33323a226637643937663533636162353465306236613966613037643561313137646139223b733a33323a226331383864646630396135313465633131343263313432306164376332316337223b733a33323a223836636537636465653434396633613332353231613564623362303238376362223b733a33323a223136323435663165303436636163663563363064326664663835343239353262223b733a33323a226561363638323132346130363930373631376265356130616430383164323333223b733a33323a223364366135386137366562643061333066393931333865383834656638626335223b733a33323a226433366230303430313531356666386430333233616433393339316338323034223b733a33323a223430633765303265353834313564613535653466363735616232623362653836223b733a33323a223939313430336365373938366166353566653335303936396165653532663766223b733a33323a223333396432326465316133386637616638373562323237623036616132376161223b733a33323a226364656435336363313738323965393362663464636661303335333235313237223b733a33323a226237383434656566623038393533356330646365316539346566383061646666223b733a33323a223164386466626130613632323864333762323831323030616130383738386634223b733a33323a223661366536356635383135653964366532383762316164316131313639623133223b733a33323a223136326665613766316438346335313738363030666163326362663135633762223b733a33323a226339663939386237643434633439343631323839363566346332306438633766223b733a33323a223632393033333233326332666532306464623666643964366461626336633832223b733a33323a223131333137393731393438643561643735356665646564663432303134396464223b733a33323a226339346639663232333830343261313037656430383963366436366661643837223b733a33323a223933643338303365666130623863396164646637323931656438636265396564223b733a33323a226361393936613132333635316432336662623365623032636362323638646264223b733a33323a226237623830663366643930393961373264663639646537333331336363393639223b733a33323a223833643964303736393138326638343436623637663866363062656334386635223b733a33323a226365383636353735356233366163343266656130323837343266643531653231223b733a33323a223930303336653132643237306432326132656364343737383666303437393238223b733a33323a223337306539373366386237363437336164366537643533323032663566643533223b733a33323a223635396261663461326337333865306430393461656439613633396566656437223b733a33323a223531323633646637663736323230636561653365356136653866313939623238223b733a33323a223935666239353733313031616136316461643663356463353165303966346231223b733a33323a223631396231396466366437663335653662333734643335383161613266376632223b733a33323a226463613236346166666434653464343334333964623631363863363235326635223b733a33323a226433366633666638616531643036633833633330366631623433333966656435223b733a33323a226639613965373765663231366463373334376231343133613930643538636134223b733a33323a226232336239353737313638613431656138303332373533353238663836636239223b733a33323a226532326664653562646139363832613230356431636664386337313134373738223b733a33323a226133393032393761393632646433363738386335343530333166613963396363223b733a33323a223861383465626463326166633863363964376437656637363766396564666430223b733a33323a223332643461326636303935636531383662346238353764636630363961313034223b733a33323a226131653237343566303030376231616664333936353635396636656532636537223b733a33323a223030363536356565326232616562373663653531636138323738333530336531223b733a33323a226366313930356362646233323961643135313065316532383339323562353661223b733a33323a223037663431306263643036623462396530613132643961343430646263303166223b733a33323a223834346232376165666262323939653137323330396666316365323335383762223b733a33323a223135333530613839363632376665373337326532613832363830363530663662223b733a33323a223862643430613663316466363661636366623930343334643637383734376436223b733a33323a226333633063633264313864333137393361353734636332393035363166613163223b733a33323a223036353366316534353562343337656138663339653035626237326433643765223b733a33323a223737376136363361653430613239643065373336626230633461623533393433223b733a33323a223861323231653636636261386362366463663565633738643235333866383034223b733a33323a226562373765663063303963353961643630336439616263313165643764356562223b733a33323a223830353365383932616363313835356436656436363238656162396534356438223b733a33323a223564336533373932333235663433346536376362343764356166353166306239223b733a33323a223064313064643333363636623666616664633163343166383230326637393434223b733a33323a223461663039643132633565353430353231626434386564353035303232393266223b733a33323a223564626537646639616234613932386234626630393232613330353433326163223b733a33323a226563343831366237656635636365386635666533313865306463373063656432223b733a33323a223461316534366536353065613639653563633466326434633330643933346662223b733a33323a223464663966313735386363383065623833366564306264383535643066383763223b733a33323a223830346661636131373831616430333862303032356466333161393638393731223b733a33323a223337373034363163386334356230336439626637316638353333346230636262223b733a33323a223437393437353233333237373063613931343832333261373730326337666363223b733a33323a223034646330653363313336636162333233326265343339323537616161626561223b733a33323a223430376138653336333132633335373338396530306135393131396265333866223b733a33323a223631653635326636366566663365323261353833333836303933313262373533223b733a33323a223166386538383539356336653734663234646339396331353863303139353066223b733a33323a223538363865393737313132613436636637366565633330353366393666326134223b733a33323a226336376264346264363732663038333666653832353261343262323863323164223b733a33323a223838396337356437346639633761393234353238656663356635623332623566223b733a33323a223534356562656366376437346364613938356138656664313734616266323261223b733a33323a223937646562613764386536333233323462623537633137663365363031376530223b733a33323a223937333333616563633739633763663038303063333132333132326563336164223b733a33323a223638393464343338636664343461393331326366626566343334393464326534223b733a33323a223733393264613065353163316639373738633431663464363266663432636333223b733a33323a223863633639346438363931363633346462353537356439656137383338663635223b733a33323a226430643566303861616664623939386234333739343332366264333764336432223b733a33323a223338353736356465646361623133373631333434343632326562303232326465223b733a33323a223430373166306238633465373138636463353435336639313265626239393665223b733a33323a223330663835306562613533616264343534366636643438653033626130366465223b733a33323a223536626466343136666137383663346130363139633631663363393464363935223b733a33323a223865393834343664313634613164373036386464306164323032326261653334223b733a33323a226630356363643336356139636662333962393837613162633734633464313836223b733a33323a223037643731373036353231663531616465346131333066373664343136353363223b733a33323a223366373665626431393433323939353736393036363535323365613738303631223b733a33323a223037643963616437366532623066313839336234623663343236643634326338223b733a33323a223531633961666437336533623336643737353037356163333762366431303864223b733a33323a226561643634383466303039613133326562373361613735353661613232666535223b733a33323a223831303461386132393437613565626165633266666135663261356663643738223b733a33323a226430623966346536653035643864333531353664393965613563633937343066223b733a33323a226236643765646131323864313136626363656361633064346533633434343338223b733a33323a226333343234306230333636623332326364333462613961376331333639323530223b733a33323a223532666166386531316539663639653733373730666636623363623938303339223b733a33323a223035636139373535383865666532656332396535626234623535333865303362223b733a33323a223033396637353063636139313733383663373237393835623230656665346130223b733a33323a226638633961383662643334323536643033323437646163376263316137623061223b733a33323a223733613039666335363134386366646366623565663239636235346562373739223b733a33323a223961346634616531383763636265313463613530373236383034313932316662223b733a33323a223135396163643634613834653461303035626664383635323763366265363566223b733a33323a226466383937323964306663356534356636343834653132363365643935336632223b733a33323a223935396431353532626464666664363734363838653635323237313432616635223b733a33323a223466626562376264616237343937393162613366376434393231333561356538223b733a33323a226134303565626236393162623230396363373135393139363064363330646134223b733a33323a226333326339386231356438376332623836323364353833646430613861663064223b733a33323a223332373139346634623336313464636634646532653831373364623437643839223b733a33323a223663353230613961306130613137636635306331613864613535343662383562223b733a33323a223631343938336464646332376237623030633361623238636236303463393863223b733a33323a226237346165303732383333613262366631376661376132343638663763383163223b733a33323a223030663066396434333033316661303133363938353464303361353631653834223b733a33323a223465396565353930333139306632333335646535313365326166343130336534223b733a33323a223262643033646661386231323937363765376662383830326163303164386135223b733a33323a223138646133663865333063346363653466626238633263643130353864623738223b733a33323a223263313261326130633264323230383962663334613266383537373532333235223b733a33323a226435333037366361633362626133656565373465323563386633666332663538223b733a33323a223035323233313966656462323065636161633332333432343730656265313834223b733a33323a223761313136626634646563353334626632643130633832313636653235326366223b733a33323a226366373164643661656437666135626430643234343461343735383836303063223b733a33323a223438323462373738363934333239313130643633653130316530633264613437223b733a33323a223239323138336433323339643137656332366662383231393264393466326162223b733a33323a223334626366616437646366346361313935313530383633336664373038633363223b733a33323a226539396132623530343637346332373630643332663931306563303439333261223b733a33323a226138626537383439616461353235656565363932396536623932346231303265223b733a33323a226337306333643964653663663564636333333862623337326536386365356332223b733a33323a226665383336633434623737393062383438633030633032323238653237633333223b733a33323a223537336561323730303530356564313731623065356631373234386135386264223b733a33323a223136346662643064326463643135306130636366613433346266303261633835223b733a33323a223031646531316261613539396537616439363939613133366564363064303363223b733a33323a226432646137323962653234663633623535363932363865373266643139376636223b733a33323a223030303538333965623032313635353864336536343063653437393765383034223b733a33323a223631643530313938353761646265303836613136656162323861343530373033223b733a33323a223461346363663836366633626531343730386338636239306632623138616662223b733a33323a226438656436323231353761396336373539323834666362333838656631303665223b733a33323a223366353333363734356538363037643831396362386534663933613030616562223b733a33323a223862303962313230306135386366633934346136376630386462376266333134223b733a33323a223161353338346239346333316437303461646164643331626166333162613864223b733a33323a226234626163323463636462633537373439343537653461363739663634303936223b733a33323a226235323836316530323231303865316332613764663461396533366135356234223b733a33323a226331316566306434623564653237653737303236616566616232336435653838223b733a33323a223336303164646532623363396237333130303565393833363933326637653538223b733a33323a223733346539313964613638313236343434396536353539653666336138353566223b733a33323a226266343461386539323165646630313762663665343730313461393539373937223b733a33323a223339343366626362316535656134366533326566353033336266353264353864223b733a33323a223861346630656262353835383031333961633139386430623131376263396462223b733a33323a223732393634393239343562323438303465363834633566366537636333383931223b733a33323a223735303535363235343663383330303232363163653164396266303530633235223b733a33323a223361333562653032663761303563656564363666646339386238306630613231223b733a33323a226164623864633333356433363637656165626639323336386239663934363231223b733a33323a223432323563386465646164303766626230396263393563613166626165306632223b733a33323a223434623631336238303961626430363038396335333439346234353861333437223b733a33323a226631643334303239363165343030303734353830383961623661663833376130223b733a33323a226336623438333065326538663761333665363132386636316132306236366666223b733a33323a223930653865356539383637396631363766343233613735633231646436323731223b733a33323a223431363462393139303132663037303561613633316464373163373138313133223b733a33323a226666383765336232303634666261663530626466313736643431386463303736223b733a33323a223033653861343463366436633937363663373739633437646465633864333337223b733a33323a223930656464323737326665646235663461666662373136393839336333373337223b733a33323a226434366561333031303236373863363032343131636234636535626231383739223b733a33323a223632346136356539396232383863376464373164323532623066393931383438223b733a33323a226165366565393862303238313461373065316534613736303066353365643337223b733a33323a226533333261666261303436353931363033333533346464623732666537623033223b733a33323a226335626132653161636566616532623935386336363966363664373663636664223b733a33323a223035643432366366346265363062613031336131396363303937356562666231223b733a33323a223061623930313863656361306138323366373166373131393338633166656561223b733a33323a223965356436376134313435376332303666613938333166386433613837383164223b733a33323a223330366338363339333939643138623534353336616430653862653032313966223b733a33323a226231393336646461623533656363643736353265393234393033373862383732223b733a33323a226234643237356161343837646363666236333930653539663262623862613566223b733a33323a223533333963656163653061346564623135383838396662663030346435303332223b733a33323a226637336132643539383363326139653434633262303332623437363233616630223b733a33323a223239646231636262646662333935656561623433666536623861383062383237223b733a33323a223361373439643961356566363864396566366634386431616263366562376364223b733a33323a223162373734643765363037363731636339323835626234366230643661346565223b733a33323a226230613861323931353734326530616263653833353332396265373830383739223b733a33323a226538643736306131623530376261376564666636393565363537366333346561223b733a33323a223362303765636635643932623461626464346437656161393562626238333666223b733a33323a226235373930373139376534316166643339653730326430363432343230666262223b733a33323a226130346164663264656164326230653665633565393838643233646234316236223b733a33323a223030333835316638363839333036373534616366363462663863373434643036223b733a33323a223165623062636133383734303663616434643835666432333830363335663762223b733a33323a226436383061343234616132343363303633353334353064653162333431616336223b733a33323a223238643034353837356630376664343665306265393239386164333735333438223b733a33323a223963306138353834626265366165323033303832666635326361376664623936223b733a33323a223438333436313435656164633535353664643065333536383764636664346263223b733a33323a223466643663616230393662663538663261366537343335353934626139616639223b733a33323a226638393761336538366361373934336238303836623035353339333039653635223b733a33323a223734356335346538333630623239336337343166346463356563323061613736223b733a33323a223137346662663339663538656133623834383033353137616333323830323966223b7d733a343a2268617368223b733a36353a2231373466626633396635386561336238343830333531376163333238303239662d3734356335346538333630623239336337343166346463356563323061613736223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4561737941646d696e5f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223164373637333964356130393339363164303566383435356634343931383663223b733a33323a223666643435646236373939366635326266626139313336616566343136653535223b7d733a343a2268617368223b733a36353a2236666434356462363739393666353262666261393133366165663431366535352d3164373637333964356130393339363164303566383435356634343931383663223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31303a7b733a33323a223665383662336633393932373936303861666565363866353536393131353236223b733a33323a226466623434663735623566376337306631313062303538353333636236336430223b733a33323a223735306136353132343261303363303563646666633630373761313438343033223b733a33323a226162656431373137353563353465656431653165646231633133316331626266223b733a33323a223232643265353938646164343461313235333834653336633765333135336634223b733a33323a223838323364333030623031653062636164323536623936373038643362376236223b733a33323a226139393765663565626564353966646363383739343461323966616132663135223b733a33323a223362393132323065353531393965376437323230663364623236343835313134223b733a33323a226431353164316336653035633865396539356166633465343530356535636265223b733a33323a223661653734666565333534636563383439313433353934346466656465373730223b733a33323a223566316263326434663730306636663837323735633930643765333937393438223b733a33323a223366356433393463366663316135353633633165316535623434313537333162223b733a33323a226262373764643431393439653036326331356162626430386231323632363832223b733a33323a226562333564336531323866373936353734323066393239643734366439376439223b733a33323a223565633662363462366463643962376338393034636361663135343930616130223b733a33323a223939363364376363353961666337663839363630303332376265313036353263223b733a33323a223034343435366339353037363031393137383736643434383733373939333266223b733a33323a226533656463646637343633333633343938626262353539643432356236313663223b733a33323a223537336135643264656338363363386561306438343735633964373762616131223b733a33323a223138643937383939643032333237393037386564623333393264306534643365223b7d733a343a2268617368223b733a36353a2231386439373839396430323332373930373865646233333932643065346433652d3537336135643264656338363363386561306438343735633964373762616131223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1747729535);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `value`) VALUES
('administrator_email', '\"admin@example.org\"'),
('advancedsearch_all_configs', '{\"1\":\"find\"}'),
('advancedsearch_api_config', '\"\"'),
('advancedsearch_batch_size', '\"100\"'),
('advancedsearch_configs', '[\"1\"]'),
('advancedsearch_fulltextsearch_alto', '\"0\"'),
('advancedsearch_index_batch_edit', '\"sync\"'),
('advancedsearch_main_config', '\"1\"'),
('archiverepertory_item_convert', '\"full\"'),
('archiverepertory_item_folder', '\"id\"'),
('archiverepertory_item_prefix', '\"\"'),
('archiverepertory_item_set_convert', '\"full\"'),
('archiverepertory_item_set_folder', '\"\"'),
('archiverepertory_item_set_prefix', '\"\"'),
('archiverepertory_media_convert', '\"full\"'),
('ark_naa', '\"example.org\"'),
('ark_naan', '\"99999\"'),
('ark_name', '\"noid\"'),
('ark_name_noid_template', '\"a1.rllllk\"'),
('ark_note', '\"\"'),
('ark_policy_main', '\"Our institution assigns identifiers within the ARK domain under the NAAN 99999 and according to the following principles:\\r\\n\\r\\n* No ARK shall be re-assigned; that is, once an ARK-to-object association has been made public, that association shall be considered unique into the indefinite future.\\r\\n* To help them age and travel well, the Name part of our institution-assigned ARKs shall contain no widely recognizable semantic information (to the extent possible).\\r\\n* Our institution-assigned ARKs shall be generated with a terminal check character that guarantees them against single character errors and transposition errors.\"'),
('ark_policy_statement', '\"erc-support:\\r\\nwho: Our Institution\\r\\nwhat: Permanent: Stable Content:\\r\\nwhen: 20160101\\r\\nwhere: http:\\/\\/example.com\\/ark:\\/99999\\/\"'),
('ark_property', '\"dcterms:identifier\"'),
('ark_qualifier', '\"internal\"'),
('ark_qualifier_position_format', '\"\"'),
('ark_qualifier_static', '\"0\"'),
('ark_subnaa', '\"sub\"'),
('blockplus_html_config_page', '\"default\"'),
('blockplus_html_mode_page', '\"inline\"'),
('blockplus_page_models', '[]'),
('blockplus_property_itemset', '\"\"'),
('blocksdisposition_modules', '[]'),
('bulkedit_deduplicate_on_save', '\"1\"'),
('bulkexport_format_fields', '\"name\"'),
('bulkexport_format_generic', '\"string\"'),
('bulkexport_format_resource', '\"id\"'),
('bulkexport_format_resource_property', '\"dcterms:identifier\"'),
('bulkexport_format_uri', '\"uri_label\"'),
('bulkexport_formatters', '[\"csv\",\"json-ld\",\"ods\",\"tsv\",\"txt\"]'),
('bulkexport_language', '\"\"'),
('bulkexport_limit', '\"1000\"'),
('bulkexport_metadata', '[\"o:id\",\"o:resource_template\",\"o:resource_class\",\"o:owner\",\"o:is_public\",\"properties_small\"]'),
('bulkexport_metadata_exclude', '[\"properties_large\",\"extracttext:extracted_text\"]'),
('bulkexport_template', '\"\"'),
('cleanurl_admin_reserved', '[]'),
('cleanurl_admin_use', '\"0\"'),
('cleanurl_item', '{\"default\":\"ark:\\/99999\\/{item_identifier_short}\",\"short\":\"\",\"paths\":[],\"pattern\":\"[a-zA-Z0-9][a-zA-Z0-9_-]*\",\"pattern_short\":\"\",\"property\":10,\"prefix\":\"ark:\\/99999\\/\",\"prefix_part_of\":false,\"keep_slash\":false,\"case_sensitive\":true}'),
('cleanurl_item_set', '{\"default\":\"collection\\/{item_set_id}\",\"short\":\"\",\"paths\":[],\"pattern\":\"[a-zA-Z0-9][a-zA-Z0-9_-]*\",\"pattern_short\":\"\",\"property\":10,\"prefix\":\"\",\"prefix_part_of\":false,\"keep_slash\":false,\"case_sensitive\":false}'),
('cleanurl_media', '{\"default\":\"document\\/{item_identifier}\\/{media_id}\",\"short\":\"\",\"paths\":[],\"pattern\":\"\",\"pattern_short\":\"\",\"property\":10,\"prefix\":\"\",\"prefix_part_of\":false,\"keep_slash\":false,\"case_sensitive\":false}'),
('cleanurl_page_slug', '\"page\\/\"'),
('cleanurl_settings', '{\"routes\":[],\"route_aliases\":[]}'),
('cleanurl_site_skip_main', '\"0\"'),
('cleanurl_site_slug', '\"s\\/\"'),
('default_site', '\"\"'),
('default_to_private', '\"0\"'),
('disable_file_validation', '\"0\"'),
('disable_jsonld_embed', '\"0\"'),
('easyadmin_addon_notify_version_dev', 'false'),
('easyadmin_addon_notify_version_inactive', 'true'),
('easyadmin_allow_empty_files', 'false'),
('easyadmin_content_lock', 'false'),
('easyadmin_content_lock_duration', '14400'),
('easyadmin_cron_last', '1747727463'),
('easyadmin_cron_tasks', '[\"session_8\"]'),
('easyadmin_display_exception', 'false'),
('easyadmin_interface', '[\"resource_public_view\"]'),
('easyadmin_local_path', '\"\\/var\\/www\\/html\\/files\\/preload\"'),
('easyadmin_local_path_any', 'false'),
('easyadmin_local_path_any_files', '\"0\"'),
('easyadmin_maintenance_mode', '\"\"'),
('easyadmin_maintenance_text', '\"This site is down for maintenance. Please contact the site administrator for more information.\"'),
('extension_whitelist', '[\"aac\",\"aif\",\"aiff\",\"asf\",\"asx\",\"avi\",\"bmp\",\"c\",\"cc\",\"class\",\"css\",\"divx\",\"doc\",\"docx\",\"exe\",\"gif\",\"gz\",\"gzip\",\"h\",\"ico\",\"j2k\",\"jp2\",\"jpe\",\"jpeg\",\"jpg\",\"m4a\",\"m4v\",\"mdb\",\"mid\",\"midi\",\"mov\",\"mp2\",\"mp3\",\"mp4\",\"mpa\",\"mpe\",\"mpeg\",\"mpg\",\"mpp\",\"odb\",\"odc\",\"odf\",\"odg\",\"odp\",\"ods\",\"odt\",\"ogg\",\"opus\",\"pdf\",\"png\",\"pot\",\"pps\",\"ppt\",\"pptx\",\"qt\",\"ra\",\"ram\",\"rtf\",\"rtx\",\"swf\",\"tar\",\"tif\",\"tiff\",\"txt\",\"wav\",\"wax\",\"webm\",\"wma\",\"wmv\",\"wmx\",\"wri\",\"xla\",\"xls\",\"xlsx\",\"xlt\",\"xlw\",\"zip\",\"bin\",\"dae\",\"fbx\",\"glb\",\"gltf\",\"json\",\"ktx2\",\"mtl\",\"obj\",\"xml\"]'),
('file_sideload_delete_file', '\"no\"'),
('file_sideload_directory', '\"\\/data\\/sftp\\/omeka-sideload\\/\"'),
('file_sideload_max_directories', '1000'),
('file_sideload_max_files', '1000'),
('hidden_properties_admin_show_all', 'false'),
('hidden_properties_properties', '[\"extracttext:extracted_text\"]'),
('iiifsearch_minimum_query_length', '3'),
('iiifsearch_xml_fix_mode', '\"no\"'),
('iiifsearch_xml_image_match', '\"order\"'),
('iiifserver_access_ocr_skip', '\"0\"'),
('iiifserver_access_resource_skip', '\"0\"'),
('iiifserver_identifier_clean', '\"1\"'),
('iiifserver_identifier_prefix', '\"\"'),
('iiifserver_identifier_raw', '\"0\"'),
('iiifserver_manifest_append_cors_headers', '\"0\"'),
('iiifserver_manifest_attribution_default', '\"Provided by Example Organization\"'),
('iiifserver_manifest_attribution_property', '\"\"'),
('iiifserver_manifest_behavior_default', '[\"none\"]'),
('iiifserver_manifest_behavior_property', '\"\"'),
('iiifserver_manifest_cache', '\"1\"'),
('iiifserver_manifest_cache_derivativemedia', '\"0\"'),
('iiifserver_manifest_canvas_label', '\"template\"'),
('iiifserver_manifest_canvas_label_property', '\"\"'),
('iiifserver_manifest_collection_properties', '[]'),
('iiifserver_manifest_default_version', '\"2\"'),
('iiifserver_manifest_description_property', '\"dcterms:bibliographicCitation\"'),
('iiifserver_manifest_external_property', '\"dcterms:hasFormat\"'),
('iiifserver_manifest_homepage', '\"resource\"'),
('iiifserver_manifest_homepage_property', '\"\"'),
('iiifserver_manifest_html_descriptive', '\"1\"'),
('iiifserver_manifest_item_properties', '[]'),
('iiifserver_manifest_logo_default', '\"\"'),
('iiifserver_manifest_media_properties', '[]'),
('iiifserver_manifest_placeholder_canvas_default', '\"\"'),
('iiifserver_manifest_placeholder_canvas_property', '\"\"'),
('iiifserver_manifest_placeholder_canvas_value', '\"Informed public\"'),
('iiifserver_manifest_pretty_json', '\"0\"'),
('iiifserver_manifest_properties_collection_blacklist', '[\"dcterms:tableOfContents\",\"bibo:content\",\"extracttext:extracted_text\"]'),
('iiifserver_manifest_properties_item_blacklist', '[\"dcterms:tableOfContents\",\"bibo:content\",\"extracttext:extracted_text\"]'),
('iiifserver_manifest_properties_media_blacklist', '[\"dcterms:tableOfContents\",\"bibo:content\",\"extracttext:extracted_text\"]'),
('iiifserver_manifest_provider', '[\"simple\"]'),
('iiifserver_manifest_provider_agent', '\"\"'),
('iiifserver_manifest_provider_property', '\"\"'),
('iiifserver_manifest_rights', '\"property_or_url\"'),
('iiifserver_manifest_rights_property', '\"dcterms:license\"'),
('iiifserver_manifest_rights_text', '\"\"'),
('iiifserver_manifest_rights_uri', '\"https:\\/\\/rightsstatements.org\\/vocab\\/CNE\\/1.0\\/\"'),
('iiifserver_manifest_rights_url', '\"\"'),
('iiifserver_manifest_seealso_property', '\"\"'),
('iiifserver_manifest_start_primary_media', '\"0\"'),
('iiifserver_manifest_start_property', '\"\"'),
('iiifserver_manifest_structures_property', '\"\"'),
('iiifserver_manifest_structures_skip_flat', '\"0\"'),
('iiifserver_manifest_summary_property', '\"template\"'),
('iiifserver_manifest_viewing_direction_default', '\"left-to-right\"'),
('iiifserver_manifest_viewing_direction_property', '\"\"'),
('iiifserver_media_api_default_supported_version', '{\"service\":\"2\",\"level\":\"2\"}'),
('iiifserver_media_api_default_version', '\"2\"'),
('iiifserver_media_api_fix_uv_mp3', '\"0\"'),
('iiifserver_media_api_identifier', '\"media_id\"'),
('iiifserver_media_api_identifier_infojson', '\"0\"'),
('iiifserver_media_api_prefix', '\"\"'),
('iiifserver_media_api_support_non_image', '\"0\"'),
('iiifserver_media_api_supported_versions', '[\"2\\/2\",\"3\\/2\"]'),
('iiifserver_media_api_url', '\"\"'),
('iiifserver_media_api_version_append', '\"0\"'),
('iiifserver_url_force_from', '\"\"'),
('iiifserver_url_force_to', '\"\"'),
('iiifserver_url_version_add', '\"0\"'),
('iiifserver_xml_fix_mode', '\"no\"'),
('iiifserver_xml_image_match', '\"order\"'),
('imageserver_base_url', '\"http:\\/\\/omeka.local\\/\"'),
('imageserver_default_thumbnail_type', '\"tile\"'),
('imageserver_image_max_size', '\"10000000\"'),
('imageserver_image_tile_dir', '\"tile\"'),
('imageserver_image_tile_type', '\"tiled_tiff\"'),
('imageserver_imager', '\"Auto\"'),
('imageserver_info_rights', '\"property_or_url\"'),
('imageserver_info_rights_property', '\"dcterms:license\"'),
('imageserver_info_rights_text', '\"\"'),
('imageserver_info_rights_uri', '\"https:\\/\\/rightsstatements.org\\/vocab\\/CNE\\/1.0\\/\"'),
('imageserver_info_rights_url', '\"\"'),
('imageserver_tile_fallback', '\"tile_large\"'),
('imageserver_tile_manual', '\"1\"'),
('installation_title', '\"OmekaS Docker\"'),
('locale', '\"\"'),
('media_alt_text_property', '\"\"'),
('media_type_whitelist', '[\"application\\/msword\",\"application\\/ogg\",\"application\\/pdf\",\"application\\/rtf\",\"application\\/vnd.ms-access\",\"application\\/vnd.ms-excel\",\"application\\/vnd.ms-powerpoint\",\"application\\/vnd.ms-project\",\"application\\/vnd.ms-write\",\"application\\/vnd.oasis.opendocument.chart\",\"application\\/vnd.oasis.opendocument.database\",\"application\\/vnd.oasis.opendocument.formula\",\"application\\/vnd.oasis.opendocument.graphics\",\"application\\/vnd.oasis.opendocument.presentation\",\"application\\/vnd.oasis.opendocument.spreadsheet\",\"application\\/vnd.oasis.opendocument.text\",\"application\\/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"application\\/vnd.openxmlformats-officedocument.presentationml.presentation\",\"application\\/vnd.openxmlformats-officedocument.spreadsheetml.sheet\",\"application\\/x-gzip\",\"application\\/x-ms-wmp\",\"application\\/x-msdownload\",\"application\\/x-shockwave-flash\",\"application\\/x-tar\",\"application\\/zip\",\"audio\\/midi\",\"audio\\/mp4\",\"audio\\/mpeg\",\"audio\\/ogg\",\"audio\\/x-aac\",\"audio\\/x-aiff\",\"audio\\/x-ms-wma\",\"audio\\/x-ms-wax\",\"audio\\/x-realaudio\",\"audio\\/x-wav\",\"image\\/bmp\",\"image\\/gif\",\"image\\/jp2\",\"image\\/jpeg\",\"image\\/pjpeg\",\"image\\/png\",\"image\\/tiff\",\"image\\/x-icon\",\"text\\/css\",\"text\\/plain\",\"text\\/richtext\",\"video\\/divx\",\"video\\/mp4\",\"video\\/mpeg\",\"video\\/ogg\",\"video\\/quicktime\",\"video\\/webm\",\"video\\/x-ms-asf\",\"video\\/x-msvideo\",\"video\\/x-ms-wmv\",\"application\\/octet-stream\",\"application\\/vnd.threejs+json\",\"model\\/gltf-binary\",\"model\\/gltf+json\",\"model\\/obj\",\"model\\/vnd.collada+xml\",\"model\\/vnd.filmbox\",\"image\\/ktx2\",\"model\\/mtl\",\"model\\/vnd.threejs+json\",\"application\\/alto+xml\"]'),
('mirador_annotation_endpoint', '\"\"'),
('mirador_plugins', '[]'),
('mirador_plugins_2', '[]'),
('mirador_preselected_items', '0'),
('mirador_version', '\"3\"'),
('modelviewer_config_default', '\"\"'),
('modelviewer_config_property', '\"dcterms:abstract\"'),
('pagination_per_page', '\"25\"'),
('property_label_information', '\"none\"'),
('recaptcha_secret_key', '\"\"'),
('recaptcha_site_key', '\"\"'),
('searchsolr_server_id', '\"1ik8m4\"'),
('statistics_default_user_status_admin', '\"hits\"'),
('statistics_default_user_status_public', '\"anonymous\"'),
('statistics_include_bots', '\"0\"'),
('statistics_per_page_admin', '\"100\"'),
('statistics_per_page_public', '\"10\"'),
('statistics_privacy', '\"anonymous\"'),
('statistics_public_allow_browse', '\"0\"'),
('statistics_public_allow_statistics', '\"0\"'),
('statistics_public_allow_summary', '\"0\"'),
('time_zone', '\"Europe\\/Amsterdam\"'),
('universalviewer_config', '\"{}\"'),
('universalviewer_version', '\"4\"'),
('use_htmlpurifier', '\"0\"'),
('value_languages', '[]'),
('version', '\"4.1.1\"'),
('version_notifications', '\"1\"');

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE `site` (
  `id` int NOT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `homepage_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `navigation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `item_pool` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `assign_new_items` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`id`, `thumbnail_id`, `homepage_id`, `owner_id`, `slug`, `theme`, `title`, `summary`, `navigation`, `item_pool`, `created`, `modified`, `is_public`, `assign_new_items`) VALUES
(1, NULL, 1, 1, 'default', 'default', 'default site', 'Default site created at Docker bootstrap phase', '[{\"type\":\"browse\",\"data\":{\"label\":\"Browse\",\"query\":\"\"},\"links\":[]},{\"type\":\"search-page\",\"data\":{\"label\":\"Search\",\"advancedsearch_config_id\":\"1\"},\"links\":[]}]', '[]', '2023-02-15 16:04:55', '2024-10-08 13:41:30', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `site_block_attachment`
--

CREATE TABLE `site_block_attachment` (
  `id` int NOT NULL,
  `block_id` int NOT NULL,
  `item_id` int DEFAULT NULL,
  `media_id` int DEFAULT NULL,
  `caption` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_item_set`
--

CREATE TABLE `site_item_set` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `item_set_id` int NOT NULL,
  `position` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_page`
--

CREATE TABLE `site_page` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `layout` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page`
--

INSERT INTO `site_page` (`id`, `site_id`, `slug`, `title`, `is_public`, `created`, `modified`, `layout`, `layout_data`) VALUES
(1, 1, 'welcome', 'Welcome', 1, '2023-02-15 16:04:55', '2023-02-15 16:04:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_page_block`
--

CREATE TABLE `site_page_block` (
  `id` int NOT NULL,
  `page_id` int NOT NULL,
  `layout` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `position` int NOT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page_block`
--

INSERT INTO `site_page_block` (`id`, `page_id`, `layout`, `data`, `position`, `layout_data`) VALUES
(1, 1, 'html', '{\"html\":\"Welcome to your new site. This is an example page.\"}', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_permission`
--

CREATE TABLE `site_permission` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_permission`
--

INSERT INTO `site_permission` (`id`, `site_id`, `user_id`, `role`) VALUES
(1, 1, 1, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `site_setting`
--

CREATE TABLE `site_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_setting`
--

INSERT INTO `site_setting` (`id`, `site_id`, `value`) VALUES
('advancedsearch_configs', 1, '[\"1\"]'),
('advancedsearch_main_config', 1, '\"1\"'),
('advancedsearch_redirect_itemset', 1, '\"first\"'),
('advancedsearch_search_fields', 1, '\"\"'),
('attachment_link_type', 1, '\"item\"'),
('blockplus_block_buttons', 1, '[]'),
('blockplus_breadcrumbs_collections_url', 1, '\"\"'),
('blockplus_breadcrumbs_crumbs', 1, '[\"home\",\"collections\",\"itemset\",\"itemsetstree\",\"current\"]'),
('blockplus_breadcrumbs_homepage', 1, 'false'),
('blockplus_breadcrumbs_prepend', 1, '[]'),
('blockplus_breadcrumbs_separator', 1, '\"\"'),
('blockplus_items_order_for_itemsets', 1, '[]'),
('blockplus_page_model_rights', 1, 'false'),
('blockplus_page_model_skip_blockplus', 1, 'false'),
('blockplus_page_models', 1, '[]'),
('blockplus_prevnext_item_sets_query', 1, '\"\"'),
('blockplus_prevnext_items_query', 1, '\"\"'),
('browse_attached_items', 1, '\"0\"'),
('browse_body_property_term', 1, '\"\"'),
('browse_defaults_public_items', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_heading_property_term', 1, '\"\"'),
('bulkexport_format_fields', 1, '\"label\"'),
('bulkexport_format_generic', 1, '\"string\"'),
('bulkexport_format_resource', 1, '\"id\"'),
('bulkexport_format_resource_property', 1, '\"dcterms:identifier\"'),
('bulkexport_format_uri', 1, '\"uri_label\"'),
('bulkexport_formatters', 1, '[\"csv\",\"json-ld\",\"ods\",\"tsv\",\"txt\"]'),
('bulkexport_language', 1, '\"\"'),
('bulkexport_limit', 1, '\"1000\"'),
('bulkexport_metadata', 1, '[\"url\",\"o:resource_class\",\"properties_small\"]'),
('bulkexport_metadata_exclude', 1, '[\"properties_large\",\"extracttext:extracted_text\"]'),
('bulkexport_template', 1, '\"\"'),
('bulkexport_views', 1, '[\"item_browse\"]'),
('disable_jsonld_embed', 1, '\"0\"'),
('eucookiebar_message', 1, '\"<p>Warning: this site uses cookies or other means to steal your personal data and to allow Google or Facebook to fetch them. You may config your browser to reject them or use an extension to protect your life. See terms and conditions. By visiting this site, you accept them.<\\/p>\\r\\n\"'),
('eucookiebar_options', 1, '\"{\\r\\n    \\\"acceptButton\\\": true,\\r\\n    \\\"acceptText\\\": \\\"OK\\\",\\r\\n    \\\"declineButton\\\": false,\\r\\n    \\\"declineText\\\": \\\"Disable Cookies\\\",\\r\\n    \\\"policyButton\\\": false,\\r\\n    \\\"policyText\\\": \\\"Privacy Policy\\\",\\r\\n    \\\"policyURL\\\": \\\"\\/\\\",\\r\\n    \\\"bottom\\\": true,\\r\\n    \\\"fixed\\\": true,\\r\\n    \\\"zindex\\\": \\\"99999\\\"\\r\\n}\"'),
('exclude_resources_not_in_site', 1, '\"0\"'),
('filter_locale_values', 1, '\"0\"'),
('imageserver_default_thumbnail_type', 1, '\"large\"'),
('imageserver_tile_fallback', 1, '\"tile_large\"'),
('item_media_embed', 1, '\"0\"'),
('locale', 1, '\"\"'),
('mirador_annotation_endpoint', 1, '\"\"'),
('mirador_config_collection', 1, '\"\"'),
('mirador_config_collection_2', 1, '\"\"'),
('mirador_config_item', 1, '\"{\\r\\n    \\\"window\\\": {\\r\\n\\t    \\\"imageToolsEnabled\\\": true,\\r\\n\\t\\t\\\"imageToolsOpen\\\": true\\r\\n    },\\r\\n    \\\"thumbnailNavigation\\\": {\\r\\n        \\\"defaultPosition\\\": \\\"far-bottom\\\",\\r\\n        \\\"displaySettings\\\": true\\r\\n    },\\r\\n}\"'),
('mirador_config_item_2', 1, '\"\"'),
('mirador_plugins', 1, '[\"annotations\",\"dl\",\"image-tools\",\"ocr-helper\",\"share\"]'),
('mirador_plugins_2', 1, '[]'),
('mirador_preselected_items', 1, '\"0\"'),
('mirador_skip_default_css', 1, '\"0\"'),
('mirador_version', 1, '\"3\"'),
('pdfviewer_template', 1, '\"common\\/pdf-viewer\"'),
('property_label_information', 1, '\"none\"'),
('search_resource_names', 1, '[\"site_pages\",\"items\"]'),
('search_restrict_templates', 1, '\"0\"'),
('search_type', 1, '\"sitewide\"'),
('show_attached_pages', 1, '\"1\"'),
('show_locale_label', 1, '\"1\"'),
('show_page_pagination', 1, '\"1\"'),
('show_user_bar', 1, '\"0\"'),
('sitemaps_enableindex', 1, '\"0\"'),
('sitemaps_enablesitemap', 1, '\"1\"'),
('sitemaps_maxentries', 1, '\"500\"'),
('theme_settings_omekas-theme-um', 1, '{\"siteMainColor\":\"#920b0b\",\"UMLogoLink\":\"home\",\"logoRight\":\"\",\"logoFooter\":\"\",\"mainText\":\"Main text here.\",\"footer\":\"Powered by Omeka S\",\"footerBar\":\"Text for footerbar\",\"searchController\":\"find\",\"CustomFieldList\":\"modsrdf:name, modsrdf:subject, schema:dateIssued, schema:contributor, modsrdf:namePrincipal\",\"IiifViewer\":\"mirador\",\"cover_vh\":\"30\",\"highlight_Image_1\":\"\",\"highlight_Link_1\":\"\",\"highlight_Link_Text_1\":\"\",\"highlight_Image_2\":\"\",\"highlight_Link_2\":\"\",\"highlight_Link_Text_2\":\"\",\"highlight_Image_3\":\"\",\"highlight_Link_3\":\"\",\"highlight_Link_Text_3\":\"\",\"highlight_Image_4\":\"\",\"highlight_Link_4\":\"\",\"highlight_Link_Text_4\":\"\"}'),
('universalviewer_config', 1, '\"{}\"'),
('universalviewer_config_theme', 1, '\"0\"'),
('universalviewer_version', 1, '\"4\"'),
('vocabulary_scope', 1, '\"\"');

-- --------------------------------------------------------

--
-- Table structure for table `solr_core`
--

CREATE TABLE `solr_core` (
  `id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solr_core`
--

INSERT INTO `solr_core` (`id`, `name`, `settings`) VALUES
(1, 'Default', '{\"support\":\"\",\"server_id\":\"\",\"resource_languages\":\"\",\"client\":{\"scheme\":\"http\",\"host\":\"omekas_solr\",\"port\":\"8983\",\"core\":\"omekas\",\"secure\":false,\"username\":\"\",\"password\":\"\",\"bypass_certificate_check\":\"0\",\"http_request_type\":\"post\"},\"query\":{\"minimum_match\":\"\",\"tie_breaker\":\"\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `solr_map`
--

CREATE TABLE `solr_map` (
  `id` int NOT NULL,
  `solr_core_id` int NOT NULL,
  `resource_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solr_map`
--

INSERT INTO `solr_map` (`id`, `solr_core_id`, `resource_name`, `field_name`, `source`, `pool`, `settings`) VALUES
(1, 1, 'generic', 'resource_name_s', 'resource_name', '[]', '{\"formatter\":\"\",\"label\":\"Resource type\"}'),
(2, 1, 'generic', 'is_public_b', 'is_public', '[]', '{\"formatter\":\"\",\"label\":\"Public\"}'),
(3, 1, 'generic', 'owner_id_i', 'owner/o:id', '[]', '[]'),
(4, 1, 'generic', 'site_id_is', 'site/o:id', '[]', '[]'),
(5, 1, 'resources', 'resource_class_s', 'resource_class/o:term', '[]', '{\"formatter\":\"\",\"label\":\"Resource class\"}'),
(6, 1, 'resources', 'resource_template_s', 'resource_template/o:label', '[]', '{\"formatter\":\"\",\"label\":\"Resource template\"}'),
(7, 1, 'resources', 'title_s', 'o:title', '[]', '{\"formatter\":\"\",\"label\":\"Title\"}'),
(8, 1, 'resources', 'dcterms_title_txt', 'dcterms:title', '[]', '{\"formatter\":\"\",\"label\":\"Title\"}'),
(9, 1, 'resources', 'dcterms_creator_txt', 'dcterms:creator', '[]', '{\"formatter\":\"\",\"label\":\"Creator\"}'),
(10, 1, 'resources', 'dcterms_subject_txt', 'dcterms:subject', '[]', '{\"formatter\":\"\",\"label\":\"Subject\"}'),
(11, 1, 'resources', 'dcterms_description_txt', 'dcterms:description', '[]', '{\"formatter\":\"\",\"label\":\"Description\"}'),
(12, 1, 'resources', 'dcterms_publisher_txt', 'dcterms:publisher', '[]', '{\"formatter\":\"\",\"label\":\"Publisher\"}'),
(13, 1, 'items', 'dcterms_contributor_txt', 'dcterms:contributor', '[]', '{\"formatter\":\"\",\"label\":\"Contributor\"}'),
(14, 1, 'resources', 'dcterms_date_txt', 'dcterms:date', '[]', '{\"formatter\":\"\",\"label\":\"Date\"}'),
(15, 1, 'resources', 'dcterms_type_txt', 'dcterms:type', '[]', '{\"formatter\":\"\",\"label\":\"Type\"}'),
(16, 1, 'resources', 'dcterms_format_txt', 'dcterms:format', '[]', '{\"formatter\":\"\",\"label\":\"Format\"}'),
(17, 1, 'resources', 'dcterms_identifier_txt', 'dcterms:identifier', '[]', '{\"formatter\":\"\",\"label\":\"Identifier\"}'),
(18, 1, 'resources', 'dcterms_source_txt', 'dcterms:source', '[]', '{\"formatter\":\"\",\"label\":\"Source\"}'),
(19, 1, 'resources', 'dcterms_language_txt', 'dcterms:language', '[]', '{\"formatter\":\"\",\"label\":\"Language\"}'),
(20, 1, 'resources', 'dcterms_relation_txt', 'dcterms:relation', '[]', '{\"formatter\":\"\",\"label\":\"Relation\"}'),
(21, 1, 'resources', 'dcterms_coverage_txt', 'dcterms:coverage', '[]', '{\"formatter\":\"\",\"label\":\"Coverage\"}'),
(22, 1, 'resources', 'dcterms_rights_txt', 'dcterms:rights', '[]', '{\"formatter\":\"\",\"label\":\"Rights\"}'),
(23, 1, 'resources', 'dcterms_spatial_txt', 'dcterms:spatial', '[]', '{\"formatter\":\"\",\"label\":\"Spatial coverage\"}'),
(24, 1, 'resources', 'dcterms_temporal_txt', 'dcterms:temporal', '[]', '{\"formatter\":\"\",\"label\":\"Temporal coverage\"}'),
(25, 1, 'resources', 'dcterms_spatial_ss', 'dcterms:spatial', '[]', '{\"formatter\":\"\",\"label\":\"Spatial coverage\"}'),
(26, 1, 'resources', 'dcterms_temporal_dr', 'dcterms:temporal', '[]', '{\"formatter\":\"date_range\",\"label\":\"Temporal coverage\"}'),
(27, 1, 'resources', 'dcterms_type_ss', 'dcterms:type', '[]', '{\"formatter\":\"\",\"label\":\"Type\"}'),
(28, 1, 'resources', 'dcterms_subject_ss', 'dcterms:subject', '[]', '{\"formatter\":\"\",\"label\":\"Subject\"}'),
(29, 1, 'resources', 'dcterms_creator_ss', 'dcterms:creator', '[]', '{\"formatter\":\"\",\"label\":\"Creator\"}'),
(30, 1, 'resources', 'dcterms_publisher_ss', 'dcterms:publisher', '[]', '{\"formatter\":\"\",\"label\":\"Publisher\"}'),
(31, 1, 'resources', 'dcterms_language_ss', 'dcterms:language', '[]', '{\"formatter\":\"\",\"label\":\"Language\"}'),
(32, 1, 'resources', 'dcterms_rights_ss', 'dcterms:rights', '[]', '{\"formatter\":\"\",\"label\":\"Rights\"}'),
(33, 1, 'resources', 'item_set_dcterms_title_ss', 'item_set/dcterms:title', '[]', '{\"formatter\":\"\",\"label\":\"Item Set\"}'),
(34, 1, 'resources', 'dcterms_title_s', 'dcterms:title', '[]', '{\"formatter\":\"\",\"label\":\"Title\"}'),
(35, 1, 'resources', 'dcterms_date_s', 'dcterms:date', '[]', '{\"formatter\":\"\",\"label\":\"Date\"}'),
(36, 1, 'resources', 'dcterms_creator_s', 'dcterms:creator', '[]', '{\"formatter\":\"\",\"label\":\"Creator\"}'),
(37, 1, 'items', 'item_set_id_is', 'item_set/o:id', '[]', '{\"formatter\":\"\",\"label\":\"Item set id\"}');

-- --------------------------------------------------------

--
-- Table structure for table `stat`
--

CREATE TABLE `stat` (
  `id` int NOT NULL,
  `type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `entity_id` int NOT NULL,
  `entity_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hits` int NOT NULL,
  `hits_anonymous` int NOT NULL,
  `hits_identified` int NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stat`
--

INSERT INTO `stat` (`id`, `type`, `url`, `entity_id`, `entity_name`, `hits`, `hits_anonymous`, `hits_identified`, `created`, `modified`) VALUES
(1, 'page', '/', 0, '', 8, 5, 3, '2024-03-26 13:43:37', '2025-04-30 07:57:12'),
(2, 'page', '/s/default/item', 0, '', 3, 0, 3, '2024-04-15 12:33:56', '2024-04-15 12:34:19'),
(3, 'page', '/s/default/item/1', 1, 'items', 1, 0, 1, '2024-04-15 12:34:18', '2024-04-15 12:34:18'),
(4, 'resource', '/s/default/item/1', 1, 'items', 1, 0, 1, '2024-04-15 12:34:18', '2024-04-15 12:34:18'),
(5, 'page', '/s/default', 0, '', 2, 0, 2, '2024-10-08 13:36:04', '2024-10-08 13:38:46'),
(6, 'page', '/s/default/page/welcome', 1, 'site_pages', 2, 0, 2, '2024-10-08 13:36:04', '2024-10-08 13:38:46'),
(7, 'resource', '/s/default/page/welcome', 1, 'site_pages', 2, 0, 2, '2024-10-08 13:36:04', '2024-10-08 13:38:46'),
(8, 'page', '/s/default/sitemap.xml', 0, '', 4, 0, 4, '2024-10-08 13:36:11', '2024-10-08 13:41:32'),
(9, 'page', '/s/default/sitemapindex.xml', 0, '', 3, 0, 3, '2024-10-08 13:38:53', '2024-10-08 13:41:32');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `password_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `name`, `created`, `modified`, `password_hash`, `role`, `is_active`) VALUES
(1, 'admin@example.org', 'Admin', '2023-02-15 15:44:23', '2023-02-23 19:08:52', '$2y$10$F6zoM/4CQP80t6rglGrpRuBNeuXEYRxUwz7ehD38Q9bCzlO4H1WcK', 'global_admin', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_setting`
--

CREATE TABLE `user_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `value`
--

CREATE TABLE `value` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value_resource_id` int DEFAULT NULL,
  `type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_annotation_id` int DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uri` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `value`
--

INSERT INTO `value` (`id`, `resource_id`, `property_id`, `value_resource_id`, `type`, `lang`, `value_annotation_id`, `value`, `uri`, `is_public`) VALUES
(1, 1, 1, NULL, 'literal', NULL, NULL, 'First item', NULL, 1),
(2, 1, 4, NULL, 'literal', NULL, NULL, 'This is the first item in this Omeka instance. It was created during the Docker bootstrap phase.\nIt contains metadata, but no associated media files.', NULL, 1),
(4, 1, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a1apZs2', NULL, 1),
(5, 2, 1, NULL, 'literal', NULL, NULL, 'CC-Licenses Collection', NULL, 1),
(6, 2, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a12vpho', NULL, 1),
(7, 3, 48, NULL, 'literal', NULL, NULL, 'CC-BY-NC', NULL, 1),
(8, 3, 1, NULL, 'literal', NULL, NULL, 'Creative Common license - CC-BY-NC', NULL, 1),
(9, 3, 1639, NULL, 'uri', '', NULL, 'Creative Commons website', 'https://creativecommons.org/licenses/by-nc/4.0/', 1),
(10, 3, 1645, NULL, 'literal', NULL, NULL, 'You are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nThe licensor cannot revoke these freedoms as long as you follow the license terms.', NULL, 1),
(11, 3, 1646, NULL, 'literal', NULL, NULL, 'Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNonCommercial — You may not use the material for commercial purposes.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.', NULL, 1),
(12, 3, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a1UAQRM', NULL, 1),
(13, 4, 48, NULL, 'literal', NULL, NULL, 'CC-BY', NULL, 1),
(14, 4, 1, NULL, 'literal', NULL, NULL, 'Creative Common license - CC-BY', NULL, 1),
(15, 4, 1639, NULL, 'uri', '', NULL, 'Creative Commons website', 'https://creativecommons.org/licenses/by/4.0/', 1),
(16, 4, 1645, NULL, 'literal', NULL, NULL, 'You are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nfor any purpose, even commercially.', NULL, 1),
(17, 4, 1646, NULL, 'literal', NULL, NULL, 'Under the following terms:\nAttribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.', NULL, 1),
(18, 4, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a1MGfH7', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `value_annotation`
--

CREATE TABLE `value_annotation` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vocabulary`
--

CREATE TABLE `vocabulary` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `namespace_uri` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vocabulary`
--

INSERT INTO `vocabulary` (`id`, `owner_id`, `namespace_uri`, `prefix`, `label`, `comment`) VALUES
(1, NULL, 'http://purl.org/dc/terms/', 'dcterms', 'Dublin Core', 'Basic resource metadata (DCMI Metadata Terms)'),
(2, NULL, 'http://purl.org/dc/dcmitype/', 'dctype', 'Dublin Core Type', 'Basic resource types (DCMI Type Vocabulary)'),
(3, NULL, 'http://purl.org/ontology/bibo/', 'bibo', 'Bibliographic Ontology', 'Bibliographic metadata (BIBO)'),
(4, NULL, 'http://xmlns.com/foaf/0.1/', 'foaf', 'Friend of a Friend', 'Relationships between people and organizations (FOAF)'),
(5, 1, 'http://omeka.org/s/vocabs/o-module-extracttext#', 'extracttext', 'Extract Text', NULL),
(6, 1, 'https://schema.org/', 'schema', 'Schema.org', 'Info: https://schema.org/docs/developers.html'),
(7, 1, 'http://creativecommons.org/ns#', 'cc', 'Creative Commons', 'Downloaded from https://creativecommons.org/ns# -> and click on \'RDF Schema\'. Or use this direct URL https://creativecommons.org/schema.rdf'),
(8, 1, 'http://id.loc.gov/ontologies/bibframe/', 'bf', 'Bibframe', ''),
(9, 1, 'https://d-nb.info/standards/elementset/gnd#', 'gnd', 'Gemeinsame Normdatei', ''),
(10, 1, 'https://omeka.org/s/vocabs/curation/', 'curation', 'Curation', 'Generic and common properties that are useful in Omeka for the curation of resources. The use of more common or more precise ontologies is recommended when it is possible.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_key`
--
ALTER TABLE `api_key`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C912ED9D7E3C61F9` (`owner_id`);

--
-- Indexes for table `asset`
--
ALTER TABLE `asset`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2AF5A5C5CC5DB90` (`storage_id`),
  ADD KEY `IDX_2AF5A5C7E3C61F9` (`owner_id`);

--
-- Indexes for table `bulk_export`
--
ALTER TABLE `bulk_export`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_625A30FDBE04EA9` (`job_id`),
  ADD KEY `IDX_625A30FDB4523DE5` (`exporter_id`),
  ADD KEY `IDX_625A30FD7E3C61F9` (`owner_id`);

--
-- Indexes for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6093500B7E3C61F9` (`owner_id`);

--
-- Indexes for table `content_lock`
--
ALTER TABLE `content_lock`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_4AED76CB81257D5D16EFC72D` (`entity_id`,`entity_name`),
  ADD KEY `IDX_4AED76CBA76ED395` (`user_id`);

--
-- Indexes for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_84D382F4BE04EA9` (`job_id`);

--
-- Indexes for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_17B50881BE04EA9` (`job_id`),
  ADD UNIQUE KEY `UNIQ_17B508814C276F75` (`undo_job_id`);

--
-- Indexes for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8533D2A5EA750E8` (`label`),
  ADD KEY `IDX_8533D2A5960278D7` (`item_set_id`),
  ADD KEY `IDX_8533D2A57E3C61F9` (`owner_id`);

--
-- Indexes for table `fulltext_search`
--
ALTER TABLE `fulltext_search`
  ADD PRIMARY KEY (`id`,`resource`),
  ADD KEY `IDX_AA31FE4A7E3C61F9` (`owner_id`),
  ADD KEY `is_public` (`is_public`);
ALTER TABLE `fulltext_search` ADD FULLTEXT KEY `IDX_AA31FE4A2B36786B3B8BA7C7` (`title`,`text`);

--
-- Indexes for table `hit`
--
ALTER TABLE `hit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5AD22641F47645AE` (`url`),
  ADD KEY `IDX_5AD2264181257D5D` (`entity_id`),
  ADD KEY `IDX_5AD2264116EFC72D` (`entity_name`),
  ADD KEY `IDX_5AD2264181257D5D16EFC72D` (`entity_id`,`entity_name`),
  ADD KEY `IDX_5AD22641F6BD1646` (`site_id`),
  ADD KEY `IDX_5AD22641A76ED395` (`user_id`),
  ADD KEY `IDX_5AD22641A5E3B32D` (`ip`),
  ADD KEY `IDX_5AD22641ED646567` (`referrer`),
  ADD KEY `IDX_5AD22641C44967C5` (`user_agent`),
  ADD KEY `IDX_5AD22641C2F0CDFC` (`accept_language`),
  ADD KEY `IDX_5AD22641B23DB7B8` (`created`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1F1B251ECBE0B084` (`primary_media_id`);

--
-- Indexes for table `item_item_set`
--
ALTER TABLE `item_item_set`
  ADD PRIMARY KEY (`item_id`,`item_set_id`),
  ADD KEY `IDX_6D0C9625126F525E` (`item_id`),
  ADD KEY `IDX_6D0C9625960278D7` (`item_set_id`);

--
-- Indexes for table `item_set`
--
ALTER TABLE `item_set`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_site`
--
ALTER TABLE `item_site`
  ADD PRIMARY KEY (`item_id`,`site_id`),
  ADD KEY `IDX_A1734D1F126F525E` (`item_id`),
  ADD KEY `IDX_A1734D1FF6BD1646` (`site_id`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FBD8E0F87E3C61F9` (`owner_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8F3F68C57E3C61F9` (`owner_id`),
  ADD KEY `IDX_8F3F68C5BE04EA9` (`job_id`),
  ADD KEY `IDX_8F3F68C5AEA34913` (`reference`),
  ADD KEY `IDX_8F3F68C5F660D16B` (`severity`),
  ADD KEY `IDX_8F3F68C5B23DB7B8` (`created`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_6A2CA10C5CC5DB90` (`storage_id`),
  ADD KEY `IDX_6A2CA10C126F525E` (`item_id`),
  ADD KEY `item_position` (`item_id`,`position`),
  ADD KEY `ingester` (`ingester`),
  ADD KEY `renderer` (`renderer`),
  ADD KEY `media_type` (`media_type`),
  ADD KEY `extension` (`extension`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E1B5FC6089329D25` (`resource_id`),
  ADD KEY `IDX_E1B5FC60549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6D39C79089329D25` (`resource_id`),
  ADD KEY `IDX_6D39C790549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7E2C936B89329D25` (`resource_id`),
  ADD KEY `IDX_7E2C936B549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7367AFAA89329D25` (`resource_id`),
  ADD KEY `IDX_7367AFAA549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `password_creation`
--
ALTER TABLE `password_creation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C77917B4A76ED395` (`user_id`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8BF21CDEAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  ADD KEY `IDX_8BF21CDE7E3C61F9` (`owner_id`),
  ADD KEY `IDX_8BF21CDEAD0E05F6` (`vocabulary_id`);

--
-- Indexes for table `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BC91F4167E3C61F9` (`owner_id`),
  ADD KEY `IDX_BC91F416448CC1BD` (`resource_class_id`),
  ADD KEY `IDX_BC91F41616131EA` (`resource_template_id`),
  ADD KEY `IDX_BC91F416FDFF2E92` (`thumbnail_id`),
  ADD KEY `title` (`title`(190)),
  ADD KEY `idx_public_type_id_title` (`is_public`,`resource_type`,`id`,`title`(190)),
  ADD KEY `is_public` (`is_public`),
  ADD KEY `resource_type` (`resource_type`);

--
-- Indexes for table `resource_class`
--
ALTER TABLE `resource_class`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C6F063ADAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  ADD KEY `IDX_C6F063AD7E3C61F9` (`owner_id`),
  ADD KEY `IDX_C6F063ADAD0E05F6` (`vocabulary_id`);

--
-- Indexes for table `resource_template`
--
ALTER TABLE `resource_template`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_39ECD52EEA750E8` (`label`),
  ADD KEY `IDX_39ECD52E7E3C61F9` (`owner_id`),
  ADD KEY `IDX_39ECD52E448CC1BD` (`resource_class_id`),
  ADD KEY `IDX_39ECD52E724734A3` (`title_property_id`),
  ADD KEY `IDX_39ECD52EB84E0D1D` (`description_property_id`);

--
-- Indexes for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_4689E2F116131EA549213EC` (`resource_template_id`,`property_id`),
  ADD KEY `IDX_4689E2F116131EA` (`resource_template_id`),
  ADD KEY `IDX_4689E2F1549213EC` (`property_id`);

--
-- Indexes for table `search_config`
--
ALTER TABLE `search_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D684063E78C9C0A` (`engine_id`);

--
-- Indexes for table `search_engine`
--
ALTER TABLE `search_engine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `search_suggester`
--
ALTER TABLE `search_suggester`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F64D915AE78C9C0A` (`engine_id`);

--
-- Indexes for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_536C3D170913F08` (`suggester_id`),
  ADD KEY `search_text_idx` (`text`,`suggester_id`);
ALTER TABLE `search_suggestion` ADD FULLTEXT KEY `IDX_536C3D13B8BA7C7` (`text`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_694309E4989D9B62` (`slug`),
  ADD UNIQUE KEY `UNIQ_694309E4571EDDA` (`homepage_id`),
  ADD KEY `IDX_694309E4FDFF2E92` (`thumbnail_id`),
  ADD KEY `IDX_694309E47E3C61F9` (`owner_id`);

--
-- Indexes for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_236473FEE9ED820C` (`block_id`),
  ADD KEY `IDX_236473FE126F525E` (`item_id`),
  ADD KEY `IDX_236473FEEA9FDD75` (`media_id`),
  ADD KEY `block_position` (`block_id`,`position`);

--
-- Indexes for table `site_item_set`
--
ALTER TABLE `site_item_set`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D4CE134F6BD1646960278D7` (`site_id`,`item_set_id`),
  ADD KEY `IDX_D4CE134F6BD1646` (`site_id`),
  ADD KEY `IDX_D4CE134960278D7` (`item_set_id`),
  ADD KEY `position` (`position`);

--
-- Indexes for table `site_page`
--
ALTER TABLE `site_page`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2F900BD9F6BD1646989D9B62` (`site_id`,`slug`),
  ADD KEY `IDX_2F900BD9F6BD1646` (`site_id`),
  ADD KEY `is_public` (`is_public`);

--
-- Indexes for table `site_page_block`
--
ALTER TABLE `site_page_block`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C593E731C4663E4` (`page_id`),
  ADD KEY `page_position` (`page_id`,`position`);

--
-- Indexes for table `site_permission`
--
ALTER TABLE `site_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C0401D6FF6BD1646A76ED395` (`site_id`,`user_id`),
  ADD KEY `IDX_C0401D6FF6BD1646` (`site_id`),
  ADD KEY `IDX_C0401D6FA76ED395` (`user_id`);

--
-- Indexes for table `site_setting`
--
ALTER TABLE `site_setting`
  ADD PRIMARY KEY (`id`,`site_id`),
  ADD KEY `IDX_64D05A53F6BD1646` (`site_id`);

--
-- Indexes for table `solr_core`
--
ALTER TABLE `solr_core`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `solr_map`
--
ALTER TABLE `solr_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_39A565C527B35A19` (`solr_core_id`),
  ADD KEY `IDX_39A565C527B35A195103DEBC` (`solr_core_id`,`resource_name`),
  ADD KEY `IDX_39A565C527B35A194DEF17BC` (`solr_core_id`,`field_name`),
  ADD KEY `IDX_39A565C527B35A195F8A7F73` (`solr_core_id`,`source`);

--
-- Indexes for table `stat`
--
ALTER TABLE `stat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_20B8FF218CDE5729F47645AE` (`type`,`url`(759)),
  ADD KEY `IDX_20B8FF218CDE5729` (`type`),
  ADD KEY `IDX_20B8FF21F47645AE` (`url`),
  ADD KEY `IDX_20B8FF2181257D5D` (`entity_id`),
  ADD KEY `IDX_20B8FF2116EFC72D` (`entity_name`),
  ADD KEY `IDX_20B8FF2181257D5D16EFC72D` (`entity_id`,`entity_name`),
  ADD KEY `IDX_20B8FF21B23DB7B8` (`created`),
  ADD KEY `IDX_20B8FF215F6B6CAC` (`modified`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Indexes for table `user_setting`
--
ALTER TABLE `user_setting`
  ADD PRIMARY KEY (`id`,`user_id`),
  ADD KEY `IDX_C779A692A76ED395` (`user_id`);

--
-- Indexes for table `value`
--
ALTER TABLE `value`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_1D7758349B66727E` (`value_annotation_id`),
  ADD KEY `IDX_1D77583489329D25` (`resource_id`),
  ADD KEY `IDX_1D775834549213EC` (`property_id`),
  ADD KEY `IDX_1D7758344BC72506` (`value_resource_id`),
  ADD KEY `value` (`value`(190)),
  ADD KEY `uri` (`uri`(190)),
  ADD KEY `idx_public_resource_property` (`is_public`,`resource_id`,`property_id`),
  ADD KEY `is_public` (`is_public`),
  ADD KEY `type` (`type`),
  ADD KEY `lang` (`lang`);

--
-- Indexes for table `value_annotation`
--
ALTER TABLE `value_annotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_9099C97B9B267FDF` (`namespace_uri`),
  ADD UNIQUE KEY `UNIQ_9099C97B93B1868E` (`prefix`),
  ADD KEY `IDX_9099C97B7E3C61F9` (`owner_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asset`
--
ALTER TABLE `asset`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_export`
--
ALTER TABLE `bulk_export`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `content_lock`
--
ALTER TABLE `content_lock`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hit`
--
ALTER TABLE `hit`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2150;

--
-- AUTO_INCREMENT for table `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `resource_class`
--
ALTER TABLE `resource_class`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1281;

--
-- AUTO_INCREMENT for table `resource_template`
--
ALTER TABLE `resource_template`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `search_config`
--
ALTER TABLE `search_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `search_engine`
--
ALTER TABLE `search_engine`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `search_suggester`
--
ALTER TABLE `search_suggester`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_item_set`
--
ALTER TABLE `site_item_set`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_page`
--
ALTER TABLE `site_page`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `site_page_block`
--
ALTER TABLE `site_page_block`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `site_permission`
--
ALTER TABLE `site_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `solr_core`
--
ALTER TABLE `solr_core`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `solr_map`
--
ALTER TABLE `solr_map`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `stat`
--
ALTER TABLE `stat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `value`
--
ALTER TABLE `value`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `vocabulary`
--
ALTER TABLE `vocabulary`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_key`
--
ALTER TABLE `api_key`
  ADD CONSTRAINT `FK_C912ED9D7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `asset`
--
ALTER TABLE `asset`
  ADD CONSTRAINT `FK_2AF5A5C7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bulk_export`
--
ALTER TABLE `bulk_export`
  ADD CONSTRAINT `FK_625A30FD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_625A30FDB4523DE5` FOREIGN KEY (`exporter_id`) REFERENCES `bulk_exporter` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_625A30FDBE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  ADD CONSTRAINT `FK_6093500B7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `content_lock`
--
ALTER TABLE `content_lock`
  ADD CONSTRAINT `FK_4AED76CBA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  ADD CONSTRAINT `FK_84D382F4BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Constraints for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD CONSTRAINT `FK_17B508814C276F75` FOREIGN KEY (`undo_job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `FK_17B50881BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Constraints for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  ADD CONSTRAINT `FK_8533D2A57E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8533D2A5960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `fulltext_search`
--
ALTER TABLE `fulltext_search`
  ADD CONSTRAINT `FK_AA31FE4A7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_1F1B251EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1F1B251ECBE0B084` FOREIGN KEY (`primary_media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `item_item_set`
--
ALTER TABLE `item_item_set`
  ADD CONSTRAINT `FK_6D0C9625126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_6D0C9625960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_set`
--
ALTER TABLE `item_set`
  ADD CONSTRAINT `FK_1015EEEBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_site`
--
ALTER TABLE `item_site`
  ADD CONSTRAINT `FK_A1734D1F126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_A1734D1FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job`
--
ALTER TABLE `job`
  ADD CONSTRAINT `FK_FBD8E0F87E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `FK_8F3F68C57E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8F3F68C5BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `FK_6A2CA10C126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `FK_6A2CA10CBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  ADD CONSTRAINT `FK_E1B5FC60549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E1B5FC6089329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  ADD CONSTRAINT `FK_6D39C790549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_6D39C79089329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  ADD CONSTRAINT `FK_7E2C936B549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_7E2C936B89329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  ADD CONSTRAINT `FK_7367AFAA549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_7367AFAA89329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_creation`
--
ALTER TABLE `password_creation`
  ADD CONSTRAINT `FK_C77917B4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `FK_8BF21CDE7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8BF21CDEAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`);

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `FK_BC91F41616131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F416448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F4167E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F416FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `resource_class`
--
ALTER TABLE `resource_class`
  ADD CONSTRAINT `FK_C6F063AD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C6F063ADAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`);

--
-- Constraints for table `resource_template`
--
ALTER TABLE `resource_template`
  ADD CONSTRAINT `FK_39ECD52E448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52E724734A3` FOREIGN KEY (`title_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52E7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52EB84E0D1D` FOREIGN KEY (`description_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  ADD CONSTRAINT `FK_4689E2F116131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`),
  ADD CONSTRAINT `FK_4689E2F1549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `search_config`
--
ALTER TABLE `search_config`
  ADD CONSTRAINT `FK_D684063E78C9C0A` FOREIGN KEY (`engine_id`) REFERENCES `search_engine` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `search_suggester`
--
ALTER TABLE `search_suggester`
  ADD CONSTRAINT `FK_F64D915AE78C9C0A` FOREIGN KEY (`engine_id`) REFERENCES `search_engine` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  ADD CONSTRAINT `FK_536C3D170913F08` FOREIGN KEY (`suggester_id`) REFERENCES `search_suggester` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site`
--
ALTER TABLE `site`
  ADD CONSTRAINT `FK_694309E4571EDDA` FOREIGN KEY (`homepage_id`) REFERENCES `site_page` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_694309E47E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_694309E4FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  ADD CONSTRAINT `FK_236473FE126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_236473FEE9ED820C` FOREIGN KEY (`block_id`) REFERENCES `site_page_block` (`id`),
  ADD CONSTRAINT `FK_236473FEEA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `site_item_set`
--
ALTER TABLE `site_item_set`
  ADD CONSTRAINT `FK_D4CE134960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D4CE134F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site_page`
--
ALTER TABLE `site_page`
  ADD CONSTRAINT `FK_2F900BD9F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`);

--
-- Constraints for table `site_page_block`
--
ALTER TABLE `site_page_block`
  ADD CONSTRAINT `FK_C593E731C4663E4` FOREIGN KEY (`page_id`) REFERENCES `site_page` (`id`);

--
-- Constraints for table `site_permission`
--
ALTER TABLE `site_permission`
  ADD CONSTRAINT `FK_C0401D6FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C0401D6FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site_setting`
--
ALTER TABLE `site_setting`
  ADD CONSTRAINT `FK_64D05A53F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `solr_map`
--
ALTER TABLE `solr_map`
  ADD CONSTRAINT `FK_39A565C527B35A19` FOREIGN KEY (`solr_core_id`) REFERENCES `solr_core` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_setting`
--
ALTER TABLE `user_setting`
  ADD CONSTRAINT `FK_C779A692A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `value`
--
ALTER TABLE `value`
  ADD CONSTRAINT `FK_1D7758344BC72506` FOREIGN KEY (`value_resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1D775834549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1D77583489329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  ADD CONSTRAINT `FK_1D7758349B66727E` FOREIGN KEY (`value_annotation_id`) REFERENCES `value_annotation` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `value_annotation`
--
ALTER TABLE `value_annotation`
  ADD CONSTRAINT `FK_C03BA4EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD CONSTRAINT `FK_9099C97B7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

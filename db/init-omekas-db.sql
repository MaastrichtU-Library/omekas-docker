-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Apr 16, 2024 at 12:08 PM
-- Server version: 8.0.36
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
(7, '/', 0, '', 0, 0, '::', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-16 12:07:36');

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
(7, 1, NULL, '', 6, 'Indexing in Solr core \"Default\": item #3', '[]', '2023-11-30 19:00:07');

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
('20230601060113'),
('20230713101012');

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
('ArchiveRepertory', 1, '3.15.16'),
('Ark', 1, '3.5.13.5'),
('BlocksDisposition', 1, '3.4.2.3-beta'),
('BulkEdit', 1, '3.4.27'),
('BulkExport', 1, '3.4.30'),
('Common', 1, '3.4.55'),
('CreateMissingThumbnails', 1, '0.3.0'),
('CSVImport', 1, '2.6.1'),
('CustomVocab', 1, '2.0.2'),
('EUCookieBar', 1, '3.4.4'),
('ExtractText', 1, '2.0.0'),
('FileSideload', 1, '1.7.1'),
('Generic', 1, '3.4.46'),
('HideProperties', 1, '1.3.1'),
('IiifSearch', 1, '3.4.7'),
('IiifServer', 1, '3.6.20'),
('ImageServer', 1, '3.6.17'),
('Log', 1, '3.4.22'),
('Mirador', 1, '3.4.9'),
('ModelViewer', 1, '3.3.0.7-132'),
('NdeTermennetwerk', 1, '1.1.0'),
('NumericDataTypes', 1, '1.11.3'),
('PdfViewer', 1, '3.4.4'),
('SearchSolr', 1, '3.5.45'),
('Statistics', 1, '3.4.7'),
('UniversalViewer', 1, '3.6.9'),
('ValueSuggest', 1, '1.17.1');

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
(1648, 1, 7, 'useGuidelines', 'useGuidelines', NULL);

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
(1004, 1, 7, 'Work', 'Work', 'a potentially copyrightable work');

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
(1, 2, 'Default', 'find', 'main', '{\"search\":{\"default_results\":\"default\",\"default_query\":\"\",\"default_query_post\":\"\",\"hidden_query_filters\":[]},\"autosuggest\":{\"suggester\":\"1\",\"url\":\"\",\"url_param_name\":\"\",\"limit\":null},\"form\":{\"filters\":[{\"field\":\"dcterms_title_txt\",\"label\":\"Title\",\"type\":\"\",\"options\":[]},{\"field\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\",\"options\":[]},{\"field\":\"advanced\",\"label\":\"Filters\",\"type\":\"Advanced\",\"options\":[],\"fields\":{\"title\":{\"value\":\"title\",\"label\":\"Title\"},\"author\":{\"value\":\"author\",\"label\":\"Author\"},\"dcterms:creator\":{\"value\":\"dcterms:creator\",\"label\":\"Creator\"},\"dcterms:subject\":{\"value\":\"dcterms:subject\",\"label\":\"Subject\"},\"date\":{\"value\":\"date\",\"label\":\"Date\"},\"description\":{\"value\":\"description\",\"label\":\"Description\"},\"resource_class_id\":{\"value\":\"resource_class_id\",\"label\":\"Class\"}},\"max_number\":\"5\",\"field_joiner\":\"1\",\"field_joiner_not\":\"1\",\"field_operator\":\"1\",\"field_operators\":{\"eq\":\"is exactly\",\"in\":\"contains\",\"sw\":\"starts with\",\"ew\":\"ends with\",\"ex\":\"has any value\",\"res\":\"is resource with ID\"}}],\"attribute_form\":\"0\",\"button_reset\":\"0\",\"button_submit\":\"1\"},\"display\":{\"search_filters\":\"header\",\"active_facets\":\"none\",\"total_results\":\"header\",\"paginator\":\"header\",\"per_pages\":\"header\",\"sort\":\"header\",\"grid_list\":\"header\",\"grid_list_mode\":\"auto\"},\"pagination\":{\"per_pages\":{\"10\":\"Results by 10\",\"25\":\"Results by 25\",\"50\":\"Results by 50\",\"100\":\"Results by 100\"}},\"sort\":{\"fields\":{\"dcterms:title asc\":{\"name\":\"dcterms:title asc\",\"label\":\"Title\"},\"dcterms:title desc\":{\"name\":\"dcterms:title desc\",\"label\":\"Title (from z to a)\"},\"dcterms:date asc\":{\"name\":\"dcterms:date asc\",\"label\":\"Date\"},\"dcterms:date desc\":{\"name\":\"dcterms:date desc\",\"label\":\"Date (most recent first)\"}}},\"facet\":{\"label\":\"Facets\",\"facets\":{\"resource_class_s\":{\"name\":\"resource_class_s\",\"label\":\"Resource class\",\"type\":\"\",\"options\":[]},\"dcterms_creator_s\":{\"name\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\",\"options\":[]}},\"limit\":\"10\",\"order\":\"\",\"languages\":[],\"display_list\":\"available\",\"mode\":\"button\",\"display_submit\":\"above\",\"display_reset\":\"above\",\"label_submit\":\"Apply facets\",\"label_reset\":\"Reset facets\",\"display_active\":\"1\",\"display_count\":\"1\"}}', '2023-02-15 16:01:30', '2023-02-28 14:50:30');

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
('091f06d721530f2e299f16480b6dc966', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731333236393239362e3833323239313b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223737373338666162386366326164303036323564306331623566646539663930223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333237323835383b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313731333237323839353b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333237323839363b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223137643465393764653230376632353761633364333564333830313861353961223b733a33323a223662616433306238336532356266343362386661623033343463373662303031223b7d733a343a2268617368223b733a36353a2236626164333062383365323562663433623866616230333434633736623030312d3137643465393764653230376632353761633364333564333830313861353961223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a33323a7b733a33323a223264383562326339323533623732306432333735313831653332653230393731223b733a33323a226136616564343363636539383639353430353732363831373632303639306338223b733a33323a226263396164383831303737373136626534333731646435313164666332323266223b733a33323a223566366365323730376535626162373862323535633038623531353837343139223b733a33323a226631653433383764363462313165396435326438643130313166373935383632223b733a33323a223265316532313661386561326461663864383333633736656165306562633137223b733a33323a226462383534333862633264653130623463626638613461303839323364646565223b733a33323a223161653261623766353831393637363930336263386335363464616362313136223b733a33323a223033323564323932323636373765353530313036313035366432643865393935223b733a33323a226637366161336130386562313432366135393538363935623564653435306439223b733a33323a226466336232333631626235633665353437656139333864653564396139343430223b733a33323a223634613438306661303733663531326266313331643862313036353937653564223b733a33323a226362616433376130303035663138346330633637306631353338306433333365223b733a33323a223665643666633265663839326334393438313639623865363834636636313336223b733a33323a223763323936313164323366633163636336323432613035376264396366393062223b733a33323a223135346337333065363933623631363862313030626531363365633430643638223b733a33323a223562633337633665303462313337393937383637616263306539633035653664223b733a33323a226334643734636634646533316331323662653438396536363335323562633236223b733a33323a223930343138313338343263323862386365363434663765613465326435353931223b733a33323a226136663738303233383062333562383662373163613963373662343534636261223b733a33323a226333313739666166383266306164323761376162306365663432383165353238223b733a33323a223833623866623036316239623330643536346638376638663261623631663735223b733a33323a223038663437313234343561306133383661363866663434643130643861363132223b733a33323a223531646135356464343965643032363832353738323236636534336361383262223b733a33323a223237653934363433313064326436333835666434366633626432373666366661223b733a33323a226332626338343435356635636638393262656239393332306664353031643135223b733a33323a226431326434393038306266653839336231396439393332623433373365663137223b733a33323a226332626632643937306636383637623362343433333435623764303162653066223b733a33323a223437333130383232316236643337333136623435616131366237313166396463223b733a33323a223433303731653065613863353161326139636266356363666532353865623763223b733a33323a223036353532303735643863623633323934333930646133616536626662666338223b733a33323a226233643465303363313861343465646330363039363231363239333231313964223b733a33323a226464653866396237343065346166336337626364343662396334626538626666223b733a33323a223830313466633563333262653536373835346562303330326336333438313333223b733a33323a226634313333353132663834343261326266663536336530323734316136373331223b733a33323a223731386137626632666333376530663231616565333961663931663866306463223b733a33323a223462343064306664643663363863333830623463326262306162303330353863223b733a33323a223538333830326233326162626637393637633839653831316163323034396633223b733a33323a226534323364616136396136333963636163626133646231343836343063386263223b733a33323a226462396563373033356236633133343830396436326662353235353365663034223b733a33323a226139643565616363343061633237306434393130396163643533633931376465223b733a33323a226130346538656162363065323735316537623230623363623435393966376137223b733a33323a226632383135356233353233653362653830616265333633646433373561626364223b733a33323a223234343763376239613761633064376533396565646266346632343935303161223b733a33323a223866383264376638333163326531663566396161393138396235306430356566223b733a33323a226631666130623232663662643562366663303161333266653338633539623630223b733a33323a223863353765633464373032643339616463656538643533363465306533346338223b733a33323a223537613736623463383635383538333332316536373766303735373832323263223b733a33323a223931303864336234643134363531626665303139623465353661663632383636223b733a33323a223966656139323464323130666237393265396436353631313135313732356637223b733a33323a223236633466353265633862396465393262646333636131303532656464396462223b733a33323a226163653062366132646663336164326264613563363837343436666331626534223b733a33323a223764313766633539626233363439653232663661386261623565366337653961223b733a33323a223035623637393065396430353536373237363235623333323263633861336136223b733a33323a226534323532356366613230386361356430353638663261646563333838623338223b733a33323a223436346137613933356130383561396662643436373335356435343166623436223b733a33323a226132663836356563323564303864613635353030646666326131323233313936223b733a33323a223165636338336364333663343133636437306138376564666634386231336162223b733a33323a226563366333336435636135386261383236303433393461616135323235333538223b733a33323a223237333734353736353330343530363465346565386363303837396537633437223b733a33323a226461353364363438633265333566343937313831366337326363326234386334223b733a33323a226436306137643662646436346630343936333832316662613435643062636234223b733a33323a223765613165333266636135626334393566323433643531646138363236643036223b733a33323a223465326564643631373964323035316439393166323666636139363031643439223b7d733a343a2268617368223b733a36353a2234653265646436313739643230353164393931663236666361393630316434392d3765613165333266636135626334393566323433643531646138363236643036223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226332613437666231346534616261313234313439393733313531386161323231223b733a33323a223330373165643838303263646562326339653937353339353262623266316530223b733a33323a226366643864616130346335323630353737353065623435306434336432613039223b733a33323a223534643339313865653165613736393232326266376335323166303663316362223b7d733a343a2268617368223b733a36353a2235346433393138656531656137363932323262663763353231663036633163622d6366643864616130346335323630353737353065623435306434336432613039223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1713269296),
('1451dff50abeb146aa0f5f2bfccd7870', 0x5f5f4c616d696e61737c613a373a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313730313136393239332e3238393030393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223661616637613566313631633239663964633536653463383164396630356630223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313137323639333b7d733a33373a224c616d696e61735f56616c696461746f725f437372665f73616c745f666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313137323838363b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313730313137323839323b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313137323839333b7d733a34353a224c616d696e61735f56616c696461746f725f437372665f73616c745f7369746570616765666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313137323836373b7d7d72656469726563745f75726c7c733a35303a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f736974652f732f64656661756c742f6e617669676174696f6e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226363663733626264363632366364313531306534383039663237633538333265223b733a33323a223335346466633739356162633663666166656362616464633039646537666634223b7d733a343a2268617368223b733a36353a2233353464666337393561626336636661666563626164646330396465376666342d6363663733626264363632366364313531306534383039663237633538333265223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a226333646534383334343161336234386434383535623331353562663764386335223b733a33323a223738316136333461656533643466343230633634333031336637623733316638223b733a33323a223139316662373633636366336135316365656638616439333465353832366163223b733a33323a226337356363396435376230386136633664363135626530376537373539323761223b733a33323a223166353666666661633766323331376263396663373062373561323239336432223b733a33323a226466613565353461623937306562626262376139323965616663656163623032223b733a33323a226133633438363737363063613531386663373136643464303062336638643337223b733a33323a226663396536326136316335653533346365383262613863636633373763656139223b7d733a343a2268617368223b733a36353a2266633965363261363163356535333463653832626138636366333737636561392d6133633438363737363063613531386663373136643464303062336638643337223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a37313a7b733a33323a226431353739333638356432303331323066333936303962336536383664646338223b733a33323a223963383765653539663966356263393561653539306162383930366135373333223b733a33323a226637616332663233666437613030396130613965613065336137653230383566223b733a33323a223133366630626432363266383338623431613738326633613965333965663861223b733a33323a223766663539326263326161653432353966303663616133383037623866373665223b733a33323a223461383836376164353030623864306231356262646561386234396131386338223b733a33323a223936306165353433623030306266383834383163313736313231346431343866223b733a33323a223364353639393962653366623933323335376239616462646633656337346537223b733a33323a223338346461353761653837663039333233623934306135613634343632616265223b733a33323a223339353631373962333832656631613732356431313132656539333833386162223b733a33323a223234336664306262616239323139323630316262333466376635383030306533223b733a33323a223334613531386238623130376134613562353432613936323731613932666636223b733a33323a226437396638313664336137313832656561663432646564353535383139356432223b733a33323a223531353436363337353165396665316563343065623437326232316532643131223b733a33323a223163363866666236313537333435653261346535626563393634616563376665223b733a33323a223034303032303132393639393331663631363535376262356230633864656466223b733a33323a226233383462396438613064383339623665636262356165636132663430323731223b733a33323a226164333566353265373165656235636136333436363361336130613635616134223b733a33323a223164363234393761373739623635666434303933343034626331393633663137223b733a33323a223939333236613434316137643562346635393937623561373032336537393739223b733a33323a226437376632323261656561646666623866636235616438653639623734616365223b733a33323a223732656561386539393161663435643738386366356461393934616562303931223b733a33323a226638656366653430313034316538343966323832373031643464616565623162223b733a33323a223964386339353564333234663565623235666133393939393137376136313033223b733a33323a223765386561396661613238383439366536383864656339373533343165393861223b733a33323a226266383762366238323838393830386631653634653666313034353533396335223b733a33323a226533336632666530613136386633646334313631323230613230643137616439223b733a33323a226530653332313466326632393733633135343966393063373032383034393865223b733a33323a223637353837653237363466383033346161366637336134633535653739306436223b733a33323a223534333133643832303139373135616239383365333061373836383964623037223b733a33323a226133386461326661316536636336626334643034633530303466326161326637223b733a33323a223663303664336634396231636661393239653261366664353562373738363362223b733a33323a223435666164616636646230663937613435613064386461313031653730616135223b733a33323a223738613436623130626437313936326335623464663738356539626463636663223b733a33323a223034376631383834656336316165323033323666343031373062633636663237223b733a33323a223966653739383636653132366363636634313034383662623161373265373566223b733a33323a223966383939336536376633323465613563366336376435393530346165316633223b733a33323a223062613935303132326634333762333431613961386164326365393633386563223b733a33323a223832656336323666653165326633343430363763323466636230376461306565223b733a33323a226664333238623937393263643337336438623635623162643735353433626435223b733a33323a223636373161326364656236313164656264393038316439363134366166383830223b733a33323a223531643534623265663166623937656333396434353965653832383738303532223b733a33323a223865333461383066356339346463386466663038633031396435353337356563223b733a33323a226131346665313261633939633437663865363939383663616561653732643739223b733a33323a223239333034383866633363653133303138633865356434366633663063373534223b733a33323a226237313438323861346536653232353161613766316638393734366266646238223b733a33323a223965343730653563383833356331313230623432343134303031386139323337223b733a33323a223737386564313761376266363862613137303561303365306539316438303238223b733a33323a226634313662393631313537616234353738343330636131396161626166383662223b733a33323a226332316566373365613864616232393136343437373132316365323732396433223b733a33323a226437616466303262613966316235613333613139363934623266663830613230223b733a33323a226536363033366335393462393635313935343761366633353966353739346630223b733a33323a226135663632313535343135353734323135333866613632366165323166653639223b733a33323a223166323664336131303361613839353637336663323161636664656533613233223b733a33323a226330666631633666656262386464633164316561663462643861363462356531223b733a33323a226532333464303661616530386639623836306239333536383432643261373937223b733a33323a226366313938366334393232613438306564353335323162363634383238353636223b733a33323a226630323134666263336365363438636138376130366131613038636533653931223b733a33323a226635653364343938353835393130356132373337663233623362313362393062223b733a33323a223765393636616439343437383233383337656333363634383833303934623561223b733a33323a223836366533656134323337383764646139333665303530356139326266626137223b733a33323a223135663339303561353736616161313164356239633064633462333734366261223b733a33323a223961653439366631626434346238303162363132633162623633613064353933223b733a33323a223934393438366332383736656564396539313462356464336636346563633363223b733a33323a223164316463626535636533316434363562613636623538663536316362343032223b733a33323a223566313734626638383561306332336266313437393834366633346232346639223b733a33323a226536353262653431656163306139373563303437356565313335393438346162223b733a33323a223832653164613839353366376566346438313464393633396166393939316136223b733a33323a223365396661663232363338636533636330393134613161653765306230643261223b733a33323a226565643638623738383165663163666134336561313161383066373863643561223b733a33323a223338656330653936333361306437656133663866323936626339393163353039223b733a33323a223639623461376539326564376532653233333838616161623137313939343962223b733a33323a223961393565653634663064373761353166336263373765373739383565316431223b733a33323a226530346231383161643938303236313664666266396563663962613363303437223b733a33323a226439616665353536313462326261393661373964343032643161666538656561223b733a33323a226133383133303562316231613131333835623361336337376236616235383333223b733a33323a226135383265353334326561633839663563316138643462356130303163373731223b733a33323a223865616466316639353231386138636463663732326264643664336266303538223b733a33323a226333333461643130356366633265643161353163613432656632633636363539223b733a33323a226636613434393534393435386234376663643162303239376437303230626635223b733a33323a226533363439356131613334323863396462666333663032343337366461653932223b733a33323a226237393033653066316365336635393065303235303466343666613533656234223b733a33323a226234333161346434613563636138356136333636633333353939666535336439223b733a33323a223933643239643465653038333865323364653665343337376632643038303334223b733a33323a223933343530643532633231386239333463396166613662316232346335313736223b733a33323a223930386163373635363133336536353438333662636637373632613437396464223b733a33323a223666393063316661356331356637313262316435323931313335383063383631223b733a33323a226130376238356338366465346531316638396137353230323664393034363435223b733a33323a223432326639313163356232356639333363666336363265626634656432396465223b733a33323a223531633638336439333861316135656639613435646535636432363738386632223b733a33323a223131363837353039343739643237333963343039376636613662623339366430223b733a33323a226332613034666137323062613761613262643664626132366133393062303264223b733a33323a223830313936653765373766306666366232316265333332376364393734613436223b733a33323a223464363836373631366334616534613035653134643431663437393661323230223b733a33323a223565316231383431613162386132323031363263653737326235663032663036223b733a33323a226366363630363431353035396334343731316637386331393261356537643362223b733a33323a226532633633623134656232346437323339303066653465646134653539653539223b733a33323a226230356630383839626539353465633866666139316265306535666662363161223b733a33323a226534393236626634643461663864666165633162623236626238323935356333223b733a33323a226431363863353164653338343061613864653932323139393661383036653364223b733a33323a223064616131623534326562633037643831646136383734653632343564366234223b733a33323a223836303736336630366634313465323134333065323864633334633264643038223b733a33323a223661303036663066323234396435353036663134363331616233366537356266223b733a33323a223037636230396232653766646633343166356134343331373635616637613437223b733a33323a226331366135303034383131333932643039393939363064656165383239633733223b733a33323a226437663036303937646230626365653362626431353466663062366531613239223b733a33323a223231393063343465643730336161333437393430306462656566613266303762223b733a33323a223636393632363365613961363637663630373866373338613263333436313963223b733a33323a223632353430343937396165366537346662303162366233373838303135313362223b733a33323a223165666233363764616563633037376461343831343665343038366336646232223b733a33323a223438373264613963383937333034656537386535343261306366626462666238223b733a33323a223733303435666638646238373563396636383665306239656635643234393730223b733a33323a223232353431353331636134386437636439346439326362393366353230373431223b733a33323a226536656332643333633565633661373661386637323332633534636537666234223b733a33323a226437636262313630396139393035336233366539363137353866336265666536223b733a33323a223165656161343463633431313163656337666231663436393762636431343363223b733a33323a223133303937323663656564633939633832376266326661393565363732613535223b733a33323a226566306138343433613834656136306432333039306266373265303661363561223b733a33323a223439356631396164643832646637393565653838656330633032626266623432223b733a33323a223466363862313737333961643931653332376332366466653430633839326261223b733a33323a223465323234323139613934346263396531363265653061363136323861353232223b733a33323a226661646564633330323637616465643431646539616265626264336232313530223b733a33323a223439623632383530346538316563343162353966386635336562646133373638223b733a33323a223863663334353334623330653665316631613532313838613335626537643961223b733a33323a223438616130336465353631356161353539613435336439333532653439336463223b733a33323a223464323066633765303335633966316339396236313264616661313764626431223b733a33323a223664313464393835323631633335336539643439373965313464663335626335223b733a33323a223863653063303835643061343734353561323937633130653737383034383433223b733a33323a223539623930376139383163303165333234646261383839353333633961393966223b733a33323a223963663231653335663064633734663037346334356334623735333234353934223b733a33323a226366656264303339346663316431636163343030386231333461303361353330223b733a33323a223463336639393438636134333033316463656264633635366565373136626638223b733a33323a223066383937633231373233363238623330616562663461333763653838656564223b733a33323a223764613533353333643530306539373930666333323762633433313163663730223b733a33323a226464663838386135613332636130636130326133323836653963663933316362223b733a33323a223164656537323936353230323865313463623432616466656532313164646665223b733a33323a226532626431633637353533653735366362663863613432626435386139393561223b733a33323a223961623063336432373764363266626539613662656534326436356330623133223b733a33323a223438393834656532383335643230333830396431656664343964656531336330223b733a33323a223238653766346665316166356236313461373035643865313933316463353938223b733a33323a223332373734306136633130366233353938343466323737373030663764363862223b733a33323a226362633938663165306462366463363433383034373166653764363538333037223b7d733a343a2268617368223b733a36353a2263626339386631653064623664633634333830343731666537643635383330372d3332373734306136633130366233353938343466323737373030663764363862223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a353a7b733a33323a226661376235636237613463383635353063613136306265313135386466333639223b733a33323a223939623532633734626239643339663632353039373936396665666461613633223b733a33323a226237343862393162646530623734656166633830313134303961646432306531223b733a33323a223162306635326264303765623830316264353264373838303034313032393133223b733a33323a226338643335343337643637366666663335343738623562396633353361656261223b733a33323a226335383332623932303766653537383763353161353335356364363130353630223b733a33323a223261376266396539346339386531623830303133663464643532653566616233223b733a33323a226166613533386138346531313261363437643463326332333065643131373537223b733a33323a226335323731613630646466633636366561386635643366353362393732636438223b733a33323a223836306165356163643133643131313731626164376332336363393330303065223b7d733a343a2268617368223b733a36353a2238363061653561636431336431313137316261643763323363633933303030652d6335323731613630646466633636366561386635643366353362393732636438223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7369746570616765666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223764363832393065663864386135336561363239303033346363616166373530223b733a33323a223961613664373261363337633166396433653535353865653362363131383539223b7d733a343a2268617368223b733a36353a2239616136643732613633376331663964336535353538656533623631313835392d3764363832393065663864386135336561363239303033346363616166373530223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1701169293),
('391e5f430210280cbae2dc827a0e0366', 0x5f5f4c616d696e61737c613a31313a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313730313337313535302e3236363637393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223234646636323531333532653939353830336635663566653364616666366136223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313336303130333b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313337343537323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313730313337343430313b7d733a35393a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465696d706f7274666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313337353037363b7d733a36353a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465726576696577696d706f7274666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313337353038313b7d733a35343a224c616d696e61735f56616c696461746f725f437372665f73616c745f637573746f6d766f636162696d706f7274666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313336353835333b7d733a34373a224c616d696e61735f56616c696461746f725f437372665f73616c745f766f636162756c617279666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313336363135343b7d733a34383a224c616d696e61735f56616c696461746f725f437372665f73616c745f637573746f6d766f636162666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313337343534373b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730313337343539343b7d7d72656469726563745f75726c7c733a32393a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f73697465223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226566613830646434626231303136323632363937633733303838653732303138223b733a33323a226362393461323163643465386232366138366665323139386634653363353038223b7d733a343a2268617368223b733a36353a2263623934613231636434653862323661383666653231393866346533633530382d6566613830646434626231303136323632363937633733303838653732303138223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a32313a7b733a33323a223761346538313765326435393439666332623335336333326662353039663637223b733a33323a226365316363623733633439313935373233653939363736656436393735313930223b733a33323a223263613032346133343265326533376361353433666535643137363364356639223b733a33323a223662666661303464653332353938303661646536393137313336356630363566223b733a33323a226437333136366532346134346631313839313735396534303236363161663263223b733a33323a226134616133613362323839386464616466313863316166653564653162663032223b733a33323a226565636563396431633438306164313663666338316362306661376538303164223b733a33323a226666316465306536623961643734656232393839353632383364346430316566223b733a33323a226165316539353565626364396563666561393830396334626264656439323431223b733a33323a226361653961363031643964666132353631313665653237636233656131343530223b733a33323a226565313833333430306139353666363739656564626361353736313163366633223b733a33323a226238326539343665353532346263633365613464343664343462636265363964223b733a33323a226263643530316632333238623337356265376432623930663130353565623761223b733a33323a223739663564393262646238363331306562613332303637613461313433386630223b733a33323a226566623731363234336336613563306363303163343562393063376233626262223b733a33323a223366373237636438633032343333326331333231343066636236373764323963223b733a33323a226137346565646631303363626362373737303835616564323834626363383432223b733a33323a223165656134376430313638653335353732636336363430626336353563613664223b733a33323a223963373133656634386337383633343064623763386666393363663634376632223b733a33323a223935346533653964636162623363623432616362383138303539373037366566223b733a33323a223637316337306263316532303633373435373537346535373961326132383332223b733a33323a226563366134323966316133653966663232626234663034656232663330656630223b733a33323a223739343330613232393139366465643430653938346166383632346434666437223b733a33323a226461366537363462326436656433663261633330666137323434323261636635223b733a33323a223436363937313530663663613036396138333632336663396565643731396334223b733a33323a226238326264393366323233343231376531633539636438353862633332623761223b733a33323a223634306162653365626235373731626237313466396632643935343239666566223b733a33323a223531383936353763353935616531396135303663663761653334643564663766223b733a33323a223666656632613135323337356662316438643664303861393962343465326434223b733a33323a223330636331363837623537653935646665613634653330356236396665633434223b733a33323a223564326135643239623263616131653034613662643163373763663063333563223b733a33323a223063363736346662363435623633366435393236633739333230313465623365223b733a33323a223963653732646635363962393461333038656130653533383161643361626331223b733a33323a223565633538666663616464363362333537666337383766646165386431636134223b733a33323a223337326339613335373839373366613138303234636330326332613533326264223b733a33323a226364663364623830333035636637376165666433383234363261323161353332223b733a33323a223235643339353337366365623333626436356135353334346630666435346564223b733a33323a223764323130313865333861396265323464336466663436333634643461636434223b733a33323a226130393733396233613836396131663435336539613661643266303836333133223b733a33323a226237356466353633633439326433326131363762346336396637313935363438223b733a33323a226130366236383434386639663631393862656637363763336430366234613461223b733a33323a226536373931326535393563623131323738333934626364356434346136663532223b7d733a343a2268617368223b733a36353a2265363739313265353935636231313237383339346263643564343461366635322d6130366236383434386639663631393862656637363763336430366234613461223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a373a7b733a33323a226139366538323230613835386661663533343766353065313838353233613963223b733a33323a226264646235663765316334313863336638653135306562353666636361303531223b733a33323a223333316132393463353364343035616664316231666361356430616138313265223b733a33323a226137623533333361373231366331333235633435353033653563636434636134223b733a33323a226230313034363831646438656130323132373166343338626339336139663363223b733a33323a226566306664646336313664383866646239323939366334333035616266643437223b733a33323a223235333661653534376130396366313230636237353735616237633235613736223b733a33323a226562396636323531323431623663363831633433343030346238613336616465223b733a33323a223161343537383137636631636362653331333766353361333530656135633132223b733a33323a226436636136353439376133356237663661396363333036623930353564616464223b733a33323a223436613335376264346261393863333165393965643463386664353535306230223b733a33323a226234303461363633653336326335376363376262626538376132666262643539223b733a33323a226161633334616562623630326236376565353038353431666131326235366365223b733a33323a223536333835653261386131333830353435376335326633386336303363346462223b7d733a343a2268617368223b733a36353a2235363338356532613861313338303534353763353266333863363033633464622d6161633334616562623630326236376565353038353431666131326235366365223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465696d706f7274666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31323a7b733a33323a223762663232306263383432663838643862343731653663393632653230323733223b733a33323a226231303364313564623432343932343738303233346135636337313464303730223b733a33323a223164333162343238386634613633373832323830346635646332373335376666223b733a33323a223665616364376435386332366363353133636366646335663761383266636536223b733a33323a223164663433363964633464643466633766343539333135656437396434343838223b733a33323a226137303161393333663535383565346136393762306131636536656635373166223b733a33323a223761366461313330333830333064666234643338386463356365316365633161223b733a33323a223764623862353336616261386163316437616631316566386634376139626463223b733a33323a223465376661653431643832623934663130643063306661623364366132386531223b733a33323a223731356635306335333033363433396666323038356263363436326337616566223b733a33323a223038636161306630306631623239386466353965363561323665346432343161223b733a33323a226330636262393233653766323966613236663832616362353364613661303066223b733a33323a223661366561653766626164303332633563623039646235653761633833316663223b733a33323a226335333463313663663938626464353939336464386236643962373838353535223b733a33323a223034376666393235366334333139666664383536363830623231316236396463223b733a33323a223363333362636461633966666363663665623761333064653463663430353539223b733a33323a223766653361636535306563613264366435323839303664373161663365653162223b733a33323a226434353734383561316662393334323763646339353631353566396366393064223b733a33323a223063376139363764373232663761643438613433656664656139346537396464223b733a33323a226139373033376561356330363662333736633265343338333862383937616336223b733a33323a223765623063346634323039633531613938383366613630646134306131303131223b733a33323a223762643762376463336436353038386335336361643462353337353335383865223b733a33323a223065363265626132653430653961393066363238366134323330383437613733223b733a33323a226434323937383032353563376338656438393338633034306639653763326265223b7d733a343a2268617368223b733a36353a2264343239373830323535633763386564383933386330343066396537633262652d3065363265626132653430653961393066363238366134323330383437613733223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465726576696577696d706f7274666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31323a7b733a33323a223366336339313462366235373338636266626134373635346133363132626264223b733a33323a226238653135376162656463336162383865383939333330636333383336353333223b733a33323a223735653935663636636261636530353864623833313062333532373362363532223b733a33323a223037666537343930366232636563386135313733323765313663646137616232223b733a33323a223530353265323531343238653661326538663366393239636234386232613962223b733a33323a223932303962303132623061346162303265343162643631623163623764626633223b733a33323a223130663436653531643836306232313030626661633936343563353633396335223b733a33323a226339643734643230363435323134646463656266376137363162323161366234223b733a33323a223865323865643837653662666530393031623034343965363566636565323330223b733a33323a226263636636613463323030303234346232366162333035646663356166613036223b733a33323a226338383134353434663233396664636265353339383861386639336538356239223b733a33323a226236363731303663356231656330643338353334393036393965323833623633223b733a33323a226434393133376466653130636563663366633232333262366138343034396134223b733a33323a223638333835366437656633373261376363373231363534656230333665386536223b733a33323a223065636537626262353435626631383139626631386633626634363134373765223b733a33323a223839616263386437383534396633353038373865626636386561336537353139223b733a33323a223232626565343534373331666264333031306564336163376166353161393065223b733a33323a223736653161396632373862613039666434626235663437366138613338306233223b733a33323a223031346531643464323535343139333531353139313763386262303764623961223b733a33323a226266393766633565363861386232623334303762323736623962353461326337223b733a33323a223630306534343430653833346162383366373761303761373236373963633866223b733a33323a226539383334306164306664663563316564643564666263383932353533386666223b733a33323a223730656136643763336333653539656435633333653534393032343532623536223b733a33323a223833316332613536303863633130633462663330343133393931316336333838223b7d733a343a2268617368223b733a36353a2238333163326135363038636331306334626633303431333939313163363338382d3730656136643763336333653539656435633333653534393032343532623536223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637573746f6d766f636162696d706f7274666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223032363466663739623535366137633961633366633230343539663933623736223b733a33323a223365373266396166376437643231343434643635366239333733376565343234223b733a33323a226538376334323536326430313762316434396365616333376339633537646339223b733a33323a226362313833363130316534623331333738656163343834353534343061353562223b7d733a343a2268617368223b733a36353a2263623138333631303165346233313337386561633438343535343430613535622d6538376334323536326430313762316434396365616333376339633537646339223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f766f636162756c617279666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a226462303638636331343332373362386438383238333535356462653337386332223b733a33323a223338376632306261633063396333356361303463343738323734653338653333223b733a33323a226232373434333765353662383130393631333363656332373339336361356561223b733a33323a223033303431656232313433643165623262626561316465656535366636323336223b733a33323a223637653936656362613665353665323633646234323935316237393137343637223b733a33323a223733663164623839656561383231336235393062343866386635346536663763223b733a33323a226135363263363738366230623731663565636264336338656462373266383264223b733a33323a223732396135323738663839303530333830363764636563336564383234376430223b7d733a343a2268617368223b733a36353a2237323961353237386638393035303338303637646365633365643832343764302d6135363263363738366230623731663565636264336338656462373266383264223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637573746f6d766f636162666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226466373838326162323464656238663331343461393264646265323936323535223b733a33323a223365376362343330306434316539383938653239393263343930613661356639223b7d733a343a2268617368223b733a36353a2233653763623433303064343165393839386532393932633439306136613566392d6466373838326162323464656238663331343461393264646265323936323535223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223438613666333732613164346363316535313364393836663663623665363661223b733a33323a223064646231363535343963383361616631616661653061353163396565633362223b733a33323a226339303835323134366635643062663638316166393533363532353161383864223b733a33323a223964623530373465393962383733346164383433396130633063373536326564223b7d733a343a2268617368223b733a36353a2239646235303734653939623837333461643834333961306330633735363265642d6339303835323134366635643062663638316166393533363532353161383864223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1701371550);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('4d3fa5855d83c2659422e4db5e702e04', 0x5f5f4c616d696e61737c613a393a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731313436303831342e3130373836363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223731366535316339363439633837346235353735333430333465323639323763223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343231383b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343431343b7d733a36303a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496969665365727665725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343236303b7d733a36303a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496969665365617263685f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343239313b7d733a36313a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496d6167655365727665725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343430323b7d733a35373a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4d697261646f725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343330343b7d733a36353a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f556e6976657273616c5669657765725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731313436343330393b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226537363231346636666231643832313738613937323532353431623435313964223b733a33323a226332326637373662353564626134626239346564363238633762633462653933223b7d733a343a2268617368223b733a36353a2263323266373736623535646261346262393465643632386337626334626539332d6537363231346636666231643832313738613937323532353431623435313964223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3233323a7b733a33323a226335616365326561323330363630373261646434313933313165313463353532223b733a33323a226130373862346338633638613131353237623664613138636435323237643434223b733a33323a223963343566343065356130306431616537343963656237656533363631663162223b733a33323a223965373233343433663337363865663964363536663663643835633030323030223b733a33323a223530653464633430363961643161383338343736633665333966343534353631223b733a33323a226530326565623363303932366536656266636135616234316166373230613735223b733a33323a223637303633343763623966373565343366633965316336643961623465333431223b733a33323a223939336233326139343331626232386662363965366337363937386162656333223b733a33323a226364613433636166326137383430363933333637353530383830333066353031223b733a33323a223864616561633137623766336230633733666462353164346434646363353431223b733a33323a223337326539313365663638353632336337636639633062333630376433616366223b733a33323a226437306231393435313261663565613930313864323430343536356562353931223b733a33323a226338376333616464643038323931393339656336643566636536323264373062223b733a33323a223335623265636262323061643033613162353536363537363863653761326535223b733a33323a223530313939613739393931623635636531353337343361393566336438643765223b733a33323a223563336635356331386463646134376163303037383735663666363761623435223b733a33323a223334323338373763316639373862336436393831393138343865323836383066223b733a33323a226462333836306335623238633733313064393662386262333361356436303230223b733a33323a223565333036303539666330646532623632383163653435376166333966626438223b733a33323a226535383531653565363664633262636533366266623964383863623736613266223b733a33323a223230633333663964316432653132313336356662656662366162643063366166223b733a33323a223665353766613936626339306263306637363631326261653230343663356333223b733a33323a223665333131313333383232386331666334336637376238393264623963393363223b733a33323a223133346635336239653664373335643665316537343463313735306633386339223b733a33323a223766383239383332343564323238353633643639663238313265666437356163223b733a33323a223761633462636338353237353637393530346232363861653065363630643338223b733a33323a226238383466646338393162376661623862653065313236613935383632623436223b733a33323a223133376236623138623630646466386462393465313638366134306636383436223b733a33323a223131356264393766633332343863313161663264346562346632613461366163223b733a33323a223534323432656434373262343462373130633564396364316236386636656234223b733a33323a223265366364636539323563383738383636386433613866376630646662613939223b733a33323a223030346330663736316338363161346261393433386230656566343130353032223b733a33323a226161336635313235663832313332653465656136376665643335353663643166223b733a33323a223965653138613631313231356536343965626461633764386432356534316536223b733a33323a226132663565663166353434393638336639343338613033366134626436333339223b733a33323a223864346338633038333036303030613764376237656438353539336561666531223b733a33323a223333633166326266373765663362336635356233633939306635363832323936223b733a33323a223137613235343934613834383838636630613135353436353831353266663464223b733a33323a226466323338633237653931333365333162636132386463396236393761396239223b733a33323a226333633162613165363635373235613765643738356437376363373736346136223b733a33323a223330366239353931393939636362323336646334643935643131356332333737223b733a33323a223035633936393830626430643664373161333561376631636538373665386530223b733a33323a226266313833363666383339366532373232613166356466376635356230393930223b733a33323a223535396331396664306638316332643235306238313438373165353235373438223b733a33323a223232643462633638383962646631346332333165383737396361353962616432223b733a33323a223134353139333633323962353930363933323637343164636632333065636331223b733a33323a226365393539346439323937333066643337616662323166393131313565333233223b733a33323a223965343561376530336466363636323531653038613239386435343736346530223b733a33323a226263663665396135333837383134663063333831643931396132663166626239223b733a33323a223461663731316435366433373537356337633635386665383336646666663262223b733a33323a226136376463316334613235343262643366376334353330366536366334643036223b733a33323a223732623633616330333163373131333134316363643164633362636138323566223b733a33323a223164326639646430666664623062353930313765356638653231656261333836223b733a33323a223766336662386537313437386661656131396536353537386163356239393464223b733a33323a223566663063633932653532343264643838343535383234646265373963656530223b733a33323a223566356666613333356239613030353132616335613063663836353831626236223b733a33323a223261666161313366363562303062383361373533646664366133613263306663223b733a33323a226466366463386366643436363266386464373232303430326235323333396132223b733a33323a223539636337376132656530353733316531323632353664646433343535636661223b733a33323a223432633836373836636234356237353334343835353363633466653966373833223b733a33323a223330616539383766393462396637643338636261393263663934636664666336223b733a33323a223338383961386133313665313334633537383564336432353764663761626339223b733a33323a223938306539663835373265663232663534306335383066616239323134383031223b733a33323a226463376362663761396634356130393662666634653134626234323834393439223b733a33323a226635303738316266323735306336303435356531393835393764386434333165223b733a33323a226237353364316237623961633937363464363462666637636464646532313364223b733a33323a223662376461383161313666383933656163356265353962613365323963393866223b733a33323a223239393962653636353564626134393938323761376261613130376634323432223b733a33323a223337313465613539373462616436313331313435633062663635306266333033223b733a33323a223564393666656535396238343435323062303464363438643766646139343864223b733a33323a223463366362643761363530306164656565323034303764636332383532646238223b733a33323a223761333665643834306131653432363633343535343938353439636537333130223b733a33323a223863323261383966346330663363383832336565646165653936663832616562223b733a33323a223337663362653436356461613638633939616338336135616633636662653636223b733a33323a223433346633633534366639323539373636643239353136306262313330373166223b733a33323a223638396462393430656438353564636133306236346131366532383637336431223b733a33323a226431373634383338666133356565336138363665633838313566326237613634223b733a33323a226538633364396230356638633431386233623731353239623364356131306664223b733a33323a223761643539326232313532653232346137396235356463323935393834646531223b733a33323a223262336530613761343739633139323934313266663834616136643434633735223b733a33323a226638396664396230613331333638363163313635333662343633306363663036223b733a33323a226264303362646630386466623437336533333231373863306563656633383731223b733a33323a223333633061613261376161663562383535363339626535303239333938396665223b733a33323a223363323734306335333039636630633136663862636366316361666161373631223b733a33323a223562323530323964643336383631346366383965646633376131343164613362223b733a33323a226231346237343762616338396235376137373430396230616439376462343663223b733a33323a223966613033643237653166336266613463623739643536373064306139653632223b733a33323a223865336264613432333838306537383462623832623333633033363933643536223b733a33323a226132303639616437623461356666383534393434333765633238373363396135223b733a33323a223964623734396439383231373964623230366638386532316330386230333739223b733a33323a223131396335376365663566353037306236663264656434613536323262343234223b733a33323a223962663430393634653564373262343964336130623832613037656234623463223b733a33323a223164646164356562373262613834653336656339383761326265373636646662223b733a33323a223963363365316632333562396665303366313433323433653433333337636134223b733a33323a226130313334653366353763306230353036636637326137653336376537656432223b733a33323a223938363462353634383637356364383665366465666538633630623161643832223b733a33323a226261653634636563366234326264623663626230383864636334626364616539223b733a33323a223437373734383630656539396564343232373861373237346235366534316537223b733a33323a226563333437373961336266653931376639363437663861666534653962343862223b733a33323a223365313835633035346139383665326339653938326264653731343033343762223b733a33323a223335636566383630363166643339663933343361616233376666663938653535223b733a33323a226138363466636539623534646535633639323738323337636363623661313961223b733a33323a223738373136313961303563653439353337663939396334383032333531613737223b733a33323a223165623565636539313364323131306536393931333661646439306538626230223b733a33323a226438346566303130326163396536386266333462333232353364303530653964223b733a33323a226135633562386362646235353936383537323935656561313964393861383839223b733a33323a223164333938383265663332663430633039626431343863376431343636353738223b733a33323a226665616637663831373138333661653531626631396331646435373931386532223b733a33323a223233393835393866363737626165363230326431376135643536396639353937223b733a33323a226435343333353130366665613661656434333664376131383731353933623831223b733a33323a223465326562633730346539323263623233346164373762613130373966316636223b733a33323a223736303665636364643536633666303039353066383062323165373534653231223b733a33323a223237393362663338613338643265313066336232646630353537356363373833223b733a33323a223833363437376565626462323762383165643035326265653962636438353432223b733a33323a223734313732613838336439366362313938663631353362626263333636303166223b733a33323a223064353462306163643933383064613630373066353761356238353262616565223b733a33323a223139383732643935393933303336313336373738383930666139306238333261223b733a33323a223331336561653764376430393862376331323837376161363763663263613764223b733a33323a223136613764616539356133346435343766663330396463316230376566613332223b733a33323a223461383430373631393061646664656432643762306139663635356531663762223b733a33323a223538373461386366383138346532333239646165323964656434393161636339223b733a33323a226134666132333436656434366231336433336336363966316430373966396261223b733a33323a226464346131346638623665373761623335643131373633646431383030643337223b733a33323a223935373966343865376137613430663435346433373939313430656164613661223b733a33323a223430666162613463613830613366333937656537313937313734383635396538223b733a33323a223935666162303733343731373862306630656533643861366533633539613030223b733a33323a223336363238653437373666396437643733393161343731336238633165326361223b733a33323a223966336363626230356230646262313139393537623564643437323838383437223b733a33323a223563343666323263653636373466316134353038636130626231623734323333223b733a33323a223738623531653039343961363230373561353432313336343438633666666363223b733a33323a223564663538303965616535323432343162616537656166346133396439333766223b733a33323a226433363039366365363837386634663630353032353761323239616534303364223b733a33323a223833316161313637626438346330333935393039663838653061376237623137223b733a33323a226635333535333133396461646533306662363433346164316337343630623833223b733a33323a226563383961363562326534653063316431383466353066393161363262646633223b733a33323a223066633239626337376166653166313866616232663737346233396535633130223b733a33323a226566373261656264616664376666613164313731303233613330653133356262223b733a33323a223338373064633266626439336632636564346435313766326533643631353366223b733a33323a226539396466363766393337383230333435626438363139303764383065663133223b733a33323a226634356636633366343338613764306664623039636230643963666362303134223b733a33323a223864653433373135363836636339663436303239643065366434343438373835223b733a33323a223366333133383730373566346563383032633961653730343639626238396639223b733a33323a223334626433616332613632623936663333346634626235353362646566653137223b733a33323a223563343066303836663766373432623730626562316431303332336462633763223b733a33323a223732643337346334336162353764656234343836376363393264343430393238223b733a33323a223638383239346361616233343836316366643839376237376339383363343863223b733a33323a226235393238626238303538323933393335366632383233353434616130613331223b733a33323a223438373939316537383232343133666235386536613238363339343531613330223b733a33323a223365616466386464303261313836346166376330616438353965666132323635223b733a33323a226537396532653331626531643863383038353332396636306165633231643463223b733a33323a223631306165653434646439306533613137303832373537323833643439386130223b733a33323a223565366366646366356537383666306232613637626131303332336163306333223b733a33323a226338653038653763373063303366393366613832356564633235656366373361223b733a33323a226261373938353930653434346662663934376333653730376562623536633238223b733a33323a226638343563386134303661386437623364643064306130323631613761346637223b733a33323a223830316665363163393936346435646363653666376234366538353732623266223b733a33323a223632656636386437656566393231323234663764343265303766366166386131223b733a33323a223066386330323862313863303165386166653431333962616362346439346234223b733a33323a226362383032353535323433303537383963386237393639306163633863626430223b733a33323a223430303038326335663466383134663230333832623935383232636531633831223b733a33323a226665343133316137396666633938323435646165643461353763356238613233223b733a33323a226265636165646261653632663166353362623336636330653239636431356635223b733a33323a223637616432353761376135623138393361636664643061336365396464623366223b733a33323a223835306161663034646365353631373436613131306265646431626665653964223b733a33323a223733343063376335343332356463303864323631313963643635303562316564223b733a33323a223463316338326163343961626536363137633536646337316264383930383835223b733a33323a223335363732643561643735643236333331356664663836393339386266373363223b733a33323a223464316435353965393639356231633032616538393863306337393033343066223b733a33323a223662376330633031626633653061633566346339623862303530363138393733223b733a33323a226436613330373163626530363861633866643937656639333264333436306266223b733a33323a223535323963613930613836623639376431323234353833646365326434653762223b733a33323a223765633839653033396661376130366133366231316530313631303138356635223b733a33323a223562366137626565663837393162313865336536303037626162613731636335223b733a33323a223733663265386366616538393962336435333731333936363037353638623561223b733a33323a223531613730656431623938346131366337313665363361396239366565343765223b733a33323a226635643938623463633734613261333536323439633061663961336439383931223b733a33323a223964333435383764336637613462393834356535363161363331623231616336223b733a33323a223964353633306266376133323334336264396564326564636333633739653163223b733a33323a226563643538343333303335663239316238636364313238663161356466363531223b733a33323a226461323363633766663230663330373563346239396166333862623864653436223b733a33323a226337666334363334633433386136396562616139306564373934343338353330223b733a33323a223932316561646332373232333435626234383464353636636464643135363236223b733a33323a226131643565656332613461323234363332363532376531346562633535636338223b733a33323a223038653033386236313730623637373664383530333234313863663061656233223b733a33323a223566383333306135633237373265383165653861666564386237613530623033223b733a33323a223230333666636538343836343666393637346566636565386437656234333763223b733a33323a223735383862313036643135326639363264303536653837626261643932336465223b733a33323a223233626261373064616664363662373631363937626562313531303363336365223b733a33323a223962333938623330303663613461656535653035653362656435623465353034223b733a33323a223663306131343034373161653166626561626663613931666236313762373364223b733a33323a223234656131393137333266333862376563326236623833623464323166666631223b733a33323a223138616639653932383539323865386130396638663837353830306530333866223b733a33323a223738623932666538363131616133313335373434356339653165386331633766223b733a33323a226333333165333437396633646436396161333364306566343164646335386630223b733a33323a223361626332333261383330326263393561316430336364663734636230303237223b733a33323a223065613738353562356238613238363261333038323532353064343365396138223b733a33323a226234333466363266653863623033383039346236353664643263366432646339223b733a33323a226665663435386534316166373463363165346337616435623666616430663262223b733a33323a223366303130623738613363323565616336616532613563306664376638616539223b733a33323a223366633039646631343439363033663735373233393632356263633935303130223b733a33323a223130633464343831636365623864633433646239323037626536346535383534223b733a33323a223961373132643133363564306665656164633764383132343735313562613264223b733a33323a223537343635323731333839333539343237623563613535306639326335633931223b733a33323a226362393738333131633034313032663831613236313362383261653931363263223b733a33323a223161306537666463323936396361323833383266396336646564666636653737223b733a33323a223939666136663937303232323137353462393363666237306434336535306234223b733a33323a226234376234643234626234316466663333613034306536633232613162663539223b733a33323a226463623035323031343238663739376266363865306530383734646333643339223b733a33323a226439666435623837633231363261373138336435383238376264373735666632223b733a33323a223964353361323739333334373461643764666139376432346431373866316261223b733a33323a223633353665343464636462323834323863316264393539316663323033623362223b733a33323a223162633530353533346431333733393664323361653638373537633866373132223b733a33323a226234303463373034346130383866666133623233316330623864333533363263223b733a33323a226437363638353937303963303561636531663437353637396164333339636430223b733a33323a226334653364376131633063653734396531363633636534393738396561333738223b733a33323a226564306133393935643061343035303433393662383634353563383264636535223b733a33323a223238613134316364306531613138663765303737396564623366393464323336223b733a33323a226364626562306137393536653732356631633739623764376465326466326332223b733a33323a226334366531666538366264633864313462333134663639616237613731616165223b733a33323a226631393535626431393961386333326265626631636439326436366134343035223b733a33323a223764326366356132636663366566393135313433663938303035343537376165223b733a33323a223561366434373565353464303239643266316266626661353330343161333132223b733a33323a223133323466326537303431376533626236356334323332646639633864386465223b733a33323a223938386232613433666465333366376139613034616337383065303537666230223b733a33323a223833633533353466363631616130663037326336653030653930346363316435223b733a33323a223232613665656461643030343236326239393933643365333830653262356461223b733a33323a223632633238373930393238633361626532653764343536343261373061616631223b733a33323a223130383832366538393363666436303236383237316261313866613533396431223b733a33323a223332363137616132353264356138636163303632383930396236666435303431223b733a33323a223962366266626533376636333865643163336539363130626665376164356533223b733a33323a223562303131313866616634383733656135363832646130333332613430323736223b733a33323a223837393162636361633336323835376265613139663639366434616463303639223b733a33323a226338666330353333333939373139393233666335336639646466643562356466223b733a33323a226265656235373862323533323534333239313262653761353963633538653366223b733a33323a223235316461316138656537613332666162323832636634633633656335326137223b733a33323a223238303939376135623337353534373461356464396466323339343361656462223b733a33323a223630346430613365316266613731666538653533666433343765366230383030223b733a33323a223438356434343837663635336666333963366261303439646362336563356130223b733a33323a223538613836613933663564666364343439313936343261636632653731663938223b733a33323a223663616635313761626439376137333035613039376534363833613736393231223b733a33323a223932306362646631303864373738613261666639633835303436373665636462223b733a33323a226532313139353137303933633833623366613332336566613739643032336133223b733a33323a223161616263313935306634303334373731323430613433326364326432656538223b733a33323a226235306362663531643539363565303833366337623135343562363963663432223b733a33323a223938643864373632326233333562353666333461666436303631396364616235223b733a33323a223061636364653665306263653836626634613434313430396261316462636162223b733a33323a223632373265333061386363656432373335653463303138633332306461653835223b733a33323a223666613332613262316666646538383638303139636239663661363135306138223b733a33323a223966353563666465393864343632396333333363393830376665643137643366223b733a33323a223561633831363331393064356238363538393531323230373862643832373061223b733a33323a226364313239326530643162386534663261653838326532323939356362303732223b733a33323a226564336231313432383262376565613862643735633636356533646431666430223b733a33323a226666396461323036396264633132653261343962356136323833346536616138223b733a33323a226234376165396531373065353036323462323334376665666239666438626132223b733a33323a226137373933396466663364393264643333346136646632323065623465323762223b733a33323a226561653865646233373638666430386534643436643061346130616534393166223b733a33323a226432666631326462323930643261633133646463353638653036333830313763223b733a33323a226537383031636466333036326132313735353166396635323235316230316232223b733a33323a226338633535653464383838613665303166356662346533326361336332393737223b733a33323a226234633461653939366638396463386237646332646237353932376566636231223b733a33323a226236303463636535643762333165663333626236313134643862343464356634223b733a33323a223765393964633439323739336564346162653061626332323231386332393731223b733a33323a223830666630663534353331306434373266326237633937663462306366623233223b733a33323a223563323432623134646239303434326537653338653131646437346233633062223b733a33323a223965623362386161373436316661656462333339336339663761653462623463223b733a33323a223933353131653639336162613765396562343632623264616336303862316666223b733a33323a226562346463633939616236623462626461323234366336383138333463353636223b733a33323a226438643466346161663135393862363961653639353936646137383731313639223b733a33323a223435666339383462653733393666313539353734303430383839356333303664223b733a33323a226330646137343065393066326338313939366235353436356361666465386338223b733a33323a226633356462646635343366313034646166663563396239616139316234353236223b733a33323a223636633930356139373635363730323537643031383063313031356464326237223b733a33323a223430303938366466663737363763653366353133306464363666356162333339223b733a33323a223732623738616339353730313361623436363261373263646564663661353532223b733a33323a223332393063306139623537383635303633363831386263613962303534353537223b733a33323a223731613035343436646435333538333733366433326539656131623838636537223b733a33323a223733313961306337613738346535313638326366393161343033656531386562223b733a33323a226266663762323465613231363965316530366263626634353436383661663131223b733a33323a226563663431306166353630346662383134383430653666303932653663633932223b733a33323a223264386565303661303736353866666336333438333533643565366633613537223b733a33323a223530343633383166393837356165623132656461303130623035666165353866223b733a33323a226362313330383539376432316631346439623264346330306439316166343666223b733a33323a223939623437383631656361393164323530333766373239636337653131393234223b733a33323a223835376266653061666630666436386337663766373635653633343539343861223b733a33323a226533323732616432366461623336343834633566666239396562386666636331223b733a33323a226334663962346337323663323730653664633561643962363731316461383064223b733a33323a226636303236613562376465366235343132643135656362333233643863663362223b733a33323a226531313632633565386431323361373836623464366166656264626432613063223b733a33323a223839383735626132303830666531646531303531386466613936666632623463223b733a33323a226439393630613362333034316166623165353135623936333662396530313939223b733a33323a226530336162386637656439303131623437343431383965353363616238343933223b733a33323a226634356163336532353835363961353534336439623163313435613263333265223b733a33323a223532333730613238373762363936333462633233326161386661363332656463223b733a33323a223964643737303161313630643138306432333965393130346534373433633364223b733a33323a223165313134653764353361653266363134306266363335316430306464383834223b733a33323a223261306533386237316534316331363937386262323035316265633131313838223b733a33323a223362303239366566663330343533353962333864373865386164336663363464223b733a33323a223430383666383632356230323334316531343564303962633034616363353962223b733a33323a226663653665336534313036656337323833393636653331326537356236383033223b733a33323a223461653637323765633133623834376664633262356435616336393435623632223b733a33323a223931623465616532343931373631643136616561313339383465616265626234223b733a33323a223064666533303661373937373531616533333337336663636531373732383439223b733a33323a226134633865306533646630653739386137383933656430323664643930633130223b733a33323a223931666265396338663561353866393134376332316363393139613139343636223b733a33323a226262386161616631316133616537393034653666616530616534326237646333223b733a33323a223265326534616166326265386362323062383963306532663638333266353965223b733a33323a223066643263323935336161323861336262373466643564613562373639336135223b733a33323a223436313433613933633162636635663138303536303337396434366434633464223b733a33323a226666616636366531373634346637393934666161343665323265383662643034223b733a33323a223863366263636565633265636665383335373134646334313934386563646330223b733a33323a223733336133656638396666373664613561396264366532363966356437336462223b733a33323a226435663534353838626139663934373432653564353562656631386565656131223b733a33323a226165386638366564643733373338653739633932306465626132303731343233223b733a33323a223935346230623439653536336465376530663935373863383835633635303139223b733a33323a223932623333643330613430363332386535306565383065393634376530626537223b733a33323a223361363264343438353536306466356531356138666437376162663036393763223b733a33323a223464373463336364376631656233373533633430323239316539663935383663223b733a33323a223461633864376536383034623132656536393532323831326639633064653339223b733a33323a223735316532623434643565393165336235306335373533623635366638353038223b733a33323a226337396464653466343430623362363735633436656336346632313238386236223b733a33323a226264356139613335643235663262643730623432386366333230363237613363223b733a33323a226332366163646232613964316162653235306234633730636139346133353865223b733a33323a223636626235366663333661346439633236326138333431646337383737343566223b733a33323a226363653161386464393535343535306230383738663230666638396235313933223b733a33323a223863323935396664646436613137643935343735663334646436666637636663223b733a33323a223631303862376237643061323538363365353433373635303137386139326632223b733a33323a223838653631353563313738663162653338633930376333393561393638346530223b733a33323a223937363232666238653166363834393633653230383039336466376631653561223b733a33323a223239356435386233336165613265313535383833393430393934356335393061223b733a33323a226337363466363337323530396631383831666564303334386436323235303731223b733a33323a223964363336623036323736376264633839623563663834363666306566613465223b733a33323a226131653663353433663238323231623763373030616661326233636161326633223b733a33323a223434323130343633373638663839306639643464656532333239383434303032223b733a33323a223434366138336233326266303665376534343936313465613137326534666162223b733a33323a223138363431623761346638306166326132663663383235393638323138373062223b733a33323a223737383764636238333565613261383638613966666436636235623866636133223b733a33323a223866336666346161323839633333343133643464643136636461336337383163223b733a33323a223562333537366534613864313932656436356361393665333236393730353430223b733a33323a226130613133333961393962323830663133393566353735303165653966333536223b733a33323a226233343730373766356334366630626530366539306634356564373263316565223b733a33323a223034313430366138343330643638393632653231643939393738346463303630223b733a33323a223834633964303966633830633365656561646362323364356239643231316130223b733a33323a223034623833373064636132386330373136666233663137623434343532333838223b733a33323a223064396136303237616565646330346432653735343763393664333930383863223b733a33323a226632306364636539306361366463643632343365363661393033323530366561223b733a33323a223635386438613264353138383231366338383136656465636338336664386531223b733a33323a223537346564386335643039393761653737386565653964393030366163653733223b733a33323a223138613438326266376363313766653761633862633764313339363737666137223b733a33323a223038666233363139333762363562346332383566383535313330633766663834223b733a33323a223839393362323266383833666335616361663566336338653436633563383430223b733a33323a226639373130376339373030303836343966346337373763656362306536376130223b733a33323a223638396562326261613635373963346136353563323061623066653134303066223b733a33323a226131366330623736323639333431366537393632383139663664623531373538223b733a33323a226338313339623039643230613564316566633133653730623139333264386161223b733a33323a223131346461396231383437313837656661666430326162623663336335393532223b733a33323a223431383430323731383333613530396365643632633839366434613965346462223b733a33323a223336333363333738663662383565326361663163393334316664366466616237223b733a33323a223139326661336561303635346563643761393864643733616239353132343136223b733a33323a226532343265663562626566363062373036306636613235393966633761333230223b733a33323a223265336661363361373336303334643631343233646130386331313534663538223b733a33323a223764343761643936373763303162623264376364376231636139633336346166223b733a33323a226665323937623337386638323238396662363633623432666566303338663535223b733a33323a223839316130646533383739646663353032316536373864663739353231343330223b733a33323a223562626538633333333466316337353131666231356463633666303935636361223b733a33323a223964353065386137356431636664363134616631303530616539656263343233223b733a33323a223066396231303039333334363566386632373566316162666236376130633037223b733a33323a226130303864386438376663303562636565353863393131336431376139326639223b733a33323a223133626463313238653239653236633535313566316264393338313135383662223b733a33323a223238616565333662393165616539616139663361626232653132363037383636223b733a33323a223239663838356432613532633735383936613536643037373839633633636433223b733a33323a226239346361663964643634616461366131616135333063643736666336666466223b733a33323a226266626139313832323434633735323533376163383038303266656339613061223b733a33323a226631643165616536383135666261633236326563383832346366363466653263223b733a33323a223731343063363435616666333535393364316238393835333635306438616365223b733a33323a223163333634663463383030393465393032353665613165356336323535346537223b733a33323a226430306537376637396461363461343032373735383030343534353033353939223b733a33323a226663633466316636633031303635666237653032343032393461393831306630223b733a33323a226538373263383038363031613665613262326436623463326538343233373230223b733a33323a226534316230336466323336343632626661323935353533396365646638363938223b733a33323a226231333862363334323766323134613735616333313662636533373830373639223b733a33323a223465326238663237656638386639333364343831313933633737386565303237223b733a33323a223931316132303764626365376439326636323763343861323936333862376335223b733a33323a223363376236346237376234666637376231303034393461653364356335323231223b733a33323a223066333964353434393764646236643266363030643739373261633137636537223b733a33323a223137363466366431343861653535373966373363373938613037646134353462223b733a33323a223663636530353233626562346561393831386235386133323630636636646432223b733a33323a226437633931316166356565613765646530343830336237326566613564333437223b733a33323a226535366536333765643739643164393463643939666262333437653563343733223b733a33323a223132613738663238316134393865396637353766376536346361343138616331223b733a33323a223262303065356533303739383834633463613763383033633336316263653834223b733a33323a226332373864383832336635363038323264653564316637653830356265613132223b733a33323a223630363532633864383563343732343964303464626534363237353234303766223b733a33323a223133343132663866633165313434633662353232333362656632316338353937223b733a33323a223438396536373162646530363431383238656330643835613633326631633237223b733a33323a223535336162613663383165646439666433333932613034613238376538623932223b733a33323a223266383433636262386336623539636464336432613932613664343064633866223b733a33323a223263633964383533306430343439346362363439303136376130383231653439223b733a33323a226661643033343638653165383439326335336365643337396166383631346231223b733a33323a223565306136393165656239313838353063383766376264303037373833633536223b733a33323a226239326265393164323139626262313565303135353035303263656431656439223b733a33323a226132623638383861313935306663633538363038616537393135316338316633223b733a33323a226137616335306637313139336266353030316237646531386236356665323163223b733a33323a223039383061643237386437303766613531323734616562303139613363626462223b733a33323a223365653038316433393865643731343634386537646531346137623138646234223b733a33323a223034303438653138626439306633353666323235343136353761656366373163223b733a33323a226133633633333436373661313861303936383733393362363234396161316235223b733a33323a226666656433393566383465383036656236373334393162613034396638306364223b733a33323a226161633938626166303431376264376563616365306663663862376133366634223b733a33323a223062313434656431333834336233396337383131373063656633626466613935223b733a33323a223633643133353130366361643966363263623438636330356164303964653066223b733a33323a223138366264666262313231356165396330363064643236633166316562366264223b733a33323a223737303236313965633037336163646665656264323663363739313336326331223b733a33323a226362336665643965333537646232633636323132306662613261363636663633223b733a33323a226139653438303831373966316132346538383864663762386564393633316332223b733a33323a223239643065363334373834623331303334313738653633653237636363646332223b733a33323a223038313337333665333339636630323531323834363731616332303166333231223b733a33323a223761306538303731303933626364643861383038656533343732316266653565223b733a33323a223138383463396430616533653635663230323961646437383439376438636434223b733a33323a223638616139653137373764323262333335316432316330646364653331663635223b733a33323a226263336539623461653731323366623832366264396362323533396634386139223b733a33323a223834343531633234343063356138363934636630376438323364343264346338223b733a33323a223866306430306265613765323037623830383763353835333138326163393637223b733a33323a223866646138333533653533656631633132393766383862646238356530666163223b733a33323a223734313961656334643535396332653432386231343738623964316361633037223b733a33323a223061613932363038363039326437336437396264343634323666666239383938223b733a33323a223864663961333363666136353336643362653465666330316163633665353739223b733a33323a223437313935383462646563393962633130326536643138363661396238353730223b733a33323a226638663231316136363735663862376537393132386634303832313538636635223b733a33323a223363356331323739393739343131396334393165643666326432636262623537223b733a33323a223364383663323166363065396265643932386531376537396134386235393162223b733a33323a226537343532613361663161323837613538623164353565343962323963326132223b733a33323a223130623863663532623261623137323335633364633163663365323562633534223b733a33323a226164393236373861333930376532653563343465313039613631363663616235223b733a33323a223166373137656263336361626137376135626665353532343834323539363138223b733a33323a223530356335623633393461656433643031323433323965626235636164623837223b733a33323a226238393237626338383865346661663237316333643637656664353133626138223b733a33323a223530303434383562633465376563386131356564353063373033336231613866223b733a33323a226162633566666336643939373135343236663433393339333262363965666635223b733a33323a223366326565386461653030323264326438613738383762323234393439323866223b733a33323a223232653964613233353733336637313863353262303332353034323034366666223b733a33323a223462333534346665636466323862666630616235303631656537356337383131223b733a33323a223062303433316635643161663265653535376166346661393139383931656434223b733a33323a223936326230613764346536353339396665313666653561306235353165373462223b733a33323a223533346663313130313830653061626437643032306637616634323766313230223b733a33323a226131326332303463613063656539383530646335376632636463613332656166223b733a33323a223937633164343265323930623663663863343730323139326566353566663462223b733a33323a223633376564316535663563316636306436613639633333323238376461623133223b733a33323a226161613238363033626335333137646162666330326437356166356237353065223b733a33323a223164353764393031653462363861313164656161643435306432356161353461223b733a33323a226238653039646630373936373239623362646234623131323330646564643864223b733a33323a223466616161623036613461303733663361396561323530356136343336623135223b733a33323a223633363531643836326662616436303036633238636333336564303837646137223b733a33323a223635643337663263346132656262653734623535326562653236633730373765223b733a33323a226261663639343861613230626536643363653734626535303436343463396163223b733a33323a223662303865383264346633343263373331653935643734396336373833616436223b733a33323a223866386364336536393739393665386337303132616637373037333663316433223b733a33323a226237313438373564336530323366353861623837373735343435376164653939223b733a33323a223739303461383830356335633763656538623737633365613133663263626632223b733a33323a226432656462343033653132373235376666323665633264656665643561323563223b733a33323a226562613531653665646334613632343633383962613061626532663263666334223b733a33323a226530343533343532393532343661303234613436663332346438323065633530223b733a33323a223430303832303361663666663662383931336361343362643635323038353236223b733a33323a223837623738636164396163623162343031623666303965366534336465653235223b733a33323a223766366236616163626363623338373838646131383964396161643564316137223b7d733a343a2268617368223b733a36353a2237663662366161636263636233383738386461313839643961616435643161372d3837623738636164396163623162343031623666303965366534336465653235223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496969665365727665725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223165383665613062623432363666303963303362653634323232653030663632223b733a33323a226638333565313133333232393765363030383261633863613035333736303333223b7d733a343a2268617368223b733a36353a2266383335653131333332323937653630303832616338636130353337363033332d3165383665613062623432363666303963303362653634323232653030663632223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496969665365617263685f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223331623836353134636337353932633063613835323063373965373637306665223b733a33323a226162316537643330393438343262353465346564343066356664346238353735223b7d733a343a2268617368223b733a36353a2261623165376433303934383432623534653465643430663566643462383537352d3331623836353134636337353932633063613835323063373965373637306665223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496d6167655365727665725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223061666439663133653262353135623866626533303035363337363836343839223b733a33323a223962383734613639376163623439353135343036336439613766373663326639223b733a33323a226233656165353431313032643132353635356664663361666138626437393562223b733a33323a226531363238383230653764313966393765366536653835643033343132373837223b7d733a343a2268617368223b733a36353a2265313632383832306537643139663937653665366538356430333431323738372d6233656165353431313032643132353635356664663361666138626437393562223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4d697261646f725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223230316133313766646530336433326432323930356562613762386634323836223b733a33323a226437383966613937336365656165373839306666633631623137343236306336223b7d733a343a2268617368223b733a36353a2264373839666139373363656561653738393066666336316231373432363063362d3230316133313766646530336433326432323930356562613762386634323836223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f556e6976657273616c5669657765725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223861346232306336656566373230333031633635626461343139323663363537223b733a33323a223738623363636362323166363966316236313339306430626230636465386265223b7d733a343a2268617368223b733a36353a2237386233636363623231663639663162363133393064306262306364653862652d3861346232306336656566373230333031633635626461343139323663363537223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1711460814);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('56b13fab1970b395938a115ce6647b38', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731313435393537322e3337343332393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223361343136356133323538366636313338346561303738656438666635356630223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731313436333035303b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313731313436333137313b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731313436333137323b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223064636538306461376661613333306430633561336131616161636663376530223b733a33323a223566363733356637346465646565396263663433376234643563333137303635223b7d733a343a2268617368223b733a36353a2235663637333566373464656465653962636634333762346435633331373036352d3064636538306461376661613333306430633561336131616161636663376530223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3235373a7b733a33323a226463383930643839376462306339393366313130373632626232653632613739223b733a33323a226134613139663765363636393634363665616132373764383834353765376666223b733a33323a223533303132636537383265343734636639653531363930323862326334616162223b733a33323a226363333733613665303235363061306431663733363765613231623535626632223b733a33323a226465363034626361623566373265366336303833393564653832343035653437223b733a33323a223863353830313664653333313137363732623863383866656265623866666133223b733a33323a223231623538336631343165333561663436363466393233303764626435383965223b733a33323a223832383039633966643663626439303834366336393036613139623734323364223b733a33323a226433666530316238326636643638643137393535376433656338336637363134223b733a33323a223661313938656337613636343238653733396133303363363139346666363634223b733a33323a226634623266303539376537303537346238653163656133343535376535643162223b733a33323a226264303465383933633537306436363464343266646466383366376537643835223b733a33323a226431303932623361303632343664613534616135306466396537633830303266223b733a33323a226365383530646131363862336437386462383530333735613563663363343666223b733a33323a223163626132633162303934323035306164663239393237666465643363383366223b733a33323a223735316539336563386232336162373439623963353434363964623734316362223b733a33323a226234353930343231333463626263323064333165303864646163383338316635223b733a33323a226663346430633739336431343163373534393866396231333539666364353032223b733a33323a223366383039356431626536323263393930323863653161363239303231636563223b733a33323a223761303065613935666138656161376538356265333539313630343462386330223b733a33323a226565383461363861383432396639323636373962663932373765393036663732223b733a33323a223631366230323936326662633962643438366134656334623762333564623863223b733a33323a226162326235393837396435633130323961356139623161323732323565653131223b733a33323a226165343162316332303064646664303562623039616437633134626637343364223b733a33323a223036353161623232306363353865336163666335353830646437616639366532223b733a33323a223863373930633733346231386632343033323964616439646339646361326563223b733a33323a223361313335636339626365306131313264333631346537343634626530353432223b733a33323a223232666263383864666365323762363966393532633162646534326634643036223b733a33323a223134313831323236653966333138396539316565643537393439313334383432223b733a33323a226236353939306664326534366237333231653362323039373338633061313039223b733a33323a223733653133323230393733323432633165396138353362356433323663303930223b733a33323a223065333664326530633831633833323063303038333435343433303037373630223b733a33323a223365316666303732316435383564366435373561306435303166663065353836223b733a33323a226530666239343732386465363730303864633933316136316636333961393336223b733a33323a223162333733316235336238653133653831366566653139656361666636373561223b733a33323a223962623735383233393162323863303030306634363238383066623065333531223b733a33323a226231316435343831363931326162623063376166353036633637346432396464223b733a33323a223538363035386461633462346538636333336264633366316232666361386564223b733a33323a223036316230323836363233393065336436356132353931383130363964323738223b733a33323a223665306665633436643963643733313530663766343163643938303735663134223b733a33323a226439656331653531363635393334353639393139336239663666333266633631223b733a33323a223331313739366238653832376334353163646363623833623063313836346632223b733a33323a223938376262613461373562646465616134313739313135643334633233613538223b733a33323a223565303739363634636363656632623732643038323536343838623964633137223b733a33323a223162366263636338393931616564623433356663323430353535306535666535223b733a33323a223761666261643538653831326636326539643165646331633363343232336633223b733a33323a223064393266623433313230393363313434363464343165366265323661613736223b733a33323a223539333562323231623366303732626363646337656666323665653330346265223b733a33323a223735353036633863613764363930646365333531376236303631616235633262223b733a33323a226264366262386637323534663938353166636662623666313064343763343935223b733a33323a223466363431633138336636353330343964343732303536643536663161343865223b733a33323a223233343433633531306266303634333664393566316133303137316361656165223b733a33323a226565613032346661616537623761666138666235316331363435353732393836223b733a33323a223433646536343936306664626437623633333665366336613836666665616664223b733a33323a226161326631633836376634383631343834646562313535303462623138346561223b733a33323a223333383338663762336364323163383335376166353263376262633732613433223b733a33323a223134353738636230343164623362623362653234643537663634346534353038223b733a33323a226639306334613739373238643733663633623339616538303464363061313166223b733a33323a223533393738653236633737663861636563353664623634356463623230653164223b733a33323a226439376434336634656138663837653562616138616661363863343230646262223b733a33323a223261313661613466393664653535373031616562373335373834306133623637223b733a33323a223030396136633834306664363633646364323363313236646136636434386631223b733a33323a223136303736323464376139613133646461663162323830613331633164653136223b733a33323a223731306239653538623033383732386436346561376534366161653734303738223b733a33323a223831336366353664383962623662623161613035613931623637333136353736223b733a33323a223035663133646166313434373662333661333432363532306564306435333665223b733a33323a226230326262303164333137333534316436653337623133386432343664643636223b733a33323a223537366331613962353336393361623934356339363134373035333636636631223b733a33323a226164336663363662626239323062626437313434363030373035396333646534223b733a33323a223166373334313333623663393762646537623936313532393039333131303564223b733a33323a223663373664383131323731393531323866303364386436633662643130326462223b733a33323a226430373034643064363531363237663934626533616462346164323564393665223b733a33323a223430336561393462623764626330346663306639633134363737646564306366223b733a33323a223332343562326436633333383139386135336364313232646135383539373439223b733a33323a223961383139313630663465316432653262363637376464326466303332363434223b733a33323a223032326639393839643239306438383232373733663830343539313431323261223b733a33323a223664353231356634356333353137643835303839396438663235393665643135223b733a33323a223664626566633463626133383639663236363338366534303463383063316232223b733a33323a223538303232383733333735346337343565646563623164323034633664313239223b733a33323a226430303363396566646565346566343563386430626265656638393066643562223b733a33323a226637363436346235343431373430393264613066616333653535656439306366223b733a33323a226663656362383237626537316535316233393961386638376262326162633536223b733a33323a223965383430323662366463663764623665666239663733616236366164613266223b733a33323a223366346263653962396538386562393434353566623763333337396332343931223b733a33323a223532636162343636383834316630323138383737386134393835343538663665223b733a33323a223165383363376138363231356135393837343631326532653062303735653833223b733a33323a223135353134303432613731663162353431383037613435393065643762633764223b733a33323a226538306139306539396138336335643565326666393039326438326661326333223b733a33323a226237663366346333636566386535636131383462353763396162336236366364223b733a33323a223739313639396330666363323365663237386238626232633131373538346333223b733a33323a223731386436653433353065356636643137376335336238323235653365386165223b733a33323a226136633365323633313461656334643134353963326239343363666366306361223b733a33323a226430303035353933623436366461373839333866356536396263663366333962223b733a33323a223764653063343838396439653563636161336466666430643439316239613964223b733a33323a223036653162393736656334386365613638323733383031393730613130353038223b733a33323a223138386331396234626336633661653732653039653732376439613938323830223b733a33323a223736393437366335653239386664386237313238636266303463663439643033223b733a33323a226134376463366662383730613864346437393532376139356437653635346263223b733a33323a223936393366613061363134643938366337336531343336366135376666376633223b733a33323a223632646533363361383062623735663438343930353938356663663263653839223b733a33323a226566633032373733326464363034643662393763373266646634316161333965223b733a33323a226163343462346663343866623535636332626130313062366461356134613530223b733a33323a223938343261373735336232343533316631376564323439373931313035386230223b733a33323a223831303932653763306530373335353738373261666633343334306561343865223b733a33323a226335326330366564303539363334613461316430306439343565323533623364223b733a33323a226532643464353566636538636263653934303534393730633238626431343437223b733a33323a223566613535363765306631623361376362303433343364643633396461623436223b733a33323a226161643162323563626464363933326630616465326161376639336537643133223b733a33323a223864323963636665646632343263303636666364663233383830623337646662223b733a33323a226463653361316538356361616161333735383032636666383163303734346231223b733a33323a223466326537333965323364366337656632623964396433363463323666303631223b733a33323a223262393430366163386137346535363663323430363533636438373736343065223b733a33323a226637323664623737653435313430383265376162373161336232623733653238223b733a33323a223334636137653437326262333065306230646363356362363766346364353239223b733a33323a226330633738316435666230363534633737373030663631356262343064343139223b733a33323a223965313631636531313166393138616662646163396663366532623736316133223b733a33323a223961643566373839626538373932353235663034643762393736626238366366223b733a33323a223266636663316533393464363437656362383231383933653230373136313830223b733a33323a223165323034363833366437303935636631646464346664313632393535333166223b733a33323a223666323337353962303762383033353063623033383134396236643035373530223b733a33323a226264613165366332343964663162613066636138363131666639666439633432223b733a33323a223365626637643564393836616166313261633033326239383831643762303265223b733a33323a223334616433323264633238356338383937386562386466353466323334326239223b733a33323a223639363435643263373466323033643236656232643463656236613833323738223b733a33323a223337343830376437306663373561623631366532396435653464316265616262223b733a33323a223136633937373363326366336161373333633935336139653734316431653763223b733a33323a223139333136663333626334663366636430643235343830656438633138386534223b733a33323a223738376530383262636261306331313462633835356539376434643461343136223b733a33323a226133383132336339643366376133343463623166636636356562616662663630223b733a33323a223935623561333962613638616630653266383666373965373238393766373430223b733a33323a223632376333316134636138613464636236643063626563393063616136393436223b733a33323a223564353636653065623137383663323165313231666565666362643362383862223b733a33323a226436313032333838613735613732613563363935306332633665653538323330223b733a33323a223534633438643262366263353966623631373462386632326165343433396330223b733a33323a226565633062613930393234633437306163393235633133303261643137636262223b733a33323a226562663935666536306465313935636634323865646562616335316434363031223b733a33323a226633646334333366623938313732396331376137303861613530376430393933223b733a33323a223031386337616364363734366339636533306662313561333435623035303835223b733a33323a223830666538343530623238376139303331623137636564376337626662636135223b733a33323a223936356138366466643139616563306639633236363263666330383266323066223b733a33323a223833393537383436383134353066306562616136313432663836356164386166223b733a33323a223638346632616666393665336266653931316265306637363537306238303865223b733a33323a223332643561643931653431336232666131396334643938336436623330343865223b733a33323a223030383435313564393735343938353139376132323934383139633032653832223b733a33323a223563303331643132663139623666333365333866326133376363643135656133223b733a33323a223631313264396165643132633364653138313538396633343365346237616231223b733a33323a223030316137366537393734336538313566336639303065366439656136383739223b733a33323a223233353031303633633236366465353162633463613136356639306632643032223b733a33323a223632613264303035613361376630623031393462373138306635346162613064223b733a33323a223132373765386264643735643566313135333138366637383864313061633062223b733a33323a226566343661616334616237353561626132343435633963323234376365623037223b733a33323a223761366630336534343936626334336133643632346531633933656134626264223b733a33323a226536613564313830363364313935353963653135666661343263346165393137223b733a33323a226363303137353235316436313164623435613964353037653739373835333663223b733a33323a226234653739373631613463393764613030383037323963393866353037323133223b733a33323a223130366132366238363339393333366334313864303533346134633861666262223b733a33323a226531666238336666306231323236613838356636643666653463643663383836223b733a33323a223830616235653762363664376266383261393937333131336633343765303139223b733a33323a223861336562343361313132326538383739623731663961313463393036613233223b733a33323a226431613963643330383561313930623131326364383939636365623631396131223b733a33323a226139643638356465376238383537353561613766616430366564626565333966223b733a33323a223836383030643664383934366636653834336636613166383933316464636664223b733a33323a223334646435366263386461313361656331633934653639346134363839653239223b733a33323a223361643431316135623939343365646562636131663962363161663466643162223b733a33323a226435393036383961626562303563336431356532333661626532643963383566223b733a33323a223964653464393066303266343032616339643032376332313465306661663437223b733a33323a223562333237633465666666656136343333663362643630373431616234336333223b733a33323a223536343235646461633666343861616538343739353134633261333330633439223b733a33323a226233363038356433303832323637393138383134326634303962366163386430223b733a33323a223563333863303164343866333736663139393230363939356465393232383336223b733a33323a223637363061643436653938363461623361323331643439633630333837663432223b733a33323a226637303164353666366133623564316334633334323966353437356463323566223b733a33323a223139343738323836346261313963633633343437666166666534663864356266223b733a33323a223464633133626464626538646530333962313633363738363763363638373939223b733a33323a226331336261373230383762393537316366626339366335613263323066323432223b733a33323a226531653962343462393735363635643938666661353530376666313636636336223b733a33323a226561633065353137303934666536356338393631366231653265386161636130223b733a33323a223262313763643833303339376339373661356337306136346635656138666232223b733a33323a223663333634386132383036353562663231643366646539353731363630633164223b733a33323a226538636265613933346461656162643064386233396230313730323432623836223b733a33323a226463666339356231656663333930366338396233313366653534636132636362223b733a33323a226538653762303238353239306138623035346436653764373361376631323737223b733a33323a223066396139373263646564363931336336633532646534643336633266613835223b733a33323a223239346463363939363036346564316261633835313361323535393733616262223b733a33323a223262383766616166666565346665353936373865326239356262363231393866223b733a33323a223539383434393537303638383030626139633333393634336365396539646364223b733a33323a226666333366383764616535656561663062343930316463303531623063333830223b733a33323a226538303961346535393462353437393239396532396238316530326138363733223b733a33323a226136343165333038373564383065393131373833326665623935326263383635223b733a33323a223537383261393430373966646632313666303465396666373232386139353363223b733a33323a223763396237613938393465323561643763633538633766653038303134383135223b733a33323a223236633066353736303063353433616266666134643939363861336633636233223b733a33323a226165663764613665363065383764313563343131663963366465643336393561223b733a33323a223239313635653861356138373364643732313237333331323238346132336235223b733a33323a223731353938316666616462646638643163333939616265616635333666336437223b733a33323a226262393934336230363234613935303965653433646465663638393434376434223b733a33323a223663373832303538333138313665363339333037643331356663383161386639223b733a33323a226366303439383862623762373538663635663337396639333466666133316432223b733a33323a223438383565333766346339363437316630363632363231303930623766363436223b733a33323a223232313038366338633535343437353266326630373864376633666133666261223b733a33323a226338383130326531643437326564346137643163653136356531626330386434223b733a33323a223063363539613764363138356464643563323236323436323065316362633430223b733a33323a223738316134373838343563643630353664363965386430363532333163636431223b733a33323a223235663964643163313138373639623438383436366361343366633534303666223b733a33323a223366313138646333623966343033633736653532323632373366643364623039223b733a33323a223366356165626336343636656661343231316334663166646134326364343338223b733a33323a223634646465653564636161656666303762643737386461303363323038393166223b733a33323a226365633763383631393363346235326234663161623963343766663864633236223b733a33323a223866636438653137373630353962363136333030306333626334373938323166223b733a33323a226664393063376335316133313235393536363861386435366464613739386465223b733a33323a223637346234646434393530326164616234633436333136613732616638643434223b733a33323a223433656264616165323864663133623236393133343932373337356264363539223b733a33323a223930393265313362363364666631646462623965366362316563386435376534223b733a33323a223933303164373261656432633239646531353538656163393065613230383635223b733a33323a226630316430393038353238666638326662666562616233633435626431316463223b733a33323a223232363463333330386265363631386636313434336334663865333631383434223b733a33323a223234386135396435313739303264613232323062646530373233613736343333223b733a33323a223961373264356161653830303761643231303663653434316338643731306530223b733a33323a223336343632323865626537326561363562643136326366666231623364643863223b733a33323a223663653038386262326535336637653238313061656166326233303563356332223b733a33323a226366663230363931356636656132316630346538636333303437306364303935223b733a33323a223430356163393934396362316565633233663532306563363431666235616264223b733a33323a226463373862356530613135643365326661363537653164363739333434336237223b733a33323a223233376239663561393636633065663938646136343335623864366338353631223b733a33323a223561373331393233653934346333343234623931623334363834633862656236223b733a33323a226632373364643933353533303336613230353933306338386139653731353936223b733a33323a226366303935326334616238656636343039316666396231653836636361626466223b733a33323a223866346237316432623137316564653035363137353935396138333464333330223b733a33323a223034303933336162663831366566333964653232646632313630376334623166223b733a33323a223334363232313136376464303935323364633033313365626336363465353230223b733a33323a223732663830613862313963343539303466326639353562643762353161633139223b733a33323a223261386530316136656338373236653662353737386462613561373836376237223b733a33323a226536333865633032373161393864303435363732346337396561633138336464223b733a33323a223234326436393337633565663164363033313736353763613836353739306432223b733a33323a223862343461303032366565623433353665643562643764353163373164633331223b733a33323a226561646339363336343036616133653132616130306664623762383533353338223b733a33323a226133356234633635383865386664663462356265303733613739363835313266223b733a33323a223337373633653331326237393636396465623231393262643533306132666134223b733a33323a223835316666633333326365643837313232366330663139643035333766373438223b733a33323a226435643761623931396139646537376239353230373438333363653263633334223b733a33323a226335346366323732393661306461383234376536636462356564343561633839223b733a33323a223839636232633962336562323430363932353830346166613230326663306663223b733a33323a223239373738316361633264663034353230613639623065636231636664306264223b733a33323a223637663062323138376266626336643765633962383033376462613530363731223b733a33323a226337363534386663373337656238386437633265336232363766313863616232223b733a33323a223039316163363036663237336662323334636130613766306461613966623538223b733a33323a223338383163303538636131343630313335326361623366393064636261663665223b733a33323a226336323432366564373831386237636631613635643430326563343161313039223b733a33323a223135643937656436353733633966386235323766653966316435356364313731223b733a33323a226632383964376231373734353562376437303239633063313036353335623536223b733a33323a223137626564396637326135656462653262613632323931383135306563616663223b733a33323a223161343961626365363131306638396362343337306563353966613532373036223b733a33323a223537666263623532653930616533646433323639383730663734313865353037223b733a33323a223430656238353066633165313735393137636263373732613435326164663161223b733a33323a223439376338323166396239343737313966316130656331363665336637663362223b733a33323a223039613366636666326166333037303239616339626530336135396239373164223b733a33323a223664306535366365343330316361396631373866346463366330303436626362223b733a33323a223065343162653138636434313135626337323965326566646632363137306539223b733a33323a223366363662636330343034333832303434366338333639366436343630303437223b733a33323a223531323933306238393161333566613130643836623065623135626461303437223b733a33323a223665343532373464396334376231633931623130666537323531303364303465223b733a33323a226539316431393239323361633332323030373835373963623066326233666531223b733a33323a223965313265303138306231353838626336376463393561616435356365636231223b733a33323a223065376336313036346163346266303138376438663033323664613039353833223b733a33323a223736663035623563316237306439633531653763633333616633323135363165223b733a33323a226137393532346338333266343935646537376264616265366163363132663338223b733a33323a223837643862303164343762363835356366333330613366346531363132663361223b733a33323a223335303262343732316537353839323063646266393161636362393763383464223b733a33323a226230376231643161663136366638323265373038333537376361353163643833223b733a33323a223063356436373564616262303831383533366161643137623865333336326234223b733a33323a223537313836366464303762646464366636353766316562383832646635333133223b733a33323a223962623835633736343062313963313932343465633035333232336366633765223b733a33323a223563333261343462656536623863373237323466653231353533373161656237223b733a33323a226665306164333436613835343436306265373965643239663062366163616535223b733a33323a226132383266333336643932363938376162373664653539643836633137333430223b733a33323a223532323132316562656433656166323662366131653366663362313763376365223b733a33323a223566653265393134373066346538323233383631366564666564643464376361223b733a33323a223064313131316532383934643133386535373638393530323833363538343338223b733a33323a223831333265626637636461376232393038366164383066653737326333613230223b733a33323a223966366263323230303039336537306465653131383436343561303961623863223b733a33323a226430646330626466656235636333323638343263363265343537646330343833223b733a33323a223039633661326539313331613530396261643037393331616530326364646638223b733a33323a223331613964346165303433316137313861623534366432623538393634383631223b733a33323a223036666332633162343666633861363338653635333234376366643334326435223b733a33323a223134666430323536363130393531613539386466353862393766343039366363223b733a33323a223930333130653337373762303732306131623132353730366433656630663230223b733a33323a226533363265633735616333356265306563653466623562336234363437363935223b733a33323a223164323535313163643832383066626431623532373430356435613834366635223b733a33323a223965646363393439323334313835363266326635353537363765373662323663223b733a33323a223839633837653334616462313136653761316530353034616265303532636332223b733a33323a223938396134326461643834363361663236313464346337666265626338383931223b733a33323a223461333639316538356435666232336533623162346365326366326134393031223b733a33323a223165336465393465353065323862333331396464633562363638363063393763223b733a33323a223665613138663637316330346362343261306639633937636139393431633838223b733a33323a226162363139306139626339643039306537356535366662313130376235663532223b733a33323a223866323930653863356236653934633832373462303965383635663661643930223b733a33323a226166623961646538323164383363626135333133396237643138623962633164223b733a33323a223866386262636536356430666266363835636262333338613064613435313964223b733a33323a226635353331336365316562633735316634333663333862383534343535386531223b733a33323a223163396232393236323664623830613962643763633834363335643436326566223b733a33323a226334393530353462343561323634613863326534393834303636393563646238223b733a33323a223138626131636236323830663437326265663536656235373563333766353238223b733a33323a226561626463303164666334356233396362613066666163363731376334383565223b733a33323a223532303239343033646466633866623264363434313234613966613533633335223b733a33323a223633653737393630383835376439633835626633663364396232376538323863223b733a33323a226637363264356135386365646133373161313534616432376132343136326361223b733a33323a223332346130653962316437333662663736393136626462363136636431643637223b733a33323a223431386639653166633062613034613163366561656263626134666337643761223b733a33323a223935353334313237346434623831653737343737333636383834393164396232223b733a33323a223061376466376534633735666463326365376233623435396138343739626531223b733a33323a223839626332313730616262336464353933373934323362656266613766643763223b733a33323a226564613032353838623933363933363263643839336536383166313631356234223b733a33323a223363363233646232633936653066303938646431373263383238396536373836223b733a33323a226636386333626230306335376639366264616132366330363837613234366436223b733a33323a226362616232663066366232356631336463663239633536643531616162653033223b733a33323a223834626562356338663232373162323432383830656163336262323836303535223b733a33323a226162353839393037643762333431633530343234393561386538656338353461223b733a33323a223336653333313364653631373239316633666330643466623435346631663663223b733a33323a226563653632656163393934616163633930656563663563646362326439356234223b733a33323a223936303661643035333138653739636633343761336632313633343030663061223b733a33323a223165333161616633653733356438633732636663656233316534346564363263223b733a33323a223762376230366432383036613532666234336534646431656336396434326233223b733a33323a226632356130653564336339646462646536306461383436343064383766373636223b733a33323a226461653963323766323761366638636535313036613865313033663136346633223b733a33323a226639373762353064356439353066313530366131633461616663333834396538223b733a33323a223262623163336231313266626536636433653961366131313063643034373734223b733a33323a226439396630356264663165626664396533616336376464316663356239326661223b733a33323a226437396563633539656133336536303166626438316431376637386464303632223b733a33323a223437363631646633623266303461633963643465386437653062633935393166223b733a33323a226166656635373938383561633038656138336164656564386563386634353034223b733a33323a226439393461323465653834316266313737663863636565346561623861356464223b733a33323a226563303438343633646365336662373563633436616266313839353432333032223b733a33323a223938616365323062323930663864666464626565363464313462613034626436223b733a33323a223366633139376232373765613031386133383935633862626134643434343062223b733a33323a223763326563623337393461336236623935613339376436616661356262363734223b733a33323a223237643661666464643738393036666431653833363033326139386438656636223b733a33323a223832656432393236376330653361303933303937313431653336653635386438223b733a33323a226638323262663261383333333835623135303261356266376263326562373534223b733a33323a226566633839353465313961623236393932656531386135333134613631653464223b733a33323a226430363732646534636233663065326164613361316562663732376432356265223b733a33323a226133373437366338323433626539666436313162303235663432656338336432223b733a33323a226266386234373765623334323465366536346533313663393664396330323663223b733a33323a226362306663653532366539303163613635643063616265666232656139383863223b733a33323a226161303036663066383865383031626162303363613736633431323538393836223b733a33323a223962306237383962386238616430303733646136343665626364633232326466223b733a33323a223030346338633934643066626262663630333135383038356563353164313739223b733a33323a223833323234353466353737313538636433353331613532306466346231333938223b733a33323a226333666538326534316361326166366635333838316361616265633437333334223b733a33323a226332336438386331373266613364653765643361616539313332623232326135223b733a33323a223161643066623165323464343930393066343966343637656533653339626361223b733a33323a223461383533373830663330663031366265303165346562303463353435316164223b733a33323a223239343335393664626332386364383532663430326631353332613165356161223b733a33323a223564323034336231633231653564386334313134633538366536363731623261223b733a33323a226536663630326565386266656264623063623861383963373031316262323566223b733a33323a226439383563356261306462666436383065326335396431323763313362666562223b733a33323a223534363134373761666164616234313837663966376139303334626135316637223b733a33323a223736623461376465623262393336623635633036643261303532626663623364223b733a33323a223465636530316561383462386131343533386266363466633665386337393065223b733a33323a226338636166633766363763323232653432313661303132626266633563633662223b733a33323a226361316164323030366638326663366531643964376535313436313537663863223b733a33323a226335396562396436663861336534353866326536656632653538306564656139223b733a33323a223965386465656565646366613766303039613439666132633736343137303865223b733a33323a223735376331323234653339623965376339333762663636383234616332383965223b733a33323a226566376566643764326435663233626335323066666433356139623461663737223b733a33323a226462396330666666306562646562353134633035393832626531626463303065223b733a33323a223862336139613837333133393333313161376238643837303633613139306463223b733a33323a223534346365363463663361306361353432336466656335393634373764346466223b733a33323a223061663166313161396431333065373638383830383761643039633362363032223b733a33323a223063636562316165346639356365383266336639396434623565653036383538223b733a33323a226234313265326234623234613936336234646537383038383233643539326263223b733a33323a223733363465623861633837333737373333653134616261383036363264366331223b733a33323a223765653635396532643862653265303932663638343065333538613961626232223b733a33323a226562636630636338343364336338613532396336383133396431303731393765223b733a33323a226161393862663561366530623961303039633232323038316438346537343264223b733a33323a223861303932393538386664333232303730613264636361333431393839396563223b733a33323a223632306439653232396463383532633636343439316437393562376535626364223b733a33323a223131643632626336636439326439376337376466633439643532306361626562223b733a33323a223564346237616235396137303837653738343563353633363266346637633565223b733a33323a226337646331363336643338633261363766303563666130306238643331636630223b733a33323a223939313138346364306337333837316562353432613537336339306165356531223b733a33323a223066636364346239376135636566356163373961376531336265356561626163223b733a33323a223164666435353535663437336464363738383033343735613532613735643239223b733a33323a223533626465346533333637343539393463383435616430366333653461306561223b733a33323a226637323836636462623436343166363936386334323239343739396162306363223b733a33323a223230316530623130343434373631376265326632616261343764333665643164223b733a33323a223632646535323236393662323461316364323338346330653665653065616363223b733a33323a223539376236633335323465336462646635353735666535366163653437323962223b733a33323a223332656539623065376630366638363634643562663536653239373733313630223b733a33323a226365633766363630626164386466653136373839336239353166333762363134223b733a33323a226639656134373633363631613831616131666366323035633738393732636263223b733a33323a223131653765313862646536336364383961363835633366393561623934633836223b733a33323a226230366234373938303761323164313830343837346637396634326532396635223b733a33323a226632623835613533353336666262613534326462623166393133326538663532223b733a33323a223533383263383961663266336263623030646363383831653462636339376137223b733a33323a223530633466333130363239353135393765386436356634643139326462613530223b733a33323a226334373863383366363037343264333237366136306466663565393937303033223b733a33323a226664633130343066316164613562373636663038343135396235633630313236223b733a33323a223230316164396234613336323862633736313162653064393137306339373833223b733a33323a223361323865333732366532333432643630356536363834346536343133393562223b733a33323a223562613766303431396132346138663231623030306265386565303764373064223b733a33323a226532333134626239333934396534623033326338613338326664663933663165223b733a33323a226437383363306137613237613736656535363234313031623636623766343435223b733a33323a223838653261386561663039646138333934656163643964366266613063386231223b733a33323a226332343133616437663763393137636563396464383135636563336264383734223b733a33323a226362396239303035626531323635306163623533383232666166653938376265223b733a33323a226537623831656239633264323230376434383132633061646131353265646534223b733a33323a223165393736313038353035333836303063303838636635333934343230663066223b733a33323a226464343333653562393464616336623766353933616330323533353435306466223b733a33323a226232336433616162653135393464373635376138326332356661313535343139223b733a33323a226131386165383133323738373239303334336236663263333632313161643932223b733a33323a223966306230343763646639346666653430323332353838373230663136396637223b733a33323a226661376335363061633561636532326664653661653937353537633533626564223b733a33323a223433386639623366613466373838623766323436316665366530633531376638223b733a33323a223965356531376337316565376364666561653232643734353034376131396334223b733a33323a223262373531653335326233643833323233313831346634343230386436656533223b733a33323a226661333336333630313132326231663034616631343339303439393066336462223b733a33323a223333653735323335323230623162316633393532373738386361313164633261223b733a33323a223834353136396366323265346239343734396264323132623239366639616136223b733a33323a223837303639653335666134663765633335613635386335653433653238353466223b733a33323a223665623265373736323533386339626136376265363365363530353730626362223b733a33323a226365613133643762613034623262613731356636633365323665363233633066223b733a33323a223564613166396537313536333732323865313032393562633739316537633765223b733a33323a223331373963306232343861376463393335613039636264353432363335313532223b733a33323a223164636230373563313831666162623539373836353136636435646134333066223b733a33323a223934303630613762363833643164623131623830333161353736376361393635223b733a33323a223432613537396261356430623465663463353663653138663961663763336330223b733a33323a223737643639333363313138613731383264316263343966373931383339356334223b733a33323a223064653131336137613437333337626530393839363739383365613462396437223b733a33323a223435396635346463363336656530326363313233346634306266393062366130223b733a33323a226664326361616139653831343661313763663138303366353334623837663466223b733a33323a223039353931346266343634626165333438326534306663376132373334646238223b733a33323a223433623932373139396537373838363434363336623066343531646633383830223b733a33323a226234643761316363623938636661346465313561373534323866316538376631223b733a33323a223537376436393062306138666236636237303662386632383233346633656366223b733a33323a226465396264613332656337366535383564636264653962393230653864346639223b733a33323a223961636631616138346234333331306332636463356334383039636239326230223b733a33323a223537643035663666313336613931623165663461323931626238333365396239223b733a33323a223234396164376362366337346265653364326636383738306539346266613863223b733a33323a223532366435356461633862343535666131613333383133356538626465376237223b733a33323a226631646534323230613162333764363336316333353639643033303731396264223b733a33323a223034613434633030636366616236613166306632393166363538326430306564223b733a33323a223865356633643234623632393732373539363661303237656232633834633336223b733a33323a223634353738636561303138373533643036653762623831306234313463356262223b733a33323a223865636265643564336364383837333839313433316264303335656365333736223b733a33323a223661383666663432393763666263636636633664396561613162363763613235223b733a33323a226534303836646565633963663765363561623536326432353862316462383638223b733a33323a223634666165333963346237633332663134623731306137653935396639666332223b733a33323a223039363666626164646231326165376562623739363632326664613232613330223b733a33323a223738383137373562323863666337663532643235366365323866323533363064223b733a33323a226336336232356666356434376439653037626133346264643563326339643531223b733a33323a223333353837363032623732626239366463306365636436396631363962343064223b733a33323a223361326261396166313932663638356234323832663537383264323661613261223b733a33323a226137333235313234646263323234373835326132363739323535613461353036223b733a33323a223734643666323033613836343537303438646566323336333736633239323965223b733a33323a226332393562363732633263653334626635626332396466313661396132653333223b733a33323a226133333638623231366562376465633564343137363530356461373836656330223b733a33323a223831613762383931303633633837393931396437653363613361313634313461223b733a33323a226165643761333062306530326662386631373136353338646564363332623733223b733a33323a223230353461623261376435333065633238376566663035333836643333373061223b733a33323a223762386333613537633236336265366231616462623334646430343438386266223b733a33323a223439363436333961613737333137663061653139613865613231343939386438223b733a33323a223661336237306563646130623262303238363165653061646163353732613738223b733a33323a223564346465633838383236343136646534653065616330303761356630663661223b733a33323a223233316437623066353066643935623839643337633630353364323932346461223b733a33323a223662373139316364343635303436313866383539323562666530333466383364223b733a33323a226438333536613135313035313963303132326638646136306435363533626434223b733a33323a223131393162336237333536353137656230636634326233616162376532666264223b733a33323a226161373036356337633164663662633734646139393363383366633064303331223b733a33323a223165663337343539303130326435663838663339396362363136346433316630223b733a33323a223964616534623436363733633661396636323764343161626662346466376365223b733a33323a226538336339353064363438636236386466646636643036663038363366646435223b733a33323a223039613230613530356563663065326164623232313266616530616362353731223b733a33323a226635643163623966636431326337343834626162353438613035666462636263223b733a33323a223834666339306536646565643736653237633066326337343263373737663838223b733a33323a226133613663666664633766333336396231333134643666333237653361663739223b733a33323a223738393130303937306565316463306533633339373261613633643135616133223b733a33323a223661613161646463333638623138663665353039373662623335663432616238223b733a33323a223833356237333436313865333162353365636631613165393335383263636638223b733a33323a226234366365366466323230626134653464343430653565366239663833343133223b733a33323a226230363335343937353539663034636631626430303362616334303238383431223b733a33323a223833373839623464643365333739326235626632353034303131666433383935223b733a33323a223163666438326663383334636466623563636130396339653061373362323664223b733a33323a226633386564363165373263396636666630316664303530323763343035616439223b733a33323a223837356131386364393866336430626332616432333465313461633534653139223b733a33323a226563356333616339663731303335346536323637393030346165396138663562223b733a33323a226533313432376165356663303437396631383861323036613263643834653837223b733a33323a223537376562633934656166386230623132323737353464646535656163333638223b733a33323a226433346430376233323866303532393138376332626137633839363738623236223b733a33323a223464323435313066633834393664306632343730623630353264656139633133223b733a33323a223032316433636532643638636535376466323566323033333238343135363731223b733a33323a223635653637383737393730666261373333363263313236636632613035373331223b733a33323a223330303063326134313337383135633837306232363633376436303330663733223b733a33323a223064373735656234663165656337376464656334396137656530653563643162223b733a33323a226639323265613735396334396538353165326365353633643233356264656637223b733a33323a223334613666666331316135326639333465306461613666313834313035663132223b733a33323a226330313735396132663763323833316133303366666134343536343663343030223b733a33323a223538343633386563636430303963396365343237646464303939346461613636223b733a33323a223933353436383739643263363035633931386366623530376636316131323837223b733a33323a223566336364373638333465373761376631356161376666343434643233386663223b733a33323a226462633133326534336137353465373262333532396665386134366435656330223b733a33323a226563346361363964653032343433376330303930376664373134633764323863223b733a33323a226438313262363838313730366633363833353465356435613361323230333561223b733a33323a223031663135663337626233373337333737363366633632366236666165613333223b733a33323a226364366638313161343336373766373361316232346436373730633433386565223b733a33323a223234643635316133656665623266326163323365613033346130373033656535223b733a33323a223138663935353035303639303131323035313261656362626230613332363138223b733a33323a223236336438646133353234383139363765396265363531333939366165343435223b733a33323a226430666435346565373263323265363463336337656463633639643466303664223b733a33323a223966656462396537623563653932316434616332336339666433393136376632223b733a33323a223632326636333862343931306366613333353435656336326234336138656531223b733a33323a223064393330323763623666613634333633306634313335353036356130323534223b733a33323a226466366439373039326235636234343561383866653662363235646233313830223b733a33323a226631353534656535616632663432306536313230373531663539353363653737223b733a33323a226464336264363632363063333837393065613336376561633138383464306538223b7d733a343a2268617368223b733a36353a2264643362643636323630633338373930656133363765616331383834643065382d6631353534656535616632663432306536313230373531663539353363653737223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226666633931386537343364336334323461366335386235613231336431376333223b733a33323a223365636130663332626334376237643431373839383635323365346235653965223b733a33323a226633393261343462383964386638326337363532643435346465366238656133223b733a33323a223537663737663037346433666435363935343232393563363237316638646635223b7d733a343a2268617368223b733a36353a2235376637376630373464336664353639353432323935633632373166386466352d6633393261343462383964386638326337363532643435346465366238656133223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1711459572),
('6f4d3e29a632d008afdc136d028a6e82', 0x5f5f4c616d696e61737c613a333a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731333138343332312e3531343131333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223666346433653239613633326430303861666463313336643032386136653832223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333138373932313b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223664396235653731633531313163336264633530626362613637653362336532223b733a33323a223932326633386462306636393763366231613366613566303436353031663032223b7d733a343a2268617368223b733a36353a2239323266333864623066363937633662316133666135663034363530316630322d3664396235653731633531313163336264633530626362613637653362336532223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1713184321);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('73cbbb6cb5c0e4b70bc508f9ed638210', 0x5f5f4c616d696e61737c613a393a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731333138343435392e37353632343b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223964383232363432626666613037653864363661366230633663353032666166223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333138373732343b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333138383034323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313731333138383034313b7d733a33373a224c616d696e61735f56616c696461746f725f437372665f73616c745f666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333138383034393b7d733a36313a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496d6167655365727665725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731333138373936353b7d733a36303a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496969665365727665725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731333138373939363b7d733a35373a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4d697261646f725f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313731333138383032363b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223433376536623466643733646638303635306230383834353265666137306238223b733a33323a223564323931663730663566353637363166313033346361383431366563326133223b7d733a343a2268617368223b733a36353a2235643239316637306635663536373631663130333463613834313665633261332d3433376536623466643733646638303635306230383834353265666137306238223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a363a7b733a33323a226133303731366661306665383139313734336438633032326636633134376438223b733a33323a226462616435626430646164663434363930363139333535333066303561613162223b733a33323a223163363135316233333065303834306664373763643437373766393935666665223b733a33323a223463626135633533306438363665393863636465303666623735383562356536223b733a33323a223635383439386263306436633531326138623466343130323231323665653339223b733a33323a223338343338363162323664323439653034363739613364393036323831653334223b733a33323a223739646635303733613561613261326537396237626363383664383136393334223b733a33323a226337656633313234643537643638333539363830653234656233373833333765223b733a33323a223131646433616237363635303233666362653437616138636434623934643731223b733a33323a223564306238303533386437616664306332353337663236643535306364353366223b733a33323a223238663135363538366662393035356264623337343761643934646630623032223b733a33323a223531663263643035316662396136363431303032323633396433353838643565223b7d733a343a2268617368223b733a36353a2235316632636430353166623961363634313030323236333964333538386435652d3238663135363538366662393035356264623337343761643934646630623032223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a39373a7b733a33323a223266663238396461623435653335666634343831653434613063653233633163223b733a33323a223939633436323633353932373032373332616664643363326134336637643033223b733a33323a223562636133663538303463616236336436653866343362356635666531663636223b733a33323a226263353464613061366565303964383733366531386261653431326335616430223b733a33323a226533306337656231363338373163663130333761383134356161653665626565223b733a33323a223861656133396666373966303461336632653161636633663239626438386137223b733a33323a223431323061633038653337373065316233373362633530376133666332383462223b733a33323a223335363833353336363361316234306563633966656331356537353530646565223b733a33323a223533623763316230366230663834376434383134316465633833306537666363223b733a33323a223164613465663463333366646434383339326361343330646565313062393262223b733a33323a223334613266633337303765386161366134383535393530373263616464346139223b733a33323a223430303965323332343566623235363837656238643061373030393833323164223b733a33323a226533666232626331373063346466393439663761343233363438383161663433223b733a33323a223836326637633838653239316230613164313762623033643430616661623839223b733a33323a223064353066336562343061353437343964313736323166376662373063383238223b733a33323a226266666161646361353937376363323730376661303563353837646465626230223b733a33323a223466616431383730316435663732336532383735316531386631326335666532223b733a33323a223665323332626566306231306339383630396366383133356530633066323664223b733a33323a226337376134386633653330393938656638363761303262396538383130333265223b733a33323a223366666639643862623864613633646230386535333465653032316639326230223b733a33323a223931316534363539356232326664656264616237303861313065353961356362223b733a33323a223362633231323934616335303661303864393863356661336462663037333734223b733a33323a226465353237333438363634323737363936393935366266653334313866336666223b733a33323a226130333765396130343664313965323337376566666264336631336430316263223b733a33323a223565626335626631376138313233343662663838363036303761623635646162223b733a33323a226334313534613938373464373666633439303339626537313636356537393238223b733a33323a223062306365613862386365633163356161333437663639306433663739613934223b733a33323a223139343539346239343433346663313534323435313334623562643461633633223b733a33323a223765373563643766653336646166343532326134373739353064346537373731223b733a33323a223434663131373163613336373438383230613561363866393038303162343036223b733a33323a223731623565306435653839316233353832373761666361343766373836353962223b733a33323a223937336532306661623439633139303237633135383030656465336230633934223b733a33323a226663366363626637373837383130643433353361343930333230396433346638223b733a33323a223137633139303864386438313166626137313936663031343533323936386231223b733a33323a226364326435666632393666326331323339346235333535666463343931336538223b733a33323a223930393962336132616665306132306434336530373933346232303564626338223b733a33323a223130373736386135353735633735613734326230353131646632666663303865223b733a33323a226333653030646337656435363739386261366438313466386466376536616262223b733a33323a226137323564323065633435323132343765656434396439396230346261343963223b733a33323a223562663334313636376230613632393563336661336437636565376365303238223b733a33323a223763393833346161323538306535663233376133636264393839343930343764223b733a33323a226262663730356433383436303235306132643034346635383936313438373930223b733a33323a226438393336343664646363623132363164396235326264653863623431363464223b733a33323a226662623538616464333835616536356439303061313131386662306666353034223b733a33323a223463323233383966386539323565663062336561343437346532323563363265223b733a33323a223962613361366435626262616162643836303830396434386637306264626361223b733a33323a226637396234663332643462363465303261353232623162383137383763656436223b733a33323a223866636635653664626139633637666530373533306432653264613162313630223b733a33323a223337623633353032353162326339306663323461356139346163353839313432223b733a33323a223761393737323464653830326665303264646233366164306631363433303165223b733a33323a226362653631316132336130636635663935326462326435616365353239646164223b733a33323a226236343638303164656562376362303062343038313965623837663162303661223b733a33323a226638323637326562646131663533396332333262306666623733666334636431223b733a33323a223363616531653332383765363837306137316631613565383135323333363063223b733a33323a226531383239623533626163663166616234656239623765353264653462303334223b733a33323a223864666435653937666639373066376364613265303734623564613162633930223b733a33323a223738366330666632366338333562303666316137323963386635386562663735223b733a33323a226139363637646439303538333839353163636638616266323464313935316130223b733a33323a226334393964386563333464626162613561616564333538383662383832626166223b733a33323a226238653833616439643435333263616334636434666237623066356662306465223b733a33323a223135333335353231633761306465393738343233323166646335386664616561223b733a33323a223864353639393434373838623365353462636661623236623638363033666133223b733a33323a223961663933633664613763346566626133323663643563393137373062343864223b733a33323a223361653337636665383035373365323661653235393738363162643462343862223b733a33323a223435363866373732303934353232383730336432646131376464333764386266223b733a33323a226430616139353530613434653331613363333363656564663833343839633834223b733a33323a226538613762366365326662613261393032643334336162383961623132363261223b733a33323a226330306264376164383635613633393338653034313936383530656535613636223b733a33323a226562323762393033613839646166623263366138316238633963663865623963223b733a33323a226539613531313565353463643864376630313531656537646539363066313661223b733a33323a223765333332653962363630656432653565383330663961663135613530353363223b733a33323a223665356263626631376163656339356166343835613038396666316565316463223b733a33323a226231653034626335303236333936613733656166306230636435393137343735223b733a33323a223761353035303135356332646531613234633961306233643861333030393562223b733a33323a223238656664323136663031656265393164383231353932333935343436323333223b733a33323a223365383530306231353962613363313137323837623134623037623864346435223b733a33323a226237623931323936636639626234396465623131643766333866613861306437223b733a33323a223037643034356661633338396363366162393737636630306139326231376232223b733a33323a223366393031663465363038646236363632316462663239373964616538363964223b733a33323a223662636339343662663133333939336666386264633063316534373862313038223b733a33323a223863316335396633333231663661393930306332323131613064333735333739223b733a33323a223336353262633862313530333865633764646161636630396165303537383961223b733a33323a223631316634396630396363336562343332633737306135633436646362333835223b733a33323a223564326635316432306337383834386235306638333265353065653532313530223b733a33323a223864346630346532363239643436343464386437666131663136363166373438223b733a33323a223737383062393630306161396234616662656338643239363566303532643037223b733a33323a226166316138366236303636303062353863663732343164383765333230393938223b733a33323a223031323037343365393662383961623434393662363037323733393437646139223b733a33323a223830396235373162383663373730333861663233636237646332623566636465223b733a33323a226433613738623561383163373266656661646534636163376439623262323964223b733a33323a223237663165376464323866656538613036653331376231663961383762356163223b733a33323a226234643736303232326665346536303861353831333432646437623962386464223b733a33323a223761646135303134626166663234363764626262633965363833393939643061223b733a33323a223938363532643734353564316536633362623264313433363938383666373261223b733a33323a223965326136303434313037646564383439636439366233363639666235346436223b733a33323a223335313137656634336634306531336531333530613931356264386633383333223b733a33323a223765353431353831383335343339373336326264356466363237363464326333223b733a33323a223964313837373263656633323137353537343536396563663064616531656339223b733a33323a226466316637663061326466396131373930356638353766636365653439343430223b733a33323a223832376138356235343338613866653733633935326464636438613163653334223b733a33323a223037613761353335653361313037373933313839323337333163383063323534223b733a33323a223532303730656164393936313837376636303839626461366665623437623366223b733a33323a223533626338346139373837316332363337356466323734383334356132663337223b733a33323a223239323463303564356639376338316435363464623230383235626635613830223b733a33323a223734323839626536376335663138366331393734623937393631373666616430223b733a33323a223233633135306435306632373533623239356163383839323835666233646138223b733a33323a226365353338396238383939633432616630356632656138646163393462643864223b733a33323a223730373332353437623133656439663933633463363866313139316237393439223b733a33323a226162396435663364626135313964353964663964316639653739373839616665223b733a33323a223735396431313639353538343634663031303535636637643064626563383365223b733a33323a226338616635313532633531653133333932343132343964643034333436333638223b733a33323a223135646139343561376230613037643966623666383665363264386130633634223b733a33323a223430326261663962343435633266316161633433343630646463613665653666223b733a33323a226564303239623135623962383533656635396231343039333862656261326539223b733a33323a226337373135663037336664363861323236633532663131656134633864333963223b733a33323a226531616130343936613233396363393033363832336437313937343736313636223b733a33323a223065363739343835616664623130643333393564643734393262376235376537223b733a33323a226436663338363231616535306434323038623362316539626263346537383063223b733a33323a223739313962636137343138636363633230363239666663626635393530653933223b733a33323a226636613239343533313430643262393639663234316433343831373936306561223b733a33323a226365333362356239356633323831346335643335316233343037326566333031223b733a33323a223539306361356466383062383064646261333862383531666631383065666264223b733a33323a223561366664373261343935303837343336346230356137623938666236656365223b733a33323a226666656434313334633032663236396365613534376661353363313462366633223b733a33323a223461343330313236346631333935323137623336373039643437396461323862223b733a33323a223735613435353632313865353063306436666363353835323833383838353839223b733a33323a226534303333663335366332363362316236383162343639666263343636656566223b733a33323a223063653334366263646434383364393132343264363838393637373763626134223b733a33323a223933346364336331363330343938356534383665363939643466383639356332223b733a33323a226162386339643163653134316431393138393332306132643063306130366533223b733a33323a226236393233666630663735613365356538356136373963313335356363333736223b733a33323a223163623661303962616532643466356637633161663261636466306365616135223b733a33323a226566343632313965363332383061666566633561326339373836383638633632223b733a33323a223566356563323663326361356530333436386261333131643364343336653865223b733a33323a226133646135626131316266613633336235336138623032343637346565393262223b733a33323a226263356631386166336437643336383831636437313834613634626433613638223b733a33323a223165363764356532333762313836366537346266616466666663643131323438223b733a33323a223235353865363834336166613564373135613632366234356133333233356531223b733a33323a226264333438303866343131643033343934323830613565666331623963613337223b733a33323a223437626238343234613038326135663736666661316562316363333164336335223b733a33323a226532306337383234663664663161396237353739613635363736353835353438223b733a33323a223165333532313163373032353536613163366564623930623264623262333366223b733a33323a223566373535616565333533336262393330393939666165656666633734663030223b733a33323a223962383438396135623765316237663166353634353937353833656466343134223b733a33323a226631386366613531386231393066613337326431303339343539376530356365223b733a33323a223963643666643664323732613137326465633037376137386361363566373965223b733a33323a223038373064396234636333643062633235643636613834313136373465366531223b733a33323a226366393636633132323564366238653834383062633339353965326238333864223b733a33323a226539613237316465303036643934363532353935343239623531623633396431223b733a33323a226262626237306663323563316331646535653562623663613935373535616361223b733a33323a223934663037343636653961643563616166373666663866656263656132343764223b733a33323a223635323862313261333633303761373564646139643931326536333962323530223b733a33323a223764623064366463336536623733363833646566633661653633613032306366223b733a33323a223533306365656132303762633836373264646336623562666663383132303534223b733a33323a226261343361356139303461636462336436303664633434613766653337373834223b733a33323a226532343464313464336130393830643766353333373961653232383734653265223b733a33323a223536306136663237336362323165333161386534356531383530616331643231223b733a33323a226237363762666433343437623338633662643364633066666462346662393137223b733a33323a223862316331353037383139656433323433666430343833646634343130613232223b733a33323a223637653430396439336438333339373264613531623833626665333837356132223b733a33323a226466323833336263646331333463663531313730373235396264353936653536223b733a33323a223835333134313963653835306630346163363637613165376538666264376235223b733a33323a223034623832333330363931376262653837653234353531626330343130663238223b733a33323a223936646462386265633036386464633338343634373030363961663263336638223b733a33323a226136306533633665323035343563326235396163623562613238653435373964223b733a33323a223665343934346236663739373063663466323466643262343363376135646635223b733a33323a226338313662376632636564333961663662613364323037353031386338653638223b733a33323a226561353630623366393437653765383931636233363563666236643036636531223b733a33323a223938623466333135346131663731306639356230626433353230356439343265223b733a33323a226465363732303032383438633532396639656630376136383836353865326561223b733a33323a223164656462633061653566366533343632613232393538356331393864626634223b733a33323a223965653238396239393236666636313534393963643532376164303139313364223b733a33323a223637363636633834333865666631336236616432643034613930373561653938223b733a33323a226131356165313435643939353663376637353835666334316466383035316365223b733a33323a223430396335323564316335626565303933663064653137343831303539626566223b733a33323a226162363161643665383638393730356431393966363464666130666630633861223b733a33323a223065353365383730333461336331616561366334313439346531633835393339223b733a33323a223333666333386439366164613539316634633462306362623731363465616164223b733a33323a226366623139303665336532353735373437646434303836616133343439393366223b733a33323a226430616633646634386163386236616635643665393937303638323337393464223b733a33323a223130636165333132646665633966393636626239633566626338626566313130223b733a33323a223037346330643666346330383932643436636634393930626136333862353135223b733a33323a226530306132616162656339626261626233613361396466633761326339323261223b733a33323a223564366237633661373730316236643764663264363030356165656138623132223b733a33323a226637623764626238626339373935396230303835323565356333393732663438223b733a33323a223939366536663333643733393661383731623764383834353937323134643330223b733a33323a223462626336326434396464663638346365636262373936333632376264373231223b733a33323a223535623066663562623262636231373039666638373837616562653333303730223b733a33323a223437323034306266633961386663333336356364336463366634666265303933223b733a33323a223235396364353639636561373931646262373132396666623133313731313530223b733a33323a223936336433666238653763333562623133353939653439316565636630663531223b733a33323a226163383765646334316662663664313765626362386531623736353238353265223b733a33323a223236623262633038616539353035616665623064366330313134383761613835223b733a33323a226236336634393032666130663466633166333739303564363732356333636162223b7d733a343a2268617368223b733a36353a2262363366343930326661306634666331663337393035643637323563336361622d3236623262633038616539353035616665623064366330313134383761613835223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a363a7b733a33323a223965316438386338373265366637643031336332366163366534663438656233223b733a33323a223031623439643333313332383234303366383535383766653437623766636364223b733a33323a223436356663623565646238623236326461313630323935663766643465313738223b733a33323a223862656464653961663066663636393361386666326566363031373133666537223b733a33323a223334643930663464613933303430353465383539343066326338363639666237223b733a33323a226137633262313536363833613838653533646464313535323538343237613331223b733a33323a226330373336376534636434623664383138666666346435613761383430346132223b733a33323a226665316162333735343736633733363061636265333165343231396639353166223b733a33323a223733666539303931303935363530323363373366396437313136313338633036223b733a33323a226337396261363538313336366132396237383436616666666138383337393431223b733a33323a223464356635363832396263316337373033333961623837353938346133366261223b733a33323a223866306134623462653434393935653632363434666334373330343737303136223b7d733a343a2268617368223b733a36353a2238663061346234626534343939356536323634346663343733303437373031362d3464356635363832396263316337373033333961623837353938346133366261223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496d6167655365727665725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223736393135323935356435656335636436323165363234323063326161353231223b733a33323a223066346237336236396664623763306364303833393266336339653035613662223b7d733a343a2268617368223b733a36353a2230663462373362363966646237633063643038333932663363396530356136622d3736393135323935356435656335636436323165363234323063326161353231223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f496969665365727665725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226163636634346361656630303235363936383563303664396364636437633931223b733a33323a223261653539656133316431613935353431626466313831313963333463346565223b7d733a343a2268617368223b733a36353a2232616535396561333164316139353534316264663138313139633334633465652d6163636634346361656630303235363936383563303664396364636437633931223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4d697261646f725f636f6e6669677572655f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223864343931623865623236313432643333303233363731626165643239373365223b733a33323a226565353837623764373133636666336436396636313939623239333730633466223b7d733a343a2268617368223b733a36353a2265653538376237643731336366663364363966363139396232393337306334662d3864343931623865623236313432643333303233363731626165643239373365223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1713184459);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('79v4hv0efjb9m3mfkmd2ul8reh', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313730363039303235362e3039373339393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a2267646f376e37626b62373764696a6771703938366164686e3472223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730363039333739333b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313730363039333835363b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730363039333834393b7d7d72656469726563745f75726c7c733a33313a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f6d6f64756c65223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223032633231363431333335656634386666626562313137633761333266363038223b733a33323a226334346433393661373034363130303033613561356636636430393663316563223b7d733a343a2268617368223b733a36353a2263343464333936613730343631303030336135613566366364303936633165632d3032633231363431333335656634386666626562313137633761333266363038223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3139393a7b733a33323a223565313566613833656365386665386236303332343663373137613562323631223b733a33323a223933313234396130616333656164336264663663643961666336366165343131223b733a33323a223163653365323263623133316131306533663064646436663662336539316534223b733a33323a226533303732656430353531326566656439623961343539653361643938333534223b733a33323a223766626238633431373435363633333263386532343731343831353365373865223b733a33323a226133623531623833613232303739646332663730343732386465613833613461223b733a33323a223962343539653936373935343865383232336633393061343134333235663462223b733a33323a226365613639616133386338303264346666616139313630396365656335316335223b733a33323a226562323539353233373334363063646264633064623636323966393632346362223b733a33323a226362333036383261363633643639666331663337323166643433323964613864223b733a33323a223031613635623737663463316336626266303662333630313339326531363633223b733a33323a223865653835333466353035343734616536626431653838323662363062373832223b733a33323a223763393133383431323733633335613030346263633432333338383334643631223b733a33323a223939333762646236613032656266336434343138623235346163303664386635223b733a33323a223331343430653336616538623734386131633831663237376366383338666432223b733a33323a223339643466343839666262663939346565323263323433316165313530336161223b733a33323a223939343932393638393537393165663762633839353637663563623530373466223b733a33323a226362353366653936336162376139313536656466626235613461376362646233223b733a33323a226131343763656338363564623333313337623230303738643437353866383432223b733a33323a223863613730326466353633353332656366386461323831313864356264353264223b733a33323a223431386537343931646236326231373437636262656263323834613038633132223b733a33323a226535666330313964316161396365663436303065393538313939356534633733223b733a33323a223036643832616231313837316436326339653264393034326537663065356166223b733a33323a226262373833346530633333636233653066393735666135653338613837336130223b733a33323a223738373364396631633336363664633065613233326437663834656630303236223b733a33323a226439643432346231313165386161303261393239333537636237663036666532223b733a33323a223235393562626331373232326264626433353963363634306464343339353762223b733a33323a226433303638616439376264663165643338643961623564633966326634353165223b733a33323a226662326137626630386262653238353763383331313637313664663236316633223b733a33323a226637343039373232633036363033643639363364383232356263653361303037223b733a33323a223161303761346564333034313736363432303961616235353765363330313162223b733a33323a226438303165613537386438366164653766663062303366316363356661623537223b733a33323a226238313162386436343762663531313466363632313931343065383730636432223b733a33323a223463653861633339396539643532663963643164303961613032366130346330223b733a33323a226234376462326565376366323765383963386333643366343163633765373363223b733a33323a223239363232303463613163666238353561616466343663376464663061643134223b733a33323a226433633830626639306365356166623562386635373030373635636436393638223b733a33323a223332653337356361393231613763343331373537316530383363653838376134223b733a33323a223439343732623539643961303037623931623165323066666264393633323866223b733a33323a223738303563373566663263643537326232663733623962613464653761663565223b733a33323a226265313539373765383136386130663433626662383835616638643430626530223b733a33323a223364303031313639393761666632626231633766633939353732656362373466223b733a33323a226435626533666165323231613065376338336234376162613531393535326439223b733a33323a223563633232653737633133626438323764633536333661663933343837646434223b733a33323a223664393339623436353765626164356636383733306133643062663037333831223b733a33323a223761616339313363373335326465613362353764303836626237663763653766223b733a33323a226133663035303466353562613534663437323564333133643766373730656361223b733a33323a223665326533316334343561656131333730313731373661656562313763623565223b733a33323a223632636566303538353234663765326366373136343862636338323731636636223b733a33323a226633663335653639396631623633663561346336396536363239363637383337223b733a33323a226431626132643533643732623136613332386265386266373139646265373734223b733a33323a223930316337366165373939313163366665396236326536396435666131363431223b733a33323a226164636363623062353665356438323931613436386465616239313162363538223b733a33323a226231316536396262616437333266393965343133333335306538623335656539223b733a33323a226430623433393565393438323530656336356666396634643335663362336130223b733a33323a223730316434633838646663346239383739303865386333313261333638396666223b733a33323a223530323265643935623261313433366534636130366662633365383162316462223b733a33323a223861303639623161393135366531653061663031316439626239393635333634223b733a33323a223436636335323063313531356464356530383239316133396438373939353462223b733a33323a223734623631656464323030613035376563313463616133613062356261633531223b733a33323a226331626137363639363834313937626334383338626539333861386566383932223b733a33323a223363356538323564303639666438633932363064313630383833656532626466223b733a33323a223331323433303031353366323234333431333761663466633538613436633136223b733a33323a223632633635376131366138386533323032663437343234353039653231363365223b733a33323a226565613730643266386634393764646337343831656535313062356334636339223b733a33323a226534626436383939306530663030633132623630323438333537663261623731223b733a33323a223439313332343332313133316334383164396165333437376461333963626264223b733a33323a223133616330303537613263653365663638616666313533623763396139616335223b733a33323a223663633239323665323362316133643037336337313738356164353537323164223b733a33323a226537643335343166646364663633626237366663306561353662613535376137223b733a33323a223165386538653537613339336664613339356139626633636634373562373861223b733a33323a226231306632316137623832393365323535366634636132326130313735366666223b733a33323a223835303635343437323438366365336165313638303765336634373333383832223b733a33323a223038383238643839316638393762336266396230636138646632666430373430223b733a33323a223337396663313333396263613436386466346235326464623832336466303339223b733a33323a226431373938373435373330643561636137393962633832353639636463383538223b733a33323a223036346137626638313038366361633536366662323932336439666564366134223b733a33323a223831323264613665326363636130343535383736633737623432336662616538223b733a33323a223935386365353161353931613434373536663432333130386463313232623264223b733a33323a223735366533653861373437613364613131393333373036376238633439346339223b733a33323a226130363732336131656535626137313639623566316334613334663530383831223b733a33323a223534613835636433313065303237386565643331313965376465383836353230223b733a33323a226633363563383965626362356630356530393061663230333261646138343362223b733a33323a226332326339633066303138336561393161323838653631396366333134333261223b733a33323a226666326631656638326131653564663939353034383666373134393134303666223b733a33323a226263643238616235376330383936373234313933633266323064303237323264223b733a33323a223634383335313531653137333230613238646434633931653934626539376137223b733a33323a223436333865636534363237303031383161643537653337343738643233653839223b733a33323a223165343966306466353536623735646265626135316163356265313063653836223b733a33323a226233323064363361333162326235326464356262363535346138323736616265223b733a33323a223261616662306438363739353035643866643938623035623039653161336164223b733a33323a226635363065303066633762626637346530366337636639653834656137363331223b733a33323a226264376637363963316363646264326261663934316162393163386336346636223b733a33323a226462303761616665383032656161623466636133333861306631386665376139223b733a33323a226266363237346338323333353730313836373162333963353732633663323162223b733a33323a223837623761373532636533316362663132633964343963313032656334333130223b733a33323a226539323263306436393534663233313433363161643063396463343233333266223b733a33323a226135666635326664643661323162396334656634323461633933666239373664223b733a33323a226565643035383766383236336632393231356136646337383233376132326133223b733a33323a226265306432613439663634373033663063343063386664313933363265313433223b733a33323a223566356230363862663236316666333662643962353265363661613034656638223b733a33323a226466623537613661373764346237346534376361313335663439366163353062223b733a33323a223863663132316434623563353934336532636366663932333632356165623534223b733a33323a223435343239383762386266343332376436663930363966616663393032646534223b733a33323a226537323333616234393132376263613562363564616130336436363163356639223b733a33323a223564346137346363623063656137333138383235343366643730666337393461223b733a33323a223438653439663965653136383966316264396533653465633339363662343665223b733a33323a223233626538346433383934363065336463386666653633353266363931623733223b733a33323a223430316365333538323966613433323461343231613261653034323938623865223b733a33323a226230333337373937636361356465396431373334333663343333373063643836223b733a33323a226464383639626439326431306662643762373335336434656232306463653833223b733a33323a223639616336636335363631646438633364396532626564393732383839353266223b733a33323a226137393431366365633033656138653833336465316665323563323336623766223b733a33323a226438643439356531663436393736383263663835643533326530383636306539223b733a33323a223863373730353037623563366339373662663831626466383364353135306535223b733a33323a223037393566383633613630666563333632363231663233363030333538396138223b733a33323a223363376139386438626136643962626362636333326564613234383238386161223b733a33323a223661616338313330303163343338383531613138626333323862323063623265223b733a33323a223762343263333865623439633731636134316466313430643433323333646136223b733a33323a223562333534363936383430373732656663663165383761333834653535353561223b733a33323a223434303730643231303733336364363730346536336130623736306264666564223b733a33323a223464363533623935336561633932613430306532336331636431356364353766223b733a33323a226333333330636134663336653864383535626234333865646261656334393235223b733a33323a223038643863333865333930613532636338396439623161313939356362333164223b733a33323a223265333039396662393337616431656234663962386561313962353761303737223b733a33323a223131393931376562393232366334373538623966623338646165313938393261223b733a33323a226337356133666138303364343964363138326166613066643064333633633163223b733a33323a226663626464636239643566333266353338616638383733663639316237336632223b733a33323a223763376365643832326262376362623936303861346161333936393033346434223b733a33323a223738633561653235363262393238386634366539383533376163343236383139223b733a33323a226465613038353333303839643332383732343038613335383230383164383334223b733a33323a223338383565396661646234653531636463383630396331656139656134336637223b733a33323a223639326533386233366535393532353330336561663532336530336130653434223b733a33323a226166616264343738646134613132613239386635626161316337613339323664223b733a33323a226539373266333632303634343335646337346664386362306161343566633136223b733a33323a223465643033323638643237386134663338316666663435363537623239633933223b733a33323a223361656461356539626164653637323663303338313034386632353535323663223b733a33323a223965396463613330383531346633363633333165306530336233616231323136223b733a33323a226464656432646531386365313561653536633633333636313531363965393730223b733a33323a223532663965633734623936343162626461306262303239633161303061373561223b733a33323a226362343433343935653965633139303531656637396166333263373962306266223b733a33323a226233316139636339343962303230613133653863366139646532396631336636223b733a33323a223337333033306232323435623365376335376462383934366531336633373034223b733a33323a226362353837333830623863643163356330396235616335613631616661306632223b733a33323a223237333331376139643338626436656366636263633463323862366233326264223b733a33323a223563333538386164346365333563333638353937333065383330666333303763223b733a33323a223330343834323961313661303935663563636337666436366166646565373232223b733a33323a223531636133353965636532666535366131613835363538316164303535323762223b733a33323a226632316238666161393636386131613133353839616438363962633362623565223b733a33323a223339663464653138633461636462376330333936373132343930623866343863223b733a33323a226163616161363432306437343765346331373038646363306435653666636134223b733a33323a223831643564393830303731363534356334623939336237643339313736313138223b733a33323a223166356531643865313130356466656337626366326637363338353336373766223b733a33323a226438633965393064396631613939373536303430393838333335646634323632223b733a33323a223331303361636638616631343562383932666239636639383964373635363234223b733a33323a223765653234333833623366626333306463373162363462666364636331323263223b733a33323a223135383533623466343830636232643539646337643739306131313836613734223b733a33323a223333303132356135346266663337346534653135646235323539383263373835223b733a33323a226634343935666564353132633030616334656533626435333964323935396133223b733a33323a223037343136386564303533653832623262653663386361633433383531376266223b733a33323a223562366135366139393962303665653663376332633731626362373933663035223b733a33323a223963316465363665386462383435363538393330323164633634396539323331223b733a33323a223761376464666439396166653633656464303338363562373362386435623033223b733a33323a223661326663363834393034353530346239323161613261303731623739386335223b733a33323a223834633264356464336333623338343137363662626263613035366533333633223b733a33323a223463336536663338663136363636376264333033633364663966656531313138223b733a33323a226565373461663630336264356530343233343964633338326164313633653836223b733a33323a226364396539373866663639303335376431356539643030376466366563663530223b733a33323a226364306465396239626234346236373466646433393261303535666561656564223b733a33323a226561663566643438626337646131623461663137663036353134353630343561223b733a33323a223533353131376561353935323365616362393231366666386664356530366631223b733a33323a223433363761353936356337383262623036343035346237303432316138333938223b733a33323a226234383730343765663839383165616638383339653830613838666330373466223b733a33323a223239333837353864303437626562633064653839623262333931636639383165223b733a33323a226162306462306365343463663536616534626633626561323033363835326436223b733a33323a226239633139363966333037343032313432653135303338373461613536636633223b733a33323a226333663537656332373864386263633631666539346236396266376663373930223b733a33323a223637386262363664316631303238303533613561656166313034626238663237223b733a33323a223133646566653637663934333262343336376538666266323530613364363033223b733a33323a223763646265323863303333383838333963343664363061386463353739653763223b733a33323a223032313332343039666261616435386433646539356662626435633739663962223b733a33323a223230303930363035666430623237353437623533626433356336393163356136223b733a33323a223533613331373263366363336466623531386231326463346261663139363531223b733a33323a226364303061333338306464313766623961386234336638323637326465313733223b733a33323a226137346137616633303635363733313333356464366137396132646661663930223b733a33323a223335373962386235666163303534363163633631616235343130623063376232223b733a33323a223765303832656333353766303061353237376136343361376262366266323332223b733a33323a223735366562656330313665393364326634336631633764373565656237666334223b733a33323a223062363031363334336634383133316232623738386137633930653363383036223b733a33323a223231373366326238306137653366643861393463383262373735393336386532223b733a33323a223834313538346266313461643861613037376433386630643636306635623464223b733a33323a223038353166666134356365643065316533386531613039633264623932333964223b733a33323a223137663130343631383536333239313761316666366339613132333165633536223b733a33323a223834626439386130306439346565656264313633313832353434646232333839223b733a33323a223633313038303963366230393466383931663833383033323161306362333637223b733a33323a226636306263613537386535646365333136396337663566313532303030323464223b733a33323a223035643333396338636539623832616536613531666466626263313831363539223b733a33323a226539646335336437646262633563306632613137363238653863373731373834223b733a33323a223966326339333039626233626666396566336138336637663139323939353963223b733a33323a223433653761323764326136396466373961363337656335666339366362666333223b733a33323a223065633461663538326163613330343931393939373339363330653131343238223b733a33323a223466336530643662363833303933303034316338376461353132386534653635223b733a33323a223931333065613238376430633639633735663064316662303537363339636539223b733a33323a223865326232383866353163303166343437333232383733386431303632636430223b733a33323a223862383366373336353166333061386239366635393035653034303738613036223b733a33323a223165383361373838626462326235393037616661623633623133396634366462223b733a33323a226339343966666130646634323833643231646235663334383534346662616561223b733a33323a226563343437316134353734303430393734333138303333653062653766343137223b733a33323a223537613831353930633961343337626465373061353734386666356364633564223b733a33323a223238396463613966613230623738373337643731663532643739353135363337223b733a33323a226232646666343334656432316338626261306534633363623239356264393065223b733a33323a223835373330383737343036653635663365366464333231666138633061386262223b733a33323a226232386434633135363031346162613038383063656634633733396136636163223b733a33323a226165383535623633366363313332343031323466346537333864303266353664223b733a33323a226433343666366631636335343234376431343334613864333736666530653536223b733a33323a223831323163646362373539363935633633396163613239383763366534623537223b733a33323a226139653837616463346431386561613566386263393437643334623161366139223b733a33323a223631613562653439643961376561626565366133643730616266633639613263223b733a33323a223434336132323430386638333665333430383463666634393861643539396161223b733a33323a223435363534363561373537623435363537623636356130623339656366643566223b733a33323a223864373936303830333231306431633938323838353863353333306230363461223b733a33323a223762346663316565353539663165653765633162656663626337643536373062223b733a33323a223161393263633166386132643632333430393163386132303235336464393339223b733a33323a226266626436353037373039336162323239346131386638653164616333333335223b733a33323a226165613762386137396363613433313066643665633761326539653361393839223b733a33323a223837613466646633663436393731316463386365376265343830653166333663223b733a33323a223435313837393964306530373333383165343366663632326231373163343862223b733a33323a223835393837336435336631323363646334646433643661636438663063323831223b733a33323a226562646166383165656234393839663731663439393865313035656564613735223b733a33323a223061323362323864343763623466636435643036323262396630346432663837223b733a33323a226264666165353638633937393230396235666231306637343536353262333230223b733a33323a223963353065613638663831616561366162386431396663643863663363373265223b733a33323a223133633032353761323331656537306330313537393562346131333933396336223b733a33323a223134303336353861316661666261316238666538393135623739633162663737223b733a33323a223465666131643237336232653564613131636238303535353131323139313635223b733a33323a226533646337383636353962353433643764363332333630313135333463623936223b733a33323a226636386539303632643966336137353965353965656437343034633136323031223b733a33323a226138343531333738323032346262346166376564356434626133386236343638223b733a33323a223035363465363564376435366431316266323465306366643736363534346436223b733a33323a223233633762626531613265303230663638623532646434663838666430383931223b733a33323a226439333662653437623765323266386239633334323838326363613435666465223b733a33323a223439666336386437383665623266333433306435333335353464363637333932223b733a33323a223166383431653465396138386533393265393931366665383765386231633130223b733a33323a226433393866666564353832626466303932383163666363306230396638383533223b733a33323a223762643930313535626564666666646437356665366434303965393339653335223b733a33323a223335636264656431343233613062363763343633633462373366646138333032223b733a33323a223463633435643237663635616331646234316436303531623565346265643565223b733a33323a223337626566396438663164613437663139633664636338666539636462666437223b733a33323a226362356235393932323637616632323335333164353363393165336338386262223b733a33323a223231613335333664623062663535383063363365356465393830636239363762223b733a33323a223166343636373134353563356231383233616131383663396463393731366363223b733a33323a223233613366366132376162613732663863643465383038333038303165613236223b733a33323a223635386233636465616334313764306534663037373235363165383863343866223b733a33323a223639613664393831323363316632656163626130313836353537616663613437223b733a33323a223339643032393661663464366639636563363237626365363433626265656531223b733a33323a223566323737303238636462626338646337396462313935626665383337376536223b733a33323a223866343439303362656562353962623034343062646534663366356361353063223b733a33323a226161626262646533346232313763393837306237393935396533333262313133223b733a33323a223163396363316334616238343431613566363062653935343663616638303361223b733a33323a226633393162373934613361373337346137393236613732313761343665356533223b733a33323a223038396531646464346165373836336432613339396437373539303936333438223b733a33323a223235336633663763383233663237386664323631386233633538396139333432223b733a33323a223133346238353664613639363538393931633063316538646438643730623331223b733a33323a223433313261323866386339663663396435303762643934306334313136393437223b733a33323a226333663337333832643866383233336138396434343461373331363039313165223b733a33323a226339613061323532313639336338623339616264633034383361633636313466223b733a33323a226431343733306633306531653936386265336133353535633263313737333466223b733a33323a223934653565383066393437333839366632393332616537383164393536356463223b733a33323a223634383238623039373537616466353837333033306566336535633231323866223b733a33323a226563393033376339653232653437386261333737656437356263396437653436223b733a33323a223533306665623039383734613662343961633738323939366330313034376234223b733a33323a226566653834376531346636346133316335623064656633363762613933333333223b733a33323a223733646334663934386263626465373534646634383632373664333834316431223b733a33323a226261363565393339636664363165363331656137323936656162633332373738223b733a33323a226430656136323263663166383661623435393565353139613537666131363230223b733a33323a226536613266386530376562356138666662643336333261313563623534363636223b733a33323a223634366136346633623438373431313530326162353961313962376437626435223b733a33323a223564356635376139636163623933653130323234633165363838333161636633223b733a33323a226362326334613836656435333339346231303031316339316538663236313162223b733a33323a223966313162303338306632346138306631393165303139643837323635623738223b733a33323a223263633334363537373935366235356366386166316535343231396438623964223b733a33323a223233613665383662316536653231373434363530623566623664393338393836223b733a33323a223733373862333534616232646333616635303939646566656165636131336564223b733a33323a226430623938323961303630376333396463643064373634333937343135383964223b733a33323a223637396533643637623639653635346665643463343864356364346539666132223b733a33323a223062313431623834333263653935643039326265326333346361333939363233223b733a33323a223533326665313961313139323432383731313461343338373233333239393262223b733a33323a223033333037336265663935363431333361653236336232663066623430326362223b733a33323a226130373763623061633561363361383431363738333163303033306632643831223b733a33323a223535373130346664313566633630306665643165633865306362383064306237223b733a33323a223538643939636361643339393537373339666239666365626465663031323464223b733a33323a223232396466633664643365626664336465633537363933336636346664333964223b733a33323a226265303861333265313965343765613531666662653337333435646433636465223b733a33323a223661343330643730383738393066333731366330663666653265643839373962223b733a33323a223463376561663030323761343631306531633837333232653239656661383534223b733a33323a223464383764353539613736313130373262613863366533326530383233343362223b733a33323a223934333162633263356561363565653666666130663036316135383531643939223b733a33323a226162636634353263613563633763396630366133663761383963303438656364223b733a33323a223639326330333432663831616336346534613930353164653931336563653163223b733a33323a223336643831396664653237663832663531376538373663333435393934373032223b733a33323a226266396664346137663266303831323337363533306132393232636362613131223b733a33323a223231376238383630306666343730666434643566316162646533366361323664223b733a33323a226264633333613363373163306431626437316164306266326238373735666531223b733a33323a226234313630643163613064306239623765653035383261353936336433303634223b733a33323a226561383435303437386639396264373333313736633666653762353364653662223b733a33323a226461336534363539643234656431306233373161636634396462363836376161223b733a33323a226263343764393565383439653565383863633566343861386361616538306166223b733a33323a223361366432633437636131623437623365646130333734366436303534376463223b733a33323a226162323138323164393638336139306661346463633365303137656432343363223b733a33323a226230353665363964393866323366376265353534396431656535626466346465223b733a33323a223230333435353039333636376665313663363561386463663134643066656664223b733a33323a223932316264343834346433303065653035313963613665623435363363386465223b733a33323a223831663137663065643237626535323436323464643339326637643838353539223b733a33323a223964393834626436343862313232616266303063666335636462393063613131223b733a33323a226264366234353163383465376637613661373938393362633264393833376531223b733a33323a226533396438326564666439303437613030373237666435646531303837373061223b733a33323a226461633833313430633061303237353133643730343531363962333962656237223b733a33323a226133313735343265343261653637393866623038346263336464383934656233223b733a33323a226437626431386466336138356166343435396466313261303034623038333236223b733a33323a223039393337393639393939663436326633313232343239623861343232343936223b733a33323a226266646139383966386364353431386465663938336235663335313837366566223b733a33323a226265313961346338633832646161343563303634353632326330663665646266223b733a33323a226565316262326631646534656565663736386233306563323332313562353933223b733a33323a226661303535396433663164643838613038623966303731643637333339333636223b733a33323a223739356533336139646330376233373639383139343131633835653035323734223b733a33323a223537316638616135623762393236333461383465643766353833616166613435223b733a33323a226430356363363036653337326531613263323466376632393865363931393265223b733a33323a226631663731303665633264393834356535383566336436396261623762653964223b733a33323a223931373561613630616161333337663365613033346665633936663330626366223b733a33323a223333353439303635623863343538366364383265386361646666633164353230223b733a33323a223661353863343035353231626239303738343965313831656135386265646339223b733a33323a226333396361636164333134643034633261336231666461663463353530313639223b733a33323a223864613930643839356232373335333439366164626666666564376431346663223b733a33323a223666663731653764616133646665363635343439633031306534663265633933223b733a33323a223438396335616233343036333030346163643437373266616433666663366230223b733a33323a223332626336613032613537396562396537633661656364366231326562363531223b733a33323a223165633039373231316635313066306133353639653866663036663038666439223b733a33323a223362306264306366333166303964623034316133393064623461376636383934223b733a33323a226662616534376664366332666131323634633162326639376138326638626638223b733a33323a223262303434333965366363383530366362356630393339386530386539623936223b733a33323a223037633232396634636233643435666361343037333434623235623337363136223b733a33323a226165326238323432306434666636326535313537666336666231383137636631223b733a33323a223863653032316261353233366638386264306165656637383932636632373865223b733a33323a223138363964663465386132656436633162653433666464656633383564363164223b733a33323a223737323433346639326464383932653436316339653634623435353136356439223b733a33323a223834343539616462326235393136666663646534333530366165623738383862223b733a33323a223963363939306663343339313330306335316432333633653662613330383362223b733a33323a223036303732636434633766633564303263313436303232633232663131666662223b733a33323a223737656565323363633565653430323166656438663935306638323730623232223b733a33323a226661386631306130613765383665646136353536363237333532626466623061223b733a33323a226166306231333363306431303236616539343733363538393464643563613931223b733a33323a226337653332373763646364643338633538663638363530313261303837363765223b733a33323a226335613863643838333162653134333134663534336630346235313632313861223b733a33323a223530356663363765393438653364666634663635613861376336396530383865223b733a33323a223732656665643236343539643235386462626135316433633932363164363536223b733a33323a226638663261343635633565653063333731353936633339653036643761316134223b733a33323a226437656539366437376439326639373738333236343733363635386638353832223b733a33323a226662353730316332643832306138623130373731643433356338346232313536223b733a33323a226336353339393037333330663932396331653533616439633538333963633261223b733a33323a226463373133363535646231386531643638636138363238663339626533633434223b733a33323a223733396261636439373030303864353562313437646238623830316230326461223b733a33323a223334373565326435343038653239386330373565636337636334393436356637223b733a33323a223261373966643461616237623863363535393138353430393032363266396464223b733a33323a226534663965356134343533313533306534666339396238306162373932643238223b733a33323a223465646537353236373761623064326161626334373733343830353364643131223b733a33323a223562653066616236323737306434653237646339653137623436316331616437223b733a33323a223438373437623066333238383162616134313761383034636562663633373765223b733a33323a223539393835383034306131666631316161336363613433363161306639653466223b733a33323a223638366563346539336166336532383431323537633333646331343238613266223b733a33323a223639613465366232333865326430353461376233663331396530333165323765223b733a33323a223363383236383936616663343064646237323339656434383333363136316366223b733a33323a226462646230643630616432366435323831666563333632386236363661363734223b733a33323a223936373432346162316464663062393638356232316337663464363830373330223b733a33323a226564306264343738356639313436623531323562623462313731323337376332223b733a33323a223536323938303131626664333664343138643033303735636239373562373734223b733a33323a226632336662396462306438316635643439613439353030313039666636346133223b733a33323a223765316534343339666465383765396534356262313165356431656539373939223b733a33323a223232306332656234643835383734613436643230336332643165396131373731223b733a33323a223932613165323138333533616661663066383433313139623833633537353462223b733a33323a226233363666656462613064646562653637373539353730336362313063616434223b733a33323a226136366339336233636562333439616437343362646234393936623835663334223b733a33323a223630393463616565616533636235393338643438306338653437656331663431223b733a33323a226264626130636162646134626166666263343166653737343635386265356462223b733a33323a223061303561343739616430396264653639626238383164616663313765653434223b733a33323a226665616261313035343432323063303661633734383662396436636437393132223b733a33323a226363343133623464306632366261633933346438313338613237333033613532223b733a33323a226261666234626263373966613662353566653762663135396236626130663139223b733a33323a226138313864356634353831326563336665363135393732333161663235386533223b733a33323a226134313164353834363161303339646136653232353534323731363163386261223b733a33323a223964656635353063396239666332343936373733346561393462343034326261223b733a33323a223261653433396361323739303730396338353365653938623764396266393132223b733a33323a226439363839653361323334313663386234633962363735643134353739376132223b733a33323a223364333632336164323065393635306438613430323731623266616261353231223b733a33323a223732636532353730383837616464333431616637643066393765316161366333223b733a33323a223430383062393162396361636432643962643936393764383730653530666338223b733a33323a226164653130316438643437396336356336316537613134333231633036626433223b733a33323a223331636439633964633634623635323032363031316532373663323135333064223b733a33323a226536326139396465333562393236343732653962623662663561393266383364223b7d733a343a2268617368223b733a36353a2265363261393964653335623932363437326539626236626635613932663833642d3331636439633964633634623635323032363031316532373663323135333064223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a223534323431363731333561356162356338346666653161303863343766613831223b733a33323a223761643334363265626334393933323561663235323635666338643262363062223b733a33323a223264663461666362656462323861313637346264633330373936303061653330223b733a33323a226432613862313538373066396535343533336466643838356536613633386131223b7d733a343a2268617368223b733a36353a2264326138623135383730663965353435333364666438383565366136333861312d3264663461666362656462323861313637346264633330373936303061653330223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1706090256),
('8jno8l1bgbiue9nevspu252gg0', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313730363130393333322e39343437363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a32363a22736870696a6b75356771756c6f6e3665637067326b746e6b6c6d223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313730363131323932363b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313730363131323933333b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226666376236623833323939306638333062303630616138353361373332623131223b733a33323a223566343930323661653861383565326333316430393361373035313630376431223b7d733a343a2268617368223b733a36353a2235663439303236616538613835653263333164303933613730353136303764312d6666376236623833323939306638333062303630616138353361373332623131223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a34343a7b733a33323a226563616136643138343932616331653965646437663263323034373162323632223b733a33323a226337613163306534336132646639363239363462336234303266393162383863223b733a33323a226566363162343564663132346331363034656136333738313230656437336535223b733a33323a226130336365646136356136323761393136313536663561633831393336623533223b733a33323a226637363939653462623739633533663861613232656134313862653631633738223b733a33323a223535386238346530653832356263386232373764656132373966343762363732223b733a33323a223066336334396334303133626639393337313865636464383161636334333134223b733a33323a223362656566353861646235373635306136643165383366636632356362653537223b733a33323a223861323530323865653437656336343863353563383064633836666633323161223b733a33323a226636363034613463616236353734366535323762393864623264356431653362223b733a33323a223935366637353534393863663835623639663036333231306462396532343833223b733a33323a223538336139353536356163316463393635306533336466353861636565386262223b733a33323a223831333638373065306636306138393235376231323866363264376239623538223b733a33323a223466363335303736306366656539626138383335623062323734316132653861223b733a33323a226666313861633837353139336430616533386433313437646537643034303964223b733a33323a223733643163333234653634633534323863303231316461306564616263656632223b733a33323a226337623466633233373563366539616563383035666437306364336166396465223b733a33323a223431646432383961663035663736656266646532643463613130633135386133223b733a33323a223564363734343532613862633839393532616465343130613436633432363630223b733a33323a223938363665386164646365333132353764363766613065346364306433346536223b733a33323a223263333831346264346630366662383565663264383930326330386238643161223b733a33323a223836613039663266393162313939326533353439376565306339336638623864223b733a33323a226637653766303336343433653136393432626432393432663335616630356436223b733a33323a226265386136323737366533383161663736303363323461383537323233643763223b733a33323a223063323865633133633130393632383332303138333864346330623062383733223b733a33323a223362313335343861346634643230333162616366323464303232626437323266223b733a33323a223238616462613035366565343564393938666663643739363039326530636363223b733a33323a223765303634646661623139656331653564663662663635306436393534633965223b733a33323a223233653037636461356335633131353866313962323863646666323165636439223b733a33323a223936393539643261636637636139653132366139663739633935363431643130223b733a33323a223837306465613939623136353164393163353165333531303432303033653265223b733a33323a223963653439353334626666393738646435626634343361623933356664363634223b733a33323a226165636538633365616330616131633830633339373861323431396364393234223b733a33323a223961636331643332333864633932383335346262316361623637316161356265223b733a33323a223837373637633632333062373435343731356330313766316161663437643738223b733a33323a223437623536343063323263656334366562353633366337363238303730323130223b733a33323a226361336636303165636634646466386666623636613566373265353138396263223b733a33323a223637303738633539353136666632393736343962323839633662303364346231223b733a33323a223931646436323061386265653865333034353733346238343462646333363235223b733a33323a223637343732303932373231363634366238363836666639356239653862333461223b733a33323a223566663835613438366334626563616363333338646431646266336433616239223b733a33323a226631396134376638646335313232363330363864663762356638303638623465223b733a33323a223563376538653434333865373161643664663239653037666566373339653632223b733a33323a223530623835373432613764363565616434626436633663393838646461393364223b733a33323a223633376632303937303934393933326337363139333137666235376134363363223b733a33323a223463623561643533613531313464663464343663363361623237363334323265223b733a33323a226333323938346365656239663537303630623863646563316363616434393835223b733a33323a223565363561316630616631346134646466323262313237363037353335383262223b733a33323a223533636661373632303032386664613937633930663033343161663238346263223b733a33323a223431393735653062373161313234616331333832623034353866363939643261223b733a33323a226132323730643861376634663964613564323765333339376230636264666161223b733a33323a226131613237396365333235396165343565326533613266626361303039386166223b733a33323a226261313633653933643235353566333133653934366362363238336636383132223b733a33323a226435356561656330653035396539376137383432333062633337366234303236223b733a33323a223762613263336135666436643166643035306562623061353032343432396130223b733a33323a223635666437626539326135623436623134303634663233613036323937343162223b733a33323a223463653465353038303665336161663232303136373863653865623338393462223b733a33323a226166616466343866343632626439633938636636313065613934616235386237223b733a33323a223162396633386264313839373766666531343563326637613665363034376163223b733a33323a223365373164373463633362383432336631353962323163343535393134383663223b733a33323a226136343635393333383930626232303461613834336633323465616261326535223b733a33323a226265626336633136386634653263393637333539626235393932376230326530223b733a33323a223563626430646331363533383266383338306136396363373939303230663463223b733a33323a223537623861303465323638613634326337653234343164626437333735663662223b733a33323a223137356439633766356534363166363736643266623264376362376661646532223b733a33323a223134623165326231343164343938626239326537663732356166383761366333223b733a33323a226566373466366430313239633531356533353662343461656166393236393334223b733a33323a226665383032663034383664393863313730626135616338396365323030323263223b733a33323a223633383062343766373532343637633332643062653637393962613266313130223b733a33323a223462626635393632636335346330613532326430626331346439336338313733223b733a33323a223837306264623337323839333338383032303830393161626661383661346232223b733a33323a223132653535353064363035656636356165383034393464363333313163613761223b733a33323a223864326661623133316437616261336161323236633636326665636636336661223b733a33323a226531656263373163326336653462613938613539633333393563666335306639223b733a33323a223232636232613334376463343065306536363738653135663938356232643135223b733a33323a226136633838646366613364633038353065613332303735663637653066613564223b733a33323a223763363734386330653766643930346634373434313564376363636234386538223b733a33323a223936386566636239616633343237393232616434353231363638646265356336223b733a33323a223230343461353539333066333461316534373363616561363136303866333436223b733a33323a223732346364363163343362633862643662396563323234316531663138666139223b733a33323a223038393365366365626438636564636664323530313865623135636464323437223b733a33323a226435373236633565306534646137333164613636316130323865356431393566223b733a33323a223832623035363562656334633836396265373236633763373237613337323565223b733a33323a223535663133633138323339613437646130623566636637373937393265636438223b733a33323a223063363136663961393063376635643139653736323833663666626465313230223b733a33323a223263313039393162386331316437653135616530396564613465626334396138223b733a33323a223466643933633936353030343038313066353037303862623862336335333531223b733a33323a226664393838626532646263343939383266363030653662393264663032396363223b7d733a343a2268617368223b733a36353a2266643938386265326462633439393832663630306536623932646630323963632d3466643933633936353030343038313066353037303862623862336335333531223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1706109333),
('96f09c7b6f296183150f05264ea207fc', 0x5f5f4c616d696e61737c613a323a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731333138343332312e3330303831373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223936663039633762366632393631383331353066303532363465613230376663223b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b, 1713184321);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('b98c6be8676e6c50510e1fb88894cb40', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731333138383135352e3132333635333b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223762383635303135613835396363623466396330326234363535343865363634223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333139313734333b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313731333139313735353b7d7d72656469726563745f75726c7c733a33313a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f6d6f64756c65223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223163336134353236623365636665626261633233616135383336666237613839223b733a33323a226464326163363161626236323137353732623334666465313031613362646264223b7d733a343a2268617368223b733a36353a2264643261633631616262363231373537326233346664653130316133626462642d3163336134353236623365636665626261633233616135383336666237613839223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a35363a7b733a33323a226165363233633238386531633838393662623739636139636636636233346335223b733a33323a226636633431613432653261623261313931666436663333336662633231643032223b733a33323a223830616235613233363138633132363531653435613664623766313465303638223b733a33323a223339336131383539346230643031333464643931656338393838396638653664223b733a33323a226636623966343063343530636539623561376431616639386135396365643739223b733a33323a223339346637333532346662626338343366346135303662613236363364356335223b733a33323a223738306164323263646236333338306633386564316434633266346530393264223b733a33323a226635336136336334666433363366353566333664613131303963333434383736223b733a33323a226139633165663632626134643636663966333862376266303038646364323135223b733a33323a223562333537383066646364323430303763326264353065626164333430346561223b733a33323a223662383337656263303131643766333461333063646638633263646437313439223b733a33323a226131303735313934336561373635626437373364626536653631396637376464223b733a33323a223066343762306333353334646266326666316432383536353231663766663366223b733a33323a223861303632336561616463303036373363646235623666323637313330383835223b733a33323a223430363032633632633661623434316462636433646437623861346234396266223b733a33323a226562313032666431613666653634376434656666346431633331383435393637223b733a33323a223862303736353231616131346166376462633539613961663763343834346161223b733a33323a223761613437643566646634396232333637343065616433396636373562396438223b733a33323a226339303664633861656538316562613864343262303030353662643534346362223b733a33323a226231383233366636393736303833616531643830626634376461353739653231223b733a33323a223739336462363935303663666332363938653533663637333432633364363062223b733a33323a223139623037646239353961373435363334663931623030346561626636386363223b733a33323a223463626231646333623935643430626338663830666430336266373961633666223b733a33323a223436373136336232653362646361633261303138623966366666643830356234223b733a33323a223466393962363133376130653839333932336363663461303736356334663365223b733a33323a223964663565626261363863303038316437666266356239653931343036376165223b733a33323a223634326461303064313236343931393066353265393463316165636137646338223b733a33323a223339346132386334363765613831646164643839666334303230316435613164223b733a33323a223066353565636365326364366466613039656436646466336264316562626435223b733a33323a226262633865613239343862366438613437643434353064346638643139636264223b733a33323a223363343536636536346563633564633564363430336430636633363334393235223b733a33323a226438613965643965393261333231323465383330643362653465636134313031223b733a33323a223434376531383465386463323634366632303733623361326365646434623563223b733a33323a226134663736383161313338376636343164643737626562613362613432333432223b733a33323a223136333966356666366265363161663431396232323536363035303532636664223b733a33323a226337616564626664643937633562613331326564363034616266633565643837223b733a33323a223936613233383232623566383566623534326138666134653066383739336536223b733a33323a223135303138393261613364356466373239366434373133616234356564633662223b733a33323a226538633834366535623536666539343035376461333864313062616465343236223b733a33323a223966396433616236323864656466303634333037336231616364396339663536223b733a33323a226639306630326561636466663737373736613935346234356633643863383631223b733a33323a226631633963326661333731653531666633316130366633346135373935323835223b733a33323a223065343864373066303665306337343062663466326634663961303764623464223b733a33323a226636306230353634633232663436343266336234653566306634323834626564223b733a33323a223535633633333437613234333638333264356134616437386135303733633135223b733a33323a226530346666343165373364303035616264323736313132383137666166306436223b733a33323a223838323232373937656633353138666565623661323764616630656462656237223b733a33323a226135653333613730626638383130303735643936613263663266383135373732223b733a33323a223837633630326438333035346435313062363666663635653864306366346432223b733a33323a226666333035343463633064656432643866653930616630613234613630633166223b733a33323a223431303633323161656136623462303765616562646663613165363039353733223b733a33323a223537353564653934623064613332613635343930376161636664656430363533223b733a33323a226232616436666431663033306564623637363131356132393237353565646636223b733a33323a226266343033616433636138356430633837396261303234636238323635343463223b733a33323a226162653634353731633562383138303363306533336234346361643139366239223b733a33323a223435633866303462613834643133386135303230343138386439656363386238223b733a33323a223534346663653030323830666331303534303430343962313461326465626139223b733a33323a223332316631616131633034636264303537343630623363623737643330656566223b733a33323a226432396165346337613231663137356535643337326237313732356539623264223b733a33323a223838363736663232633561373231373761383837373439343032353437356366223b733a33323a226364383032636630373731623463666136623863303265363065653266356235223b733a33323a226334383333336364643562633830613036353864366637656266393339343834223b733a33323a223233363361323564343366643664313461326236396132323062393238313934223b733a33323a223666373837306262393766326338366531343761646363303438303130376137223b733a33323a223866386164316630306638323434393439303030356234643833313431306561223b733a33323a223730386435323165363063303534633864373335656564653066613064316632223b733a33323a226630363333653238313338613635306138343233343665623464656533383636223b733a33323a226565383231303865346465373534623531613263356562353436393235383263223b733a33323a223038306636303663306361306636396262663835313033306666616235326461223b733a33323a223262643533383263363836666430353365333130353730626435663830323733223b733a33323a226631373562386661393333333165653535316462303837383632666639326338223b733a33323a223134653530316438333539373365656261633331626363326461623662656638223b733a33323a226362343233323932353331626263636437336631633761336137333330636633223b733a33323a226436346365383733343531656331656638313333343461376661313765393538223b733a33323a226462653631313164336639316138396234363739343036396232383133303630223b733a33323a223839666336663637653132373335323665323564356665636535373462623938223b733a33323a226538636138303361373530666530323763376337303638636534323135396235223b733a33323a223634303434396263383334303636663537366263613363336563363538666237223b733a33323a223134653537376332656238623162383530663330306636363666623737376238223b733a33323a223833653339636132373830343039303631316163663134616537663730643365223b733a33323a223832643239616135343462356166626230363935313634666130363136623262223b733a33323a223338363936646334383961636665616263373164306565633637336533623564223b733a33323a223465383061303166373130663132633037666630666163366564313262383762223b733a33323a223665666339306366366339396164666335313630323939666262636663346435223b733a33323a223137326563303131633031326563383965633734393162303933656138653835223b733a33323a223934653035393334326339316130336138356636623664313364343162323961223b733a33323a223466343465343565656461303335363034363838326438613864396436333135223b733a33323a223232386161363330316635313432343731613262343535353362303834613834223b733a33323a223666386332336662333166313737303132306362393933306366306663653635223b733a33323a226237356130383164643830363933613765613762366630633934316435653238223b733a33323a223939343138323361396130353736393736633366643631616465346365613936223b733a33323a223266313037616439346162336363613035333965313964366234343139363738223b733a33323a226665396466643732633835376336376138323433346463363065316330336232223b733a33323a223636336537373538363834316139396264313266366166643839663934386436223b733a33323a226365313564663263616536376265336430613263373030353665396166393533223b733a33323a223766613065353366316438613261383733316665633162326161346236643938223b733a33323a226134663061646533393466353839356530653361343231633965646564386330223b733a33323a223036333738633730353063353838393461646338366438643338333039383537223b733a33323a226236633430396631643635386238343763623538316261333165313866323632223b733a33323a226265313063326232306264636564633933656137333737663139323333633939223b733a33323a223362353933633064613463636533666464396432396232653865376532356535223b733a33323a223566323538636463663062336236663834613763333635303239643430393833223b733a33323a226663393538623766316165643565346465353832393131396462633032363133223b733a33323a226139616263663665373130336562396438313731353838623563363364653633223b733a33323a226239346532636263346537643639653234333731303365383233636161616639223b733a33323a223963373262373466653733323166336263333463386264663935623433396535223b733a33323a223661333265643062333330633966663166323162306534356364323365643362223b733a33323a223136636532356636313964356462313234383239323935363266393036363065223b733a33323a223865653531323265636333613832346164616633343131633065393733396366223b733a33323a223566343765323164306536373535366439643135653530626165373138323237223b733a33323a223932343763646261383636303033616330616339343665343930376330333633223b733a33323a223165303535646238323932663433356662616335346162333934383035343466223b7d733a343a2268617368223b733a36353a2231653035356462383239326634333566626163353461623339343830353434662d3932343763646261383636303033616330616339343665343930376330333633223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1713188155);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('d61aa0e6a3e2b8ccc3f52b2a437135fe', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313731333137343433372e33353730373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223839393630373030653236613935613736623136396133393132346161623465223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313731333137373535393b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313731333137383033373b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223465636638613365346462626535356437656566303863373439343338626163223b733a33323a223564643362383664653439626439373665383363343631643431303437376662223b7d733a343a2268617368223b733a36353a2235646433623836646534396264393736653833633436316434313034373766622d3465636638613365346462626535356437656566303863373439343338626163223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3232343a7b733a33323a226564656431343836303564646539663930333461636433313661633963313637223b733a33323a226639663438373930663864363830626235653331393530333966633238323930223b733a33323a223234656562663537626662393563323162393835663865323137626662373764223b733a33323a223661656238613130646365363437623939303466396533363039653839356661223b733a33323a226264393334393062623831353333353164306232633866663361646266356130223b733a33323a223739616364656232306365633539323265633039353361323662666235663336223b733a33323a223862363462653930326364353663626130633039653334323634306130643132223b733a33323a226232393535326333626333363733656262663266393733616337306164396436223b733a33323a223637376465303031616364353433653432323231663630613235336534373335223b733a33323a223830666361663662666432386338613636616164353930343036643736363034223b733a33323a223237306365386139666533333633326137633239383764323131323331363930223b733a33323a223661373362343532303261666466373130336535326235376135633930643763223b733a33323a226233646430646163383464653663333339366430373364373230353661633536223b733a33323a223666613365666435313663646532343632656230303362313837343238666233223b733a33323a226532353864333066333038343538666261366237613636623130373563323534223b733a33323a226434383135383738376664303534393662333831623363663631353961313232223b733a33323a223264636265623630393935626637346665656466613364666439663635363937223b733a33323a223961643432333261356530343564633735623332633565366462616331656430223b733a33323a223536353637376263626437363234373634333735616237353261623332666163223b733a33323a223164653262393164353430666434303234323961306263613761656234633436223b733a33323a223139636365663861643835323337396463656163646631303465663861663234223b733a33323a226639393132663330376337316535366166653338663065613765313634626436223b733a33323a223931383232343639353662626261313065316234646435333261623137356264223b733a33323a223466633838383866656362623737303964663136356164623239316165626165223b733a33323a223834623730383038663566636536303734393531393064346362326331373665223b733a33323a226464383463613363633337616265316438346563356666633638386561653562223b733a33323a226337663235363439356363646231343434326433656539363565653936363438223b733a33323a223239393064333366353237313361333962656536656130303561633562323933223b733a33323a226130303639343364653039666635373464613933323865393462326231353733223b733a33323a223661616233383263363931316162626137393165666334653330376566306234223b733a33323a226461383365393064333434656436663433363164343139343237656131336265223b733a33323a223330663234646364306139386361383762313539613031333437656665343735223b733a33323a226438313661663639353035323439633865653138623333613235313337366138223b733a33323a223563393431313638643064633938386531333735306538376535643863373538223b733a33323a223439616163646366376661343533326465363837653930303035623236313239223b733a33323a223532626437333036613831396465313561623937666636646361353531343165223b733a33323a223538396461333232313332633535306434386334616539653961306539613836223b733a33323a223639343766653734316164346533313463323034393266333733336230653364223b733a33323a226465366231336534333735656130353763656232356364383930656233613434223b733a33323a226633646134323531646431343231626139313963643763323338303430633264223b733a33323a223963306364653734393365356633343636376665303433636139326436383630223b733a33323a226662303531613935393339353235613934616330623863336334663431396662223b733a33323a223737666632626361336631306361666437663262326361303261303537623566223b733a33323a226266376565636138663733313065393739346663373262343235626339393235223b733a33323a223263646138613864333738663265623865343937373162333634353466373435223b733a33323a223038323663393831373933363137313335356537316131356332346366323438223b733a33323a223663343763623963613565623465623463643066666237396361326562333338223b733a33323a223835323865343835356465623036386461323261666231383334303338633165223b733a33323a223433343564613938353763623234323335386531316338633362623364393564223b733a33323a226664643265323638616163373338636134643930653066663230373938323630223b733a33323a223637666462646335346339313731616665343135373061353664626633633036223b733a33323a226631383666616565323463356363373634613564633261656464343863353433223b733a33323a226266333764366439643938343033386336373336363535643336316139333234223b733a33323a223233643961396263346530626366393239656161363930376538326465313631223b733a33323a223836636538356261653233313232356438343964386134353230666639616362223b733a33323a226539613231346131306437346432393830383939303437373765383566623231223b733a33323a223961373236643031383261346132626632663733646134633134623139353637223b733a33323a223036303266303163656466376230363935366231616663633061376239356165223b733a33323a226532343863393036383637646430306131633838656337303466383665316335223b733a33323a223334336466616634643435653536363131336535343431323833353338323431223b733a33323a223437383033333162313432656561343035393365383163346463316534353738223b733a33323a223137666135363237666537643961633236346135326633323838373731303463223b733a33323a226261653537333165366465616235383830366430633133383564366430326338223b733a33323a226534383236373731663562653061656534393364333933303535386334323135223b733a33323a226634636335333530613832363266326339326666663666306338663234663635223b733a33323a226131316632313336646630323264386132636561373565313335613862633161223b733a33323a226332636665323065386438316630656163613539663662383863353164613233223b733a33323a223733366532376366393763343166366565306436373732313332303533343235223b733a33323a226633643834303137303362616535613062613732613031623264316239663962223b733a33323a223434306636313466623738386664363035613030313964396130313961366236223b733a33323a223662356130626336663433306664376431316238623133383630326633646565223b733a33323a223263396434353037636438396535646437666261303466663664366336313961223b733a33323a223231396232663137646264366539363063663062333661343365656365363537223b733a33323a223366306135316232616563323331383337383036623336623139323435303633223b733a33323a223030626331396331383634323461633466366363616339653963643430346531223b733a33323a226564646233366334626263663433356632356431656366323664396135323538223b733a33323a223962616464663930636439383436653862666437306339373230366338373163223b733a33323a223766613535326535396264366437323866646566383361653764393230623338223b733a33323a226263653132386337303064356466373735646138306337346362346533653063223b733a33323a223630633631643361316336636564633930353966303266333335626237633464223b733a33323a223865613439346263623561623262356534343831303035633366346330646437223b733a33323a223836633435336334306461343566323739353461323037396330386562663535223b733a33323a223338313738666135303763396563366635343965323530623730366134313432223b733a33323a226539653238376461313638643532616362363433643435343031643961303436223b733a33323a223331356534366438633762306165316635663262303730386362383637306332223b733a33323a223735333437666438643263346434346534653332663030313534666434383234223b733a33323a223762326432303363343239646433623337393830623465366334316139363236223b733a33323a226238633166306635313937303430356336376133616634363265343035666537223b733a33323a226665613362356539366532373833336639363362303164383164626233623537223b733a33323a226632356163623138343932646534646166373431393263626464666334383735223b733a33323a223265373832373061383130656437616162343834656636356239633636323564223b733a33323a223332313163613164383163363964383139363431363738383166623936633964223b733a33323a223665373736343862613766653235353137643765366631633232336564383730223b733a33323a223736333438363631363433626263386637336563373235383062366235626439223b733a33323a223738336261363266346162623261343133333730326463386534396666326539223b733a33323a223533363637373230316239383862373864613530333133303736396531363563223b733a33323a226462646231303862303235373763636532663462356630313565373764326161223b733a33323a226561636364646265303036613333316230306339326361626361306332636461223b733a33323a226137336137333538663165343262393861353330306465363432333466323462223b733a33323a226239636561353536373336666533366362333932613339376137373032653730223b733a33323a223064643164666166316361633936303462373537636232656337353339613262223b733a33323a223462366632306261326436303731363532303261396431646231633432643366223b733a33323a223966326665616430306532313163616538326332383533383562336165316532223b733a33323a223831626436636266346462633263616539393035616135363465383233313066223b733a33323a223664333838346635373331383235376465626633653533633162396535393436223b733a33323a223263633464636236643833343662303835363961643739316433646632393036223b733a33323a223365613166633631663231643536636565333439656636633330643833643333223b733a33323a226463643862323837316631333232363464356436303237303438633935333235223b733a33323a226337623262663765613237316433656264393733303238626336633763326166223b733a33323a226264376362336434346364636263313965643536353636363938383039336265223b733a33323a223932343363623031343962393164663636346132623763333632303338363733223b733a33323a226137363063356565396539393736646635366631333438316631343661343465223b733a33323a223263353536663839303038653135663865343162616430353339313732643435223b733a33323a223663633961333231313130323338356336373932646439303861663938396636223b733a33323a223266366132383535353536663265323639383031356636663962653932343237223b733a33323a223432666637626538363036633137623238333732373162383562636639356630223b733a33323a226636636539383731376162393438316465666666633536663365366462353362223b733a33323a226436323938316131336435363333626435356535316334386636616238396633223b733a33323a223232316234646137383161653539356562393939333532646264303731353333223b733a33323a223835396665633863343464353831346262616237313438386533623365643633223b733a33323a223764353736393365316165393637306131633036363865323932323633646537223b733a33323a223039613835633732343133303638643534316630366536396564646639313565223b733a33323a223639656561656561633436663234303837386265313530346635303765636462223b733a33323a226662656432346232616539353064363332383966356663353166636237353061223b733a33323a226331383939363539373238376263343335653963316233386139383665393063223b733a33323a223333373831366461373365356330626563336637656635376261393832386536223b733a33323a223866396339393331303036623231373239336362623164343438303066663864223b733a33323a223363653332383366643362616632356137623231326436356133326464616361223b733a33323a223032356164303231313865613532623133383236663031623964356531393533223b733a33323a223838313964386234653434633031326336386533323539623232303936663861223b733a33323a223262373165333538646162313038383239396638373062313836663334633866223b733a33323a226366626631336262623931356465343032666662646631653531643638636132223b733a33323a226363393264653634613930366139643830306230393864303337313536393939223b733a33323a226439623835626437663262303034666331626562336530356532626331346266223b733a33323a226662386166373336643832626633653561323763323061393531373666656364223b733a33323a226438353832383739616433613230656262303465323531306563353838303038223b733a33323a226134633830636666343637653433663539333837343035363863663237353633223b733a33323a226537336166316638313635343038656530306462623232633233643633353361223b733a33323a226266353734373731393465636333623233666363336661303035643430323133223b733a33323a226637313866616230343233666131353366333236636664303334333462376231223b733a33323a223839313435643463663936353261633636323732656433383833303335636339223b733a33323a223939656338626463663731343230626531303733633536346537356364626532223b733a33323a223862383939396631343731343736323232663366366266663233386334303032223b733a33323a223839633766383833613061333632303766336261663036366236346638633038223b733a33323a226435396332333461373036373730353731623933356535366366313331376334223b733a33323a226235383261633666386364333433373336666462393962363266363439666336223b733a33323a223235316261636636643763396338643763633430396465383836653663623535223b733a33323a226538306630313035383231333765313332353764356534663231633163346132223b733a33323a223961646130646164393936636333316234643431393461376339363662373531223b733a33323a223866356666373636373764306166343231396132333366393965303366373536223b733a33323a226362626662306163626165343834333139376365626133396234323264653236223b733a33323a226338623130343231303338356333633630303533623732393764616664393866223b733a33323a226163346662376531313264626666656433653235323739613538306132626131223b733a33323a226630313966623839656663333932303163383461623234333063613338303763223b733a33323a223035623765323638313636613739656236663666616330626139333936613361223b733a33323a223035633665386333306235316164393266323564313532363234343236386163223b733a33323a223465643939613534383266613161663133633438323161346533386562336536223b733a33323a226431316135303862356337356233303033333734666530633535343134363234223b733a33323a223464306237633464643837643332646664316266356238336463626137653430223b733a33323a226632616663383262313166333563313464353031363239326434613761613266223b733a33323a223766343438303931386464353538363431356630393037613537376163376630223b733a33323a226430386638353639376134653862353736643233333264663266643866383138223b733a33323a223030316337353634383261633962346339643462333136646464613164653939223b733a33323a226236356233376561646537373566323565386463303263663032643138636461223b733a33323a223464643438356631353832663036306130626132636135613361353662383730223b733a33323a223039343635333837663365393663666630386339653138626235326337323534223b733a33323a226663343464383861383431316236326262303464323336653337373539356236223b733a33323a223831653330363331333434373631613135373839366632613639383338363565223b733a33323a223032636266613062633130333266393738656430363132303664393937633066223b733a33323a226630653538306132646133343563613334623834333934356434343461616431223b733a33323a226162656130613238613966666239333239353039386466643866653664343438223b733a33323a223533653865323431386137383162366336306463633861383762653938343833223b733a33323a226663613639666537626232376162303066383937363132366165383662323764223b733a33323a223062313838636565303533633332633164313739366635373334336135343033223b733a33323a223734386230303761313363663834643661633761376265326262343334663635223b733a33323a223530343535353034316139313530346237383461316531313635306232333230223b733a33323a226332616439376166376335313164633932363531316463373864653233626331223b733a33323a223535383764356162646539376266666132396164376662306665656139656637223b733a33323a223464613362363661323161653664363734636465353135376165373632336439223b733a33323a226331393765303235653961633366393862633961643232373038653066646161223b733a33323a223732343966306534326132623630663535643239646237336230333632393639223b733a33323a223336393132383639373834643139613139636639366435383630366234623365223b733a33323a226439343563393863646436613034383934353565323436653966336264373637223b733a33323a223536623336656662303863636430353239613036633937333735393362336536223b733a33323a226664396538333037363538396634356231616166326533333331353530346239223b733a33323a226139613364393965646163396562646562653465383332643739396433643832223b733a33323a223736653436663561326164396130306634666631393966396531643235653433223b733a33323a223239363632306661376533383233643334646663356636323232613436396361223b733a33323a226539343535316231373136336136393063643333646562333561353638343566223b733a33323a223465636133366134623234396161373865636132633065323130656438653130223b733a33323a223362303166383031653638623461633361353338343637343566666462336566223b733a33323a223431383862623466336363346566343039343065373933306563663736386232223b733a33323a226436613331346262656132303065386462346635353961643663383161613335223b733a33323a223766613034366639633037376563626162323863373038656131333364313430223b733a33323a223734346366663965316236386239613133323061306261383131356161326231223b733a33323a223466663731313937663263346336623735313666333734666137393934623864223b733a33323a226662633266653933626630663633633532363730393231366461643030326635223b733a33323a226233373333326239383739663036373265643331653061316337383933613032223b733a33323a223136666663353539333631366534333961643065353830626262636639643362223b733a33323a226666343430646533343861386633336262336139366466313632303362376537223b733a33323a223465376238653562653264303130666465636165363430643064363736336635223b733a33323a226633666631313766336531646436323437396266636163323064383730633831223b733a33323a223339343938376665336233623136626362646565363533633136353834353161223b733a33323a223461333064343034316639363039306637323966666230623332636561623038223b733a33323a223831366632323061326339373336333237333239616230646430663838616162223b733a33323a223762323965336334343131666432333563343936636634363565646636396634223b733a33323a223233303035316138373864386363643731343331653433323661376135383266223b733a33323a226432323862383863303030396630336563343563386335303162656265343836223b733a33323a226639336331343165326166633838323164313166666566643464663662383436223b733a33323a223161643538323336343237623130636261343964636531393239383032376135223b733a33323a223265353632346132643937623536363036366633643962393438363733353334223b733a33323a223335386264663066396132323631363933383665666339373637323461636137223b733a33323a223330643437336533336264313461383761393631326333383235623833653863223b733a33323a223836343731663339646136303539363335336366663636326234313538396538223b733a33323a226439633362633062336563633336323733636230303431316536656463633364223b733a33323a226566393337616532376131316237623335386165373962343737326163396439223b733a33323a223332653265643466306138613634323935306530343537643962393430396231223b733a33323a223266613065663562383534636362336535666331323538363664366136613964223b733a33323a226165356336396164346237396130323133306138313265373063623362323861223b733a33323a226261313236373931623433383463343338323539363633333966393138383736223b733a33323a226164613166633136353437363765653937366337373835613135626462386538223b733a33323a226336636335303366376362323538643036643061383532626138366237316439223b733a33323a223165643261366331303937303664313934396362363531636432343232313539223b733a33323a226162343862633034373237333731363839303065343663323339666539643333223b733a33323a226562306236636433343638646333393165356430313030333230623937636638223b733a33323a226538383664313266393966366638383736306436643231323631643761393436223b733a33323a223731303661323534663836653465313661346461343334626566373533336337223b733a33323a226437396234316662623534363435356631653964323466636231646630383932223b733a33323a226537616564333834666630613664333765646463343566393565303538353934223b733a33323a223433366531366262356232663063353938353465383438393761326461613636223b733a33323a226166623663323461336361343838623134656439666638303831383365353064223b733a33323a223438326237386438353139356163353966396161366532663435353330643931223b733a33323a223830343034613331653530323566323866343531636366316538633365616562223b733a33323a223737643933343632303864643734633237353531323761363537346365336463223b733a33323a226563613464653532313739356538336562353030386365363933366164633630223b733a33323a223437373730633465626361373438353134336131373836653233363935306237223b733a33323a226263356439623666313039396637316366613033353530653831363835646230223b733a33323a223232343164346365663734626331623465313034396638383462333231366134223b733a33323a223639663262656635623135623234626439366232383438346432616338386161223b733a33323a223665613262303062306261386430623533393664666364663033643336386231223b733a33323a226231633932336139373432353031366566616137386534633866626331376166223b733a33323a223031636662376532666238393333326434643562653433643931636332633064223b733a33323a223766313835636338303030376562346364366439393034396437373033636337223b733a33323a223132666631656338353435393164306639373133616236643833383330653239223b733a33323a223336633235303031646639373634646435613862616532356337633564326332223b733a33323a226231326137383333306635656238306639303132626335316666643461343037223b733a33323a226234396539653065353365643962343665333766366335386631306437313538223b733a33323a223739353764333336643161666662353530356137313237356435326265313833223b733a33323a223934646538313864316262353135313336353538623933633233353661316634223b733a33323a226238623133313131303963306238313533396566333964663831376562313739223b733a33323a226635393662306264366265396336353237323063656164326630396164636639223b733a33323a226262643264653131313138373732613337643061666664663735336438383736223b733a33323a226330336238636134613561373234356231393634636136616433313761333165223b733a33323a226263343763626662623865323534656661393835383835326333383932643064223b733a33323a223738353133616361393061306234336230646332623537313462333662386130223b733a33323a223561343932643839323037333137623662343866383635653734653233303830223b733a33323a223735356630623264366661613764303536366337343233363465393165623063223b733a33323a226464633835653736326332616236393433353537336366653738643262613563223b733a33323a223533323661613531636138316665666539356636613230303232303665316337223b733a33323a223664353061636137363739313733383261326139373532303732326465326466223b733a33323a226362373633333962663035636361663866383333353935666436643439343232223b733a33323a226466633837623461656266626232343830656539336661643730313235363036223b733a33323a223633643835343830306538626363343339653736383763323830343664623838223b733a33323a226161306232653230393962346237306631313231376230313062393630363030223b733a33323a226361363364626162333439316466343939393165623162633332343535373239223b733a33323a223231313639663532373036353361376166626535656231663635396565326462223b733a33323a223533396634643038383330323964663635396566646462643362363535333337223b733a33323a223339356434376566313030666166366338656662343937303339633731656435223b733a33323a226166333030623531393838376439653664303235373565376365343564313763223b733a33323a223465306538376461333262663935303361323865366562623837333236303061223b733a33323a226536383362653033313538353431323466313865363935323435626363613036223b733a33323a223534353766616636616133323537613735373433303963306333346239636436223b733a33323a226330656162356332613165623432353431306264643163323463303539313333223b733a33323a223366316362623836373430613630306265366639613861343739306439346535223b733a33323a223238326633383763323763653532653661613638396133636639633236623830223b733a33323a226663643266633237376239353436333231666532383762303836623562323235223b733a33323a223436336262383232393037343733363635303738363233396237363932313931223b733a33323a223734646633303163613832393737643939666436376665393564333666623263223b733a33323a223964623137393263396539623434343631393632373335363738363936663234223b733a33323a223436623435366438343266303930653530343037336437626664386265623062223b733a33323a226633323666323931356638633666373864333162373134636361303638326632223b733a33323a223935303230656261363361643764643532356237316233616537316139303139223b733a33323a226461373835336235306230356265323261383939353032373830633864646630223b733a33323a223864326335363366313335333333656262666138393136323365656634353564223b733a33323a223162376239353433643330303636303665353263643737643535636131393934223b733a33323a223261643962303630306666353162313061326362663965373030343863343461223b733a33323a226431356461323666323236653438326135316361356433646234376434636635223b733a33323a223264303130393836383163306462343731323566653837386166666334636461223b733a33323a226633313334653032626532616237386562316233393636643366656161643436223b733a33323a226463656662333865356639363562393037373234616237303237356333383331223b733a33323a226466353532303031646238363831306361636630383765366533636636653963223b733a33323a223566613538303535316335626632613035356131333765613834363832326132223b733a33323a223632363037353931393464626566623363643831666130383164303164316364223b733a33323a223935613837616238306639633365353863353664333438323137323238333665223b733a33323a223635363238346333323134356461323230656338626432633032663133313230223b733a33323a223534383934383036396561386134313036663232323262656634386534636631223b733a33323a223532313437653334623636386137363231366437346462336263383138373534223b733a33323a226466663834316634666336656535306662653861333764313534616237353362223b733a33323a223464323464306166613865653635366664623665623661306131386135303338223b733a33323a223133373564313833636437303666633630393439633361343831613237316638223b733a33323a226136316630306133313733636661363065636238333262653231356633386466223b733a33323a223032623136623032663866313662616436363365656530396132373965666230223b733a33323a226431616464316231643230653336336637376632636266343964336637303931223b733a33323a226364393436313461643761343766366234343765353534383863306434643539223b733a33323a223434343035353835393730373962366436366530336565653130623638356138223b733a33323a223632306662303062333732643130316330636437646633646464613562613663223b733a33323a226434343966656137643033633062633763323566663466343933373865373532223b733a33323a223365396465383333666131383636393566663933643635636230333336353062223b733a33323a223465326439373166653334636661343163303363373462386664636537663737223b733a33323a226237343930386337356563373063646333316134396264646431343962333934223b733a33323a223337633334386163303536326539636661356234633134373164643930386262223b733a33323a223533343135373833326266636637393862323439363762363938333766643463223b733a33323a223634633566373463306331366237303834636331666162646132396332633731223b733a33323a226165356266333732373530653262383963303638306239353334333865643263223b733a33323a226535353666623462363262326264373830323232653937653064616633356537223b733a33323a223165383632653033613865376462656334303737396534623134326263366266223b733a33323a226330386633643737323537356465363839343064353934656162356337373039223b733a33323a226339366461366661643064666564366135396562636338376136376665663330223b733a33323a223932316639346333343532653339393363333966386131336134313566656163223b733a33323a223230383335613162393564346534376131366635643736633065636630343962223b733a33323a226133343637396163373233383231653831656162323334353837626637646561223b733a33323a226265306562386366363032363436356534376363306337323161616662366631223b733a33323a223062333166333534366462336237653533333339626162393533353331353735223b733a33323a226461393430613865333130636530656662386633663132633838623662303331223b733a33323a226662323136633933376336613363303030313764656533353039366663393235223b733a33323a223565336436326136633839613433366135326437323664643938306633353636223b733a33323a226236363565323333316432326433386365376264386134333666323065646636223b733a33323a226461303261393139383563626566666438623034653566613162353065633364223b733a33323a223664323562386264383437373537663533346535623336306236636636366261223b733a33323a223730633634666530656639303432376364376337623039333235363733326132223b733a33323a223534623161633431646566663032623831666434326432633939653030663664223b733a33323a223661613232346330313561383936363436623466626562303635623062643863223b733a33323a223662353438666262333865323037383634633039353434366537303965336263223b733a33323a226638623132636637636363656337306237336238363665316135333361386434223b733a33323a226239303766386130313030653762376161616131633432616561313663346631223b733a33323a226431333631356134386239613263333633356338633137613633663936383366223b733a33323a223935333465646661626335386433366138353362346530303532353733396330223b733a33323a226431313035393533633564346336313266393065366361653138336635306337223b733a33323a223335393465313166313830396365363836646636366432656135643932636431223b733a33323a223236353862363336353136623134376139323666336135303436646339346661223b733a33323a223432353836633232633364656232363634376236616230343134313437366137223b733a33323a223731613435623733313533383466626466333434366336306363333332653138223b733a33323a223239626635616266613639623835653233626435373733666664336233373039223b733a33323a223936303466343966343536373362623135313164396137623035616666383063223b733a33323a226563643263373139633865616666363561343535653662313162326331383566223b733a33323a223262303965376538303664633862633363316662616132656565393966646662223b733a33323a223736343633343732383465323062363135633533383139303766343964366365223b733a33323a226238323161373338326461386433633262653765383237636163636237653433223b733a33323a223134333038356430356634316365363763353931663438353631373039623836223b733a33323a226332373865663635623061383566666664383661363530326432373065346230223b733a33323a223962633466333061623536633063383336306237643539356532643038623563223b733a33323a226134333362376333313961653263383635336338343339653536653463313230223b733a33323a226363643231383831653837663932623531646361626266623637363564636263223b733a33323a223966646162346439633066636136306636393237626538336166376630303762223b733a33323a223765303962663131333238323463323066623662643038393939656461393232223b733a33323a223662313162303066396135353161626165323166303731366438396239626365223b733a33323a226531323039336463393035646630343065336461616230313034316231643534223b733a33323a223235343437313035613465393466373435376566353836386461353230623834223b733a33323a223631646133643232626261373934633165383661353538346335373231366237223b733a33323a226639346332623334613764316234353131333766313738346161303162316234223b733a33323a226637623430343230393733346537666335303336346434623861353931666565223b733a33323a226264366265363230663637656538333333333635623339393166666662343564223b733a33323a223433383339613664363331326164393237316639396235333261323065303862223b733a33323a226566393339313537663636353064396537353562376339346433633064396463223b733a33323a226439326365316635636563373934363335383065653231323137363464636331223b733a33323a223837356437663938383263353330313530663163646461343934636130303731223b733a33323a223130626364386666346665316363663562323964623139356266376431633437223b733a33323a223065346266393134653233326631306332633939376363356536393261656134223b733a33323a226233353931303532353566306433353533376563643736623064633661323937223b733a33323a223765303134323030343139333562373761303433386132623930336131663137223b733a33323a223038646435363239373461346635633565363137663733306433343139626362223b733a33323a223565323864386635346135646638396366373564383262633261386261343631223b733a33323a223766633537616232396363383135343561313066643665643236326432616531223b733a33323a223734646263313661616433653132633962623233646639343064313339623534223b733a33323a223836643936323530663362656435633331613461363165373031323431363562223b733a33323a223831353538353262663237393061386535623562303837343439366165663666223b733a33323a223232653264393761303734626161346163656532653765373463346139613663223b733a33323a226136663934626362303264656232386134316532633261616537343837313232223b733a33323a223561346335316638316562386562346433336161393763353031316662613531223b733a33323a226461343535313961353739376435636564346166326361383164313735663831223b733a33323a223330343466383134663539646639343639613030343431353434663063636563223b733a33323a223865373533643063316132636131313666666532663466636333613134333630223b733a33323a226433383535366231623064623636616237353562303733343363383839643635223b733a33323a226338636432623431663433646630373034633166653433663431656331343133223b733a33323a223236376363663662633065353165613337383839626636396234613530393031223b733a33323a223665396365626536643266313135306664666339356138343266626235646539223b733a33323a223366383438633833343566373765653164316636656235396231346164613932223b733a33323a223832383161326663613066323535346262316635643539633562356165396663223b733a33323a223038656539373261386332656531303639626161643933343939626633613661223b733a33323a223033386136393864386339653461373636663461663761323832616535326564223b733a33323a226166656534613465313235623731373965306531346630633230393963326532223b733a33323a223264346537623938346337333637636532306437306432366432623266313266223b733a33323a223333663132333861383832626531323765363235336165613030386332666630223b733a33323a223266373364373865396561383733636435373537373266613861646665393262223b733a33323a226664306665363065623763396533613762393830303666333664333836636565223b733a33323a226661363939343733623161623037346439343463396331643134613338303237223b733a33323a226633363135306433653166613463316161653032396231306232366536623961223b733a33323a223461346232616234303335656264393530616233376665616364363364393334223b733a33323a226239393465326239303566643138666533623232646232313136326530336334223b733a33323a226161326232633538313565636632333161616565656232626134653462666432223b733a33323a223732623834343465323933353564366435306231346635623239363030346230223b733a33323a226531613036306162623666306663386265363531643962383666386334393330223b733a33323a223637396435363434313434383065643263643333613238343866333636316661223b733a33323a223038316466626636353533396166363133363334343637316562613161393838223b733a33323a223130633265363865336337383436613536346334663633323232623263353535223b733a33323a223435613565353330386630386466653965313334626230643062373933663565223b733a33323a223237626137313836623862633531653266653263376237653236326139356464223b733a33323a223831616162313064376430323064373131373961623463376337346164356466223b733a33323a223434353665666538346233333239616234653963613761346166353539316131223b733a33323a226436343637373332366361303337633332303464633933313031633864386337223b733a33323a223835343634316265666663373865653064663564363936373937373161633964223b733a33323a226538323162386364396265333635653231656561376636636335343464396338223b733a33323a223261396436643465366363636364653331613736646564313362393739303733223b733a33323a223138386461636565316665373336393665636639653063376332643034303230223b733a33323a223930616363306331306361393232323661343761373964343231353631616132223b733a33323a226533303965613064653732376536336139303635376362323663643730336431223b733a33323a223133666437323563383835663665653136636238306236346133643666376562223b733a33323a226433656362393831623732386539613439323734636665396266333661323439223b733a33323a223735346132663066356566383665346336646630623331353963336435313663223b733a33323a223937343531356333613230653635303931323734653464303565323731393965223b733a33323a226132643561646566383865303463343934643633376166633331326464623131223b733a33323a226563613664396136343263626135303533306435343535363432356163366166223b733a33323a223331623537343636386430643231316432363434316664313938643464326335223b733a33323a226466663163386437666135393761626430383762353233616136306336653534223b733a33323a226438633536353165653663633836326562383866336134303262326532303231223b733a33323a226136376263633339383130326636336161353431353165373931386233643834223b733a33323a223830633236613764333239326163663535373335623163613231616332656165223b733a33323a226461366534663563613163653664633131326131663332653262353166656336223b733a33323a226139363461363033666239333335393064386231393938396439356434613465223b733a33323a223038316436623139316338613232316235303736346337633931616336393564223b733a33323a226164343266633761633666336262633365643065396334613963333633666464223b733a33323a223131343631623037363933346638653035323035333663303763636166653763223b733a33323a226536613636626435343265373066663537623835303161303835613937376237223b733a33323a223766316134626637396463633161653837343361313938653166636332376634223b733a33323a223661373834363138343137666235356662656665653565613862616663646332223b733a33323a226431363261643366363538393336646239343136353464383735316330346362223b733a33323a226333323732303865383939396239636432633737333864376233393135663533223b733a33323a223864323764346362393666383662336566653463363633306231306666313530223b733a33323a226561363135386662313136373765646266373366373865353864363161613766223b733a33323a223361323466363738336365343138336335333636333236326565393039613735223b733a33323a223432353331383761333136363435333634646237306538326337356231346631223b733a33323a223135376635656661323337383231323564613637626131343330623030663831223b733a33323a223731353963323833666130653763393037306138313530356637393131616333223b733a33323a226636383261366230346330363461376264663966346464633131633435636664223b733a33323a226662376435396538393561373230353863386335306539373038343066646563223b733a33323a226266653631316264633035643132363030653166643863323633663062343364223b733a33323a223831363162616462333862336466626433366261663234633034623532303065223b733a33323a223631646439343463356530316130643837393662653939643737303931353066223b7d733a343a2268617368223b733a36353a2236316464393434633565303161306438373936626539396437373039313530662d3831363162616462333862336466626433366261663234633034623532303065223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1713174437);

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
('ark_qualifier', '\"internal\"'),
('ark_qualifier_position_format', '\"\"'),
('ark_qualifier_static', '\"0\"'),
('ark_subnaa', '\"sub\"'),
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
('iiifserver_manifest_attribution_default', '\"\"'),
('iiifserver_manifest_attribution_property', '\"\"'),
('iiifserver_manifest_behavior_default', '[\"none\"]'),
('iiifserver_manifest_behavior_property', '\"\"'),
('iiifserver_manifest_cache', '\"1\"'),
('iiifserver_manifest_canvas_label', '\"template\"'),
('iiifserver_manifest_canvas_label_property', '\"\"'),
('iiifserver_manifest_collection_properties', '[]'),
('iiifserver_manifest_default_version', '\"3\"'),
('iiifserver_manifest_external_property', '\"dcterms:hasFormat\"'),
('iiifserver_manifest_homepage', '[\"property_or_resources\"]'),
('iiifserver_manifest_homepage_property', '\"\"'),
('iiifserver_manifest_html_descriptive', '\"1\"'),
('iiifserver_manifest_item_properties', '[]'),
('iiifserver_manifest_logo_default', '\"\"'),
('iiifserver_manifest_media_properties', '[]'),
('iiifserver_manifest_placeholder_canvas_default', '\"\"'),
('iiifserver_manifest_placeholder_canvas_property', '\"\"'),
('iiifserver_manifest_placeholder_canvas_value', '\"Informed public\"'),
('iiifserver_manifest_pretty_json', '\"1\"'),
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
('mirador_config_collection', '\"\"'),
('mirador_config_collection_2', '\"\"'),
('mirador_config_item', '\"\"'),
('mirador_config_item_2', '\"\"'),
('mirador_plugins', '[]'),
('mirador_plugins_2', '[]'),
('mirador_preselected_items', '\"0\"'),
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
('version', '\"4.0.4\"'),
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
(1, NULL, 1, 1, 'default', 'default', 'default site', 'Default site created at Docker bootstrap phase', '[{\"type\":\"browse\",\"data\":{\"label\":\"Browse\",\"query\":\"\"},\"links\":[]},{\"type\":\"search-page\",\"data\":{\"label\":\"Search\",\"advancedsearch_config_id\":\"1\"},\"links\":[]}]', '[]', '2023-02-15 16:04:55', '2024-04-16 12:08:14', 1, 1);

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
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page`
--

INSERT INTO `site_page` (`id`, `site_id`, `slug`, `title`, `is_public`, `created`, `modified`) VALUES
(1, 1, 'welcome', 'Welcome', 1, '2023-02-15 16:04:55', '2023-02-15 16:04:55');

-- --------------------------------------------------------

--
-- Table structure for table `site_page_block`
--

CREATE TABLE `site_page_block` (
  `id` int NOT NULL,
  `page_id` int NOT NULL,
  `layout` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `position` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page_block`
--

INSERT INTO `site_page_block` (`id`, `page_id`, `layout`, `data`, `position`) VALUES
(1, 1, 'html', '{\"html\":\"Welcome to your new site. This is an example page.\"}', 1);

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
('advancedsearch_redirect_itemset', 1, '\"1\"'),
('advancedsearch_search_fields', 1, '\"\"'),
('attachment_link_type', 1, '\"item\"'),
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
('mirador_config_item', 1, '\"{\\r\\n    \\\"window\\\": {\\r\\n\\t    \\\"imageToolsEnabled\\\": true,\\r\\n\\t\\t\\\"imageToolsOpen\\\": true\\r\\n    },\\r\\n}\"'),
('mirador_config_item_2', 1, '\"\"'),
('mirador_plugins', 1, '[]'),
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
('show_value_annotations', 1, '\"0\"'),
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
(1, 'page', '/', 0, '', 3, 3, 0, '2024-03-26 13:43:37', '2024-04-16 12:07:36'),
(2, 'page', '/s/default/item', 0, '', 3, 0, 3, '2024-04-15 12:33:56', '2024-04-15 12:34:19'),
(3, 'page', '/s/default/item/1', 1, 'items', 1, 0, 1, '2024-04-15 12:34:18', '2024-04-15 12:34:18'),
(4, 'resource', '/s/default/item/1', 1, 'items', 1, 0, 1, '2024-04-15 12:34:18', '2024-04-15 12:34:18');

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
(7, 1, 'http://creativecommons.org/ns#', 'cc', 'Creative Commons', 'Downloaded from https://creativecommons.org/ns# -> and click on \'RDF Schema\'. Or use this direct URL https://creativecommons.org/schema.rdf');

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
  ADD KEY `IDX_8F3F68C5F660D16B` (`severity`);

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
  ADD KEY `is_public` (`is_public`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1649;

--
-- AUTO_INCREMENT for table `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `resource_class`
--
ALTER TABLE `resource_class`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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

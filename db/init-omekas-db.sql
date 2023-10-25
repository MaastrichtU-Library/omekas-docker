-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Oct 25, 2023 at 12:49 PM
-- Server version: 5.7.41
-- PHP Version: 8.0.21

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
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential_hash` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_ip` varbinary(16) DEFAULT NULL COMMENT '(DC2Type:ip_address)',
  `last_accessed` datetime DEFAULT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset`
--

CREATE TABLE `asset` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_export`
--

CREATE TABLE `bulk_export` (
  `id` int(11) NOT NULL,
  `exporter_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `comment` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `filename` varchar(760) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_exporter`
--

CREATE TABLE `bulk_exporter` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `label` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `writer` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
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
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `csvimport_import`
--

CREATE TABLE `csvimport_import` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `undo_job_id` int(11) DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_err` tinyint(1) NOT NULL,
  `stats` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_vocab`
--

CREATE TABLE `custom_vocab` (
  `id` int(11) NOT NULL,
  `item_set_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `label` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `uris` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_vocab`
--

INSERT INTO `custom_vocab` (`id`, `item_set_id`, `owner_id`, `label`, `lang`, `terms`, `uris`) VALUES
(1, NULL, 1, 'Languages', NULL, '[\"Dutch\",\"English\",\"French\",\"German\",\"Latin\"]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fulltext_search`
--

CREATE TABLE `fulltext_search` (
  `id` int(11) NOT NULL,
  `resource` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci,
  `text` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fulltext_search`
--

INSERT INTO `fulltext_search` (`id`, `resource`, `owner_id`, `is_public`, `title`, `text`) VALUES
(1, 'items', 1, 1, 'First item', 'First item\nThis is the first item in this Omeka instance. It was created during the Docker bootstrap phase.\nIt contains metadata, but no associated media files.\nark:/99999/a1apZs2'),
(2, 'site_pages', 1, 1, 'Search', '');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `primary_media_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `primary_media_id`) VALUES
(1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `item_item_set`
--

CREATE TABLE `item_item_set` (
  `item_id` int(11) NOT NULL,
  `item_set_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_set`
--

CREATE TABLE `item_set` (
  `id` int(11) NOT NULL,
  `is_open` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_site`
--

CREATE TABLE `item_site` (
  `item_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL
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
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `pid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `args` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `log` longtext COLLATE utf8mb4_unicode_ci,
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
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `reference` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `ingester` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `renderer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `source` longtext COLLATE utf8mb4_unicode_ci,
  `media_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_id` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sha256` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `has_original` tinyint(1) NOT NULL,
  `has_thumbnails` tinyint(1) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `lang` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE `migration` (
  `version` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL
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
  `id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`id`, `is_active`, `version`) VALUES
('AdvancedSearch', 1, '3.4.13'),
('ArchiveRepertory', 1, '3.15.16'),
('Ark', 1, '3.5.13.4'),
('BlocksDisposition', 1, '3.4.2.3-beta'),
('BulkEdit', 1, '3.4.21'),
('BulkExport', 1, '3.4.28'),
('CSVImport', 1, '2.5.0'),
('CustomVocab', 1, '2.0.2'),
('EUCookieBar', 1, '3.4.4'),
('ExtractText', 1, '1.3.0'),
('FileSideload', 1, '1.7.1'),
('Generic', 1, '3.4.45'),
('HideProperties', 1, '1.3.1'),
('Log', 1, '3.4.19'),
('ModelViewer', 1, '3.3.0.7-132'),
('NdeTermennetwerk', 1, '1.1.0'),
('NumericDataTypes', 1, '1.11.3'),
('PdfViewer', 1, '3.4.4'),
('SearchSolr', 1, '3.5.44'),
('ValueSuggest', 1, '1.16.1');

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_duration`
--

CREATE TABLE `numeric_data_types_duration` (
  `id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_integer`
--

CREATE TABLE `numeric_data_types_integer` (
  `id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_interval`
--

CREATE TABLE `numeric_data_types_interval` (
  `id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value` bigint(20) NOT NULL,
  `value2` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_timestamp`
--

CREATE TABLE `numeric_data_types_timestamp` (
  `id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_creation`
--

CREATE TABLE `password_creation` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `activate` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `vocabulary_id` int(11) NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci
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
(1637, 1, 6, 'superEvent', 'superEvent', 'An event that this event is a part of. For example, a collection of individual music performances might each have a music festival as their superEvent.');

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE `resource` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `resource_class_id` int(11) DEFAULT NULL,
  `resource_template_id` int(11) DEFAULT NULL,
  `thumbnail_id` int(11) DEFAULT NULL,
  `title` longtext COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `resource_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`id`, `owner_id`, `resource_class_id`, `resource_template_id`, `thumbnail_id`, `title`, `is_public`, `created`, `modified`, `resource_type`) VALUES
(1, 1, 40, NULL, NULL, 'First item', 1, '2023-02-15 16:05:58', '2023-02-28 14:46:08', 'Omeka\\Entity\\Item');

-- --------------------------------------------------------

--
-- Table structure for table `resource_class`
--

CREATE TABLE `resource_class` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `vocabulary_id` int(11) NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci
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
(998, 1, 6, 'VoteAction', 'VoteAction', 'The act of expressing a preference from a fixed/finite/structured set of choices/options.');

-- --------------------------------------------------------

--
-- Table structure for table `resource_template`
--

CREATE TABLE `resource_template` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `resource_class_id` int(11) DEFAULT NULL,
  `title_property_id` int(11) DEFAULT NULL,
  `description_property_id` int(11) DEFAULT NULL,
  `label` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_template`
--

INSERT INTO `resource_template` (`id`, `owner_id`, `resource_class_id`, `title_property_id`, `description_property_id`, `label`) VALUES
(1, NULL, NULL, NULL, NULL, 'Base Resource');

-- --------------------------------------------------------

--
-- Table structure for table `resource_template_property`
--

CREATE TABLE `resource_template_property` (
  `id` int(11) NOT NULL,
  `resource_template_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `alternate_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_comment` longtext COLLATE utf8mb4_unicode_ci,
  `position` int(11) DEFAULT NULL,
  `data_type` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `is_required` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `default_lang` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
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
(20, 1, 41, NULL, NULL, 20, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `search_config`
--

CREATE TABLE `search_config` (
  `id` int(11) NOT NULL,
  `engine_id` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `form_adapter` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_config`
--

INSERT INTO `search_config` (`id`, `engine_id`, `name`, `path`, `form_adapter`, `settings`, `created`, `modified`) VALUES
(1, 2, 'Default', 'find', 'main', '{\"search\":{\"default_results\":\"default\",\"default_query\":\"\",\"default_query_post\":\"\",\"hidden_query_filters\":[]},\"autosuggest\":{\"suggester\":\"1\",\"url\":\"\",\"url_param_name\":\"\",\"limit\":null},\"form\":{\"filters\":[{\"field\":\"dcterms_title_txt\",\"label\":\"Title\",\"type\":\"\",\"options\":[]},{\"field\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\",\"options\":[]},{\"field\":\"advanced\",\"label\":\"Filters\",\"type\":\"Advanced\",\"fields\":{\"title\":{\"value\":\"title\",\"label\":\"Title\"},\"author\":{\"value\":\"author\",\"label\":\"Author\"},\"dcterms:creator\":{\"value\":\"dcterms:creator\",\"label\":\"Creator\"},\"dcterms:subject\":{\"value\":\"dcterms:subject\",\"label\":\"Subject\"},\"date\":{\"value\":\"date\",\"label\":\"Date\"},\"description\":{\"value\":\"description\",\"label\":\"Description\"},\"resource_class_id\":{\"value\":\"resource_class_id\",\"label\":\"Class\"}},\"max_number\":\"5\",\"field_joiner\":\"1\",\"field_joiner_not\":\"1\",\"field_operator\":\"1\",\"field_operators\":{\"eq\":\"is exactly\",\"in\":\"contains\",\"sw\":\"starts with\",\"ew\":\"ends with\",\"ex\":\"has any value\",\"res\":\"is resource with ID\"}}]},\"display\":{\"search_filters\":\"header\",\"paginator\":\"header\",\"per_pages\":\"header\",\"sort\":\"header\",\"grid_list\":\"header\",\"grid_list_mode\":\"auto\"},\"pagination\":{\"per_pages\":{\"10\":\"Results by 10\",\"25\":\"Results by 25\",\"50\":\"Results by 50\",\"100\":\"Results by 100\"}},\"sort\":{\"fields\":{\"dcterms:title asc\":{\"name\":\"dcterms:title asc\",\"label\":\"Title\"},\"dcterms:title desc\":{\"name\":\"dcterms:title desc\",\"label\":\"Title (from z to a)\"},\"dcterms:date asc\":{\"name\":\"dcterms:date asc\",\"label\":\"Date\"},\"dcterms:date desc\":{\"name\":\"dcterms:date desc\",\"label\":\"Date (most recent first)\"}}},\"facet\":{\"facets\":{\"resource_class_s\":{\"name\":\"resource_class_s\",\"label\":\"Resource class\",\"type\":\"\"},\"dcterms_creator_s\":{\"name\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\"}},\"limit\":\"10\",\"order\":\"\",\"languages\":[],\"mode\":\"button\",\"display_submit\":\"above\",\"display_active\":\"1\",\"display_count\":\"1\"}}', '2023-02-15 16:01:30', '2023-02-28 14:50:30');

-- --------------------------------------------------------

--
-- Table structure for table `search_engine`
--

CREATE TABLE `search_engine` (
  `id` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adapter` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
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
  `id` int(11) NOT NULL,
  `engine_id` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
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
  `id` int(11) NOT NULL,
  `suggester_id` int(11) NOT NULL,
  `text` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_all` int(11) NOT NULL,
  `total_public` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longblob NOT NULL,
  `modified` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('1758afd9b61335a1b852a203267f763a', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313639353238343531392e3934333135353b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223133313137616263316239666561396631633165636266613836366334376330223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313639353238373932313b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313639353238383131343b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313639353238383132303b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226239306232373232353139663365373035373630343537613564646136393463223b733a33323a223939656564336265613536353536373530316665303539376231383932633063223b7d733a343a2268617368223b733a36353a2239396565643362656135363535363735303166653035393762313839326330632d6239306232373232353139663365373035373630343537613564646136393463223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3430313a7b733a33323a226438623332303362323865303831626332353932326630376562646533313164223b733a33323a223066353661663332613963613437343735313633663932633232613731396337223b733a33323a226361316361323266363362636638333964363333613532646562353266363433223b733a33323a223364366434623230353066613065356466646537616461643436666434333165223b733a33323a223130653564336235626434623865636535643038306338616263323932356635223b733a33323a223338616564326532353835396632396263333439656166346565656334376631223b733a33323a226633393066656633613436306234633338333434616663636265666463313366223b733a33323a223461323365333638363165666432376363316366656233323562376661323366223b733a33323a223835656639333532643835653335373737356536396137396261643664613664223b733a33323a226366616335623761386436306339356164393063373162313266303466623365223b733a33323a226465643362666534656265663265303765623932303366313735336365663639223b733a33323a223365633938626132663835393462623834643237666131306531323864353435223b733a33323a223834356662636162623762393164633938373537373363636531613563333339223b733a33323a226561636634653634323133383866303736363133343465366465383364646563223b733a33323a223466323164386365323333633064336534653330656432326464383034396139223b733a33323a223166363664636332643461656438393235613763393065656436653433323231223b733a33323a223466663461303663386536303466303239636166316163393362366162336437223b733a33323a226461393835303930356338383264326166323535383031333064373339323033223b733a33323a226239646139306462663837646537393664323333623166646637343538373266223b733a33323a226331373163326536323536353236383462353736623466363138636563396462223b733a33323a223939623462636261306539313738633237376330386331643139306265326235223b733a33323a223338633838353364376231386361313266646535396630316231383833663563223b733a33323a226134373833633661333335383135303032323538396135336132313134353761223b733a33323a223531303237643538353233616662376465656336303139353739313834326266223b733a33323a223136323966636439333262623963396236356431393230366238373937333065223b733a33323a223339343532383534366662613237396530383935366336613666633139363234223b733a33323a223365653339303061636332646434346333323432666234383338653561613261223b733a33323a223336353937646661383962353438363537396366383166363739356464303233223b733a33323a223466363331646566663231626638613234393833616538613161356535343731223b733a33323a226565653834616163616233383639326132343139306165353637323137356436223b733a33323a223238663561363062376661663664386132373136623536646434323165353963223b733a33323a226132653238303537356633396665333264643330336564643866303632663731223b733a33323a223135343531323530333033343365656132646536396235383830373734326161223b733a33323a223139643864306262326665356235353231616136343435306565636464363534223b733a33323a223263336234346633346133626539633834343164333534383734633864333734223b733a33323a226631393762326165373436396536636131356439343439376331323564656439223b733a33323a223065653965363631656562373964353735323465356633313966623936353161223b733a33323a223030336232366162616333363637646630356339386631643035333039643665223b733a33323a223163623831326130383663316365373331326138623231316231653462346236223b733a33323a223634656464313138356165323939393764653164633662623438376262353766223b733a33323a223838303662643139346530306132353064623734333536343539643233306661223b733a33323a223638343666336439363761613137383839396338353665356335306363303332223b733a33323a223536343332333861353530363734346338633739373035633464353739663937223b733a33323a223066616663636661333139633366363565616139313263656666363862393865223b733a33323a226462386134643664653765333263633565356566373030626638303338366161223b733a33323a223536396362313266343034313237323362393462303664313334346363326661223b733a33323a223333636532646561623830333565363830616435346563376464626434613530223b733a33323a226362336365326261653563363434303363613538623437386438323563303830223b733a33323a223064623363353666366161326161366531373465396230313134373535343233223b733a33323a226664636434616433616430653438643138383531393261343437383536366165223b733a33323a226439316536666431316433633035356133643134333331626461643061616131223b733a33323a223861613634303832333464326239656633633631636332393262616535643832223b733a33323a223437313530613531646135323136313164303239343531366233623937346532223b733a33323a223563666330316364336663636639343362356335666538643735303634373563223b733a33323a223332636535353162626161373063363266323631623033303732663932316139223b733a33323a226331663432653730666265383832323561666133643634623535383461666432223b733a33323a223761356430323435386665353331656331636533333035623531333436656165223b733a33323a223937643964366663363137313239646466303232666565663234646265363936223b733a33323a223335313266313537363236396266653963666336333230353564396466376234223b733a33323a226465386237316365616337336664363237373036363330656466393431336162223b733a33323a223064333138333032386236323762376136316632343139363939303238663161223b733a33323a226166663736623665393632313061666438653137613334623130313235666663223b733a33323a226333626235353161316332396232323664656461623134343865396337646436223b733a33323a223131343539393166376636366335373164343836303165633738623766646130223b733a33323a223663626462653136633363343063643039373561336130653731303534643134223b733a33323a223538356566623233653633346634623438333532623463393530656432616265223b733a33323a223262666430323634376633363062666437653761326430306132346466376130223b733a33323a223233326235373864303538316632356636393361623030653131333763656463223b733a33323a223037383262343565643431633639666465383166646237333137343364653637223b733a33323a223535303162333036393965303861613531373863653161613333303031643537223b733a33323a226265303562356466373033636337613036323032353031373036323534376165223b733a33323a226331353961346337636132393337306665646263393062393364393933336666223b733a33323a226237366238326133376665383261313262656232303134623633336265303134223b733a33323a223734313962376566346132343039613930353762393139313033626536306437223b733a33323a223638656265313335306632356234363666643438363264613630373564623764223b733a33323a226232373663333632626230346562316334363836396435323662336461366139223b733a33323a223466626161616136636239316531346136306632663930373763353330323439223b733a33323a223761653331303666613431643039386666623337346662393262363835353966223b733a33323a223236373363356263386338333739363035306334326164653530613534346230223b733a33323a226561633931633466386536343030353732343031643863363739663738666231223b733a33323a226533353661366366306364326433326639626164656333303339383035643761223b733a33323a226262326332373765383633376132366534333636633035373539363031343838223b733a33323a223031626138363434366466373930343266376462376530306639613732616163223b733a33323a226165666563646234306230353639393736333839363166363731613465396233223b733a33323a226636366134636231383763363331313134383566316233623930393830343836223b733a33323a223233396232393738373937666265636631376138653239346431613465343162223b733a33323a226334353734333363363061343634346537336439386334386130666136336662223b733a33323a226663326166323765666638653532613063343562303134616332313131616166223b733a33323a226635306537313430623335363064343562396238336235653830613436353738223b733a33323a226636636431363431396139343261653831666335616634323337376161626564223b733a33323a223261316232653134666664663961383333316365336432356265393133383863223b733a33323a226132383266373261393936613261623765393236376265656230643161326535223b733a33323a223162356362353936303764633265663232653237653563373164326165376334223b733a33323a223437326338356464633530316463316234316262353963323738316231653339223b733a33323a223530373265356439366332353836356262363365643363303135353339643531223b733a33323a223834636238353135343435373265376632336561373834623662643166626530223b733a33323a226330623536623636396235376237623538396337356662396533356361326238223b733a33323a223565326339373937343833333261626536373966646334303933643863313961223b733a33323a223131613736396139383037356266376162346564663431356466343734353131223b733a33323a223631626134613135656632306234326338653262613630653239343734393062223b733a33323a223734633839343462636539656332383636366666383832663335393638616634223b733a33323a223661633265363763313061323265303733333134623430323232653934326462223b733a33323a226234393965343631333161616362363134393131346231323262623562323132223b733a33323a223438636234363139313363623338353337643130643366353939386634393266223b733a33323a226630616236393636386262323936383234376431326134373937383666333139223b733a33323a223237323333386536626433333164653430643534656564346566363334356564223b733a33323a226635643963393534343164636336643434623436633236666531656266616666223b733a33323a223864383036316339343564363637666632663562366539613664386439363638223b733a33323a223939326635643632663230316337333535353732303435656233303731643334223b733a33323a223735613934633738623634633966336337636630653561363735346336316137223b733a33323a223031356365333733393932623431636333316661366462376637336433373430223b733a33323a226138633131363730306265666637633061383433616637353265316535323030223b733a33323a223237663239663936353863313037343363356461626137316135366233323266223b733a33323a223735663437383337313863303063313734323263363834333661343634373331223b733a33323a223239373337633963386363623862383635656664616564396265393031346134223b733a33323a223031626638653564646133646335386263383734653764633763383165616435223b733a33323a223662643137373734653735353837633362366632643864336564626263306563223b733a33323a226435316462623863636133656532383738666663323466633363613935646433223b733a33323a223939633561336661383161626232643665366563353734313066383932376535223b733a33323a223366613961666130646361353665663662363261646136666431346334313062223b733a33323a226339623331396665326230383464663364633339343362653235626439376330223b733a33323a223965366566656262623933623233363533363937333361386234383766336364223b733a33323a226336343338376234333839366663353763616238306631366331323534613363223b733a33323a223066623335313035653964343631343037633333393133333563336635356563223b733a33323a223565353365663038396339336338336532336362376563636437666132343861223b733a33323a226439633737333235346566353436633934363433653837393333316164643262223b733a33323a226262386664653265646665373432383762326261343734343631303931383430223b733a33323a223933363430363863656465306431616531613937313938386166346262613764223b733a33323a226230353936396161303538346664376336383235383331313563383965376336223b733a33323a223738303130323864653037633138613239386364633533346432643033643238223b733a33323a226338396332376465333531636466663031343562653836396265613635336463223b733a33323a226661353736373731313138303633663636656431396362356230313537323137223b733a33323a223638333332333565656237643063623361316465653065323430376634396139223b733a33323a223937643339313336326266343465343239333137643334343637323362326463223b733a33323a226264303262343436376365613739616466373030653435646639313365303466223b733a33323a226463376636656433353036343165343439623739326136663665326137656237223b733a33323a223462313037343730663066363433616334363562323432336165303136363362223b733a33323a226537333539303964636333386466393734376632363264386466333136343432223b733a33323a226166653139303461303662303632323765363232326539303039366636373261223b733a33323a223961633262316636386636343465323864323833316331396662346533663465223b733a33323a223165626130356664623834363938333637323266633239376338366136353433223b733a33323a223736376532396439643062666265336161663136626333363134396264323361223b733a33323a223031306632396565363437346564306135376234643835333137376435363636223b733a33323a223761393834353239343339303036363865653866633661656131663930346166223b733a33323a226666383538613564376236613866636262656238326330396462303664323436223b733a33323a223836663137616235383332326166373933343361656266393233313538316332223b733a33323a226162303335303438633964353461646433373831653736326163353336316338223b733a33323a223731316430333663373465633230306534346636346138386334383932633639223b733a33323a226563343239366537343935376135353232333738653337316138623164326561223b733a33323a223261366233633534643130336264666638356433323161343231663136333433223b733a33323a226236636165343666633965366134306139323532306431623334316366643631223b733a33323a223463623461363262303930633031633535613935353465396537323037623438223b733a33323a223566323534373365653230363462366462366639633065666638646366346161223b733a33323a223161343437376437626633656366626564363439363163393635333665303566223b733a33323a226135336561366234326666656531333936376466663131666161336236393533223b733a33323a223763313163323934663736333538653562666535303763336339363364636232223b733a33323a226162363864333063653635653030646433363134383663373939646437373439223b733a33323a223538386534633565336137346238623130633930323430633164363965353030223b733a33323a226635663738326239646138303437633262376637383061323537336235343734223b733a33323a223065303534323438613431356562623961363962653036623164646163616634223b733a33323a226532663532636637666439396535313437353035313762333737386331326463223b733a33323a223833373666666463326639376561303834376466386563663335386365646638223b733a33323a223761363538633838333234636238333432306566326130323238373363353061223b733a33323a223062626165326132353638393331336630666631363735356638656361326434223b733a33323a226264396131663731636162613338313961316135646366626665653763636166223b733a33323a223566343733613063623463666638333561386338366230643961373731366230223b733a33323a226439333632303937646463636330303937376265396537356438323639346664223b733a33323a226232643238633438623232376263663239666536323664376133376265363237223b733a33323a223335306335323239306638323138323730303539623835303437306630626461223b733a33323a223238363765613364613563333334393965383764323330623664356464353464223b733a33323a226431623930343764306239353964643566626336653666346337373066306363223b733a33323a226461613339633062633733306331313436623065626431363562343834373466223b733a33323a223737363736623064366237303335636431363434306235323038376661653238223b733a33323a223131653933343465323237313633383833313631626565613933393434623036223b733a33323a226130326439656531623335653836313864623630396437333366626263343632223b733a33323a226661646435373161386238323130396235393332326462393363623561346333223b733a33323a223931386333386562623736346533623761626637343961363263306165383431223b733a33323a226362666338353130656432653430643165663961653032646630376234333862223b733a33323a223236336234653336383236613538363533393737303535383035366465386335223b733a33323a223932653862383235336361346365326162383266646238316136613166353835223b733a33323a223831663330303063366536393435333639616434323166316339353935313632223b733a33323a226435326636333532653735356366626461316463616230666262333562626530223b733a33323a223131663563363337623634656566386565393731303763343863616263326665223b733a33323a226431383462383732623961633861613036333666353639306437623062643162223b733a33323a223032343661643134376536383039366234386366623661396231623965626234223b733a33323a223635633935366231356433383365363064303133646135636236623439613632223b733a33323a223730653333323361323733373630316665333336356539323733363832323737223b733a33323a223264386465623230643362366631336439343333346533653566383833396132223b733a33323a223339346437383533633361373539393632363464653961373238623139666538223b733a33323a226230306632346139663332366661623431343761383564323135303338386437223b733a33323a223461613063663837643266323530326664363637383064353366326164343061223b733a33323a223832356638653134396666633036323938663633656262663061633736623336223b733a33323a223534363631343735373131616534396235373235643735373334653964373930223b733a33323a223337656536303662313135393730646433376538383733313135373939616532223b733a33323a226335613534623162643563396664363766353830646465613030343339343037223b733a33323a226136626361336564643533366534376331386363646263373261343965346632223b733a33323a226633643838346134306331306333343163613736343063316139313964356335223b733a33323a223363393565633139313561643835323330306439663764356363386337636532223b733a33323a223466346138633265633638386634663965633439666163623434633436643039223b733a33323a223936316434333239666664663063616165366239613263306237303030333034223b733a33323a223466313734363261643839633266343563363962623264333635643637393431223b733a33323a226237393435646362653332376338623338393037666661396434316161393062223b733a33323a226137653038346238373238326135656633396162653433646231643562653866223b733a33323a223236326237663935613764323765313764393663303661373761323161643961223b733a33323a223339316361356136346535346334363432653534626235633161386638386261223b733a33323a226335346430363134323639313931653438363133663863666334346462613232223b733a33323a223162383334393634623430333030383535663764383535323365343562653939223b733a33323a223437303139626231643431626564623536363761636236656431396562396266223b733a33323a223736333663306231396332376564623739386362356263306635363866346639223b733a33323a223561663061333461366331343232333434343030366137643439393736653337223b733a33323a226164326363326239396161316365666635336361626134363438616261663031223b733a33323a226530336263363531356136653831396566376339616430356266663637383962223b733a33323a226235373262613666323130626564313961613133316434663131303163336264223b733a33323a223966643264326135303430633964323037386262383761353431613864613632223b733a33323a223231313466623131633530613062306662613066623266326663386266323235223b733a33323a223865653666306566653062383639323132623736323037323762636237656630223b733a33323a226666306662613565393938663633323937346232633236373237316563313934223b733a33323a223666623761346137363633643938323234633762356435386235326264373930223b733a33323a223631626166326464323730613933336535653663633433386633353363646435223b733a33323a223135326633373761613938623965346465373534303565303932373633333737223b733a33323a226430623032393736666562646433313764343735383033346265643062653435223b733a33323a226162393832623831643265393339393934303766326635356364323065373638223b733a33323a226361623566333662366365343138333534653236303161386664323362326561223b733a33323a223662386231616134356366376562343337616435613562323230313565346332223b733a33323a223765363531336430626163316363373231363238363733623761353436336339223b733a33323a223334633338633666396130393564383766396334336139386461643563383137223b733a33323a223666356137313836636338313163656363353832323738613338336236646435223b733a33323a226134646266656638316137313534383433663830633564333064623266366232223b733a33323a223738626564633032633030386435396635343665383863313133616431656666223b733a33323a223436393032393263363463613564336630366237663166393033666363646438223b733a33323a226666333030313530303065333361373965326430353463393362393561613338223b733a33323a226264396566383362333864623639383962353261303739363264353137363033223b733a33323a223838316264366330383236303939383764376631326238383433643432356533223b733a33323a223233346464643763396163653066333264616537343063363737356133323536223b733a33323a223337343933383336386464356335306232363862323638336161396436616630223b733a33323a226139383464386533613135303533333362373433623535303235343938343265223b733a33323a223131306433356230626362313263633434613266643965376263313565663832223b733a33323a226638653839666233633865333430613462653064363539643961353338303562223b733a33323a223362343236643663356664626330363664626336356136656138336436663332223b733a33323a223730306433393265656465386337393735353665626134623266306364393934223b733a33323a223061623337646364336231333030376335643366653965336637323964373262223b733a33323a223063623966393835316536653434636437353434313164633538363762363661223b733a33323a223261616635326565643664643430326566666430336666396137643564306636223b733a33323a223231363166666438656633306336663937663331343230666534333938376238223b733a33323a226462343933313738663566666665386464333337353063383036393639346262223b733a33323a226539323139663630323930343330663665326132393161343764393531323638223b733a33323a226633396566643433663965363164643466623334643333316264363232616331223b733a33323a223064643362316636313136626136663330343237646330663561313561343063223b733a33323a223761356464393830326632663934356135326161366239376562616138386333223b733a33323a226235303736333166303531376163623061656531633839313335366166346535223b733a33323a223163353132633536363833656266663565653766393763313237373333363334223b733a33323a223366306533393461333565336362323939363833366463343633613861346232223b733a33323a226463333735616530653530356431353837353965393237633637383565373663223b733a33323a223662383330613531643664646364383861333239373434353637386166623036223b733a33323a226664336463393063656163386130633734653433323766643762386638386439223b733a33323a223238613161666531646237653962636636613433333032343661323666666336223b733a33323a226532303237326536303263633462313833323937313262383337613539656536223b733a33323a223063336363323934316631643666333337343238653261303630643466336330223b733a33323a223064383531666137366532613362316138333539636264346531393734636463223b733a33323a226161346330636538386263393665323633326163333462626662383131396435223b733a33323a223033336263646264333035656535343065633132303438633033646537663765223b733a33323a223731626539313233646562313663353633633761366637616363623936383338223b733a33323a226435396635643230326537393566643738376534373434336433356231666130223b733a33323a223235353134346264333635666531626133663634373966376636316434306336223b733a33323a226639343536363461303063633464373362386239666666333565323531653261223b733a33323a226163323535343334383034303130623133653463613830666435633331613436223b733a33323a226464373862343537396237356566366139373931373133346162323434373135223b733a33323a223233373337633731656533663463383139653936363730343435653837383461223b733a33323a223862643430353039613533336666633130663337313133343363633838663235223b733a33323a223862343836356363616134393730616330333932393263663461616365316238223b733a33323a223264666537313866356562376138616434616332666630386637393035363537223b733a33323a226134323461393566653866623262643561633837313737346639643965303239223b733a33323a223730613562303433623338373762393038663761646665326433643238323130223b733a33323a226238646632343337623637323837303835356634326665316131666638366431223b733a33323a226536396131333434373239613032643463663764623361363530376531386632223b733a33323a223139303637313433313235336432343339353537636363373436363930343461223b733a33323a223934666565666331663964333936393362396239666665646364656637343761223b733a33323a223731613633666639313962376565306431326465323630386439326165663833223b733a33323a226238393635666233336263373337306462383036323266663634353532363735223b733a33323a223464643365316361313231303836626332333864333465636131643839643261223b733a33323a223766356131366333333139643634653138626566383066306163333530306165223b733a33323a223534653734306237353839333634396263376664393463626333636539653063223b733a33323a223763313036313435333030663831613133363632333333353535663663313430223b733a33323a226337333136653435613637616530393362356638356264323264343933643333223b733a33323a226430363037373761623434313864396637396338623463646366656634653235223b733a33323a223430396636396338373631653165303665376533666634346135316633383262223b733a33323a226564323531313230666266616662346161383166643734373562393239383832223b733a33323a226536613333343436616436316538383061376361643837633736323634373566223b733a33323a223166326461373461326438303731623336626538346432643139666630336231223b733a33323a226465383165613438386463633139626337346431396463623137363964363566223b733a33323a223562323736643731643731373034663162376232376436316432363661643863223b733a33323a226436323563646233336363393161356137313839353532333333383531386166223b733a33323a226537656365623538363831376364626630666461633561373162326462646636223b733a33323a226435393934663635306134633565636366366264303065616263626134363766223b733a33323a223932613238356439343339363464323436346266343066303464306563343763223b733a33323a223433303961353834383436313465343136663237623665323334666463653161223b733a33323a223265323665623563383433366364313266623634396431666433373131356533223b733a33323a223661376532623166306433323432313037653435393365393761313937343335223b733a33323a223836613763626339656438656134633634663039613034313336633437366666223b733a33323a226335373031336330373231343532646437373534303534643035316334326264223b733a33323a223561346130343833616131653636383537353761623965656130613465643836223b733a33323a223366373530666437336365656337383936366231643731386265613963383833223b733a33323a226661363732376263383765386434633233386330303635653836656235626632223b733a33323a223834333836333630393533323231356235666138643135376432313965303665223b733a33323a223862353261626232366262323435303261383834353938303631376530383666223b733a33323a223635393965373633356530313531626633653336356337303635373063663566223b733a33323a223632393031313734386135343066306131616439316633636363613862626636223b733a33323a223239626161393636643939386134623130613433356531626162383830376465223b733a33323a223763396135363634643766626639383364376538373833663635333664643263223b733a33323a223938353663306130633933646330306465303061306466353038313531633130223b733a33323a223034643439623462656662333431373738363830656136393431623437663233223b733a33323a226463663337663663663533313733363133333735343238373061646334646439223b733a33323a226230343065316335663535316338316134303934363332323761343065623435223b733a33323a223534333033613364303537623965336537646334626364323635393031323532223b733a33323a223964363831373631666262636364626337623363316237633164306162663036223b733a33323a223031616364373866616663393962663435666138656236666538353066616231223b733a33323a226131666664623661636237383766666361333564313031393332353533353136223b733a33323a223533626430343364613361643631616537656365626537333031383431353238223b733a33323a223434306438353338333637623664373162363136323963353962373537346665223b733a33323a226230653235646339633562666333353738376463613630383865343561653331223b733a33323a223139396163323162393130656339663961316461616463386534626365353566223b733a33323a226331323436623262666566643364303330623365643538636133646431613465223b733a33323a226666663237386262663930343265303634303633646561306435396133613830223b733a33323a223130363036393331303565633131356132623533303264353062353335336665223b733a33323a223564613131633761373837363862353764373635376138346634653539653237223b733a33323a226664383465323137626330383131333239366561633735326433323164396465223b733a33323a223931373738393931386439333261646162363465623464633737363230376438223b733a33323a226364353236333162643162626362326262323538626135373663306162663436223b733a33323a223066376338313136356434633438653963306139343335653434323939343835223b733a33323a226435616430386165373237306430653633393833393465333666393632383336223b733a33323a226537336238376539333630633736663437643633313439343831306562386661223b733a33323a223634356236363833376335313936663238386262373566343039303630393664223b733a33323a226239323630303136653935303964356430376131623339633566343663636366223b733a33323a226136353337303039643139343137646362316539393064376532623831646134223b733a33323a226231316566366563646363343137633237646462656264316633383465656533223b733a33323a223238313034343930383161363662633830363038343335666266303939393933223b733a33323a223335663734366539666562636266646633366339343631613163346239373636223b733a33323a223333616661323931303438303963356166653765393861386331633539636536223b733a33323a226337633136636630326231393139366263303364316330363664633437336638223b733a33323a226263636632623933383937623065346230303162343361323838343136313039223b733a33323a226230643832313036353336616230376263373733376439633531373830656561223b733a33323a226435316361343935363762613864326663653036633361343538343162653063223b733a33323a223930663138646566323237333631343334626263363837313664306536636265223b733a33323a223834626161626135303232653964636533333363626461383331616665333537223b733a33323a226164663663373932363163343364363430336665666239383034383238363033223b733a33323a223437326331343337383432393631356331613336376439613235313565623531223b733a33323a226134323036373939613538303963366430313362643733646662663732333936223b733a33323a223261613963336535303137633963333038373736616235373333373434383235223b733a33323a223337323837653633663634623134616339653139363365306632376235383434223b733a33323a223165353463393936373632363565373663396231326632343365376164626139223b733a33323a223961393561613566666365393231313231366432313566316439303239666231223b733a33323a226530336433373563353435313633356635366430323035313137303937316336223b733a33323a223133336232383239633837356537386435343335353666393532373236656530223b733a33323a226635653734383730346565633766383565353662316134323464316465343865223b733a33323a226531323137383065616361393430656633626534393739643363356533343532223b733a33323a223339623632316630663731323437346663656562336364346639636464643965223b733a33323a223366356234393235313964306538373737356361633162623466333665333832223b733a33323a223631336566306562613664316337636332336637616532386637656562393934223b733a33323a223730663731616661386566613766616531633965376130393736386131343730223b733a33323a223931333837666136653934656363383130386439333333663331303837313265223b733a33323a226137313238343662326237386635643764623132333236306537666563663533223b733a33323a223831356363666339643338656262333639653265336531356439666162333765223b733a33323a223931643436626263626166613864343732363361306463306635313037663039223b733a33323a223466306638313832373662623435633338396131373432316538303438363136223b733a33323a226161376636643238663466626566383034356133376662313331633836366634223b733a33323a226165326233623736373335343863626562333961323735663761326464666434223b733a33323a223537353333353363363835366430393135663734323035306438613339663066223b733a33323a223962663533333637633831393135653861383061636432633731633131363861223b733a33323a226436383039316530633466333539653731666463663063313132353433336163223b733a33323a223737326634356262363231623133383166313765366439383438623230366137223b733a33323a223761343635303036376533626638656166633934346665626362356630323837223b733a33323a223731373731343165323036383465396661633332663461643336363030333239223b733a33323a223234623330313362373063363163333239653932616635383361333835313033223b733a33323a223165383461613130376162613865346434623337363936303433313436653165223b733a33323a223336346565333839626662626336313239643932326162326664313561396265223b733a33323a226334633636386438396235343334363434363130653663363866373764653732223b733a33323a226330653164653261656363316365646561396132646439346438303039333337223b733a33323a223766303662333435636336623533383233313738326134313162386437396631223b733a33323a223761613461383966663465356638356362373265633262626537666464646661223b733a33323a226136313062386433346132316164303662386165363564643866393762363032223b733a33323a223739313637376534333237306130653238323339383963396338666364663435223b733a33323a223534313538373961356332386531633561323539356430306631353231653333223b733a33323a223065366266323566633264376137626366343630363765326630666238393564223b733a33323a226166373939363039666664626263653036626638353539626630373966323832223b733a33323a223764363831316462376236326337393336636166663563333065643561323535223b733a33323a223266373536303564333061306438623235633861633264383037383961613334223b733a33323a226431623762613032616263353231616463353164313566653732626565613537223b733a33323a223639303034363763333335316131393139326339613231326130616561373661223b733a33323a223366303536313963373964653736303761323334636230303732623234363433223b733a33323a226263633733623536326535623330393736343762663730306166373235363463223b733a33323a223165653961353563383065353136616533373765396138343561343633376630223b733a33323a226533393935633366643662633232623664323764306430653466393836623962223b733a33323a223138366539663037373738313366626237376233633730373535366164666363223b733a33323a226166393431633664373132633239666635336165663337623838313565383162223b733a33323a223963666366386138346364346631616634333165623961323837626562393332223b733a33323a226266343932333364633737333735376133666163613566346266656330323631223b733a33323a226530666363353064363561396465376231386264616331383066356235346632223b733a33323a223636656434396265396637623165313764383532336533313564643338363064223b733a33323a223663366266313030643063303132666361363830353865663130636131363462223b733a33323a223064336465353830393437373564376137313831313138343135386237383430223b733a33323a223239333364363631393538346136323763633664653062343364303034396538223b733a33323a226533373864653435633832666334633633373234376236613938303463616133223b733a33323a223134383437363865663964613439323737303639376161323264643339623638223b733a33323a226630643131346564383636343564393435393735653930316136616263626636223b733a33323a226662373534336432633765643666333464656464333961626265376135623139223b733a33323a223636343436373639333136353130623161613737383862303934636464386537223b733a33323a226335653737313237643366393134346265313037383037373134396238303933223b733a33323a226561663431333030646533356435313435323630353235363464383138306166223b733a33323a226630343836353630363537626334616538336465313965353638353864616137223b733a33323a223862613161623339386265346233316133646661636161613166303066396661223b733a33323a223232663736353130316164313164636262386164386266633862623433353361223b733a33323a223030633932613662363762356662653666336265643662306637383438303066223b733a33323a226536306261623161616432633639376537663330333934353338366364343434223b733a33323a226565663031666434666564633932316662633366373239356337366134323733223b733a33323a223437633032396632313132386637393734343939663937356231613261353362223b733a33323a226434323334303861363663323231623334646163626538383464656461616265223b733a33323a223736383966343966383330343732303033336630353931383136633963346462223b733a33323a226434376635396136353061356564353335646634313832646439346339663139223b733a33323a223133323362626338303962666431343566613334393438396434346339663833223b733a33323a223461636666313965393530336135313939623238653332306366626338643662223b733a33323a223133383735373865393263356237396335303530356337663830313261363063223b733a33323a223262623364656534616536363436653539373534336366393133613163313337223b733a33323a226661633933313835363833616233613839306566343666636362346232353162223b733a33323a223462386461313266353834323933386461643466373061636231333935626232223b733a33323a223035656665303936356164303961316266666661373139656538353966333961223b733a33323a226136303662343066363334393634383433306536356437313561363132313635223b733a33323a223739366366633230356536363038353665653866353163303837346637383965223b733a33323a226536633765613061333030666338663862363839373863356134636236366561223b733a33323a223861633263626565633638313439663461303638663435323130346638313631223b733a33323a226366356266633933666239353630653231626632376633313763316662336531223b733a33323a226161636636666239393638333531366539613661333431336661313130653538223b733a33323a226663356666356466306266376564623231613236613536323162643830336461223b733a33323a226635393531343861343565643734663333313966396361646463323638666438223b733a33323a226532653130626436333864386339616261333762303030333136643262373033223b733a33323a223564343839663866373330616531653063633964386635303263653132393263223b733a33323a226634343336386137383563653633636234323561343831336265356231356636223b733a33323a226362336430646335636639326261323766653839396262323536316464633865223b733a33323a226264346334656438656662353763323430623236313930623735346332303866223b733a33323a226533666366656237663933633230386564636336313934313264653366646431223b733a33323a226365376263333335363338393732356331313436633636376465653733646162223b733a33323a226436316330646663396162643263343165633065356564313166363930643165223b733a33323a223262623039303636306335613037363562373465616163333338626230323861223b733a33323a223463366133386134623137336432306263353336306562396432616465656364223b733a33323a223663616163333038653761613861653964326134386565313461626630636639223b733a33323a226565333861393831666139353335333265616461616431666634356335343564223b733a33323a223461633931616239373631366438646636313138303938653439356263346337223b733a33323a223438343239643638643738663434303965366235386134343331633665666262223b733a33323a226233616531326236306435336438613933653163383164366564643631636131223b733a33323a226264323838393265343636313563326437663636616334373833316335613731223b733a33323a223335666233383062383233303131373738396230396433623839316339623031223b733a33323a226663346537323961366438323231326231396566363037356433646535323665223b733a33323a226237373965303037393034383565393637353338383238383964386235366664223b733a33323a223761336537323361396633623237366530373233313134623239633033353332223b733a33323a223135613138303763666665313531383962636665333462613565353761396132223b733a33323a226666363138316135356134376232333931303763373633393466383935663836223b733a33323a226239353733613631663435666165346334353066373139336339346438373266223b733a33323a223634306464326135396535616238613234303335623031386135663636636561223b733a33323a223562636163316363396332393132623338646439303034616165393730633064223b733a33323a226331626636643238306362343033363536663665656632363836373765313733223b733a33323a223564393562353932663735653736613061383834396338653032626637343137223b733a33323a223063653432383765346133643833663531343965613635326138376431663834223b733a33323a223061336462333761303963653237333663333039613939383065613762666336223b733a33323a223361333862633761343033643838336539636165306466626262383838303737223b733a33323a223633633032303033376235653530373334316362393236626231303833303933223b733a33323a223131376464356234633563616466653636643965633738346339333532643064223b733a33323a223331303035616230343535656332646633383861633735353139396463366233223b733a33323a223431383161363237306534633038313662613964363236396538363964333039223b733a33323a226666303564316239623433626162313436626433336237646530313138393434223b733a33323a226465393339336265373163633366386433323239366365353563653836623434223b733a33323a223435303933366665663263666664313730306530326266363635383130313730223b733a33323a223335323437666435656337333930626237356235313838313634623637653362223b733a33323a223561353531616266383762613032633235366237326633393166373439626465223b733a33323a226137636162643634626633383531633239633762336265633136393731313431223b733a33323a226330366633646531333032376431313463353465613364636138656233636137223b733a33323a226364666234643433636365326161613666323730383931313335303030616433223b733a33323a223637653765633262366363323135393032373835633466646165343236366234223b733a33323a223535333764623931326661316438373634363863336161353738333766343263223b733a33323a223138633764323938663539666366396337656164383061373763663264643131223b733a33323a223265656533666230333162353163316363626264303861333035393335356365223b733a33323a223232633062383836646135626433373631313436653134323139343766636264223b733a33323a223931643331306539613731636561333732383433326237333465363737393030223b733a33323a226431633430653565356535613630396462393432633731343961633464303538223b733a33323a226231643862653239393537376333333862383334646533333664313566366233223b733a33323a226461663061623231653065383635643563633162373963616365326661313739223b733a33323a226366623035653832656632343963626665333232653461663335393635623538223b733a33323a226165356461393531336131383235336530666162653539353839396330613761223b733a33323a223636633964393132343066326438353534316464326664333266383134626235223b733a33323a226236633962396333336230356230313831303633326132353135616561353535223b733a33323a223034303365623730386438306364633336373133373932313937646164313233223b733a33323a226337626332356433346430666163363163643735643630633832396665333230223b733a33323a223031376664653636396133633837633038353834613635626365393839646662223b733a33323a223138366131323562643536393237613136616539326564393262356634376261223b733a33323a226130386462636633326231626332333939333463643932346430393462376537223b733a33323a226664643563356264656333396234633639363737333930313363353932623866223b733a33323a223636376566326237643030616233636539633766633432623663666231313633223b733a33323a226137303965646531636463666535666436663238316533613836303930386264223b733a33323a226539316662633434636132346530366364343765326136333533353331316235223b733a33323a223132663838383339646132636633623337303139613937343065663635663963223b733a33323a223265373335623965343536343062383839656234313364613039643165316261223b733a33323a223962343237663935323163343434626539386362366232343134363065616531223b733a33323a226163333239643936376338653833396330306237386164333637356537346564223b733a33323a226165356236623162353263613937623332643332313836623763623235383432223b733a33323a223834643265376237363430323938373338326137663831353138653037353736223b733a33323a223731306462333464366264386238383739363333656365373762373531333730223b733a33323a223436633835623935373064656339373063316632663333303861363664343932223b733a33323a226165306131623330393162636233666338313530653163393435343733653734223b733a33323a223830636330396339386635636134386635316364306330613130636637326534223b733a33323a223731613239656361623539633231653136333732653061356337313838616333223b733a33323a226331356130346634373762363431623337626662316462633035363032386631223b733a33323a223262616633313831313338363235396132633536356431356236393861643339223b733a33323a223234346137383735393663666534383563613735663731346335353733316536223b733a33323a226366623236643930376665386338663166316263613535666138323962313635223b733a33323a223134636431356666643035633139353436646566333161333663333765363934223b733a33323a226236663064653835643832343437333563393466643665376563386139346235223b733a33323a223939356264316338353934613364313938633366353461316663353131313439223b733a33323a223064633163633764666430333539383364303565326231353838633535343262223b733a33323a226638353762623133656561663433303662666634613764616237663430393366223b733a33323a226332626433646166303435643737616131333638333034393635323130383532223b733a33323a223238366663626661343734613233663232363361323661666639323366666539223b733a33323a226537653363653563323431363131613036313331633262386561316666363739223b733a33323a223363653631333161666631303638616535316361366362386636333030356636223b733a33323a226538656234386466316665313466363034366232376365353565336532343638223b733a33323a226365353535646134386164643238626166313365386162323236636436613762223b733a33323a226537386534663338323133626164393763323162633836633530613163383762223b733a33323a223363356231373064343666326131326336653037636165303136323330393066223b733a33323a223432366537363531366234396532316436646364336430366530623038356430223b733a33323a223762363130613531366365306630613665626438643037313562316238626333223b733a33323a223963613361633733356533323234666264623136326635646333343866663630223b733a33323a223462643030396134376631346364643137313163346531363462326536336234223b733a33323a223962623661633964346633303935613564613633633332356166666433396463223b733a33323a223430633137396436343162616536666332633737623431333465666261326437223b733a33323a223533653139623134333165386436316232666130653039343864346133643436223b733a33323a223234396363656232356461366431303463333165613066316531376264383938223b733a33323a223837646339396431663039323066336134633235353762613130623631353536223b733a33323a226631326439326133366235613362323638373461333333636434336535326432223b733a33323a223031313563656431613138366366306164383034373039386635353564643464223b733a33323a223763303134326531336533333063363365653339626264323263353233306637223b733a33323a223037316434646465343636383630656434303939323262393338626534656338223b733a33323a223932353666346439613466373438613866653462643236633963626330393933223b733a33323a223564616563303339353931366431356665373230326534653466306430356463223b733a33323a226461636632636235363836393630353931663161373162383139646236303135223b733a33323a226536626332366630373434616238343538376630343238623235616263386238223b733a33323a226432313663343761613736666334333532323133353930623661393133356436223b733a33323a223566306166633036303664373930343164613934326138323938353562613763223b733a33323a223762626465363166396533306665393036323137373934653763323232643164223b733a33323a223865373636303231346664633162356563323266333830313363613533333435223b733a33323a223864363136383564303637666433386131643166623163376566633235326461223b733a33323a226230643239656266346464656234313731373037663430353861663635666366223b733a33323a226163633833633937323338653439616163666631336435313335376536313362223b733a33323a223335373365393066323464303165313061666132316562396638386164343561223b733a33323a226334336436633261336438623462303661656661363835313831646331323339223b733a33323a223965346465396334616133623531333035653963643138356236316162323765223b733a33323a223863626339393736316235343939323634383563333830666465393362366661223b733a33323a223665646338316134393530376564663761356234663730633938663130353636223b733a33323a226561323066336261396437356533333634616261353435333462326466356239223b733a33323a223534653130346262353930386131363165373565353366393932653030313934223b733a33323a226632396664393964366438663930623736353066633437393635643063653566223b733a33323a226538353137303731376535346261356338643438326366633762336465313865223b733a33323a223431323433633334353233303839633036633634326233616532633364323931223b733a33323a223130316266313431316661393431363430383733623464306236303435623961223b733a33323a223237643336623832363936306531666137353436343732383265363863393730223b733a33323a223464656336353866613161613366393362396134313031313137626637326137223b733a33323a223430313632373765666362333562316165663132343239663136353632396333223b733a33323a223830373763326564323938373161643338323363363134383138666133383161223b733a33323a223961336638393134356438643163303763393533383338336663656563356663223b733a33323a223565393733626663356234323361663931333963643765326361306566373464223b733a33323a223465653765633730303261306331326564626165313538613431636266306261223b733a33323a223632303534323336373137313962326263383035643838353634353638326264223b733a33323a226263373830393838653966643931633336663161323338646534656237626536223b733a33323a226362393861356335396539396262626537306132656335316661363564316639223b733a33323a223663386136643035663037653939303733663334663566613436343634376261223b733a33323a223231323832353864323736333938313637393066306663386631393263666134223b733a33323a226638656361303832626530383734643865396661386339316530343262653063223b733a33323a223235316337313661353861376639333935366631633262646237356334383932223b733a33323a226361633137653465643330353863356437393163373263653131316562383331223b733a33323a223130636636623132306166376431326161313434316437663633613061346362223b733a33323a223932316236383666656462306234633633343133663430366264373633316661223b733a33323a223930356330653733623961623736396131383230626432343438633237656237223b733a33323a223237316438303933356234633534313665353934363536633466666634643363223b733a33323a223138393764356235346261386434363162663561653438353732646365623465223b733a33323a223664363666396130353639633265623636386131373661386561386536323337223b733a33323a226339386663316335376134366630623734373261343561323535616437396631223b733a33323a223532323965373534626432356365343265393435613836623138636133646639223b733a33323a223262613461383336373835353437373035336139333834393534646464306230223b733a33323a226235333264333933653638656531333366653965353332306638336561343739223b733a33323a226333616466663666383363333239386339313534376566393762386639393234223b733a33323a226338336535643837373166653766613539333136303766333535333339313431223b733a33323a223863616433306566333934643831623263396430396637393764633364326162223b733a33323a223235303236323931616630653932346639393164653234643966396165383965223b733a33323a223831656330363561333866323761333134383232386438643439313865363536223b733a33323a226262393835653337383835303930333966373863383061636336613932363536223b733a33323a223934373039343230613532333032616537643062626466333066616665313832223b733a33323a223761656566316430346131333166643839303831646632623466333136333361223b733a33323a223565316563366562333264323865616130343335323430623033386130313936223b733a33323a223332626330363933366133316336393763323434396664363637386634633138223b733a33323a223036636334366665636136393635646162663433346337653765336334633833223b733a33323a226339343539663538653030633461366535346364616436633733303262653636223b733a33323a226332643164303637336464376430373838376135666266646261373563363731223b733a33323a223764356438353263616265356463633731326636663766363861316662363664223b733a33323a226634366336633334353037646234363235666532363836643836653132313639223b733a33323a223536343663653036663834303230656232636566623964643163383362303335223b733a33323a226464636138353863356466386135613139626664306338656636643931393836223b733a33323a226266303661653436616161613163643162623865343632363031346139346430223b733a33323a226635303262353735323935383432636234316266303837613435333634323635223b733a33323a223135356561313837623937313430386238363964376265323163643866383137223b733a33323a226236633161316662323165383261373266633833313338666538366639663163223b733a33323a223066623662643066316638316130393430626631343462333037386261643332223b733a33323a226638646133316261366239626236623330363039623165393432333962653561223b733a33323a226435323939383366613237653761663738333861616562633236656539343831223b733a33323a226437343631623932363431343430643636663236303833316633613436396635223b733a33323a223131363031616262303263353235396335336562656138383131633836323435223b733a33323a223932636362313732356266616366303833353836306561626462326235306666223b733a33323a226364333265386138356335363933363961636135353732633365356532643765223b733a33323a223932353761613564616565376536643064306435303231383034303032306130223b733a33323a226632363637316332326161373032353030373733356133666639643132306132223b733a33323a226436336330333465386361313333613466636434343836653337306666343137223b733a33323a226264636338363536643761656565643563643335633635636161306566663638223b733a33323a223134376561386662393730366434646533396538623031616664383837343962223b733a33323a226366653536343433353139323435313466646563333737366434646236643063223b733a33323a226132646335663831363661646464316435356262656632396562363435363031223b733a33323a223337363262303535643466356539306632363030373234626466323766363731223b733a33323a223665643339366361653136336337666534303736653964306561656330323163223b733a33323a223438626261363865656437333662306261383762393362626561316563323365223b733a33323a226139646264393138666161306434313765613062646365376261646433353232223b733a33323a223331373163393339326439636364303533383233303934323535343930323561223b733a33323a223835363762356464386432333962346538663231623432343838366264353766223b733a33323a223961373133323361353863363838393330313938633661383264326235656536223b733a33323a223730666136353966646661376461306431666539643030633939656364353930223b733a33323a223337313938646663633163653961353232373037353730636264323032643138223b733a33323a226532363338646530376535613436656265313030626531383761333230333738223b733a33323a226261396466383935376266336563356130333239343935363165323333663533223b733a33323a226162633138663032646133663734336434343235666235653962306332386334223b733a33323a226463346638376230383035383138323462616435316137323637616166336238223b733a33323a223638376235663438653137633931363764313463303130653364303063346163223b733a33323a223639666535356133623162316530633766633834373635353535303365636566223b733a33323a223133626135316135396431333834363135666132396361653864396239303831223b733a33323a226261383666343834393135323465643666616363306131343631383431303533223b733a33323a223566626161656333613937323062313461656137386436326535386133323931223b733a33323a226363653661303939353262646231633766336239376563333636353436633130223b733a33323a223664363331303035373036396365623532653661626463326131323065343137223b733a33323a223739343764643563393635646333393562626531653561333465643364383433223b733a33323a223530663434396534373834386232383863323765333534353561626561623362223b733a33323a223732373735363032393766383534303533316332663564633432323036613838223b733a33323a223263666266333737326131656537326364373534383633323063633733373962223b733a33323a226434623562343136396637396632373561356130643135323038653433623031223b733a33323a226236356233363466393863613932373164656531663230383434316439313135223b733a33323a226130313462356436353366613064643565623962613464333663383330386237223b733a33323a226463356466613066316232303464383962643639323138383238376263633131223b733a33323a226366643330363632303139343934353562356334346364353365346534346637223b733a33323a223830653230363861346663363736366364656461613130663738363832353162223b733a33323a226530306562643332623437333035373162616535366437396134306363373532223b733a33323a223537353864643763633631376161633136306364626463326438663434613331223b733a33323a223037396137353830306432313436656537636165373662393264363033643634223b733a33323a226432393036613136353136346139356563376432643766313038633833316461223b733a33323a223963633265326339346433616230313831386133616536346535656137373831223b733a33323a226332623136633138346234343166386636346437393036366466303335646161223b733a33323a226539653231396330376539623631323838396132343832393632303934656333223b733a33323a223234643435303335643139616533653231626334383061626334323634663831223b733a33323a223238306662376136613136316564303465626631623162346462396663313235223b733a33323a226666393166613338663634663830653237666165343632393266363839646132223b733a33323a223564373261653331366638653836663061373635613732656163323363623530223b733a33323a226535643935646539383362373935666236393664353366376165613839333731223b733a33323a223136393365383430383065316662376638333662616235323064613439653932223b733a33323a226532616437323332313065393434343230363163366662373934323864323965223b733a33323a223366346434663664623132356165386165376132353836386638333064343930223b733a33323a223066653238626433393361356232666334663961333731316539666334396363223b733a33323a223633393965306439356435386130323835613730643430646561313932633863223b733a33323a226666396433643530353362343661393431663765626238666662303965623131223b733a33323a223963356233333138396466376234643131386333363565373466316139623062223b733a33323a226663333936383466633939303164663330366265656437613532336635383339223b733a33323a223765376464336637386339336332663564323764656262343661646662303664223b733a33323a223737343263656330303333383361633937393533396639653461383034363030223b733a33323a223735356563613739376435363231353838386132386665646461623263303638223b733a33323a223237346537613333383164313231633739343763353663353261616635663432223b733a33323a226239303234303363653935326238363763383539656633653664643334646339223b733a33323a226232346533643564373461393333393361633431393736663134366136396364223b733a33323a226266376232363634663335396338656362613562383938306164613534363339223b733a33323a223761663033376237306134373961383334386466653630356536633238306463223b733a33323a223939306165343966613131653061343362326531636630393530336663376264223b733a33323a226137323034376330393432616463373962353364616633346139383435346134223b733a33323a223137643433366339393861666464313037323237623666613639323066653938223b733a33323a226464366633383435333139353063643830356464356233313930316662653333223b733a33323a223038313238643432363731613063343930356136663139353863393061616665223b733a33323a223938613034383665343737343366393132373334383465323034343632396538223b733a33323a226437373131626538636130373031346665353164303964336133646532646465223b733a33323a226566396362663631613636616465373837653065333037633231623138336561223b733a33323a226631646133633937316166336637323662656532313237376333346665366435223b733a33323a223865643464663539663139313833313064353265366234616465373334643662223b733a33323a223333336464346366663839616363643835336364386230373137343736316333223b733a33323a223531333530663265653331646266316566626563666166643835353734363766223b733a33323a223038663637363561346638643862653330626330303734396463363862366532223b733a33323a226266323566636630633330363034656462323433633334356332613238353261223b733a33323a223731376532353363356262383065386336366237366562353038313736656134223b733a33323a226464373665386139306564353830313734373635653831636530336537633138223b733a33323a226466353161623934663165656663313636363535386532376135346663326164223b733a33323a223531386562376232373735313932373065623862646134363831623066353734223b733a33323a226639656633376135636165316538353261393063613539316335333466303934223b733a33323a223136306137346661303034373864323161343438643966383030643265393132223b733a33323a226163616165646166633432386435323333386232613132383236333061626163223b733a33323a226365383666623631313837303336393163316136353132326634653565623732223b733a33323a226132343834653964336535366265323537333632396562663630616638393030223b733a33323a226431343035396436343631643738363061353366316462386538353562626534223b733a33323a223466616637326336393332303538386363623533373739643933623761313130223b733a33323a223633336430376534336564333566653939613236313730383239343431303766223b733a33323a226234396463316131633436653863313761366637303962643730326330343764223b733a33323a223233373634653762333231306434303433333763323965303166333736346134223b733a33323a223864303532326232313533623635613533643534373636303833636337386235223b733a33323a223866393633393934636635626263303235343539616237343633316335323561223b733a33323a226266393237623434346261323831396336653066356165346439333235396235223b733a33323a226632623065383432613262306337326637643964343136646136353639656233223b733a33323a223334643664323366363865306564353838636639323836353337623633626636223b733a33323a223566656266313637373637373065306238626366313561303164316566646461223b733a33323a226665653836346334306361316261633764373931326361363664383965626566223b733a33323a223166303361366335303065646139666438636261313963323766306434353633223b733a33323a226462623139626437653166636435386330653231396333653635353765373637223b733a33323a223831303231366135643130623934616237356462663465643332323163343833223b733a33323a223837306465373435666565393431613964323636656361356330336638626365223b733a33323a223361636334363433316362376230366137346330386566363930303861633939223b733a33323a223638313435663438303235623633613434333963376438383530323235653961223b733a33323a223463666361313335666639353233396366323666366363303334363832396337223b733a33323a223461366637316363306462343733313237326239313933383864313639663539223b733a33323a223737386432386464643565626136396534306262353066666133336363336636223b733a33323a226432613263396432353566653034313165626237666438666363323739383164223b733a33323a226262303136373732613532633964616437653135313436396466323139666239223b733a33323a223062636130316430633930333461666636353336313530333237666132666439223b733a33323a223661653330316163663636326363303861363965383161656562326330306361223b733a33323a223830623736363332363239383639313834656138326565313661353137636464223b733a33323a226161386637373032386163613263383436386364663835616266653538393630223b733a33323a226161343835313933333262303663643038313936373365346661303138353666223b733a33323a223338373762383661303538313730366166386135633466623666303964616431223b733a33323a223530653438376661663965316335646639386239363863343062316133303533223b733a33323a223930333334623733656435396662333633396531383734653138623234333331223b733a33323a223530343731626136623764323562636532633939333034323965303434643862223b733a33323a223264646261646361303631333665613935326462666132356262393733383162223b733a33323a223362316435333235313839646331663137303265396365353562636438313139223b733a33323a223939386562626239336161303735393731643738343031356566316530653937223b733a33323a223465353539653532663134646563313635303433653861633261626631353061223b733a33323a223865313931393530616435306332343837333861666138333963333262333834223b733a33323a223037636463633537656333666434336663613666383161306338663262343563223b733a33323a223431366534373439336566623032386438616435373565333437373562346431223b733a33323a226562626366636666666363663533326533613936616139346663316261393035223b733a33323a223065343561663535336364373162393538346437393238653134623534373236223b733a33323a223661333732306332646564666432343964623732343261353735623061386663223b733a33323a223865356364653837303034326561393936323238643866383037633433393033223b733a33323a223063663132393133633265326630386234316235626235366563343536616434223b733a33323a223733396332663865386339616665643363383165313232633836656536353864223b733a33323a223738353239383935663236363037336337363336306332316362373831666238223b733a33323a223531663735356464346230653665343538303439656538353036666532386264223b733a33323a226433316332613637303831363566623732383363303162343966616137303636223b733a33323a226133623966643831383333336637666439303835383030656262333765623361223b733a33323a226133376135373966616436396234333539343834343564356665616233643439223b733a33323a223661383139633730616131623366626165353663386635386561393033646665223b733a33323a223738343533363838336365613764623438306331333633316530363335346634223b733a33323a226232643237646130323562626638373664646539336166633431363163383930223b733a33323a223630363530643261656561643731663562313038333537343664356236346165223b733a33323a226438373034376563636630653866353238633834663231306134356531356663223b733a33323a223163313437373235383764396536343136333263646630623538323234306366223b733a33323a223439643930383133633465306131356664666465643361303461363333383262223b733a33323a223430623932646166373961616166313232363738616331623665656366623639223b733a33323a223835656232383533356230343031656335373933376336316631646431613936223b733a33323a223164613665353063633466363662666436363965303433386666396136393531223b733a33323a226338653364393831376637353139353761363831636163303233353133636330223b733a33323a226636636437386465356134633030346237343232663931626235663261323432223b733a33323a226366363934626134363235636438663262343365363637636264386564333163223b733a33323a226639666462363661393639386431353934353861306336396363303463313130223b733a33323a226166376162303966636634643937313563653432393866353166353230313933223b733a33323a226434656230653762363664336535346162343631376563613738643363656362223b733a33323a223133623333383033666264383039363530633265303563343461396638656330223b733a33323a226133666635343732353034326263653865313362626662616165623962633933223b733a33323a223238383761623236653765343161393435343031623038383430646337616332223b733a33323a226534643232386539633932633339366164303831616631323635656532636636223b733a33323a226636353364383635636562616331333865383839363635663636623761373066223b733a33323a223230653039323066366636633063373664326462373435623633626337356130223b733a33323a223839336332643630633432646638396464336634656535306165303437376663223b733a33323a223735313133383461643333306531633363373832663365623635646135363663223b733a33323a223039393464383530393932373865376466666432336639373531363361623062223b733a33323a226337383139306634373533653463316665323262323865366630326266383565223b733a33323a223261386433356134353436633335643133333964663330333332316132333265223b733a33323a223765313661336638313630616233353862306263646665633431333262633934223b733a33323a223133613739306664383663376162626632373839386337386264373038383532223b733a33323a223939343636666464303832616338623861306164333939346338343765313230223b733a33323a226665316365666666653130613439366537323439333966626233616461643663223b733a33323a226334663736373935353733653130613838316139356363333631363736313863223b733a33323a223232616535623636663966656665666436363062356463303264666535323034223b733a33323a226636663633613936313435393561346639323333323938393366376335363637223b733a33323a223338633763383366383031663433386539623131386565613237396236396361223b733a33323a223132663931326363343262316233383964646138333132313066346237333539223b733a33323a223566353764613462316134613961366235343732613466623264356235646264223b733a33323a223730333839323336333662383762666339343936643164663636623265373333223b733a33323a226437343131326664346364333263326135656263643666613830326630353566223b733a33323a226666356335653966363331346136376538363531353033616363356235626666223b733a33323a223536396133666264643932623037323733373266616139306466643936356363223b733a33323a226466336633613863356130316539373238623663666634383436373935636637223b733a33323a223961383837353534646339396363636166303363346566623330343032323661223b733a33323a223534306464636164323034373034656461343965333763626365373534356366223b733a33323a226664646163653262356665396534316431383165343766356239653835343130223b733a33323a226363346435323530333731663635343962363665376361333365343936326537223b733a33323a226630633965653533663964376331396462636139346164663063386130616663223b733a33323a223065306362613336643635353233616166616236623435386631353462366333223b733a33323a223939383733663137646564323433633063396163336330383738383436373461223b733a33323a223935656565306561636437313665616338356638666361333462313836626136223b733a33323a226238646236623730613363633665363362373162636265613437346165336633223b7d733a343a2268617368223b733a36353a2262386462366237306133636336653633623731626362656134373461653366332d3935656565306561636437313665616338356638666361333462313836626136223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a226263316630623137353836376530666466653736393837313866633939653834223b733a33323a223431366235336566316534653835373365336231393765333938376136653638223b733a33323a223630323561646665653165376163346330323330626465613161623565356365223b733a33323a223835323334613837373037363936613261386135373831633438646337343036223b733a33323a226532313337303031653332613261656237366437656530643631343832313238223b733a33323a226538643163653961373532623035366631316439656162303361316532353466223b733a33323a226232666664346161303062303736616635663365623061636336616136333334223b733a33323a223663336164646536396130656439653563633135333564323265393334366361223b7d733a343a2268617368223b733a36353a2236633361646465363961306564396535636331353335643232653933343663612d6232666664346161303062303736616635663365623061636336616136333334223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1695284520);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('2823b48ec9149fa1693d73d2bf0757c3', 0x5f5f4c616d696e61737c613a353a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637383238323033302e3638343833313b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a226632336663356134666432393135373566353663623233333764663333653834223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637383238353433343b7d733a34373a224c616d696e61735f56616c696461746f725f437372665f73616c745f766f636162756c617279666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637383238353434373b7d733a34383a224c616d696e61735f56616c696461746f725f437372665f73616c745f637573746f6d766f636162666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637383238353631373b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226365313832376265343238623938333963393363313030626566306136646465223b733a33323a223064656135373865336266306361333331666461343231346133643731623530223b7d733a343a2268617368223b733a36353a2230646561353738653362663063613333316664613432313461336437316235302d6365313832376265343238623938333963393363313030626566306136646465223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f766f636162756c617279666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223834656561616232346233376536336338643830616136323461336465356132223b733a33323a223065336164353566656237353338356437653137343433303332633631663066223b7d733a343a2268617368223b733a36353a2230653361643535666562373533383564376531373434333033326336316630662d3834656561616232346233376536336338643830616136323461336465356132223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637573746f6d766f636162666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226339636432353936313439383762346565376233373361343564663964616639223b733a33323a226433313266373063303132336138656166366564323365636136303339393131223b7d733a343a2268617368223b733a36353a2264333132663730633031323361386561663665643233656361363033393931312d6339636432353936313439383762346565376233373361343564663964616639223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1678282030),
('3337d001991ead5a920e08e6b8c7d520', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313638373933383731362e3135303639393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223965363938646565306165303361373136663735653264613037306365633030223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313638373934313935313b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313638373934323331363b7d7d72656469726563745f75726c7c733a33313a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f6d6f64756c65223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223961313431636431613736343138356430333431353965393839333261326561223b733a33323a223633623461333535626136383533313265393537363731323265613761343235223b7d733a343a2268617368223b733a36353a2236336234613335356261363835333132653935373637313232656137613432352d3961313431636431613736343138356430333431353965393839333261326561223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a353131323a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a36303a7b733a33323a223263623232623631633634613835353432363563326462343064623931313731223b733a33323a223935643734326463376239653162323737626331623766383361653133626262223b733a33323a223439393830346433316135363831336439613736623965393738623637383864223b733a33323a226662343731303533376631346633366162643430613736323935666666366130223b733a33323a223164306566393164383162356634663161656631623134623563616138656231223b733a33323a223235386635653633636161663061616263653665396263643235396630366632223b733a33323a226134356565326564326236393263636134303962653065323839383363343831223b733a33323a223134626134376461616235613461633137613362363037623033393238666161223b733a33323a226433393931376439646561636439386534313764613932343335656164663231223b733a33323a223039623736393762313365663934393239666133326239353332303038616261223b733a33323a223566373132363763653036656532323866396337373233616263666663366637223b733a33323a223536663934323962326662393837646563653562633932306139306430613839223b733a33323a223065653962343837326439336133626365613565376639373966373766396665223b733a33323a223866313035333465353934636530303663333830336461623566316137363338223b733a33323a226234353135313666343535393637303239323764613462636530396234646363223b733a33323a223162343536666663366233646639353864356332626330393237633866323064223b733a33323a226665346134666536343161326362663462333265613431343061313635623961223b733a33323a223937623136373738333932643564356561383539313430363837353266323761223b733a33323a223637383936343331643831663362663834313330353761663738306132666432223b733a33323a226662373634383830616634636366366334356365633461323263653966326431223b733a33323a223866313665626466393038373038616231363262633765333435323236616361223b733a33323a223565626231393532383439623235383438636230343130363366626633353666223b733a33323a223934363330633966613562333830656564346166626565316539613062323736223b733a33323a226332636438393533643138646436306332383161383132396565663537353564223b733a33323a226136336634313664623031346534363033386139643662353139643266396230223b733a33323a226334386630626363633065353939346561333334633062626230343930616334223b733a33323a226439653965316661303238656335613663326630393262336661346465613738223b733a33323a223135636365346639663033646132363333346563366438663032623631356531223b733a33323a223565666566663462326265656235333130313561616337363166353233646539223b733a33323a226336663139383065363436613530616139623830396261326335653161373661223b733a33323a226131323437386435383937363432653438306665326463336263633662353263223b733a33323a223965626530313431616336306530363131666334333065343837393639363265223b733a33323a223365663636326539316337356133633766613139333661373964636436333733223b733a33323a223831616339383438313865613766643164616165343565636132633131623564223b733a33323a226338353736353730633764666133366237333238326466633062383030303135223b733a33323a226538373863326132356666653030636333306130333636653438663734393837223b733a33323a223064623632323463626634623962306461663162663862303035343035303738223b733a33323a223461303331366464363464643865303735663933393031343763643164653539223b733a33323a223735396230363638316338323766663066353966656436386634366361393336223b733a33323a223661623731326163336565363839623634303461646639653330653135656462223b733a33323a223461663765653434326534663961383361613438616533363934346633653465223b733a33323a223261323836326633636231643933356536616636386163666561646630313366223b733a33323a223035613538353361366638343664303966393236393335343835636135316231223b733a33323a223932643562316164313633646236356663373165393836356534326432623462223b733a33323a223139386264643861626264323631343832663561346265383733633264313235223b733a33323a226562633730326534333966643332363464323863643135633937393739323734223b733a33323a226536623130383664626639396262626463653737663864383062616637363130223b733a33323a223932396462663665633666633031376266393163323933343431646564646337223b733a33323a223939333634343434346438626432643538316132323638666431646166373135223b733a33323a226436363138323637643036353435316535663865396565336466643039366565223b733a33323a223733656135633330623434653963643463373961616164336265303263653738223b733a33323a226239666136626532366236663265656134386532393361306631386536633263223b733a33323a223537303234393438363033303338643337336538356133323739343430653562223b733a33323a223339633830393638636262396561663565666330613535613330333334666561223b733a33323a223134376133326632363961373638616261376134316538643731663630326365223b733a33323a226163316332616264396132663062323230333637393239646233373037613863223b733a33323a223662336335303431623337326662326432323765626132326332393233316561223b733a33323a226465323164336633616262383265373033366332666534623431376134346339223b733a33323a223436323238366530613932653733666132373033663137326362303638373064223b733a33323a223735343333653863316139323432303337303962343237613038316231643433223b733a33323a226235393763326135333034316166353130366365306664373464666563336433223b733a33323a226564663664623664323933653637333630343366373434373839333464326366223b733a33323a226164303562303038636164626231316133326662653365316233363931323036223b733a33323a223262633836373065653362386661313137653632353136306237613931303563223b733a33323a226466396563383430663665366434623133343963346532616134346138326565223b733a33323a223663616665343761376566313531356362646232306164383262303764663533223b733a33323a223536623763343365346465643938346237656636383230623035313530383734223b733a33323a223863376162356336303165616132626532393535613437616438326465313934223b733a33323a226530303331653161633331343939303063633136626461636633316164303837223b733a33323a226363353564336564663637616666653264613365666562613661386239666130223b733a33323a223733336564386563656130633836616361333436393437373736313037326263223b733a33323a226264656431646234656438383338386633393733336439303263326232373838223b733a33323a223862656530306538343735363563666339653434666232346338656566333934223b733a33323a226166636636336335393034616239613365396331343538636631316638383930223b733a33323a223662383162626632346632393965663664313561363133363062396638646561223b733a33323a223537633763326262396463313738613366643165313465386439323932653966223b733a33323a226538653963656561343635376338666239616231336566346634626530376434223b733a33323a223533313262643166356633343933363936656335303731386633633961333334223b733a33323a226530303937346333303230383664303235366339343965393635363231316433223b733a33323a226264626636393432323832633333353433323666666438616435316264333165223b733a33323a223533383939653831303538343065356538353230366130653930336232313036223b733a33323a223035663930313837666466613638656131333833353962663864396335393164223b733a33323a223333653836633538663833613230336630653165336336306137393537666334223b733a33323a223161376633363264376461646332663939396138373166353132333635306165223b733a33323a226437393864333363333335373335306263343939306333666565633039383439223b733a33323a226635346163666539633332323032323935303563343865313731386531346635223b733a33323a226463383834653937633533626363313432343530363838623632643737653539223b733a33323a223132333363666165643830376664633764373733326132313933663864383336223b733a33323a223734636538333765383832313231333565303631323934396631363237363966223b733a33323a223161663432353632336562333131633662303261633661326239373465386438223b733a33323a226433363736653063303961363936656430366130643736383934653137376135223b733a33323a223334626633386466643738343664343362303431373765346466333639636235223b733a33323a223739396131653061353863653631383836613937633734373431373037323530223b733a33323a223263363439653536393936346235663030636362353735326431323036316661223b733a33323a226164363136326464666637653339666339396634386334323166666537663439223b733a33323a223831376264626639653533653736333661623533353235623766303763316663223b733a33323a226334353262333033363763313033343230383163333466613165653639633237223b733a33323a223666333533373663323133373863366661316630353839653965386462613964223b733a33323a223630656438363535313861323030323833623935616163343665656334316464223b733a33323a226563356237633234666638623162653439643035653962313764323637336532223b733a33323a226462323739323363386632373766646538666266386465376537333237363833223b733a33323a223935393736303332613730326238643538343039663262363230636232633134223b733a33323a226335393961333465653765306663356334656466646637346132353463353563223b733a33323a223935623264316535383063633936313538373864313061326365316339353961223b733a33323a223766646533326432376664333565333164346563313735663339666436356533223b733a33323a223839323934323436333036366332343132386635303430366338323137613938223b733a33323a226535353364663763666566323464663235643539646232633830343932613630223b733a33323a223235656230616238333533343430346134383233636534323231343238313731223b733a33323a223136363635333163646563373532653065633430663637303533373364396138223b733a33323a223039363066346562316634363166646134303164653662346461323639643433223b733a33323a223337383530626562386233663038353435323065653830383761356533383365223b733a33323a223566633063363563316163333034636530336663633065313262366433323165223b733a33323a223636316334636363656463343266383062393261663061353561663234353064223b733a33323a223934666130336137666334636438386133626136336562373064353831326462223b733a33323a226230326230663733633735396636323830356137373265306263303462643032223b733a33323a226533303264313466653434383132653733376663343166326138393562656533223b733a33323a226131653161623437396463626263383934303161633762623062656362373966223b733a33323a226165663031343436326664656262633833663835383730643863343933333764223b733a33323a226439383462386630323161313839666665643963373866333539663132616636223b733a33323a226564343135653735626262613961353161376538333463623864383038333134223b7d733a343a2268617368223b733a36353a2265643431356537356262626139613531613765383334636238643830383331342d6439383462386630323161313839666665643963373866333539663132616636223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1687938716);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('56fd7c9686954d646df89a7fb4cd6865', 0x5f5f4c616d696e61737c613a31313a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637363437373138332e3235303734393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a226139643036623530383136323663326433393135343439346237643237393735223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363437393436333b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303736353b7d733a36363a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f417263686976655265706572746f72795f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303439363b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303530313b7d733a35383a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303531343b7d733a36313a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f45787472616374546578745f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303631373b7d733a36323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f46696c65536964656c6f61645f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303632323b7d733a36343a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4869646550726f706572746965735f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303633323b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303736353b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226538656630303331393438666565346531626437303963666164646333643962223b733a33323a223339373036346134396638383635626134656334353030663134636565316637223b7d733a343a2268617368223b733a36353a2233393730363461343966383836356261346563343530306631346365653166372d6538656630303331393438666565346531626437303963666164646333643962223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d72656469726563745f75726c7c4e3b4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a32383331333a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3335303a7b733a33323a223730656466366531353239353062303939353035356238363438343137643235223b733a33323a223138623865656262383364653733386139383565366632376438353634663337223b733a33323a226138333731643762616338666531373033663932623435343032326231343938223b733a33323a223131663934363964373464336639653165396665313332303465626564306165223b733a33323a223637613338333837303130343734613964353137613363663632386637663161223b733a33323a223536613236303231393332626430323030326435346235346634663533633338223b733a33323a223364356137323639306138643261323833323864316530626436633938353565223b733a33323a223064663162326130643635393739356433393366313437326365363837343432223b733a33323a223764356465333161396339323832356164373666636465643833333139643436223b733a33323a223433346365313739623732306664383331333831333233346439353465386264223b733a33323a226565376231396439376662303535393237373464656463346232623933666264223b733a33323a223662393261623861626533613131383333633566636436343638306135353664223b733a33323a223362613762643932616263623832363766316333626638323332663936656530223b733a33323a226133653337626236336637616161346430633134326636313438656535383835223b733a33323a226334363730306336353836613439326630363066623639393138633932393766223b733a33323a223261633764323032613537356666363763306434663039646334623166326365223b733a33323a226335383237363035303465613636346337383035646436396336396666653339223b733a33323a223639376334333133646262653762353765383036666631366135356139656130223b733a33323a226634356363323635626639313564353130393635656162333737623739376635223b733a33323a226133313863663539613864316133653332613563316561613634336635663439223b733a33323a226562363861663935323561386361353564636333666536363633333338613334223b733a33323a223430653838623031653130383737643938353662306135353737306630633362223b733a33323a223465316565353964373935326533616635646235333262333036376536626139223b733a33323a226362663631303965356162313532356366333464613638613937353535333539223b733a33323a223765396462653166653032656231636134653535326538366663633466643364223b733a33323a223435333637323465646261323338613130323865316138343733373235373662223b733a33323a226632306633383436353464303730313338623433383362633661303333613265223b733a33323a223137306437336531633538613437656633396664313465316239313061336533223b733a33323a226234623565373930353439343861366433383337636566346262383630613432223b733a33323a223361626330363536386436333363633034346336656135333231633965353761223b733a33323a223232653331316563643064336261393435396363646137663237353266306430223b733a33323a223434333036363733316566653034376635643464626137333231623862316163223b733a33323a223762363335623133303535633034616530306137356638366163343632663066223b733a33323a226530353835313131303738306263396335633665333832343665306465623932223b733a33323a223162366564396537376465636238613934623036366566396231376664623165223b733a33323a223462313163363439363132363337613234613537653632336632666237323536223b733a33323a223336343363646166366433396366346130303135336630666136366466643334223b733a33323a223633643663386633613539653062663061323132623031363533613638636438223b733a33323a226563323030323131356634666535616664356464333063373135653464666337223b733a33323a223139393937383733323933326461323939316262626239633331363532323866223b733a33323a226637303231643933366133333031326363633964613534353566663932336662223b733a33323a226462646634386637616133343230626539393138653537356537356435326338223b733a33323a223166626533336164643564613636623364303930346264653334653537323436223b733a33323a226530353366616434303762666364633636633866653264343031333935346266223b733a33323a226165393534336634663532313837326233383561666131623231356136663035223b733a33323a223665393866636234353165323062336435316539613461633237373862396534223b733a33323a226363343437636633343030373139623863616561643064376630336430616163223b733a33323a226438336462616339373262336139323134306339326433336333636362616265223b733a33323a223937323662666561333537663864663664393336616533643838643939653634223b733a33323a223962313832643263343833626331643331303738643564613034306262613266223b733a33323a226236393239306361376335306565303137623035363133653962386266633237223b733a33323a223739626364373938616633616539323334363439643561663862643136626264223b733a33323a226638323032633965306137373436313931393262663430373130323038616237223b733a33323a223932643336303164323938616134323236363834613739346465363736616263223b733a33323a226537393731333630303235613461386536643533316365326639353639346563223b733a33323a223639366261343332343664653866636463386530396262316164303032303732223b733a33323a223837396530633632363735386164663461363732353535323365356331356336223b733a33323a223637303566633437373038303866666462663166626539336462663631663132223b733a33323a226361313932643936643436636564376434623336626435333165373734343630223b733a33323a223339303432323439613737303265346137616461313966356563333165653837223b733a33323a223162633139663833636161356434333933363132633161343431613231366266223b733a33323a223564373230343539616638633765383665373062623836316561323762373761223b733a33323a223062633033343338653065376339336131343631373130353039646636353163223b733a33323a223332343434356261343437353232636530333730616162393436316465666232223b733a33323a223639636262666537626637663234303734336435616131386265303665623831223b733a33323a226335373039376336646663393363626636643761366435303761646233626364223b733a33323a223165613565643239353865363638326235613033363435666136653036633132223b733a33323a223332616162336566326638363935383865353738353533626336616362393264223b733a33323a223961396365393763633961373730303335663865336337386364383865323365223b733a33323a223838396663366338633434636662323535333435323062316365666331613264223b733a33323a226132626364363863333764346362346461376665613835353335646264363563223b733a33323a223330383530323639613431396636306666303336346362663133633332336235223b733a33323a223035303365326238353361323866376662363231313634353061343366393264223b733a33323a226165323033643232383430336134363532383235643832383932653261666261223b733a33323a226138306262343361616136616261383165626638383433353032366430316665223b733a33323a226531633464366266313864313561306430653136373436663734656539646536223b733a33323a223438336530643963633565623131396236653333336537356464376630613365223b733a33323a226333386263656563633934323638663062663737363836616330316333623632223b733a33323a223464353763333364376233313736383638343037616437346237383538353236223b733a33323a226161393365663231616563663437373439383035363536356334373163666139223b733a33323a226562396364633364363863386335613965383461343266396264656235363838223b733a33323a223062393638393638363230336537383537613266336463323332376366316561223b733a33323a226133393439356566653861326430353166373335336232333531623539616565223b733a33323a223035366136386533303664353837616230333035613266333734666539313431223b733a33323a223930653233333031623035323464333066643665383133313562633263613435223b733a33323a226431326231643064376562383262613430333362653937613238386561646132223b733a33323a223630366137646466363863643763373065306531613663333535323431613531223b733a33323a226362346335616230376362306664656139336534653935333230353433633133223b733a33323a226365343838303066383261383264356330373632386636616533383333353138223b733a33323a226636663166643535383834646639663335633434323965303530383061623635223b733a33323a223466376364303335643038643632323833363432663837613035303566613134223b733a33323a226434316634396237393263396239316362313764376131373837633735383531223b733a33323a226333386666653736666430613938613133613063383339326166616132383733223b733a33323a223463356264323565333066356230346537616637636365313762343161366165223b733a33323a223765646336323038666131323763656232353534626334393763353364346230223b733a33323a226537313330666436333037353764386136333064346237303434376262343561223b733a33323a223035383037653430633635656130323564643864363337386530363865663034223b733a33323a223261306434343634666132376435366435643139613837323536353666363766223b733a33323a223335353863373565303230326564646239613337646136303561366361643230223b733a33323a223233343930386432376536313161333036333565643965653931333231393734223b733a33323a223539646261383562366333646235316437326333343961363066323232373462223b733a33323a226333313563313631663461323631666134373362333733393135373866636531223b733a33323a226537346639616531656639383339626361343533356534346565356361636331223b733a33323a223439373833306130316631626635363832396634363736343864363561643566223b733a33323a223462353134623366373263343138346465623935636135613637356132653132223b733a33323a223930343431383737326439613237326132326335633962623236303030323362223b733a33323a223632333938346135393638353861653133646166396339393135653931366138223b733a33323a223764393633343130633639396535303033313434393234323838383934393966223b733a33323a223365363364633764643562663363353030663135306236396231613636386166223b733a33323a226564333062303737396264313230383234306337623362353266393634653864223b733a33323a223063353536373161343865646233633861646535386165343736373863376264223b733a33323a223532336634323564656463336532663462303965323031616463316361666632223b733a33323a226333383231666362623935353934306239383762653734363433373532633632223b733a33323a223331386436353565313230623964386436376564613137393835666532313436223b733a33323a223930653064353234363435303937316232306365653637306133333434396334223b733a33323a226232386338633838663732336638313632313063646163613365356139613463223b733a33323a226230353462306138313038393731303835323430393130356535623032346633223b733a33323a223732313366633935376362313037656632366238653530336365643563363964223b733a33323a223838653335356237643036616235633264306233373339323861343364323762223b733a33323a223035653437313332323066303532306239656138656565636162346263306635223b733a33323a223731303737383631316533336438663839343261623962376536653836633737223b733a33323a223238653438653939313536613964643962393636373862353562373761646633223b733a33323a226536613261363964303733643864396132653736663165666164663865383665223b733a33323a226535356334353135646361643462643937313761356630643835626632356638223b733a33323a223034643961333864356632353562646266386333383665343538313234353737223b733a33323a226564323834653962356266663463633332333531633933303336303166353062223b733a33323a223963323939666637613839646264323765643035323430666337306531353432223b733a33323a223461353530383666653932363637663731323863326161626533376266316666223b733a33323a223161663363613239633765643365346537323861656631363163343233363736223b733a33323a226363353961646161356261366638333434393537356336663133313130623237223b733a33323a223165363239323962383536646434643034613439623964616539666266373164223b733a33323a223434366565643233303130376130366436636335633263303265346562346665223b733a33323a223034323335383466313863323236303733363262383661636137346633363231223b733a33323a223061383765326334306533343463626235363662303462663464653162633630223b733a33323a223631626431313862616432346232663664653165303931313733336635623536223b733a33323a226232646532666530393966613637653965653531346131636463646534663965223b733a33323a223865633239323837343363633565343238643432656338643265356631653537223b733a33323a223066396565613334336135323865323638303534653334313431346336373839223b733a33323a223336643031343036303162633631633239386465636466356530646663393764223b733a33323a223966373131346334373864303664303663316535373532626237613165356134223b733a33323a226233356564396366323364633532636361363135386537333639313166633166223b733a33323a226139393931623236633738383438353238336262396563316462616262343065223b733a33323a223231366263623066623036353165326338393332616432653932663939366435223b733a33323a223764336535613262303866323131643262356531353162643539383230666634223b733a33323a223937626634663135633237383062326136336332333634303934313730313433223b733a33323a223736393332666332386165623232623763376662366537333437303363353736223b733a33323a223762663530623337393130613636663135343332656333613436373735656435223b733a33323a226138333661336636363832313033646365343761626139316363383764396537223b733a33323a223166666561653933333333666338343330613039663465366239323937663736223b733a33323a226362633839313562316439386565616263376437333538333365323935633137223b733a33323a226531666430666664356166623865366631626466396333383935656330623166223b733a33323a226534643964653464353865393838353864386637333034373738663233303136223b733a33323a223237633030616235636664306162306435303232623137306263363835353965223b733a33323a226261633231616432313666626662386231643330326132356532666338663364223b733a33323a226333613234383234663737653030363737633437656664383361633630613839223b733a33323a226138393063343465376430356435643337646439626233633166613031623966223b733a33323a226665336338306232363666633030646230636332613666393930323065323363223b733a33323a226361656432636137393265366637383261633765613533633037646135623336223b733a33323a223535633063376636383138306232363465613237333866313339366161623564223b733a33323a223636356464666464303961353862386238613331353434326535393366393336223b733a33323a223966323662396335303634636466333937643739316263633239363362316661223b733a33323a223439626164643162326139363261663965643966346338323934663832343130223b733a33323a223964663933343132323631633131616461613236363037656265623664346336223b733a33323a226638653761633138343636333365646133616661623830306662396435643162223b733a33323a226139343366653433366130656139363463353661623661663231363363326365223b733a33323a223463383862383138323232333764383366623738383666366663326238613163223b733a33323a223331646463636564623334343439626666616330616434303666643432313139223b733a33323a223662623164313730336530623136653261353933643935303637646334386464223b733a33323a223938636439343931346233656533643936626663633735363231613135653665223b733a33323a226136623539353138373137373430323836343336663431613666333239363661223b733a33323a226535656362316234383433306464663738363466353531303962633234396430223b733a33323a226662303934306166393866376134356633653563303361323039383962346261223b733a33323a226431383232333562366566313232303534636264306535356463313963363465223b733a33323a226635643538643261326634353733306666653864363131653434666630303332223b733a33323a223033366133656138373531373135643065303063643034323334633466323733223b733a33323a223839313366333638666336363633303434323733623738663434346137396631223b733a33323a223564316235366463383861663765313734626236366462306333656562666130223b733a33323a226333373639393564346161663039623231653430396138626637666330636331223b733a33323a223964343165653365626635643966316364653531326230303064623137383965223b733a33323a223166633233393064323664396531343731383031343932303865633533366537223b733a33323a223033393765356238613637663439616534633035376465376233356166393736223b733a33323a226538306538646237323435333362333563333334653132636436333839363932223b733a33323a223938623436393338653734346530633962643863376633333932646163613365223b733a33323a223164336161356233373833646239303732303965626232326361383131653163223b733a33323a226432303866336530623462346337396366626165646231636162363663313830223b733a33323a226632653065653437633433396531353065336566316631643832373737613265223b733a33323a226363316438633365643135366563333061316233336161323733356631356635223b733a33323a223539636265656431616534303039363133616163386235343764653461666638223b733a33323a226632613838343434616463316363383231366131656439666136363465316261223b733a33323a223833393964613166346163336139663137626238353365313939636235373134223b733a33323a223462666633616135656130626231623666633035373365623635396437653336223b733a33323a226631636339633332643962393063353161393364613630653239633633393665223b733a33323a226535623134356237353433356636643862636538346164343465623632396361223b733a33323a226136366532376239343861343430396337373364313761653636613363666130223b733a33323a226634616237653233323737653134343733663730383664643830633965663161223b733a33323a223830616636396666323938303434343033663238383633636231306535333263223b733a33323a223732333637623631303936663439316133373239393237353634323363333434223b733a33323a223566613433363164346538326231353962366231363539343064663462643636223b733a33323a226336313761616438646138383637613964623935373334663032663163353863223b733a33323a223065346435646339666330623238663339663536623264316363656561383331223b733a33323a223836366533303739653235653933303332613966613438323837616338643835223b733a33323a226532616232643430363637343436663635383533396661613664616331313035223b733a33323a223461366163636630636337366162303034323632326138633538383038353233223b733a33323a223363626262383539623632363639653434616636363731353865326663303932223b733a33323a223761336233336631336633653436613834316335306331376537353339616335223b733a33323a226465343866616165663062363732323966383864356162623733303633316533223b733a33323a223661653830303330353333633865666233373735653435343863376537666632223b733a33323a226665656637623734643135326363613161663433393266333338363139326433223b733a33323a226239613962353963333134306537653039396138343061653366383666306365223b733a33323a226130333132303038306330383966313535636639616639633036383335666638223b733a33323a223066666664396561383932303233396532653665393765323563363630616133223b733a33323a223639363830333164303633343434303366303638366332343865646136336531223b733a33323a223565363036323734363432393234656664656334323432613661326464386465223b733a33323a226465373930336333313338346137373532326133313434386361613236346161223b733a33323a223061636464333732613466633662636432376462656632333739323935396231223b733a33323a223737346265656262633435653138623864653432353634383032633236623065223b733a33323a226431356538353032646365623938653035313964396339616130393131396338223b733a33323a223965613365393561623364643363663630623538396336646661396538636162223b733a33323a226466356233333861313030636635666338356337383737353636336563363131223b733a33323a226264376131376433306636346161363966663131356562356264396332633462223b733a33323a226163376239636231303661373166386235313033643765613438363137643366223b733a33323a226238646539666664393430653239343962636164646338653033346537333464223b733a33323a223031313632336136633833636266363739346538343736303237303131313530223b733a33323a226263626466353665393031663639643330326637336463363033623064643238223b733a33323a223633323162613639353265393162643633613731376139646639303635326539223b733a33323a226566356330623833333537343032363461386534643434666631323264363165223b733a33323a226666616331336335616139643463633935373963646335613532343434653735223b733a33323a223332383238666537633762393337633834633935376130383363616161663133223b733a33323a226662373761383733313833353662316139383163343637363139323065626332223b733a33323a226263666264373436313366613265613939343132646261353761383661336538223b733a33323a226431633538393333326261663135383835323531303931616533656634313961223b733a33323a226366663164353337323861333734643665323361303238623361343362313436223b733a33323a223733316462363230653232343532623463326238646138623331393237383535223b733a33323a223631663466613164346330303434616466333637356137623831316464666137223b733a33323a223461363665353761653839646634333234306262336137666135356230653530223b733a33323a223766623465626631386633356565333430393938373131326236616138373561223b733a33323a226363303762653237626230306637656237613466613931616133376235383332223b733a33323a223536653166336232333865633438326235363635343131636237633465363165223b733a33323a226337343638363963393632383636303039646665383333306563323032633536223b733a33323a223738623330393538316234643436333364393531613037376537623937643465223b733a33323a223034626339386532396162383065343965376366333566343132393661613535223b733a33323a223563323661303966616463383638653162393230623165633765323662623664223b733a33323a226261636539393235623530616566393766383036633865376430323136393534223b733a33323a223634346532326664363563623166663232313164363736613239333736373233223b733a33323a226330623564353064303864373936646561386638303837326263333631333566223b733a33323a223662393135633731323338386136313130626361613633666330636265363034223b733a33323a223763663166316161613463393464623762316365663635376431356637663332223b733a33323a223431353766366131383864373662643432396132643166353532346234313239223b733a33323a226564636632666466383535363635656537383931623035323035363439373536223b733a33323a223130663066623963646238303031366432633566623839353065313463313136223b733a33323a223832336133653935373838333836353963613434303131346562343733653166223b733a33323a223561353033643238366131346161346537313633613839643964373638663731223b733a33323a223265303734643337666135633863346438613138393362366233633336386434223b733a33323a226463316433336536666437656431303665306464373565636639616639386666223b733a33323a223838643766653538303466636636306332323636303533323064626432343839223b733a33323a223734373064306534613738613430643334313337623965353030333132353934223b733a33323a223063326566336134393465366566313461336364333131396235643336616133223b733a33323a223437386338366330356430343531616234626631356265616230313834393066223b733a33323a223334646162383231626663376630643466323566313536663134356137363535223b733a33323a223339653061396331346464303263396531613538306531373133386635313337223b733a33323a223861653965666432613362376635623236633361356362333262303530616431223b733a33323a223837616334333565653332396637653266376332643133323832636535653361223b733a33323a223562613064643037353034386238303831633139353538383534306331363864223b733a33323a223362353731373537386433366539316430656565633336656432333162303035223b733a33323a223637303834643365306263303737336538333836323966653061623861633534223b733a33323a223831643162363464316663333435306266343461366237353731333932656634223b733a33323a226565636166326361343961616439656631636161643534303436303065663731223b733a33323a223435633531386661643539383038633830393639616566373264383465613166223b733a33323a226463313264313731613161663637663363383464666136666361343461353937223b733a33323a226265396566316662343963363335393739663736626165613862366139393032223b733a33323a223831626163303864383937393631373763363239383334363232333832633064223b733a33323a223037353164313731306430386162343865366436636131653765396662376363223b733a33323a223662313538633364376531323062313664626563393963343836623331636530223b733a33323a223461363738643166313831343736326166633236616566376336336439653433223b733a33323a223662333966626564313264636265383665363733383933636535396562633439223b733a33323a223639643833623639333761333766306230613838353034393966386336626366223b733a33323a226333613939636366383035353437366464633861633037383831616336663062223b733a33323a223635346661626664303030616334656261306538376235353439623766343832223b733a33323a223366633635323732396139366565666664306537326466356163386563313563223b733a33323a226437363437653961336333666264343038656535303866643462363837313166223b733a33323a226631356235323364383566303262623236363861653530353339306134396533223b733a33323a223235666463616532346139626238343637343034316131636232363734393164223b733a33323a223931313034613439356236616362613134366430306532616461613764316262223b733a33323a226131343434343931623430313365616364356436306565383831343961333835223b733a33323a223232383031643961333332626332373537386131366563306461333635343337223b733a33323a223862373938663535336461336461383665356264346437356532353934343566223b733a33323a223132393532646163373464353262363963376135333835653666626334643461223b733a33323a223364303936303062333835356339383332343030376134626237396331363161223b733a33323a226564306533626464653162626365633735366439306235336364353862626134223b733a33323a226631303266363638663034613936383236613437623761346433316666643330223b733a33323a223836613334366136633136313434623032313338616630633065323133313139223b733a33323a226264653536646635306362336564653465653638643337636432633366343836223b733a33323a223366313339333738666630336666353834356634306637313837373865323237223b733a33323a223935653865666163636164346337363265353236353766663839323334613233223b733a33323a223966303836306134623639396462326565356534653530336164616238373033223b733a33323a223335323435393135376264303062326165333363366132323433643234376636223b733a33323a226664356561333866383637356432636466313239336431376561373831633066223b733a33323a223461353830643236323034363234353962396464393961373638356566396632223b733a33323a223830386435623665303830636633393538303064613136646235303730313639223b733a33323a226334663236633830653061633465366532313061643139623437376435363632223b733a33323a226238313734313439663761396366323632323863303065636361646631653033223b733a33323a223966363466373763373139643661623133663932333461613530643062373464223b733a33323a226363376635313961643264613661666135363530303631393832346364646266223b733a33323a223037393637626465663065386138353232373366623265383165613836386134223b733a33323a223063633238326663336637623435316166363062343035383765393634346231223b733a33323a223837663861336432376563346338643932373536356435623833343632343235223b733a33323a226634346130636332316561633364326130316239316337386438313932616234223b733a33323a226432323461316638666565386166313635353961633163363030646531383730223b733a33323a226334613236636635613862613538653133626337376135643337633138613631223b733a33323a223535383231623739336238316365313132356265366661376362373539653563223b733a33323a226331633633313237383261373639313738333962383365646365323439623433223b733a33323a223938646564303330663838353863326564333266633862356432303634373065223b733a33323a223437633166653033656235646337396333623464333363383438623534623731223b733a33323a226164343964663864356162653631633863313763663237343130626336306562223b733a33323a223338356463326336346661663338316232613763333063313862613637643266223b733a33323a223831653765656361646263633963393361663339346164373663386533363732223b733a33323a223135303432663034303231393339623631313065323738396236343635383163223b733a33323a223666313963336337656232636566626534646630396466656632343638336338223b733a33323a223563613339366362633531613964366537616534623737373937333535343234223b733a33323a226635323730323537613333643835366562333037396436633534363436366635223b733a33323a223931303163656661356661353035303566626665333132383138653435343038223b733a33323a226530386239393532646334616261666137323566626430353863623836636630223b733a33323a223834366530393033303532326333333735323535323930396366323236663939223b733a33323a223136616166653964633339393830666562373865376161363737383662336165223b733a33323a223237366532376130346338356261656265663433376266333839613038373437223b733a33323a223763623465353430313361363137346661663439643964633337396335366236223b733a33323a223735653434623562633639306665333038343364366431383236636465343434223b733a33323a226139643861623166373739316161363365656434616534633038636464373137223b733a33323a223262356363623962623564366362363634623737383334336465376466613830223b733a33323a226533346336316161656562343134643332653963393131633732383638396632223b733a33323a223436316535356263633663653663313461613737383337616231643837373334223b733a33323a226338373064666430663737623233343863386562336639306632313833336262223b733a33323a226531653864623138643233653766626339386165653333316431613262633366223b733a33323a223163346436656435666561306332393336663330343335636363363833373331223b733a33323a223333396339383833636434633138653131623232316238323233343465653836223b733a33323a226530323030353437653633306266383666363937376237356331343736653765223b733a33323a226535313230663264373236656437373234373966366637343032336662623635223b733a33323a223463393133353838383865326661643063306232636635636463616235386434223b733a33323a223138636238306538396362656662663965396638386531373434333531353062223b733a33323a223338313038333332326363623536616134343463346638306362343736613766223b733a33323a223938623431353631396638656334656663623838366331666133356466323661223b733a33323a223437316563323434343966373265666236333835316161616133633635326233223b733a33323a223131643461346435373030333530653862326130623764363537626233363462223b733a33323a223438373833373738653562363633393166303535646534333665303538643662223b733a33323a223830393132623662343732333762323764636632336134303630656461333238223b733a33323a226263306137306230333538653233323332376433313931356335333430383138223b733a33323a223431396239313734356630333139336666363035303361303332616164366235223b733a33323a226232383262666264343063353865346239623565353431333938393733383138223b733a33323a223730613537383235643537383233303939656432306339626238316362316430223b733a33323a226264636630346462313937376664613035376664353064383266613230636138223b733a33323a223639333665643866346336633065616232356338343666383136323464623538223b733a33323a226531376133313962663763663165383237613837316430386238336338653431223b733a33323a223563306162666439383062656564306139363263373764643463313239333638223b733a33323a226566356465323462326536636531333934313334383630623336613264383362223b733a33323a223033326631336466616334363032626566336435373031663532356263393630223b733a33323a226236303139353061383063356639613563363563643564373938393966616430223b733a33323a223436623432396464663332326538616661363039343536323637613964316662223b733a33323a223534383666353064313538313330626338313864363564306562653032396639223b733a33323a223066303865623933353965356137343137373965356639623565373139326465223b733a33323a223530363165326266316662663731633663346664386534316535353135396138223b733a33323a223765396438393862366132323666666433646530303663373838326637346436223b733a33323a223063633264626461656164666162626234326366643463333163643432386132223b733a33323a223636626262363961343765326335613165643635303435303835343332323933223b733a33323a223064653938633262383630376230643234656330663032346637636430616632223b733a33323a226639613338383739343362393863376330326563373933656437303633326238223b733a33323a223237333537633033613933646237306266373761326166306262613830373639223b733a33323a223434643962663161303562333731333639323738323032323830316663663162223b733a33323a226662656164393164376335376461363534653131313062663234366266366236223b733a33323a226361316231346239663362626635336537313533303837323733386633353438223b733a33323a226130373261323732616266656636363736393537616166323764343463376231223b733a33323a223834613138653035306461313131306433396430373339623537336231373032223b733a33323a226330356339363763353636633861393231373136383966346632656363313561223b733a33323a223266323130353938633137326439643564666361363364613732363363306234223b733a33323a223638356338633537306266633139396439636430306334353534626363303736223b733a33323a223865376433623035343139663139613632643636663034636234653232396564223b733a33323a226662316164643162653132356334633163653533636362336465303139636163223b733a33323a223936303833316136343530666238633330393864333165636266623036613936223b733a33323a223236313337623030356634366538643061383330306665623831393033353939223b733a33323a223439316465623261366136313165396337383065613763613039393334643736223b733a33323a223037623034376433376539383936663833343737643864393166623138623230223b733a33323a226136363331356534306365343536636238633566393038666630316264373532223b733a33323a223133646562346463313334633430326338633932633664623264386338653363223b733a33323a223561326230353865343337336433366662636230633562333139303335353935223b733a33323a223632333733346433326439633133383133646361353266653037343762613630223b733a33323a223864386436636563633931386562353731393631643732366535316630663231223b733a33323a223962333135666135363064323762373432343438353039373231663766333735223b733a33323a226539646663343436396461373365343730366564343934353934343732313932223b733a33323a223361366162383164643539663832303337353963383233326139333037613761223b733a33323a226438653833356637663235333061363837376438323930636430613865363438223b733a33323a223664396438373364333331356435396662316466383162613437316162333639223b733a33323a226338623362663533393838646333363966353264333431393566636236323631223b733a33323a223463343034356164636133393665333165383038613534353363613263356263223b733a33323a223134393762346232663636613564333238643537343534386165383965363262223b733a33323a226539396666363631363530613138356163363037386331326532633134623762223b733a33323a226433346538373265633938626433323337656234373138373564306333323833223b733a33323a226237653634303738636533366437396534626236313136393236346361303763223b733a33323a223964383836663561646338623861313234636566623634623139613833363438223b733a33323a226162623061663536323464646531343335636562356335303462613261663764223b733a33323a226461323663393738316335393237323366373935663235346638376436623031223b733a33323a223034386239386132666366303366353735663766383935323732663664356635223b733a33323a226638303064393862313731366130343235303531333664363337636236666666223b733a33323a223561336564323230363830313439623137623866643535306332636338383564223b733a33323a223234626133363631623366333537346238353235636133393961376230303934223b733a33323a226365393537326232386364653361663530616463343939623966663266663031223b733a33323a226234656361313230376332363036636234373233386239336132663530383364223b733a33323a223232346136313238636538353136643137313439393336623965363631636464223b733a33323a223834326135646163623430653466303361366361323962376439343135343430223b733a33323a226137386565623965353130613865366233663731653661613164613863366132223b733a33323a223639633232366661663232316233326332396433323838376138356630343939223b733a33323a226431663866363661386335323663656534303336343035326163633661636161223b733a33323a223563353334623330366339366436333438653866393135396436356436346135223b733a33323a226130653661623666343761333265663839353364303031396539333062346464223b733a33323a223465326434393262366634643463373235656230383763366366376436333537223b733a33323a223865613031373666626232663239663965653433653566303731613133306632223b733a33323a223735336161366130636461666362666461383234653337613466623061393164223b733a33323a223835623330363438323532366434373530626333353337333932666166613366223b733a33323a223965313963303137613066613236613934333065393435376361323139336665223b733a33323a226132383665616139646239393439333638623536626535386564306565383835223b733a33323a223033363830323461366634313239623434653736373336336437613637303833223b733a33323a226431613533663031373632393330626362643966663161343864616338656639223b733a33323a223138316437353839396435353232383133316333303032336462336231373339223b733a33323a223338303963333765343736353834333837316534396430363764333931306566223b733a33323a223763636530666231633034373665313638353839336130323830643032633161223b733a33323a223634633465616236646637386339613031333837343532623064303137306631223b733a33323a226631343962623036356466313137316562373733633965636130626565663964223b733a33323a223739343635336431383134323965326137303739383033633936353431383563223b733a33323a226535356133633336336666303639373861306239356336643135383663393634223b733a33323a226432366163393565313232666233356331363832306661363463376538643565223b733a33323a223034353935363738386436333736616532656564663831613563666536373336223b733a33323a226564333339323435643330316637343938643034643635633030396631356161223b733a33323a223665306565383735373232353130663238653064613830636535373063393533223b733a33323a226464333163303030613164306132326565653835303266623430393861363062223b733a33323a223532336533323838666466383563326634323462373436333064626132336534223b733a33323a226230653736303637623965353635643439623230613131356335386336376661223b733a33323a226639303962313132616539663566643037336361303231323934356533376164223b733a33323a226530393532303435323064363364643565623933626230363937613466313266223b733a33323a223132333933333665616237316231343863316539366665306133613563366366223b733a33323a223934626538646638653464363634373662623061313837373264626331636137223b733a33323a223134363132313862386362343337373566366432386334373131343061393136223b733a33323a223465316463623861386331666466623762316437343231643237343265373339223b733a33323a223465333133393863303230363630633063643861323538303264616664376465223b733a33323a223735313364366562353864346163663362323535303663333032346135376361223b733a33323a223436666636316238613165633933656262313037306131616330613166366262223b733a33323a226339386335663335653466356566356263633962323535333335396666373531223b733a33323a226130323232303063343330373230356263616465376161323531663539393730223b733a33323a226330626663303339376637633763323332353231623831336562313538386165223b733a33323a226138323030366335306130623832636666386237646666643731333339306666223b733a33323a226161346632646638366437356437633562336161646131393334616338626136223b733a33323a223261366632333065333130346230323835653066396538323865333865353537223b733a33323a223738653661613062313534393663323766336433316630636634636435373135223b733a33323a223731383661363239396230343738633431343630376539313834303461353064223b733a33323a223732376533316238366664303236313964326532333266666663623431646564223b733a33323a223439353130626263326137313735323138336638333633346333663765336633223b733a33323a223530666135363738633637656466316339636365376164363339323332343365223b733a33323a223838333763373432333363363061663264363232363135643865333931363636223b733a33323a223238633936633131373961636132613432666335643232616465386665643733223b733a33323a223333636138653636376434333537643331306162363364633861316463636663223b733a33323a226464333135633331326430623634326261636366643665633931306238643963223b733a33323a223034363532306538323339643461306237393164303262643835393566343631223b733a33323a223030353535613139633530323639313164343235393136336133396163343233223b733a33323a223534383566346537323735613665633334386437666235656234656634623363223b733a33323a223962663462643234646334316636363466353865633038313331373566316331223b733a33323a223230663633383266353939626132353763363232613464656365306161636562223b733a33323a223738663130643766333861363535396333356363323366643161363034373531223b733a33323a223230303865373365666264306462626139613465346365663633356630663139223b733a33323a223363643265633432376261383363353130363263613131646331626432663338223b733a33323a226239633435383431636233613561336665353233373734643736663036303165223b733a33323a226137303336636634653963336231353131646339633863626666663861653564223b733a33323a223761613631346637653730633030666331636366346663383130386132303866223b733a33323a226330333763653663306661306534626563333965383064343430623762346336223b733a33323a226337303736656136666237313839643864633764623062373537626163643033223b733a33323a226133663332653864373965653166346332353939313130333265666136633130223b733a33323a223038666438343132313763336334393437383832353438313736616564323638223b733a33323a223430643161376662653065363562616161386236633734666266626239333636223b733a33323a223733653431643939666533663765633561396366386662353133386262303933223b733a33323a223433323438633237356537323936303362323138353035616161393532393333223b733a33323a223939363862623765616537363833386238393963616439336364373862383135223b733a33323a226666373332323833313033643736623435616663326461633034323062643763223b733a33323a223831326234383963613631363862623633333262626161336131336232663631223b733a33323a223935333464613961626164633161323734383864656663623137626330373838223b733a33323a226464356539366366396137323832336231356232643433623265663233383361223b733a33323a223562616366653164663135396664343832613230373237366261346666326139223b733a33323a223565346663636532363261636266633364623562346535633234396631396336223b733a33323a226235333539623232323539353037663531616633653966343333323338316261223b733a33323a226262663230623836633566303236396332636234313339303135353330396465223b733a33323a226639646666323238306661646563396435373932313934386238333362653236223b733a33323a223430623536653033306630306231363734353637383030623165306532653732223b733a33323a226337373936323938336339333936643266366166323031616261663231316334223b733a33323a226232356261366536643035393739613062383937663764646361613434623734223b733a33323a223831633737646262636135663864326535313631333336323535363038393430223b733a33323a226665643832383639346664393161333137626137626465363539336534396562223b733a33323a226465646437386332643866636137623166383461343663373834653636316336223b733a33323a223437306532316364343637653638636535376161343636353834313364323239223b733a33323a223632313836373839383936346339663164373639326461613638393437383163223b733a33323a226231316564643235333037306534356364656465346432373634383839363866223b733a33323a226564613030356661363364333864353539323730363631363566613933393762223b733a33323a223538663563343931333361353366636566313238646336333636643063363063223b733a33323a223330616636613833303332396532623666386239633038383863613734373464223b733a33323a223533393832303230623838306430393638316236656532386432313837643238223b733a33323a223264613166363738646134346362393535333032336233653761653236313162223b733a33323a223537326163316161343939353764663934303233646563333436363763393536223b733a33323a223162386538313131613734386232363437333535626263366164633836333664223b733a33323a223731336133663562633862363737656139366238366236356538633937316331223b733a33323a226239363737666537636163326439393565393262616665616334363633353033223b733a33323a223763626138373065623864636635633865343738313861393162633538663337223b733a33323a226132656238306462343731356132376666333933343633646233373439343762223b733a33323a226435316639313737303130396436626232383165626266626633633139376635223b733a33323a223063383966306366336437366338653435646138333131383533363830366234223b733a33323a226632613435316463383766356364613637636463633438363333346365306666223b733a33323a226539383136396136363063633164313864633462643338396331333564633162223b733a33323a226631333062633038393035303132663532303930376530393963613361333530223b733a33323a226537366132656238383937326361616565643966633234383734626132376361223b733a33323a223839313039313937363537396361633465383234323333383861646532623034223b733a33323a223032646638336135656466663866326363383430316465616438303434643837223b733a33323a223939626534656361333139346461666137633336653061346438353135303431223b733a33323a223033613563643937343638343762316534316162363061333061336533636238223b733a33323a223036626365333733396636373336636162636438396332646239353138613930223b733a33323a226332613166303330333263396139326661613636343061663435333736383061223b733a33323a223837646434643364636437326636633236653435393931373831303737346462223b733a33323a223965666463623463393433623139623662633530616631313732303539333365223b733a33323a223463663265626661316134303931643963386337383563663334353261303931223b733a33323a226663646233353939313466303434633166616263316664383436376638393166223b733a33323a226163613137636432303062303566396339633637653037633734626163646536223b733a33323a223137333264613963323164323662353230383633383431363536363535316135223b733a33323a223063386562663839343630353765306266383035636133383836303639333934223b733a33323a226661363065613438363434363230666633653234336338333265623663383965223b733a33323a223934623964653764646438663832313165303538623666616262663564346466223b733a33323a223937623237663036373835303664316161623631623635316632663133303631223b733a33323a223633353530373036363761336562326563323637646533356664626366306636223b733a33323a223666396437316239363732653330313935643436333038373939313032653933223b733a33323a223730383664663234633139393431616235653335343165366538373131383766223b733a33323a223338396336313633616261343936386264333764636538363935636561393037223b733a33323a226231373739356331336534376566393565313136646264303563376438646464223b733a33323a223130623662653434646363663634616435366231376337343261386139363532223b733a33323a223239336264663434653735396633623532333638616164653932316534656434223b733a33323a223236336234613430336334363333326237393263323862613136646564653337223b733a33323a226363646361393639356364656466623930653964656639346530346133343735223b733a33323a223231363834646664386464306363656434323661663535313437306331303838223b733a33323a223336393130383238663664356636643865353233306566343164366132326434223b733a33323a226565643737386631393931303466613538656235343665356438363061326439223b733a33323a223833643666653438353632336264613464646438383438316631313036653263223b733a33323a226335353466373165393866623437643836646136633637353461623065646335223b733a33323a223134653162333661333438386563666337383130376132613334346232623637223b733a33323a223866613062326362656138306539656537316333643338653330366533333336223b733a33323a226563376631633536376366653363383630626236656438376138306432633637223b733a33323a223433636665363561396433396637333465306230303734383464646436313939223b733a33323a223962343636313965326331616265663835393465326431353861386335376266223b733a33323a226566366432303133656633323131623063383562343736393536373235356335223b733a33323a223437356330643631653138356333656531323862326265383033356538376533223b733a33323a223535613166316530383162323864323737376230383362356365393637353335223b733a33323a223462316138616233323133323965643230313735313434306232393862356166223b733a33323a223364336332356139653763386130326631653733363062623130366434396262223b733a33323a226531343461653561333831313730363566396330373064643236653036333933223b733a33323a226161616334386331333136326664666339643764316164353066373539613138223b733a33323a223364623832316364336234326365353966633134323830346433383535376535223b733a33323a223063633737356434356632353837363266623935303961316531363363643736223b733a33323a226231633165386463663462633966643431623566643933386662353162376530223b733a33323a223031396561396662636433386138326361336563666535386362643930653235223b733a33323a223538336364363062316133653830626230363265326532623638383538383162223b733a33323a223131313431303138393865666165326530356639336630613764363236393665223b733a33323a226432356430383061383662323961636339336137376665393132396336613633223b733a33323a223832633635613238633434393839326163393762623331393138646533326135223b733a33323a223563343231336362383766663132646336623239313337383537336361656233223b733a33323a226539623536313038623634386439623334626537313533313366636663343732223b733a33323a223337623132623365313130303963613934633961633831643262666265613936223b733a33323a223366396533663039306166663434373764633166356331663437333365366637223b733a33323a223835313163613564386332623464363032383332653034633161386365633365223b733a33323a226539346664646633653233643936633238376330373262326330623936616134223b733a33323a226366643230393331376665663461393136336131636637316161343461396562223b733a33323a226165316633313763656239636536353130353630663834353863353364613037223b733a33323a223632653031363861323433623533613739333138663866653862643138383563223b733a33323a226631353136633562616235626534303234626665343637643538663662396534223b733a33323a223231623564336339366164653164376665666230623130383134343334656337223b733a33323a223730616663336236323938323237386266356461636261363735303039613862223b733a33323a223035303435353362323466383965626533313733386430303035623438313832223b733a33323a223838316238643665663566626266323962393434326235623833313761386235223b733a33323a223662326330303630646532303134663432323331366463376565363038383637223b733a33323a226362323137646334396361623835373931336362343163323634376166653463223b733a33323a223030323034383364623439303864323736623832303662316366373137353030223b733a33323a223130613865653237316539656363653566303130393362643730366239643763223b733a33323a223836616132323238313536323662396534646236343465373738313135643834223b733a33323a226464353364643461313963616632313037623464383263386231353432666363223b733a33323a226333336631613731383164653366386164353363396138363464373632353135223b733a33323a226330653438353262383235306665656661363066616663303333303836323336223b733a33323a223061383130366639383830656163653537343366323334366435313332306530223b733a33323a226264646439356363313163616238653335643230613032653131383735356363223b733a33323a223435346234646637356566323237376366323133633764343833376437643234223b733a33323a223136383334616135386437333833373433633461393065373362366134393761223b733a33323a223966353963363564643031363838663238353238663031313231306266643236223b733a33323a226533366436623865323631653331373362353564663965336331333634646534223b733a33323a226266616237663165363061353737353832333763313466663035616431653333223b733a33323a223038313534326665346530396566346562336161303331373233383538353735223b733a33323a223638333566323766313566633830666164623962323965633830653430653464223b733a33323a223837316431636332663361323166636137323730316632393537366237366566223b733a33323a223234633533356137333038313164333931663932306231363565383835376666223b733a33323a226236323333653161386263633861353163306434303463366330336366316536223b733a33323a223434303835663838633834323363613231396234623939353262336533373961223b733a33323a226562653463623534306631373031643331303533643964353636373564666639223b733a33323a223063356332303564386463636330336165356132356634393462316539353666223b733a33323a226534383665646166646334633930373136623063333766386464613030616463223b733a33323a226238343934303235663862303261623531393762316437396666373561393961223b733a33323a223666663337303335613066323939353466326266356664363636336330613665223b733a33323a223762336337386261663637373833303964666163623865386164306466343638223b733a33323a226363356462306265316438333262336337316333313730356535313037323338223b733a33323a223733363631643865323666373261366666343866343563623766633565376232223b733a33323a223134626332373433623234623736343837633265353665646536363239313534223b733a33323a223066376331383261353433353066343233613535646231326664633738396535223b733a33323a223461393861333561363430666363353935343332326166323532373034363534223b733a33323a223436323836366431363364356463613965353862316261383437333462326466223b733a33323a226336353163353039623938343361346663356236363464386262303230353231223b733a33323a223861303863616663656164626132353530656262373135326539353063383565223b733a33323a226431323937613630306561356538306664386632626162303630336134633839223b733a33323a223639623566396534663037306637396663633466386433356635613534363133223b733a33323a223931363737306537343531353636646538663665643466313965643939633034223b733a33323a226138643364353462636166373032333336303962353264376162383838666331223b733a33323a226538353061316263643966356238663432636262613862303366343938623864223b733a33323a226431303961643638623435613338653431623531363534643732653730356565223b733a33323a223464363863323031373132316162643434303138613661626264373466653339223b733a33323a223066656233346338663439626332346530356331646635396439643866326261223b733a33323a223161336235633538663162346264656161336432393363376233396533373833223b733a33323a223838643935353331346563356133623235636134623366626265313564323466223b733a33323a223666313962666330303162636266386165383536393130333532613037326434223b733a33323a226535613636323266363166363964643333343137623366653162616232646533223b733a33323a226336346538366264333938333164343361666334643465363735333535663263223b733a33323a226638316534353263653162653365353636663137633365626330646131366633223b733a33323a226137663837636534393235313838666533373663623838626465346136323461223b733a33323a223061383235336532626132373765343861333630346166383133633530396162223b733a33323a223430323735653939323035633136656662393362636236616237306237303237223b733a33323a223362393533303238393430353438636539333331636339623766626436373032223b733a33323a223630663535636334306435613830323739376236643766623030343332313634223b733a33323a223934646366626638616164633636326631623964323163393631336261373834223b733a33323a226338333466613331663133663861333563616236623735306636313937663635223b733a33323a223830666637326264306662303432386436363235396437366534386465626462223b733a33323a223735363334333561623266386338663161363134373864396666346465393761223b733a33323a223337643334623262323164383866633033653138343737386661636637366330223b733a33323a223836316537386637383665663939366365383062303931356165383662633866223b733a33323a223530646262373335313333363730623137376563396336653361336339346434223b733a33323a226366366136396135323865373638356666333539646136373864613163356137223b733a33323a223661323762643166343562306461383739303764323965376635643238666366223b733a33323a223063383664656633663435313137396531373462356362656362643831616435223b733a33323a226231356633663866633330623238306464363336333638343732316239333166223b733a33323a223964383362313064386338636433373632306531333434663265346134653065223b733a33323a226265646232636265333534353135643734626264653964653363616132633563223b733a33323a223362656162653438306137653038666638303562633361666162323866363735223b733a33323a223032633162633665316166643235613734626261646661636261623166656135223b733a33323a226365643231313533386338333739316232356638366336666233303631643530223b733a33323a223239643937346337623963666161363737343961303265653237383734323437223b733a33323a223563353763383739336163353063313964663437323938393630303461346438223b733a33323a226662643661303763646632326539343563616165353065626633653539373364223b733a33323a223063353731316538323962373230633738666639343162383332653966373864223b733a33323a223035386362346431643363626233613462636534366232653931313039303366223b733a33323a223936313230623763636566323232373730343339333734643539393237323230223b733a33323a223962383738386566373061363363326462383361333661393632393533366136223b733a33323a223564383930613239386133616461613632393737383261343939323839336338223b733a33323a223730633432383462646131303739376235316265366564663538343863646633223b733a33323a223932353564616136343466373339383863333363373234313638616161343338223b733a33323a226433656337636561376166356261646165633531383738616239363032313566223b733a33323a226634643431653539323364343863393835323838383366373834333231333161223b733a33323a226636646233663063356432346539633362373933653237653630613238666163223b733a33323a226430343832633030383139316237306531373762633733313331396237333466223b733a33323a223366373066326430616330353435313462313132646133346661373232303464223b733a33323a226631323939363238643334616132633664323737303437663934376338626531223b733a33323a226562376130663764363737633739353163343266323130616262313334653134223b733a33323a223339613264666664316161643665323939613038623263323838346131313962223b733a33323a223730646136316535616265613861666333393035646239613535366438333336223b733a33323a223136373366653930363733643037366166376235323435353561363062643333223b733a33323a223131313033363738393065653835323164663965653264623661363532656430223b733a33323a226432623133326633623131616138373537336265343661313636646164383563223b733a33323a226266623830313537366661653735393039356362346535336134326634306332223b733a33323a223463633466306436376236656437313362383038373665633431623337356561223b733a33323a226235343630313631306361386537383632396530663466653436613266343732223b733a33323a223663356563323032313538343933353136653538623334333735613166303335223b733a33323a226133383034373830323630643963353134336164323863303436343065343362223b733a33323a226262323336376563626662396534616439346538666532643635393734666663223b733a33323a223937393663303361616334336336313835353061363365343834366162623236223b733a33323a226264636664323461316261633633303038393766626464633736383536383733223b733a33323a223963316637653434393231316665303465323665306530646362646162353139223b733a33323a223731303433326433323134393335626139623430386465623538386132363335223b733a33323a223963626136363037616663663839396339393434363135313866393438336630223b733a33323a226637356664323365613837363831653064626465333531363036373662616266223b733a33323a223833306537626337373062366434666235643031373130323162613336313661223b733a33323a226566363636363561653361666363633331306636653139646335303731356363223b733a33323a223661393134643065346536333161393530363939323435643830653165623335223b733a33323a226237353138383664346639626230663938633362626438323662653761366162223b733a33323a226639663933336231336132633461633563316339626261616366393265333135223b733a33323a223862376161613838613464383337303835616338336136646130303730613564223b733a33323a226463326364393935333865623838633733626533316361393939386364376330223b733a33323a226166653739366332653632313238633965343130386266616336313361663531223b733a33323a223464326162383165646665656564373331643534303539656431376436393936223b733a33323a223165343033653036643264373266666433386139363463386338633138613762223b733a33323a223466646637353338393730363634383333363561643865313265666364383739223b733a33323a223335323536626233383638613861653736393831396235383130353237613464223b733a33323a223863363035303033386163396634323935313465356531646564656334633731223b733a33323a226134333131626262303932343931393564666238353839353533343362366535223b733a33323a226437373265306535383266343761383764323363323834333239396261313462223b733a33323a223737376464626261326436373234636231303261326538313661663635356630223b733a33323a226430393133373063393837653032383836313835626164306135346534616639223b733a33323a223732643530346661373033626166656339396664306539336239356339646431223b733a33323a226362376635333765313961653362313538646232323137663533656635653933223b733a33323a226133643165346339653332323535346239346331613832333763393931643361223b7d733a343a2268617368223b733a36353a2261336431653463396533323235353462393463316138323337633939316433612d6362376635333765313961653362313538646232323137663533656635653933223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f417263686976655265706572746f72795f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226236326230393231373437343761616233653261326166333964653361636335223b733a33323a226637363030366130363863353935306638363634363437366262373762393666223b7d733a343a2268617368223b733a36353a2266373630303661303638633539353066383636343634373662623737623936662d6236326230393231373437343761616233653261326166333964653361636335223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226133383062613761356339376631326535323131393465306564333736333466223b733a33323a223366323864656435323337346266613664633963663332396133346532373130223b7d733a343a2268617368223b733a36353a2233663238646564353233373462666136646339636633323961333465323731302d6133383062613761356339376631326535323131393465306564333736333466223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223938366138363137353732336236316263313763393535313330616662313163223b733a33323a223666646664346666333266383430666231383565613331383035396264613663223b7d733a343a2268617368223b733a36353a2236666466643466663332663834306662313835656133313830353962646136632d3938366138363137353732336236316263313763393535313330616662313163223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f45787472616374546578745f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223265636362666335653466626364346637663064366336613638643431353036223b733a33323a226562353839306230313564346530623630626236346533373163633366616430223b7d733a343a2268617368223b733a36353a2265623538393062303135643465306236306262363465333731636333666164302d3265636362666335653466626364346637663064366336613638643431353036223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f46696c65536964656c6f61645f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226534393662373635326330633231646436376331666338316331623662633631223b733a33323a223631353930643966623638313439633662346666613339623264633136666461223b7d733a343a2268617368223b733a36353a2236313539306439666236383134396336623466666133396232646331366664612d6534393662373635326330633231646436376331666338316331623662633631223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4869646550726f706572746965735f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223566326235313734626261306663326531346662356638353234313638316136223b733a33323a223165343934343734373238333665383863643364323239376364653333373832223b7d733a343a2268617368223b733a36353a2231653439343437343732383336653838636433643232393763646533333738322d3566326235313734626261306663326531346662356638353234313638316136223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3437313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226134616262326163346533643134623866376362396665366436616663376561223b733a33323a226362356532376265363463613861363735373563303834316138336139383133223b733a33323a223637376631353039633230653365373766373037653766656638633139306465223b733a33323a223535343234303562333461376666643866396261376138333839383165363565223b7d733a343a2268617368223b733a36353a2235353432343035623334613766666438663962613761383338393831653635652d3637376631353039633230653365373766373037653766656638633139306465223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1676477183);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('57edf69a91f417a01e1c1f1499bb21dd', 0x5f5f4c616d696e61737c613a373a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637373636363236332e3330353933383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a226465633737356136353436393933643463363535396563313531643137323761223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637373539383737383b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637373636393836333b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313637373636393836333b7d733a35383a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637373539383835373b7d733a34353a224c616d696e61735f56616c696461746f725f437372665f73616c745f7369746570616765666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637373539393337363b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226136613336666634323161343934663838363638653130303634623730643436223b733a33323a223461306434306531373834646132303739663839653663613265383163383931223b7d733a343a2268617368223b733a36353a2234613064343065313738346461323037396638396536636132653831633839312d6136613336666634323161343934663838363638653130303634623730643436223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3437313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226663353435623862376434636139326634396239663366326633363038366438223b733a33323a226335633563663136623632613761623432383264646631386565663465386534223b733a33323a223435393137663931336130386463326463393837633032313763383861346632223b733a33323a226639373665623561326339656562333238623066626363616430663862643533223b7d733a343a2268617368223b733a36353a2266393736656235613263396565623332386230666263636164306638626435332d3435393137663931336130386463326463393837633032313763383861346632223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3633313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a223463316366623530326539303662356561346366613262623266386337393866223b733a33323a223332393231303631376139336261383265626565336438356664306530646562223b733a33323a223432633537353430386435306161663837353430613530663966616532623834223b733a33323a223363306332323935386537316462353730356461383563363732303031346338223b733a33323a223966666438303966643862653333646661373835393137373863643732346130223b733a33323a223031653837306363363061363634623763356331316364633033343638373836223b733a33323a226661376364303638306235613233363361303630663035323136626230306463223b733a33323a223135346236393063333963306634613734363035376339656664616565343730223b7d733a343a2268617368223b733a36353a2231353462363930633339633066346137343630353763396566646165653437302d6661376364303638306235613233363361303630663035323136626230306463223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3535313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a333a7b733a33323a223134363465663661363435333763393238393734383863623131353633663061223b733a33323a223933393833306464633932393565373963343764353332383239616361316464223b733a33323a223930333165386632326430623732373433643938626532656264613565383362223b733a33323a223362396665613766656561613230353539343038376135333838663662666566223b733a33323a226531623930626633643966616439623161633337623662303662663138373030223b733a33323a223362363331613930336332636161333366633963366637646431333035343939223b7d733a343a2268617368223b733a36353a2233623633316139303363326361613333666339633666376464313330353439392d6531623930626633643966616439623161633337623662303662663138373030223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7369746570616765666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3633313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a223532303733646466353537663436356231313130356164636165646636613038223b733a33323a223530656362356432666166336165393066643365376163306563396565353037223b733a33323a223766613762356262383336343138366164363531643436643763326232376137223b733a33323a223965363761353235323333643337636634623839323733373130663635366638223b733a33323a223862373863326164623064636130313238316466613231663837383633323136223b733a33323a223936353638306435383333313035373531323566396539623736663661616436223b733a33323a226433343231323631303537376338656130383163646432393832346462346562223b733a33323a223137626333336661313564326532346362323033373539383538623466666635223b7d733a343a2268617368223b733a36353a2231376263333366613135643265323463623230333735393835386234666666352d6433343231323631303537376338656130383163646432393832346462346562223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1677666263),
('8423e77b4588a37d7598f8def9271461', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637363533343438362e30303530383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223334326530356236306531376162316566353933633661623534653336376563223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363533373439363b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363533373537323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313637363533383038363b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363533373531353b7d7d72656469726563745f75726c7c733a32393a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f6974656d223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223939363763633539666263326339383732346636336535373535303531643631223b733a33323a226334306631626535356239363930393339393330623031636132336161363934223b7d733a343a2268617368223b733a36353a2263343066316265353562393639303933393933306230316361323361613639342d3939363763633539666263326339383732346636336535373535303531643631223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3731313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a353a7b733a33323a223233613335616665343537643065356364653863383566636537356432646234223b733a33323a223230393833623638613636383064646663303930653566616334393639623837223b733a33323a223762656438363462303832313238656231356264646436653737633162323935223b733a33323a223931306365656162316330343635643637323334336538303138356162396666223b733a33323a223531646431616233643064316639323039303464633966316431613938656532223b733a33323a223938373966623237363331373136613435363463613865393639323739666265223b733a33323a223561633762333264356534333763356136353864613635623937626538613162223b733a33323a226264613864363935613463646362643638623831383433663839616263343138223b733a33323a223966333162363766353761386139363934393033613630396630663430613862223b733a33323a223134653131353266333537646463303837636134396438363336613764373563223b7d733a343a2268617368223b733a36353a2231346531313532663335376464633038376361343964383633366137643735632d3966333162363766353761386139363934393033613630396630663430613862223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a333637323a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a34323a7b733a33323a223363373432336135653439383032333932376433626665386531306161623162223b733a33323a223539393864613766353265353462323533386666636263373737643765636564223b733a33323a226361316465323635343937626662626234646466303966666633356632666633223b733a33323a226532623236373637323932346437656261643636626236323337356333633231223b733a33323a226237373862323139663935636266313430636237386132366138353966383537223b733a33323a226633613761383634633637333335623438356461653561393965393338643166223b733a33323a223639383935326134383935653134653764656131396263343936303232326431223b733a33323a223861346435613338626630333130633338306333616363653938393731396430223b733a33323a223839303562306639383137313434613930353661646263323639346634383364223b733a33323a223733613763313632333932343035326431653034626164663931326237363261223b733a33323a223932313366633663643739666265393638356165663931376435393866383939223b733a33323a223963666164633239386133666264386365366139326662623931393662366437223b733a33323a223533333964343239613137396339633664336436373232323962663334353566223b733a33323a223933363038363235313932666534306539326330356638633431663133383139223b733a33323a223063326137343132623438613437663437643638353530373830646539663062223b733a33323a223839623030393766633633656164303362663431363762636138653435656635223b733a33323a223866396164336661666137353837306333386265323563363831663665656132223b733a33323a223664353438316333633865316164643239376636376366643135663136303533223b733a33323a223138353030346639626337373838356465646232616138346138653439333165223b733a33323a223339623137323262613863663436326362316265636363376265343237336237223b733a33323a223234383838343765336533353664386537626331373739313839386531656637223b733a33323a223237303133653231666233313435663033376566663963323562396531626138223b733a33323a226265386263356534656661333034663165306561383030386238323562623133223b733a33323a226564636364346538353134363833373836636338366566636639366534656165223b733a33323a223235656533353465643433616662353265393134326330373962643663393231223b733a33323a226161363561363837343161396536323136353736393638303862333761666563223b733a33323a223337303537393138653633343938373961623365366131663162643564663966223b733a33323a223634313561623635376439643534356561636432393734326662333462616132223b733a33323a223338393061303338393938323764356531366665343464363133303637643561223b733a33323a223839666236323238383535633166626335386163643534313864323832636161223b733a33323a223066303534393163633536643566313265353136633361313138653036326665223b733a33323a226535316133346663633261393135666537666334383834633236666637353265223b733a33323a223133636266393630373164343636393064363432626230326137373866653331223b733a33323a226530393036643037303737653637363866333066363431663261383161323832223b733a33323a226365316439343139653132656630396636373030373434336466393130356166223b733a33323a223932366436373931306465663132323235313937383830363638653430303861223b733a33323a223730346563343037333230366561313561346533316538633762363164653332223b733a33323a223365643561656365616231626636373830663563386531333061393530623933223b733a33323a223264306266323036646137336639383434333930376438323164343836656563223b733a33323a226366376361633065396238346462323763346335366131613430376631633564223b733a33323a223435636132313837346231373963333062336362323132626630373764663234223b733a33323a223738653033616239373836396334333263356136643838313432353662383430223b733a33323a223833353862376233623036303737623234663135663430623632326438323738223b733a33323a226164643165346331643964663237623863363337313263366535386436626365223b733a33323a226161383935396436373366323530636664363063356139613833633132616439223b733a33323a223839333536336135353033323138383065656530613566393265373066303137223b733a33323a226361333330386264393163333865343730613032653638323433363038333132223b733a33323a223035383139323134383835636236373163376665363833386139316166376663223b733a33323a223761656338373932313438313535306335333362383331633161626365643234223b733a33323a226464326635363562326161336439363665666137313665333632393732383731223b733a33323a223837613836653832346262376539356162383064393665366439316438613662223b733a33323a223738313665656664306434633966396161366262303237333138393437356566223b733a33323a223134303139386138653137363439633736353033663836663664376565393330223b733a33323a223734396461303439313038326266363034643939633061333064663535616535223b733a33323a223966663561653334626231356239373565363662666638656333653534356262223b733a33323a223935323963383030633466333066323463393034633134333139653664346138223b733a33323a223765613936653237303764303430303932333666666537386438346136366535223b733a33323a226566333031386561363038663936356236303163346639313937326339616432223b733a33323a223237343862653863363231643837386666363335653663333830663433663233223b733a33323a223638326666663863616430623934333436643563333432356336643634336134223b733a33323a226664353938306164666436636236353733353832393162303934656435373164223b733a33323a223835616465346162663866643035623565643230633037303365633961333235223b733a33323a226233373961613234353165633836656139666633636365656530616564663531223b733a33323a226161643866653136633662616364346361383636333963636262383937373339223b733a33323a226162313066303938316666363765323531373266386136643230633132356361223b733a33323a223534346362633538376634633033343565363962323638393561303161666363223b733a33323a223561363038656363323738343437303361656237643463363937663037626665223b733a33323a223333653362373464663032356632393435623464346261383530666533643733223b733a33323a223063663831666462316234623863393762303165623439666165383430613661223b733a33323a223366633431356163353665343037643832323735646264386561353939613637223b733a33323a223835646163623062636332633966306264353364636236386131353261393132223b733a33323a226332633434343666383537306463633632386533306165653035616639356533223b733a33323a226438653233323134643731623263643735366336653130323630633236616137223b733a33323a223032373666373739383865646134323131666137303964393564393038663661223b733a33323a223764666432393361363832323434333739393232343636626163326261613634223b733a33323a226362346164626136613536326634336632623430346263383366303262326337223b733a33323a223930653731376566363264373739373261383266326565343630303461326463223b733a33323a226231613865663535653737636566653731343130393061306534346363666565223b733a33323a223362613162323439396439666661376438623238313733643364653062643635223b733a33323a223934333466613330626664653661353139323662303963653862333035666239223b733a33323a223739393766306664653266633932396266623762333465396231663964376134223b733a33323a226362333039646130343166653831396536333939646432363339356535343131223b733a33323a223133653464373939663863306232663065623136346561643061653237393865223b733a33323a223835646565336364343237613464386263373631626664366331626433663766223b7d733a343a2268617368223b733a36353a2238356465653363643432376134643862633736316266643663316264336637662d3133653464373939663863306232663065623136346561643061653237393865223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226664353463633531623333616636363939643566373166316561666439373661223b733a33323a223564613165333766326632396264666436623161626638356662396439313739223b7d733a343a2268617368223b733a36353a2235646131653337663266323962646664366231616266383566623964393137392d6664353463633531623333616636363939643566373166316561666439373661223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1676534486),
('e1cac0837fda4376f4cccc165abcd245', 0x5f5f4c616d696e61737c613a343a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313639383233383130342e3037363830363b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a226565643431643764623633326139313664616438656664666266363734393061223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313639383234313638303b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313639383234313730343b7d7d72656469726563745f75726c7c733a33313a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f6d6f64756c65223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226262363336613039356438373532343639306539396461353835303635323138223b733a33323a223236633233653036613934396165653561383563333737356338663931386237223b7d733a343a2268617368223b733a36353a2232366332336530366139343961656535613835633337373563386639313862372d6262363336613039356438373532343639306539396461353835303635323138223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a38303a7b733a33323a223039376336633933666162633066343933383834633935643065386264366466223b733a33323a226537343437383633336332653939396462656334313439313938316463386665223b733a33323a223166616466343366393337303232633661353862306366373333313138313930223b733a33323a223863313531326536643362643435343933336430356430383237346137363933223b733a33323a223735373432646564333665653764633962663934383538323838356666363532223b733a33323a223566643762323231396339303933346139373934323632616661353137313562223b733a33323a223737386365383664663262323362393461386364613335343966666336353639223b733a33323a226562316239656137396631343532353137613364313130363862363931353838223b733a33323a223963663932616335396638323265323433636664373737353230313061343439223b733a33323a223830313732613039616330616163313833336166333664366264616435636237223b733a33323a223665386339663766613865323462626663643537323763356166636636303161223b733a33323a226433373033316434316633393535643861343466656666323363386464623536223b733a33323a226239333635353635363836353034323663306365633138373639633764643965223b733a33323a226236663062643966653331363964323438633838393766343563663136666530223b733a33323a226433373966666637386165376462326662613864613665343730623936386662223b733a33323a223361343631653035623330663762393931656530613964323362353765343466223b733a33323a226334393130633265393331613333336266643932626162356662356165666630223b733a33323a223764333830366435663531396537323666663738633966363535366165393931223b733a33323a223736623538376466333661323835326636326433656265663735656532326263223b733a33323a226563653639393935303836383763633136363832386633316435623937613739223b733a33323a226233313833333833376363353261623632663465353532643564623239316362223b733a33323a223235333063326132623763343737326262663632323936393262643537333962223b733a33323a223237363330616362313735383161343361663130656234616338333633623761223b733a33323a223839356430366135646336343131636335353739333031373164643765353737223b733a33323a223766336161306562613633653136666137326261316264643935636535356531223b733a33323a223532353335313538353233396261663430386563343135663431653032326561223b733a33323a226539373965366336616534303163653032376362653439363132666439653632223b733a33323a223163396633336334313236383765336562343433343832343532656435616134223b733a33323a223630323862376562383136333762393365656139333537313766383361343938223b733a33323a226564376636396466353035366439646638383130343265313365316539326338223b733a33323a226431356339313532653537316339336133616263626661323338626663663836223b733a33323a223034366339333337316634646138663863616437316433313461333234363565223b733a33323a223238366138356437323431346663343036626362336439633362643061323534223b733a33323a223661316337633561333738393266643033333765383833353464613363363962223b733a33323a223139316262646237633564346639623361303662386538623732353235383538223b733a33323a226631366333336562343462663966623636396334616464623239393536656265223b733a33323a226162303031363063656333663361323731323361373034316431386430623861223b733a33323a223130623435653063313132643066343130316264636231626639623666363134223b733a33323a223935633337656364373931343561633062356466326238333234303063383539223b733a33323a223836303439623635326366626464646263623135643864633764623639303862223b733a33323a223139633936313237313533646662613334323962363532626562656561356538223b733a33323a223863666639373361323439336165313964363664623538636530653535616535223b733a33323a223666353239333733613061636535316665643931366332343861363761336565223b733a33323a223461306430623666633031353464303039653866666135323837623134376563223b733a33323a226564363862323963386164616334363438323064366466613266383066333463223b733a33323a223961616564653465303238303533326634356331616164353764636366333135223b733a33323a223364343564613636613531623234326339376532663433393164666433323837223b733a33323a223830616537646532623330633361633662656261373839336534363062383934223b733a33323a223766343138303239356634363033383435613135626562303464383934633535223b733a33323a223338386265613535636561366134326362306339383562376462613734633465223b733a33323a226636343038643066666561343032656363316462353834316637313365626236223b733a33323a226633323665626533633930343262313961633564666535383132656365643066223b733a33323a226663643733616634616663306465363763326638303131363932656532613365223b733a33323a223335313133633438373564363636633961353766333466323932363337643166223b733a33323a226434383036616366313535636262666637383766363132333764373362346164223b733a33323a223839633139326563333031356638643334656233373861613266393062316536223b733a33323a223733653065636636336330643832376639366563336566343534386632663062223b733a33323a226631393739616234646466633664613262626639356132303561396231653664223b733a33323a223831643931303236656162623632623764323634636634653064393239363837223b733a33323a226536373431643131616662323931396138633831313262303735306135666638223b733a33323a223032326632636634303266306332633632643337343038343963623633613738223b733a33323a223834656135363838323538643464356261343735306463616361626531326432223b733a33323a223563343361653334663565663733653961346332393362656632353963393936223b733a33323a226330653138636365373861613039396337313432326264303065306234393739223b733a33323a226532343930636665666233643235636631376664663137626463363566306630223b733a33323a223237326338333730346334366635376266623436393462626132383663326639223b733a33323a226232666165323264623165323832656461373635356364613732363837623231223b733a33323a223331306263366362623738663330666161633032313661333764636138333562223b733a33323a223434343966613337646261613462376231376330396530393161303430666438223b733a33323a223630666363316263383539393564366162343730643231353165643630326632223b733a33323a226438633339323035376164616237653364326164336133306536303732643834223b733a33323a223563393039326263333034356266343663393538666632323431306262623064223b733a33323a223132373365376234633539623161613135356164663466343266306136623139223b733a33323a226532373837366234643362356638353730633061383862346636393439346262223b733a33323a223332386630303133626533356462333637653334383139323136383262666537223b733a33323a223865323235353465323531396237623661666639666431313432623862666336223b733a33323a223635343834396135633737656537613061333139313132666364323666396134223b733a33323a226130323330393130633632393962383333653262356337633038363435356237223b733a33323a223037376635316536613131323835386465313365643163376634666431636632223b733a33323a223537336664393336376336623533613431663563353736613938633063653135223b733a33323a226137303534663838363937323335386539666464613136313865313439393639223b733a33323a223130643331366136326539303830643862636264363636653631386366613335223b733a33323a223733646632313937336230666538333161356266623336306462663030393732223b733a33323a223762383334363130353836373266626235626461343037356134383739386139223b733a33323a226232376338386336396365396237643031376437393636613838633135323734223b733a33323a226439313031313233353363356361393136633539366166363264313036323435223b733a33323a226336313533333037346366316238303564376433616361613330346133633763223b733a33323a223339353631363062326161393135313739393966326364343636323864316635223b733a33323a226338333931643762343037343365326363626137626638623636613035303537223b733a33323a223331353739323863303565366437396531633362643034656366656231666639223b733a33323a226461343065643734316566646337633463303837636664643736663036386564223b733a33323a223539636362333763376532333365326565626336343162393138346535663862223b733a33323a223565613536623334636465653466333965636637383132623735636431376636223b733a33323a226338323637323339393032313135373266633234616332636134393733633866223b733a33323a226138663436333537323866613037356666363230666139323265386636633836223b733a33323a223164356631316138306330643037343864653536656665313433646564323730223b733a33323a226231336236303261613439613562653234623533643036626537663266333235223b733a33323a226263663466356162653961636333636438636566303463353836663535633838223b733a33323a223435353536643261323765386235336137366462316661663561633230306266223b733a33323a223235323362343932633937356337346561306235633634633238356461666362223b733a33323a226363623631633234323664326363316539633263316263393264346339376637223b733a33323a223433653334626564323039306634363961313163383462646563656239383831223b733a33323a223434663136303663326666313761623564633235613232613338393633323364223b733a33323a223262396536323237643266336233303338363761313863303639643661313866223b733a33323a223134623666313736353666666332613035343738306164336333386339336337223b733a33323a223333343730313234376435626134373733666663373637376330376161396435223b733a33323a226234656663633664393665663331383735363637613765643730363131653934223b733a33323a223231336364623630323031643766336261363265633566656464626234306633223b733a33323a226232376639313333646536396664386239363466393138313765393263326264223b733a33323a223466636330626462353137656465393135313736653463353239363534636538223b733a33323a223230643465333438656235653237316461343830643336396238323036666132223b733a33323a226466373661613166643938666430353439633038643530353561643865653233223b733a33323a223539333037316163383061653639633632323934653336623665633835393037223b733a33323a223930303638666430323835613462336531613464303434613934353833333031223b733a33323a223235666330306232363031326332656339623864373838656237626266626131223b733a33323a226331633832366331363562616262643462393863383865633763313038363763223b733a33323a223636613962353034313434623333366463396634353535343933323439623530223b733a33323a226134306663396563353066343139333061363737313066663030346561333032223b733a33323a223330386234346666646236353935386265616165316464656562363139313535223b733a33323a226437646261613066346231386233323336366532373236383634353430626164223b733a33323a223062346361306238343134393462396239653665643965323563376463316664223b733a33323a223137323838633831666138636461643639363264306165373037643238613531223b733a33323a226136636231353838343339346265303462646437623062623661623564383631223b733a33323a223661303037323934326562653335306138313637316431666332336463333532223b733a33323a223734313339613866396661323062333935356666343865323330343561643637223b733a33323a226463646237326336343965393938616434373032366239323561383039653333223b733a33323a223566343866663761636563626639323966336463343964656232366438303236223b733a33323a223336633139373136633964323263396563356439393932386164393933346138223b733a33323a223131383964643963343466316636366463656464636535346238383732313662223b733a33323a223538353864373031613332333136373364613538386664616461326537613966223b733a33323a226533666362303036366132663734343432313934366365303131353335663433223b733a33323a226230356338383561643830356361353066373132396364313336636164303539223b733a33323a223031323831373133383631386139386336663336303330626366653435336433223b733a33323a223130623862353864376636396163653631363433663333303237326437363636223b733a33323a226636396466356138656632663730326634656338383136393666636466636234223b733a33323a223330663437326531376562386361643035323534333064323863626265353030223b733a33323a223732656262343330653137373133653134376664623138326535616162366232223b733a33323a223136306136646165343031376131663164326230303664666533323239316636223b733a33323a223633646235663064303531303834613730613330383939646230333833336633223b733a33323a223466626238636139666263653331393563356135643638316237653338653633223b733a33323a223035383831363235356134363462666338336462326261316663656432353131223b733a33323a223239346465656664393331383431356430643963396565396666656362616164223b733a33323a223631646530303261396332386234326465616264306237303635613362356161223b733a33323a226237626133343934656461326535313939613664383533396534393165333136223b733a33323a226330313664393432333934343233306132623636366162363034623638343763223b733a33323a223764336330623062653438666434386163623136373035366435313731616264223b733a33323a226465646466396564643338363732613462646161653961336537623032326338223b733a33323a223733643834346438666462373136643065643334663965386462356335316630223b733a33323a223936306437653437356666333430343231396162363531383065663236316231223b733a33323a226431613237373031303137623237613139323264323137313938356130376339223b733a33323a223435363230663336396662303665663538633763653531356430373337316638223b733a33323a226433623638396431373133396436363235643964303639323561386261336365223b733a33323a223934356238313861346134643937613538306332323939653238656161313964223b733a33323a223863333239373865343330313239346133616431383935613533616231396133223b733a33323a223964306366336234626331336366346337386236653234383766356139663835223b733a33323a223333646464623338363939366264383439643638383864303065313233653935223b733a33323a223937663338653336393138386131616438396364333235383537653462306238223b733a33323a226337366432383062666636613261326532626662613531316232373731613862223b733a33323a223134346263653538663934316266313265313132386635306465613734623231223b733a33323a226339653164623764393535343162306135316337393965333638616130316338223b7d733a343a2268617368223b733a36353a2263396531646237643935353431623061353163373939653336386161303163382d3134346263653538663934316266313265313132386635306465613734623231223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1698238104);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
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
('advancedsearch_main_config', '\"1\"'),
('advancedsearch_restrict_used_terms', '\"1\"'),
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
('bulkedit_deduplicate_on_save', 'true'),
('bulkexport_format_fields', '\"name\"'),
('bulkexport_format_generic', '\"string\"'),
('bulkexport_format_resource', '\"id\"'),
('bulkexport_format_resource_property', '\"dcterms:identifier\"'),
('bulkexport_format_uri', '\"uri_label\"'),
('bulkexport_formatters', '[\"csv\",\"json-ld\",\"ods\",\"tsv\",\"txt\"]'),
('bulkexport_limit', '1000'),
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
('extension_whitelist', '[\"aac\",\"aif\",\"aiff\",\"asf\",\"asx\",\"avi\",\"bmp\",\"c\",\"cc\",\"class\",\"css\",\"divx\",\"doc\",\"docx\",\"exe\",\"gif\",\"gz\",\"gzip\",\"h\",\"ico\",\"j2k\",\"jp2\",\"jpe\",\"jpeg\",\"jpg\",\"m4a\",\"m4v\",\"mdb\",\"mid\",\"midi\",\"mov\",\"mp2\",\"mp3\",\"mp4\",\"mpa\",\"mpe\",\"mpeg\",\"mpg\",\"mpp\",\"odb\",\"odc\",\"odf\",\"odg\",\"odp\",\"ods\",\"odt\",\"ogg\",\"opus\",\"pdf\",\"png\",\"pot\",\"pps\",\"ppt\",\"pptx\",\"qt\",\"ra\",\"ram\",\"rtf\",\"rtx\",\"swf\",\"tar\",\"tif\",\"tiff\",\"txt\",\"wav\",\"wax\",\"webm\",\"wma\",\"wmv\",\"wmx\",\"wri\",\"xla\",\"xls\",\"xlsx\",\"xlt\",\"xlw\",\"zip\",\"bin\",\"dae\",\"fbx\",\"glb\",\"gltf\",\"json\",\"ktx2\",\"mtl\",\"obj\"]'),
('file_sideload_delete_file', '\"no\"'),
('file_sideload_directory', '\"\\/data\\/sftp\\/omeka-sideload\\/\"'),
('file_sideload_max_directories', '1000'),
('file_sideload_max_files', '1000'),
('hidden_properties_admin_show_all', 'false'),
('hidden_properties_properties', '[\"extracttext:extracted_text\"]'),
('installation_title', '\"OmekaS Docker\"'),
('locale', '\"\"'),
('media_alt_text_property', '\"\"'),
('media_type_whitelist', '[\"application\\/msword\",\"application\\/ogg\",\"application\\/pdf\",\"application\\/rtf\",\"application\\/vnd.ms-access\",\"application\\/vnd.ms-excel\",\"application\\/vnd.ms-powerpoint\",\"application\\/vnd.ms-project\",\"application\\/vnd.ms-write\",\"application\\/vnd.oasis.opendocument.chart\",\"application\\/vnd.oasis.opendocument.database\",\"application\\/vnd.oasis.opendocument.formula\",\"application\\/vnd.oasis.opendocument.graphics\",\"application\\/vnd.oasis.opendocument.presentation\",\"application\\/vnd.oasis.opendocument.spreadsheet\",\"application\\/vnd.oasis.opendocument.text\",\"application\\/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"application\\/vnd.openxmlformats-officedocument.presentationml.presentation\",\"application\\/vnd.openxmlformats-officedocument.spreadsheetml.sheet\",\"application\\/x-gzip\",\"application\\/x-ms-wmp\",\"application\\/x-msdownload\",\"application\\/x-shockwave-flash\",\"application\\/x-tar\",\"application\\/zip\",\"audio\\/midi\",\"audio\\/mp4\",\"audio\\/mpeg\",\"audio\\/ogg\",\"audio\\/x-aac\",\"audio\\/x-aiff\",\"audio\\/x-ms-wma\",\"audio\\/x-ms-wax\",\"audio\\/x-realaudio\",\"audio\\/x-wav\",\"image\\/bmp\",\"image\\/gif\",\"image\\/jp2\",\"image\\/jpeg\",\"image\\/pjpeg\",\"image\\/png\",\"image\\/tiff\",\"image\\/x-icon\",\"text\\/css\",\"text\\/plain\",\"text\\/richtext\",\"video\\/divx\",\"video\\/mp4\",\"video\\/mpeg\",\"video\\/ogg\",\"video\\/quicktime\",\"video\\/webm\",\"video\\/x-ms-asf\",\"video\\/x-msvideo\",\"video\\/x-ms-wmv\",\"application\\/octet-stream\",\"application\\/vnd.threejs+json\",\"model\\/gltf-binary\",\"model\\/gltf+json\",\"model\\/obj\",\"model\\/vnd.collada+xml\",\"model\\/vnd.filmbox\",\"image\\/ktx2\",\"model\\/mtl\"]'),
('modelviewer_config_default', '\"\"'),
('modelviewer_config_property', '\"dcterms:abstract\"'),
('pagination_per_page', '\"25\"'),
('property_label_information', '\"none\"'),
('recaptcha_secret_key', '\"\"'),
('recaptcha_site_key', '\"\"'),
('searchsolr_server_id', '\"1ik8m4\"'),
('time_zone', '\"Europe\\/Amsterdam\"'),
('use_htmlpurifier', '\"0\"'),
('value_languages', '[]'),
('version', '\"4.0.4\"'),
('version_notifications', '\"1\"');

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE `site` (
  `id` int(11) NOT NULL,
  `thumbnail_id` int(11) DEFAULT NULL,
  `homepage_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `slug` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` longtext COLLATE utf8mb4_unicode_ci,
  `navigation` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `item_pool` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `assign_new_items` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`id`, `thumbnail_id`, `homepage_id`, `owner_id`, `slug`, `theme`, `title`, `summary`, `navigation`, `item_pool`, `created`, `modified`, `is_public`, `assign_new_items`) VALUES
(1, NULL, NULL, 1, 'default', 'default', 'default site', 'Default site created at Docker bootstrap phase', '[{\"type\":\"browse\",\"data\":{\"label\":\"Browse\",\"query\":\"\"},\"links\":[]},{\"type\":\"page\",\"links\":[],\"data\":{\"id\":2,\"label\":null}}]', '[]', '2023-02-15 16:04:55', '2023-03-01 10:24:23', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `site_block_attachment`
--

CREATE TABLE `site_block_attachment` (
  `id` int(11) NOT NULL,
  `block_id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `caption` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_item_set`
--

CREATE TABLE `site_item_set` (
  `id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `item_set_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_page`
--

CREATE TABLE `site_page` (
  `id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `slug` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page`
--

INSERT INTO `site_page` (`id`, `site_id`, `slug`, `title`, `is_public`, `created`, `modified`) VALUES
(1, 1, 'welcome', 'Welcome', 1, '2023-02-15 16:04:55', '2023-02-15 16:04:55'),
(2, 1, 'search_iJ2q', 'Search', 1, '2023-02-28 14:48:57', '2023-02-28 14:49:36');

-- --------------------------------------------------------

--
-- Table structure for table `site_page_block`
--

CREATE TABLE `site_page_block` (
  `id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `layout` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page_block`
--

INSERT INTO `site_page_block` (`id`, `page_id`, `layout`, `data`, `position`) VALUES
(1, 1, 'html', '{\"html\":\"Welcome to your new site. This is an example page.\"}', 1),
(2, 2, 'pageTitle', '[]', 1),
(3, 2, 'searchingForm', '{\"heading\":\"\",\"search_config\":\"1\",\"display_results\":\"1\",\"query\":\"\",\"query_filter\":\"\"}', 2);

-- --------------------------------------------------------

--
-- Table structure for table `site_permission`
--

CREATE TABLE `site_permission` (
  `id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL
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
  `id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` int(11) NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_setting`
--

INSERT INTO `site_setting` (`id`, `site_id`, `value`) VALUES
('advancedsearch_configs', 1, '[\"1\"]'),
('advancedsearch_main_config', 1, '\"1\"'),
('advancedsearch_redirect_itemset', 1, '\"1\"'),
('advancedsearch_restrict_used_terms', 1, '\"1\"'),
('advancedsearch_search_fields', 1, '\"\"'),
('attachment_link_type', 1, '\"item\"'),
('browse_attached_items', 1, '\"0\"'),
('browse_body_property_term', 1, '\"\"'),
('browse_heading_property_term', 1, '\"\"'),
('bulkexport_format_fields', 1, '\"label\"'),
('bulkexport_format_generic', 1, '\"string\"'),
('bulkexport_format_resource', 1, '\"id\"'),
('bulkexport_format_resource_property', 1, '\"dcterms:identifier\"'),
('bulkexport_format_uri', 1, '\"uri_label\"'),
('bulkexport_formatters', 1, '[\"csv\",\"json-ld\",\"ods\",\"tsv\",\"txt\"]'),
('bulkexport_limit', 1, '1000'),
('bulkexport_metadata', 1, '[\"id\",\"url\",\"o:resource_class\",\"properties_small\"]'),
('bulkexport_metadata_exclude', 1, '[\"o:owner\",\"properties_large\",\"extracttext:extracted_text\"]'),
('bulkexport_template', 1, '\"\"'),
('disable_jsonld_embed', 1, '\"0\"'),
('eucookiebar_message', 1, '\"<p>Warning: this site uses cookies or other means to steal your personal data and to allow Google or Facebook to fetch them. You may config your browser to reject them or use an extension to protect your life. See terms and conditions. By visiting this site, you accept them.<\\/p>\\r\\n\"'),
('eucookiebar_options', 1, '\"{\\r\\n    \\\"acceptButton\\\": true,\\r\\n    \\\"acceptText\\\": \\\"OK\\\",\\r\\n    \\\"declineButton\\\": false,\\r\\n    \\\"declineText\\\": \\\"Disable Cookies\\\",\\r\\n    \\\"policyButton\\\": false,\\r\\n    \\\"policyText\\\": \\\"Privacy Policy\\\",\\r\\n    \\\"policyURL\\\": \\\"\\/\\\",\\r\\n    \\\"bottom\\\": true,\\r\\n    \\\"fixed\\\": true,\\r\\n    \\\"zindex\\\": \\\"99999\\\"\\r\\n}\"'),
('filter_locale_values', 1, '\"0\"'),
('item_media_embed', 1, '\"1\"'),
('locale', 1, '\"\"'),
('pdfviewer_template', 1, '\"common\\/pdf-viewer\"'),
('search_resource_names', 1, '[\"site_pages\",\"items\"]'),
('search_restrict_templates', 1, '\"0\"'),
('search_type', 1, '\"sitewide\"'),
('show_attached_pages', 1, '\"1\"'),
('show_locale_label', 1, '\"1\"'),
('show_page_pagination', 1, '\"1\"'),
('show_user_bar', 1, '\"0\"'),
('show_value_annotations', 1, '\"0\"');

-- --------------------------------------------------------

--
-- Table structure for table `solr_core`
--

CREATE TABLE `solr_core` (
  `id` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
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
  `id` int(11) NOT NULL,
  `solr_core_id` int(11) NOT NULL,
  `resource_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pool` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `settings` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
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
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `password_hash` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `value`
--

CREATE TABLE `value` (
  `id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value_resource_id` int(11) DEFAULT NULL,
  `value_annotation_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `uri` longtext COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `value`
--

INSERT INTO `value` (`id`, `resource_id`, `property_id`, `value_resource_id`, `value_annotation_id`, `type`, `lang`, `value`, `uri`, `is_public`) VALUES
(1, 1, 1, NULL, NULL, 'literal', NULL, 'First item', NULL, 1),
(2, 1, 4, NULL, NULL, 'literal', NULL, 'This is the first item in this Omeka instance. It was created during the Docker bootstrap phase.\nIt contains metadata, but no associated media files.', NULL, 1),
(4, 1, 10, NULL, NULL, 'literal', NULL, 'ark:/99999/a1apZs2', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `value_annotation`
--

CREATE TABLE `value_annotation` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vocabulary`
--

CREATE TABLE `vocabulary` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `namespace_uri` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci
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
(6, 1, 'https://schema.org/', 'schema', 'Schema.org', 'Info: https://schema.org/docs/developers.html');

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
  ADD KEY `IDX_AA31FE4A7E3C61F9` (`owner_id`);
ALTER TABLE `fulltext_search` ADD FULLTEXT KEY `IDX_AA31FE4A2B36786B3B8BA7C7` (`title`,`text`);

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
  ADD KEY `item_position` (`item_id`,`position`);

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
  ADD KEY `title` (`title`(190));

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
  ADD KEY `IDX_2F900BD9F6BD1646` (`site_id`);

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
  ADD KEY `uri` (`uri`(190));

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_export`
--
ALTER TABLE `bulk_export`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1638;

--
-- AUTO_INCREMENT for table `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resource_class`
--
ALTER TABLE `resource_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=999;

--
-- AUTO_INCREMENT for table `resource_template`
--
ALTER TABLE `resource_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `search_config`
--
ALTER TABLE `search_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `search_engine`
--
ALTER TABLE `search_engine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `search_suggester`
--
ALTER TABLE `search_suggester`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_item_set`
--
ALTER TABLE `site_item_set`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_page`
--
ALTER TABLE `site_page`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `site_page_block`
--
ALTER TABLE `site_page_block`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `site_permission`
--
ALTER TABLE `site_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `solr_core`
--
ALTER TABLE `solr_core`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `solr_map`
--
ALTER TABLE `solr_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `value`
--
ALTER TABLE `value`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vocabulary`
--
ALTER TABLE `vocabulary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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

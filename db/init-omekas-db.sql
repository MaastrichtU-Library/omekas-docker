-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Feb 28, 2023 at 02:51 PM
-- Server version: 5.7.38
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
  `terms` longtext COLLATE utf8mb4_unicode_ci,
  `uris` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`) VALUES
(1);

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
('20210810083804');

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
('AdvancedSearch', 1, '3.4.6.20'),
('ArchiveRepertory', 1, '3.15.16'),
('Ark', 1, '3.5.13.3'),
('BlocksDisposition', 1, '3.3.2.2'),
('BulkEdit', 1, '3.3.13.4'),
('CleanUrl', 1, '3.17.4.4'),
('CSVImport', 1, '2.3.1'),
('CustomVocab', 1, '1.6.0'),
('EUCookieBar', 1, '3.3.4.3'),
('ExtractText', 1, '1.2.1'),
('FileSideload', 1, '1.5.0'),
('Generic', 1, '3.3.34'),
('HideProperties', 1, '1.3.0'),
('ModelViewer', 1, '3.3.0.7-132'),
('NumericDataTypes', 1, '1.8.0'),
('PdfViewer', 1, '3.3.4.2'),
('SearchSolr', 1, '3.5.40.4'),
('ValueSuggest', 1, '1.12.0');

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
(185, 1, 5, 'extracted_text', 'extracted text', 'Text extracted from a resource.');

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
(105, NULL, 4, 'OnlineChatAccount', 'Online Chat Account', 'An online chat account.');

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
  `is_private` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_template_property`
--

INSERT INTO `resource_template_property` (`id`, `resource_template_id`, `property_id`, `alternate_label`, `alternate_comment`, `position`, `data_type`, `is_required`, `is_private`) VALUES
(1, 1, 1, NULL, NULL, 1, NULL, 0, 0),
(2, 1, 15, NULL, NULL, 2, NULL, 0, 0),
(3, 1, 8, NULL, NULL, 3, NULL, 0, 0),
(4, 1, 2, NULL, NULL, 4, NULL, 0, 0),
(5, 1, 7, NULL, NULL, 5, NULL, 0, 0),
(6, 1, 4, NULL, NULL, 6, NULL, 0, 0),
(7, 1, 9, NULL, NULL, 7, NULL, 0, 0),
(8, 1, 12, NULL, NULL, 8, NULL, 0, 0),
(9, 1, 40, 'Place', NULL, 9, NULL, 0, 0),
(10, 1, 5, NULL, NULL, 10, NULL, 0, 0),
(11, 1, 17, NULL, NULL, 11, NULL, 0, 0),
(12, 1, 6, NULL, NULL, 12, NULL, 0, 0),
(13, 1, 25, NULL, NULL, 13, NULL, 0, 0),
(14, 1, 10, NULL, NULL, 14, NULL, 0, 0),
(15, 1, 13, NULL, NULL, 15, NULL, 0, 0),
(16, 1, 29, NULL, NULL, 16, NULL, 0, 0),
(17, 1, 30, NULL, NULL, 17, NULL, 0, 0),
(18, 1, 50, NULL, NULL, 18, NULL, 0, 0),
(19, 1, 3, NULL, NULL, 19, NULL, 0, 0),
(20, 1, 41, NULL, NULL, 20, NULL, 0, 0);

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
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_config`
--

INSERT INTO `search_config` (`id`, `engine_id`, `name`, `path`, `form_adapter`, `settings`, `created`, `modified`) VALUES
(1, 2, 'Default', 'find', 'main', '{\"search\":{\"default_results\":\"default\",\"default_query\":\"\",\"default_query_post\":\"\",\"hidden_query_filters\":[]},\"autosuggest\":{\"suggester\":\"1\",\"url\":\"\",\"url_param_name\":\"\",\"limit\":null},\"form\":{\"filters\":[{\"field\":\"dcterms_title_txt\",\"label\":\"Title\",\"type\":\"\",\"options\":[]},{\"field\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\",\"options\":[]},{\"field\":\"advanced\",\"label\":\"Filters\",\"type\":\"Advanced\",\"fields\":{\"title\":{\"value\":\"title\",\"label\":\"Title\"},\"author\":{\"value\":\"author\",\"label\":\"Author\"},\"dcterms:creator\":{\"value\":\"dcterms:creator\",\"label\":\"Creator\"},\"dcterms:subject\":{\"value\":\"dcterms:subject\",\"label\":\"Subject\"},\"date\":{\"value\":\"date\",\"label\":\"Date\"},\"description\":{\"value\":\"description\",\"label\":\"Description\"},\"resource_class_id\":{\"value\":\"resource_class_id\",\"label\":\"Class\"}},\"max_number\":\"5\",\"field_joiner\":\"1\",\"field_joiner_not\":\"1\",\"field_operator\":\"1\",\"field_operators\":{\"eq\":\"is exactly\",\"in\":\"contains\",\"sw\":\"starts with\",\"ew\":\"ends with\",\"ex\":\"has any value\",\"res\":\"is resource with ID\"}}]},\"display\":{\"search_filters\":\"header\",\"paginator\":\"header\",\"per_pages\":\"header\",\"sort\":\"header\",\"grid_list\":\"header\",\"grid_list_mode\":\"auto\"},\"pagination\":{\"per_pages\":{\"10\":\"Results by 10\",\"25\":\"Results by 25\",\"50\":\"Results by 50\",\"100\":\"Results by 100\"}},\"sort\":{\"fields\":{\"dcterms:title asc\":{\"name\":\"dcterms:title asc\",\"label\":\"Title\"},\"dcterms:title desc\":{\"name\":\"dcterms:title desc\",\"label\":\"Title (from z to a)\"},\"dcterms:date asc\":{\"name\":\"dcterms:date asc\",\"label\":\"Date\"},\"dcterms:date desc\":{\"name\":\"dcterms:date desc\",\"label\":\"Date (most recent first)\"}}},\"facet\":{\"facets\":{\"resource_class_s\":{\"name\":\"resource_class_s\",\"label\":\"Resource class\",\"type\":\"\"},\"dcterms_creator_s\":{\"name\":\"dcterms_creator_s\",\"label\":\"Creator\",\"type\":\"\"}},\"limit\":\"10\",\"order\":\"\",\"languages\":[],\"mode\":\"button\",\"display_button\":\"above\",\"display_active\":\"1\",\"display_count\":\"1\"}}', '2023-02-15 16:01:30', '2023-02-28 14:50:30');

-- --------------------------------------------------------

--
-- Table structure for table `search_engine`
--

CREATE TABLE `search_engine` (
  `id` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adapter` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL,
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
  `created` datetime NOT NULL,
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
('56fd7c9686954d646df89a7fb4cd6865', 0x5f5f4c616d696e61737c613a31313a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637363437373138332e3235303734393b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a226139643036623530383136323663326433393135343439346237643237393735223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363437393436333b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303736353b7d733a36363a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f417263686976655265706572746f72795f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303439363b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303530313b7d733a35383a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303531343b7d733a36313a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f45787472616374546578745f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303631373b7d733a36323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f46696c65536964656c6f61645f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303632323b7d733a36343a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4869646550726f706572746965735f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303633323b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363438303736353b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226538656630303331393438666565346531626437303963666164646333643962223b733a33323a223339373036346134396638383635626134656334353030663134636565316637223b7d733a343a2268617368223b733a36353a2233393730363461343966383836356261346563343530306631346365653166372d6538656630303331393438666565346531626437303963666164646333643962223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d72656469726563745f75726c7c4e3b4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a32383331333a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3335303a7b733a33323a223730656466366531353239353062303939353035356238363438343137643235223b733a33323a223138623865656262383364653733386139383565366632376438353634663337223b733a33323a226138333731643762616338666531373033663932623435343032326231343938223b733a33323a223131663934363964373464336639653165396665313332303465626564306165223b733a33323a223637613338333837303130343734613964353137613363663632386637663161223b733a33323a223536613236303231393332626430323030326435346235346634663533633338223b733a33323a223364356137323639306138643261323833323864316530626436633938353565223b733a33323a223064663162326130643635393739356433393366313437326365363837343432223b733a33323a223764356465333161396339323832356164373666636465643833333139643436223b733a33323a223433346365313739623732306664383331333831333233346439353465386264223b733a33323a226565376231396439376662303535393237373464656463346232623933666264223b733a33323a223662393261623861626533613131383333633566636436343638306135353664223b733a33323a223362613762643932616263623832363766316333626638323332663936656530223b733a33323a226133653337626236336637616161346430633134326636313438656535383835223b733a33323a226334363730306336353836613439326630363066623639393138633932393766223b733a33323a223261633764323032613537356666363763306434663039646334623166326365223b733a33323a226335383237363035303465613636346337383035646436396336396666653339223b733a33323a223639376334333133646262653762353765383036666631366135356139656130223b733a33323a226634356363323635626639313564353130393635656162333737623739376635223b733a33323a226133313863663539613864316133653332613563316561613634336635663439223b733a33323a226562363861663935323561386361353564636333666536363633333338613334223b733a33323a223430653838623031653130383737643938353662306135353737306630633362223b733a33323a223465316565353964373935326533616635646235333262333036376536626139223b733a33323a226362663631303965356162313532356366333464613638613937353535333539223b733a33323a223765396462653166653032656231636134653535326538366663633466643364223b733a33323a223435333637323465646261323338613130323865316138343733373235373662223b733a33323a226632306633383436353464303730313338623433383362633661303333613265223b733a33323a223137306437336531633538613437656633396664313465316239313061336533223b733a33323a226234623565373930353439343861366433383337636566346262383630613432223b733a33323a223361626330363536386436333363633034346336656135333231633965353761223b733a33323a223232653331316563643064336261393435396363646137663237353266306430223b733a33323a223434333036363733316566653034376635643464626137333231623862316163223b733a33323a223762363335623133303535633034616530306137356638366163343632663066223b733a33323a226530353835313131303738306263396335633665333832343665306465623932223b733a33323a223162366564396537376465636238613934623036366566396231376664623165223b733a33323a223462313163363439363132363337613234613537653632336632666237323536223b733a33323a223336343363646166366433396366346130303135336630666136366466643334223b733a33323a223633643663386633613539653062663061323132623031363533613638636438223b733a33323a226563323030323131356634666535616664356464333063373135653464666337223b733a33323a223139393937383733323933326461323939316262626239633331363532323866223b733a33323a226637303231643933366133333031326363633964613534353566663932336662223b733a33323a226462646634386637616133343230626539393138653537356537356435326338223b733a33323a223166626533336164643564613636623364303930346264653334653537323436223b733a33323a226530353366616434303762666364633636633866653264343031333935346266223b733a33323a226165393534336634663532313837326233383561666131623231356136663035223b733a33323a223665393866636234353165323062336435316539613461633237373862396534223b733a33323a226363343437636633343030373139623863616561643064376630336430616163223b733a33323a226438336462616339373262336139323134306339326433336333636362616265223b733a33323a223937323662666561333537663864663664393336616533643838643939653634223b733a33323a223962313832643263343833626331643331303738643564613034306262613266223b733a33323a226236393239306361376335306565303137623035363133653962386266633237223b733a33323a223739626364373938616633616539323334363439643561663862643136626264223b733a33323a226638323032633965306137373436313931393262663430373130323038616237223b733a33323a223932643336303164323938616134323236363834613739346465363736616263223b733a33323a226537393731333630303235613461386536643533316365326639353639346563223b733a33323a223639366261343332343664653866636463386530396262316164303032303732223b733a33323a223837396530633632363735386164663461363732353535323365356331356336223b733a33323a223637303566633437373038303866666462663166626539336462663631663132223b733a33323a226361313932643936643436636564376434623336626435333165373734343630223b733a33323a223339303432323439613737303265346137616461313966356563333165653837223b733a33323a223162633139663833636161356434333933363132633161343431613231366266223b733a33323a223564373230343539616638633765383665373062623836316561323762373761223b733a33323a223062633033343338653065376339336131343631373130353039646636353163223b733a33323a223332343434356261343437353232636530333730616162393436316465666232223b733a33323a223639636262666537626637663234303734336435616131386265303665623831223b733a33323a226335373039376336646663393363626636643761366435303761646233626364223b733a33323a223165613565643239353865363638326235613033363435666136653036633132223b733a33323a223332616162336566326638363935383865353738353533626336616362393264223b733a33323a223961396365393763633961373730303335663865336337386364383865323365223b733a33323a223838396663366338633434636662323535333435323062316365666331613264223b733a33323a226132626364363863333764346362346461376665613835353335646264363563223b733a33323a223330383530323639613431396636306666303336346362663133633332336235223b733a33323a223035303365326238353361323866376662363231313634353061343366393264223b733a33323a226165323033643232383430336134363532383235643832383932653261666261223b733a33323a226138306262343361616136616261383165626638383433353032366430316665223b733a33323a226531633464366266313864313561306430653136373436663734656539646536223b733a33323a223438336530643963633565623131396236653333336537356464376630613365223b733a33323a226333386263656563633934323638663062663737363836616330316333623632223b733a33323a223464353763333364376233313736383638343037616437346237383538353236223b733a33323a226161393365663231616563663437373439383035363536356334373163666139223b733a33323a226562396364633364363863386335613965383461343266396264656235363838223b733a33323a223062393638393638363230336537383537613266336463323332376366316561223b733a33323a226133393439356566653861326430353166373335336232333531623539616565223b733a33323a223035366136386533303664353837616230333035613266333734666539313431223b733a33323a223930653233333031623035323464333066643665383133313562633263613435223b733a33323a226431326231643064376562383262613430333362653937613238386561646132223b733a33323a223630366137646466363863643763373065306531613663333535323431613531223b733a33323a226362346335616230376362306664656139336534653935333230353433633133223b733a33323a226365343838303066383261383264356330373632386636616533383333353138223b733a33323a226636663166643535383834646639663335633434323965303530383061623635223b733a33323a223466376364303335643038643632323833363432663837613035303566613134223b733a33323a226434316634396237393263396239316362313764376131373837633735383531223b733a33323a226333386666653736666430613938613133613063383339326166616132383733223b733a33323a223463356264323565333066356230346537616637636365313762343161366165223b733a33323a223765646336323038666131323763656232353534626334393763353364346230223b733a33323a226537313330666436333037353764386136333064346237303434376262343561223b733a33323a223035383037653430633635656130323564643864363337386530363865663034223b733a33323a223261306434343634666132376435366435643139613837323536353666363766223b733a33323a223335353863373565303230326564646239613337646136303561366361643230223b733a33323a223233343930386432376536313161333036333565643965653931333231393734223b733a33323a223539646261383562366333646235316437326333343961363066323232373462223b733a33323a226333313563313631663461323631666134373362333733393135373866636531223b733a33323a226537346639616531656639383339626361343533356534346565356361636331223b733a33323a223439373833306130316631626635363832396634363736343864363561643566223b733a33323a223462353134623366373263343138346465623935636135613637356132653132223b733a33323a223930343431383737326439613237326132326335633962623236303030323362223b733a33323a223632333938346135393638353861653133646166396339393135653931366138223b733a33323a223764393633343130633639396535303033313434393234323838383934393966223b733a33323a223365363364633764643562663363353030663135306236396231613636386166223b733a33323a226564333062303737396264313230383234306337623362353266393634653864223b733a33323a223063353536373161343865646233633861646535386165343736373863376264223b733a33323a223532336634323564656463336532663462303965323031616463316361666632223b733a33323a226333383231666362623935353934306239383762653734363433373532633632223b733a33323a223331386436353565313230623964386436376564613137393835666532313436223b733a33323a223930653064353234363435303937316232306365653637306133333434396334223b733a33323a226232386338633838663732336638313632313063646163613365356139613463223b733a33323a226230353462306138313038393731303835323430393130356535623032346633223b733a33323a223732313366633935376362313037656632366238653530336365643563363964223b733a33323a223838653335356237643036616235633264306233373339323861343364323762223b733a33323a223035653437313332323066303532306239656138656565636162346263306635223b733a33323a223731303737383631316533336438663839343261623962376536653836633737223b733a33323a223238653438653939313536613964643962393636373862353562373761646633223b733a33323a226536613261363964303733643864396132653736663165666164663865383665223b733a33323a226535356334353135646361643462643937313761356630643835626632356638223b733a33323a223034643961333864356632353562646266386333383665343538313234353737223b733a33323a226564323834653962356266663463633332333531633933303336303166353062223b733a33323a223963323939666637613839646264323765643035323430666337306531353432223b733a33323a223461353530383666653932363637663731323863326161626533376266316666223b733a33323a223161663363613239633765643365346537323861656631363163343233363736223b733a33323a226363353961646161356261366638333434393537356336663133313130623237223b733a33323a223165363239323962383536646434643034613439623964616539666266373164223b733a33323a223434366565643233303130376130366436636335633263303265346562346665223b733a33323a223034323335383466313863323236303733363262383661636137346633363231223b733a33323a223061383765326334306533343463626235363662303462663464653162633630223b733a33323a223631626431313862616432346232663664653165303931313733336635623536223b733a33323a226232646532666530393966613637653965653531346131636463646534663965223b733a33323a223865633239323837343363633565343238643432656338643265356631653537223b733a33323a223066396565613334336135323865323638303534653334313431346336373839223b733a33323a223336643031343036303162633631633239386465636466356530646663393764223b733a33323a223966373131346334373864303664303663316535373532626237613165356134223b733a33323a226233356564396366323364633532636361363135386537333639313166633166223b733a33323a226139393931623236633738383438353238336262396563316462616262343065223b733a33323a223231366263623066623036353165326338393332616432653932663939366435223b733a33323a223764336535613262303866323131643262356531353162643539383230666634223b733a33323a223937626634663135633237383062326136336332333634303934313730313433223b733a33323a223736393332666332386165623232623763376662366537333437303363353736223b733a33323a223762663530623337393130613636663135343332656333613436373735656435223b733a33323a226138333661336636363832313033646365343761626139316363383764396537223b733a33323a223166666561653933333333666338343330613039663465366239323937663736223b733a33323a226362633839313562316439386565616263376437333538333365323935633137223b733a33323a226531666430666664356166623865366631626466396333383935656330623166223b733a33323a226534643964653464353865393838353864386637333034373738663233303136223b733a33323a223237633030616235636664306162306435303232623137306263363835353965223b733a33323a226261633231616432313666626662386231643330326132356532666338663364223b733a33323a226333613234383234663737653030363737633437656664383361633630613839223b733a33323a226138393063343465376430356435643337646439626233633166613031623966223b733a33323a226665336338306232363666633030646230636332613666393930323065323363223b733a33323a226361656432636137393265366637383261633765613533633037646135623336223b733a33323a223535633063376636383138306232363465613237333866313339366161623564223b733a33323a223636356464666464303961353862386238613331353434326535393366393336223b733a33323a223966323662396335303634636466333937643739316263633239363362316661223b733a33323a223439626164643162326139363261663965643966346338323934663832343130223b733a33323a223964663933343132323631633131616461613236363037656265623664346336223b733a33323a226638653761633138343636333365646133616661623830306662396435643162223b733a33323a226139343366653433366130656139363463353661623661663231363363326365223b733a33323a223463383862383138323232333764383366623738383666366663326238613163223b733a33323a223331646463636564623334343439626666616330616434303666643432313139223b733a33323a223662623164313730336530623136653261353933643935303637646334386464223b733a33323a223938636439343931346233656533643936626663633735363231613135653665223b733a33323a226136623539353138373137373430323836343336663431613666333239363661223b733a33323a226535656362316234383433306464663738363466353531303962633234396430223b733a33323a226662303934306166393866376134356633653563303361323039383962346261223b733a33323a226431383232333562366566313232303534636264306535356463313963363465223b733a33323a226635643538643261326634353733306666653864363131653434666630303332223b733a33323a223033366133656138373531373135643065303063643034323334633466323733223b733a33323a223839313366333638666336363633303434323733623738663434346137396631223b733a33323a223564316235366463383861663765313734626236366462306333656562666130223b733a33323a226333373639393564346161663039623231653430396138626637666330636331223b733a33323a223964343165653365626635643966316364653531326230303064623137383965223b733a33323a223166633233393064323664396531343731383031343932303865633533366537223b733a33323a223033393765356238613637663439616534633035376465376233356166393736223b733a33323a226538306538646237323435333362333563333334653132636436333839363932223b733a33323a223938623436393338653734346530633962643863376633333932646163613365223b733a33323a223164336161356233373833646239303732303965626232326361383131653163223b733a33323a226432303866336530623462346337396366626165646231636162363663313830223b733a33323a226632653065653437633433396531353065336566316631643832373737613265223b733a33323a226363316438633365643135366563333061316233336161323733356631356635223b733a33323a223539636265656431616534303039363133616163386235343764653461666638223b733a33323a226632613838343434616463316363383231366131656439666136363465316261223b733a33323a223833393964613166346163336139663137626238353365313939636235373134223b733a33323a223462666633616135656130626231623666633035373365623635396437653336223b733a33323a226631636339633332643962393063353161393364613630653239633633393665223b733a33323a226535623134356237353433356636643862636538346164343465623632396361223b733a33323a226136366532376239343861343430396337373364313761653636613363666130223b733a33323a226634616237653233323737653134343733663730383664643830633965663161223b733a33323a223830616636396666323938303434343033663238383633636231306535333263223b733a33323a223732333637623631303936663439316133373239393237353634323363333434223b733a33323a223566613433363164346538326231353962366231363539343064663462643636223b733a33323a226336313761616438646138383637613964623935373334663032663163353863223b733a33323a223065346435646339666330623238663339663536623264316363656561383331223b733a33323a223836366533303739653235653933303332613966613438323837616338643835223b733a33323a226532616232643430363637343436663635383533396661613664616331313035223b733a33323a223461366163636630636337366162303034323632326138633538383038353233223b733a33323a223363626262383539623632363639653434616636363731353865326663303932223b733a33323a223761336233336631336633653436613834316335306331376537353339616335223b733a33323a226465343866616165663062363732323966383864356162623733303633316533223b733a33323a223661653830303330353333633865666233373735653435343863376537666632223b733a33323a226665656637623734643135326363613161663433393266333338363139326433223b733a33323a226239613962353963333134306537653039396138343061653366383666306365223b733a33323a226130333132303038306330383966313535636639616639633036383335666638223b733a33323a223066666664396561383932303233396532653665393765323563363630616133223b733a33323a223639363830333164303633343434303366303638366332343865646136336531223b733a33323a223565363036323734363432393234656664656334323432613661326464386465223b733a33323a226465373930336333313338346137373532326133313434386361613236346161223b733a33323a223061636464333732613466633662636432376462656632333739323935396231223b733a33323a223737346265656262633435653138623864653432353634383032633236623065223b733a33323a226431356538353032646365623938653035313964396339616130393131396338223b733a33323a223965613365393561623364643363663630623538396336646661396538636162223b733a33323a226466356233333861313030636635666338356337383737353636336563363131223b733a33323a226264376131376433306636346161363966663131356562356264396332633462223b733a33323a226163376239636231303661373166386235313033643765613438363137643366223b733a33323a226238646539666664393430653239343962636164646338653033346537333464223b733a33323a223031313632336136633833636266363739346538343736303237303131313530223b733a33323a226263626466353665393031663639643330326637336463363033623064643238223b733a33323a223633323162613639353265393162643633613731376139646639303635326539223b733a33323a226566356330623833333537343032363461386534643434666631323264363165223b733a33323a226666616331336335616139643463633935373963646335613532343434653735223b733a33323a223332383238666537633762393337633834633935376130383363616161663133223b733a33323a226662373761383733313833353662316139383163343637363139323065626332223b733a33323a226263666264373436313366613265613939343132646261353761383661336538223b733a33323a226431633538393333326261663135383835323531303931616533656634313961223b733a33323a226366663164353337323861333734643665323361303238623361343362313436223b733a33323a223733316462363230653232343532623463326238646138623331393237383535223b733a33323a223631663466613164346330303434616466333637356137623831316464666137223b733a33323a223461363665353761653839646634333234306262336137666135356230653530223b733a33323a223766623465626631386633356565333430393938373131326236616138373561223b733a33323a226363303762653237626230306637656237613466613931616133376235383332223b733a33323a223536653166336232333865633438326235363635343131636237633465363165223b733a33323a226337343638363963393632383636303039646665383333306563323032633536223b733a33323a223738623330393538316234643436333364393531613037376537623937643465223b733a33323a223034626339386532396162383065343965376366333566343132393661613535223b733a33323a223563323661303966616463383638653162393230623165633765323662623664223b733a33323a226261636539393235623530616566393766383036633865376430323136393534223b733a33323a223634346532326664363563623166663232313164363736613239333736373233223b733a33323a226330623564353064303864373936646561386638303837326263333631333566223b733a33323a223662393135633731323338386136313130626361613633666330636265363034223b733a33323a223763663166316161613463393464623762316365663635376431356637663332223b733a33323a223431353766366131383864373662643432396132643166353532346234313239223b733a33323a226564636632666466383535363635656537383931623035323035363439373536223b733a33323a223130663066623963646238303031366432633566623839353065313463313136223b733a33323a223832336133653935373838333836353963613434303131346562343733653166223b733a33323a223561353033643238366131346161346537313633613839643964373638663731223b733a33323a223265303734643337666135633863346438613138393362366233633336386434223b733a33323a226463316433336536666437656431303665306464373565636639616639386666223b733a33323a223838643766653538303466636636306332323636303533323064626432343839223b733a33323a223734373064306534613738613430643334313337623965353030333132353934223b733a33323a223063326566336134393465366566313461336364333131396235643336616133223b733a33323a223437386338366330356430343531616234626631356265616230313834393066223b733a33323a223334646162383231626663376630643466323566313536663134356137363535223b733a33323a223339653061396331346464303263396531613538306531373133386635313337223b733a33323a223861653965666432613362376635623236633361356362333262303530616431223b733a33323a223837616334333565653332396637653266376332643133323832636535653361223b733a33323a223562613064643037353034386238303831633139353538383534306331363864223b733a33323a223362353731373537386433366539316430656565633336656432333162303035223b733a33323a223637303834643365306263303737336538333836323966653061623861633534223b733a33323a223831643162363464316663333435306266343461366237353731333932656634223b733a33323a226565636166326361343961616439656631636161643534303436303065663731223b733a33323a223435633531386661643539383038633830393639616566373264383465613166223b733a33323a226463313264313731613161663637663363383464666136666361343461353937223b733a33323a226265396566316662343963363335393739663736626165613862366139393032223b733a33323a223831626163303864383937393631373763363239383334363232333832633064223b733a33323a223037353164313731306430386162343865366436636131653765396662376363223b733a33323a223662313538633364376531323062313664626563393963343836623331636530223b733a33323a223461363738643166313831343736326166633236616566376336336439653433223b733a33323a223662333966626564313264636265383665363733383933636535396562633439223b733a33323a223639643833623639333761333766306230613838353034393966386336626366223b733a33323a226333613939636366383035353437366464633861633037383831616336663062223b733a33323a223635346661626664303030616334656261306538376235353439623766343832223b733a33323a223366633635323732396139366565666664306537326466356163386563313563223b733a33323a226437363437653961336333666264343038656535303866643462363837313166223b733a33323a226631356235323364383566303262623236363861653530353339306134396533223b733a33323a223235666463616532346139626238343637343034316131636232363734393164223b733a33323a223931313034613439356236616362613134366430306532616461613764316262223b733a33323a226131343434343931623430313365616364356436306565383831343961333835223b733a33323a223232383031643961333332626332373537386131366563306461333635343337223b733a33323a223862373938663535336461336461383665356264346437356532353934343566223b733a33323a223132393532646163373464353262363963376135333835653666626334643461223b733a33323a223364303936303062333835356339383332343030376134626237396331363161223b733a33323a226564306533626464653162626365633735366439306235336364353862626134223b733a33323a226631303266363638663034613936383236613437623761346433316666643330223b733a33323a223836613334366136633136313434623032313338616630633065323133313139223b733a33323a226264653536646635306362336564653465653638643337636432633366343836223b733a33323a223366313339333738666630336666353834356634306637313837373865323237223b733a33323a223935653865666163636164346337363265353236353766663839323334613233223b733a33323a223966303836306134623639396462326565356534653530336164616238373033223b733a33323a223335323435393135376264303062326165333363366132323433643234376636223b733a33323a226664356561333866383637356432636466313239336431376561373831633066223b733a33323a223461353830643236323034363234353962396464393961373638356566396632223b733a33323a223830386435623665303830636633393538303064613136646235303730313639223b733a33323a226334663236633830653061633465366532313061643139623437376435363632223b733a33323a226238313734313439663761396366323632323863303065636361646631653033223b733a33323a223966363466373763373139643661623133663932333461613530643062373464223b733a33323a226363376635313961643264613661666135363530303631393832346364646266223b733a33323a223037393637626465663065386138353232373366623265383165613836386134223b733a33323a223063633238326663336637623435316166363062343035383765393634346231223b733a33323a223837663861336432376563346338643932373536356435623833343632343235223b733a33323a226634346130636332316561633364326130316239316337386438313932616234223b733a33323a226432323461316638666565386166313635353961633163363030646531383730223b733a33323a226334613236636635613862613538653133626337376135643337633138613631223b733a33323a223535383231623739336238316365313132356265366661376362373539653563223b733a33323a226331633633313237383261373639313738333962383365646365323439623433223b733a33323a223938646564303330663838353863326564333266633862356432303634373065223b733a33323a223437633166653033656235646337396333623464333363383438623534623731223b733a33323a226164343964663864356162653631633863313763663237343130626336306562223b733a33323a223338356463326336346661663338316232613763333063313862613637643266223b733a33323a223831653765656361646263633963393361663339346164373663386533363732223b733a33323a223135303432663034303231393339623631313065323738396236343635383163223b733a33323a223666313963336337656232636566626534646630396466656632343638336338223b733a33323a223563613339366362633531613964366537616534623737373937333535343234223b733a33323a226635323730323537613333643835366562333037396436633534363436366635223b733a33323a223931303163656661356661353035303566626665333132383138653435343038223b733a33323a226530386239393532646334616261666137323566626430353863623836636630223b733a33323a223834366530393033303532326333333735323535323930396366323236663939223b733a33323a223136616166653964633339393830666562373865376161363737383662336165223b733a33323a223237366532376130346338356261656265663433376266333839613038373437223b733a33323a223763623465353430313361363137346661663439643964633337396335366236223b733a33323a223735653434623562633639306665333038343364366431383236636465343434223b733a33323a226139643861623166373739316161363365656434616534633038636464373137223b733a33323a223262356363623962623564366362363634623737383334336465376466613830223b733a33323a226533346336316161656562343134643332653963393131633732383638396632223b733a33323a223436316535356263633663653663313461613737383337616231643837373334223b733a33323a226338373064666430663737623233343863386562336639306632313833336262223b733a33323a226531653864623138643233653766626339386165653333316431613262633366223b733a33323a223163346436656435666561306332393336663330343335636363363833373331223b733a33323a223333396339383833636434633138653131623232316238323233343465653836223b733a33323a226530323030353437653633306266383666363937376237356331343736653765223b733a33323a226535313230663264373236656437373234373966366637343032336662623635223b733a33323a223463393133353838383865326661643063306232636635636463616235386434223b733a33323a223138636238306538396362656662663965396638386531373434333531353062223b733a33323a223338313038333332326363623536616134343463346638306362343736613766223b733a33323a223938623431353631396638656334656663623838366331666133356466323661223b733a33323a223437316563323434343966373265666236333835316161616133633635326233223b733a33323a223131643461346435373030333530653862326130623764363537626233363462223b733a33323a223438373833373738653562363633393166303535646534333665303538643662223b733a33323a223830393132623662343732333762323764636632336134303630656461333238223b733a33323a226263306137306230333538653233323332376433313931356335333430383138223b733a33323a223431396239313734356630333139336666363035303361303332616164366235223b733a33323a226232383262666264343063353865346239623565353431333938393733383138223b733a33323a223730613537383235643537383233303939656432306339626238316362316430223b733a33323a226264636630346462313937376664613035376664353064383266613230636138223b733a33323a223639333665643866346336633065616232356338343666383136323464623538223b733a33323a226531376133313962663763663165383237613837316430386238336338653431223b733a33323a223563306162666439383062656564306139363263373764643463313239333638223b733a33323a226566356465323462326536636531333934313334383630623336613264383362223b733a33323a223033326631336466616334363032626566336435373031663532356263393630223b733a33323a226236303139353061383063356639613563363563643564373938393966616430223b733a33323a223436623432396464663332326538616661363039343536323637613964316662223b733a33323a223534383666353064313538313330626338313864363564306562653032396639223b733a33323a223066303865623933353965356137343137373965356639623565373139326465223b733a33323a223530363165326266316662663731633663346664386534316535353135396138223b733a33323a223765396438393862366132323666666433646530303663373838326637346436223b733a33323a223063633264626461656164666162626234326366643463333163643432386132223b733a33323a223636626262363961343765326335613165643635303435303835343332323933223b733a33323a223064653938633262383630376230643234656330663032346637636430616632223b733a33323a226639613338383739343362393863376330326563373933656437303633326238223b733a33323a223237333537633033613933646237306266373761326166306262613830373639223b733a33323a223434643962663161303562333731333639323738323032323830316663663162223b733a33323a226662656164393164376335376461363534653131313062663234366266366236223b733a33323a226361316231346239663362626635336537313533303837323733386633353438223b733a33323a226130373261323732616266656636363736393537616166323764343463376231223b733a33323a223834613138653035306461313131306433396430373339623537336231373032223b733a33323a226330356339363763353636633861393231373136383966346632656363313561223b733a33323a223266323130353938633137326439643564666361363364613732363363306234223b733a33323a223638356338633537306266633139396439636430306334353534626363303736223b733a33323a223865376433623035343139663139613632643636663034636234653232396564223b733a33323a226662316164643162653132356334633163653533636362336465303139636163223b733a33323a223936303833316136343530666238633330393864333165636266623036613936223b733a33323a223236313337623030356634366538643061383330306665623831393033353939223b733a33323a223439316465623261366136313165396337383065613763613039393334643736223b733a33323a223037623034376433376539383936663833343737643864393166623138623230223b733a33323a226136363331356534306365343536636238633566393038666630316264373532223b733a33323a223133646562346463313334633430326338633932633664623264386338653363223b733a33323a223561326230353865343337336433366662636230633562333139303335353935223b733a33323a223632333733346433326439633133383133646361353266653037343762613630223b733a33323a223864386436636563633931386562353731393631643732366535316630663231223b733a33323a223962333135666135363064323762373432343438353039373231663766333735223b733a33323a226539646663343436396461373365343730366564343934353934343732313932223b733a33323a223361366162383164643539663832303337353963383233326139333037613761223b733a33323a226438653833356637663235333061363837376438323930636430613865363438223b733a33323a223664396438373364333331356435396662316466383162613437316162333639223b733a33323a226338623362663533393838646333363966353264333431393566636236323631223b733a33323a223463343034356164636133393665333165383038613534353363613263356263223b733a33323a223134393762346232663636613564333238643537343534386165383965363262223b733a33323a226539396666363631363530613138356163363037386331326532633134623762223b733a33323a226433346538373265633938626433323337656234373138373564306333323833223b733a33323a226237653634303738636533366437396534626236313136393236346361303763223b733a33323a223964383836663561646338623861313234636566623634623139613833363438223b733a33323a226162623061663536323464646531343335636562356335303462613261663764223b733a33323a226461323663393738316335393237323366373935663235346638376436623031223b733a33323a223034386239386132666366303366353735663766383935323732663664356635223b733a33323a226638303064393862313731366130343235303531333664363337636236666666223b733a33323a223561336564323230363830313439623137623866643535306332636338383564223b733a33323a223234626133363631623366333537346238353235636133393961376230303934223b733a33323a226365393537326232386364653361663530616463343939623966663266663031223b733a33323a226234656361313230376332363036636234373233386239336132663530383364223b733a33323a223232346136313238636538353136643137313439393336623965363631636464223b733a33323a223834326135646163623430653466303361366361323962376439343135343430223b733a33323a226137386565623965353130613865366233663731653661613164613863366132223b733a33323a223639633232366661663232316233326332396433323838376138356630343939223b733a33323a226431663866363661386335323663656534303336343035326163633661636161223b733a33323a223563353334623330366339366436333438653866393135396436356436346135223b733a33323a226130653661623666343761333265663839353364303031396539333062346464223b733a33323a223465326434393262366634643463373235656230383763366366376436333537223b733a33323a223865613031373666626232663239663965653433653566303731613133306632223b733a33323a223735336161366130636461666362666461383234653337613466623061393164223b733a33323a223835623330363438323532366434373530626333353337333932666166613366223b733a33323a223965313963303137613066613236613934333065393435376361323139336665223b733a33323a226132383665616139646239393439333638623536626535386564306565383835223b733a33323a223033363830323461366634313239623434653736373336336437613637303833223b733a33323a226431613533663031373632393330626362643966663161343864616338656639223b733a33323a223138316437353839396435353232383133316333303032336462336231373339223b733a33323a223338303963333765343736353834333837316534396430363764333931306566223b733a33323a223763636530666231633034373665313638353839336130323830643032633161223b733a33323a223634633465616236646637386339613031333837343532623064303137306631223b733a33323a226631343962623036356466313137316562373733633965636130626565663964223b733a33323a223739343635336431383134323965326137303739383033633936353431383563223b733a33323a226535356133633336336666303639373861306239356336643135383663393634223b733a33323a226432366163393565313232666233356331363832306661363463376538643565223b733a33323a223034353935363738386436333736616532656564663831613563666536373336223b733a33323a226564333339323435643330316637343938643034643635633030396631356161223b733a33323a223665306565383735373232353130663238653064613830636535373063393533223b733a33323a226464333163303030613164306132326565653835303266623430393861363062223b733a33323a223532336533323838666466383563326634323462373436333064626132336534223b733a33323a226230653736303637623965353635643439623230613131356335386336376661223b733a33323a226639303962313132616539663566643037336361303231323934356533376164223b733a33323a226530393532303435323064363364643565623933626230363937613466313266223b733a33323a223132333933333665616237316231343863316539366665306133613563366366223b733a33323a223934626538646638653464363634373662623061313837373264626331636137223b733a33323a223134363132313862386362343337373566366432386334373131343061393136223b733a33323a223465316463623861386331666466623762316437343231643237343265373339223b733a33323a223465333133393863303230363630633063643861323538303264616664376465223b733a33323a223735313364366562353864346163663362323535303663333032346135376361223b733a33323a223436666636316238613165633933656262313037306131616330613166366262223b733a33323a226339386335663335653466356566356263633962323535333335396666373531223b733a33323a226130323232303063343330373230356263616465376161323531663539393730223b733a33323a226330626663303339376637633763323332353231623831336562313538386165223b733a33323a226138323030366335306130623832636666386237646666643731333339306666223b733a33323a226161346632646638366437356437633562336161646131393334616338626136223b733a33323a223261366632333065333130346230323835653066396538323865333865353537223b733a33323a223738653661613062313534393663323766336433316630636634636435373135223b733a33323a223731383661363239396230343738633431343630376539313834303461353064223b733a33323a223732376533316238366664303236313964326532333266666663623431646564223b733a33323a223439353130626263326137313735323138336638333633346333663765336633223b733a33323a223530666135363738633637656466316339636365376164363339323332343365223b733a33323a223838333763373432333363363061663264363232363135643865333931363636223b733a33323a223238633936633131373961636132613432666335643232616465386665643733223b733a33323a223333636138653636376434333537643331306162363364633861316463636663223b733a33323a226464333135633331326430623634326261636366643665633931306238643963223b733a33323a223034363532306538323339643461306237393164303262643835393566343631223b733a33323a223030353535613139633530323639313164343235393136336133396163343233223b733a33323a223534383566346537323735613665633334386437666235656234656634623363223b733a33323a223962663462643234646334316636363466353865633038313331373566316331223b733a33323a223230663633383266353939626132353763363232613464656365306161636562223b733a33323a223738663130643766333861363535396333356363323366643161363034373531223b733a33323a223230303865373365666264306462626139613465346365663633356630663139223b733a33323a223363643265633432376261383363353130363263613131646331626432663338223b733a33323a226239633435383431636233613561336665353233373734643736663036303165223b733a33323a226137303336636634653963336231353131646339633863626666663861653564223b733a33323a223761613631346637653730633030666331636366346663383130386132303866223b733a33323a226330333763653663306661306534626563333965383064343430623762346336223b733a33323a226337303736656136666237313839643864633764623062373537626163643033223b733a33323a226133663332653864373965653166346332353939313130333265666136633130223b733a33323a223038666438343132313763336334393437383832353438313736616564323638223b733a33323a223430643161376662653065363562616161386236633734666266626239333636223b733a33323a223733653431643939666533663765633561396366386662353133386262303933223b733a33323a223433323438633237356537323936303362323138353035616161393532393333223b733a33323a223939363862623765616537363833386238393963616439336364373862383135223b733a33323a226666373332323833313033643736623435616663326461633034323062643763223b733a33323a223831326234383963613631363862623633333262626161336131336232663631223b733a33323a223935333464613961626164633161323734383864656663623137626330373838223b733a33323a226464356539366366396137323832336231356232643433623265663233383361223b733a33323a223562616366653164663135396664343832613230373237366261346666326139223b733a33323a223565346663636532363261636266633364623562346535633234396631396336223b733a33323a226235333539623232323539353037663531616633653966343333323338316261223b733a33323a226262663230623836633566303236396332636234313339303135353330396465223b733a33323a226639646666323238306661646563396435373932313934386238333362653236223b733a33323a223430623536653033306630306231363734353637383030623165306532653732223b733a33323a226337373936323938336339333936643266366166323031616261663231316334223b733a33323a226232356261366536643035393739613062383937663764646361613434623734223b733a33323a223831633737646262636135663864326535313631333336323535363038393430223b733a33323a226665643832383639346664393161333137626137626465363539336534396562223b733a33323a226465646437386332643866636137623166383461343663373834653636316336223b733a33323a223437306532316364343637653638636535376161343636353834313364323239223b733a33323a223632313836373839383936346339663164373639326461613638393437383163223b733a33323a226231316564643235333037306534356364656465346432373634383839363866223b733a33323a226564613030356661363364333864353539323730363631363566613933393762223b733a33323a223538663563343931333361353366636566313238646336333636643063363063223b733a33323a223330616636613833303332396532623666386239633038383863613734373464223b733a33323a223533393832303230623838306430393638316236656532386432313837643238223b733a33323a223264613166363738646134346362393535333032336233653761653236313162223b733a33323a223537326163316161343939353764663934303233646563333436363763393536223b733a33323a223162386538313131613734386232363437333535626263366164633836333664223b733a33323a223731336133663562633862363737656139366238366236356538633937316331223b733a33323a226239363737666537636163326439393565393262616665616334363633353033223b733a33323a223763626138373065623864636635633865343738313861393162633538663337223b733a33323a226132656238306462343731356132376666333933343633646233373439343762223b733a33323a226435316639313737303130396436626232383165626266626633633139376635223b733a33323a223063383966306366336437366338653435646138333131383533363830366234223b733a33323a226632613435316463383766356364613637636463633438363333346365306666223b733a33323a226539383136396136363063633164313864633462643338396331333564633162223b733a33323a226631333062633038393035303132663532303930376530393963613361333530223b733a33323a226537366132656238383937326361616565643966633234383734626132376361223b733a33323a223839313039313937363537396361633465383234323333383861646532623034223b733a33323a223032646638336135656466663866326363383430316465616438303434643837223b733a33323a223939626534656361333139346461666137633336653061346438353135303431223b733a33323a223033613563643937343638343762316534316162363061333061336533636238223b733a33323a223036626365333733396636373336636162636438396332646239353138613930223b733a33323a226332613166303330333263396139326661613636343061663435333736383061223b733a33323a223837646434643364636437326636633236653435393931373831303737346462223b733a33323a223965666463623463393433623139623662633530616631313732303539333365223b733a33323a223463663265626661316134303931643963386337383563663334353261303931223b733a33323a226663646233353939313466303434633166616263316664383436376638393166223b733a33323a226163613137636432303062303566396339633637653037633734626163646536223b733a33323a223137333264613963323164323662353230383633383431363536363535316135223b733a33323a223063386562663839343630353765306266383035636133383836303639333934223b733a33323a226661363065613438363434363230666633653234336338333265623663383965223b733a33323a223934623964653764646438663832313165303538623666616262663564346466223b733a33323a223937623237663036373835303664316161623631623635316632663133303631223b733a33323a223633353530373036363761336562326563323637646533356664626366306636223b733a33323a223666396437316239363732653330313935643436333038373939313032653933223b733a33323a223730383664663234633139393431616235653335343165366538373131383766223b733a33323a223338396336313633616261343936386264333764636538363935636561393037223b733a33323a226231373739356331336534376566393565313136646264303563376438646464223b733a33323a223130623662653434646363663634616435366231376337343261386139363532223b733a33323a223239336264663434653735396633623532333638616164653932316534656434223b733a33323a223236336234613430336334363333326237393263323862613136646564653337223b733a33323a226363646361393639356364656466623930653964656639346530346133343735223b733a33323a223231363834646664386464306363656434323661663535313437306331303838223b733a33323a223336393130383238663664356636643865353233306566343164366132326434223b733a33323a226565643737386631393931303466613538656235343665356438363061326439223b733a33323a223833643666653438353632336264613464646438383438316631313036653263223b733a33323a226335353466373165393866623437643836646136633637353461623065646335223b733a33323a223134653162333661333438386563666337383130376132613334346232623637223b733a33323a223866613062326362656138306539656537316333643338653330366533333336223b733a33323a226563376631633536376366653363383630626236656438376138306432633637223b733a33323a223433636665363561396433396637333465306230303734383464646436313939223b733a33323a223962343636313965326331616265663835393465326431353861386335376266223b733a33323a226566366432303133656633323131623063383562343736393536373235356335223b733a33323a223437356330643631653138356333656531323862326265383033356538376533223b733a33323a223535613166316530383162323864323737376230383362356365393637353335223b733a33323a223462316138616233323133323965643230313735313434306232393862356166223b733a33323a223364336332356139653763386130326631653733363062623130366434396262223b733a33323a226531343461653561333831313730363566396330373064643236653036333933223b733a33323a226161616334386331333136326664666339643764316164353066373539613138223b733a33323a223364623832316364336234326365353966633134323830346433383535376535223b733a33323a223063633737356434356632353837363266623935303961316531363363643736223b733a33323a226231633165386463663462633966643431623566643933386662353162376530223b733a33323a223031396561396662636433386138326361336563666535386362643930653235223b733a33323a223538336364363062316133653830626230363265326532623638383538383162223b733a33323a223131313431303138393865666165326530356639336630613764363236393665223b733a33323a226432356430383061383662323961636339336137376665393132396336613633223b733a33323a223832633635613238633434393839326163393762623331393138646533326135223b733a33323a223563343231336362383766663132646336623239313337383537336361656233223b733a33323a226539623536313038623634386439623334626537313533313366636663343732223b733a33323a223337623132623365313130303963613934633961633831643262666265613936223b733a33323a223366396533663039306166663434373764633166356331663437333365366637223b733a33323a223835313163613564386332623464363032383332653034633161386365633365223b733a33323a226539346664646633653233643936633238376330373262326330623936616134223b733a33323a226366643230393331376665663461393136336131636637316161343461396562223b733a33323a226165316633313763656239636536353130353630663834353863353364613037223b733a33323a223632653031363861323433623533613739333138663866653862643138383563223b733a33323a226631353136633562616235626534303234626665343637643538663662396534223b733a33323a223231623564336339366164653164376665666230623130383134343334656337223b733a33323a223730616663336236323938323237386266356461636261363735303039613862223b733a33323a223035303435353362323466383965626533313733386430303035623438313832223b733a33323a223838316238643665663566626266323962393434326235623833313761386235223b733a33323a223662326330303630646532303134663432323331366463376565363038383637223b733a33323a226362323137646334396361623835373931336362343163323634376166653463223b733a33323a223030323034383364623439303864323736623832303662316366373137353030223b733a33323a223130613865653237316539656363653566303130393362643730366239643763223b733a33323a223836616132323238313536323662396534646236343465373738313135643834223b733a33323a226464353364643461313963616632313037623464383263386231353432666363223b733a33323a226333336631613731383164653366386164353363396138363464373632353135223b733a33323a226330653438353262383235306665656661363066616663303333303836323336223b733a33323a223061383130366639383830656163653537343366323334366435313332306530223b733a33323a226264646439356363313163616238653335643230613032653131383735356363223b733a33323a223435346234646637356566323237376366323133633764343833376437643234223b733a33323a223136383334616135386437333833373433633461393065373362366134393761223b733a33323a223966353963363564643031363838663238353238663031313231306266643236223b733a33323a226533366436623865323631653331373362353564663965336331333634646534223b733a33323a226266616237663165363061353737353832333763313466663035616431653333223b733a33323a223038313534326665346530396566346562336161303331373233383538353735223b733a33323a223638333566323766313566633830666164623962323965633830653430653464223b733a33323a223837316431636332663361323166636137323730316632393537366237366566223b733a33323a223234633533356137333038313164333931663932306231363565383835376666223b733a33323a226236323333653161386263633861353163306434303463366330336366316536223b733a33323a223434303835663838633834323363613231396234623939353262336533373961223b733a33323a226562653463623534306631373031643331303533643964353636373564666639223b733a33323a223063356332303564386463636330336165356132356634393462316539353666223b733a33323a226534383665646166646334633930373136623063333766386464613030616463223b733a33323a226238343934303235663862303261623531393762316437396666373561393961223b733a33323a223666663337303335613066323939353466326266356664363636336330613665223b733a33323a223762336337386261663637373833303964666163623865386164306466343638223b733a33323a226363356462306265316438333262336337316333313730356535313037323338223b733a33323a223733363631643865323666373261366666343866343563623766633565376232223b733a33323a223134626332373433623234623736343837633265353665646536363239313534223b733a33323a223066376331383261353433353066343233613535646231326664633738396535223b733a33323a223461393861333561363430666363353935343332326166323532373034363534223b733a33323a223436323836366431363364356463613965353862316261383437333462326466223b733a33323a226336353163353039623938343361346663356236363464386262303230353231223b733a33323a223861303863616663656164626132353530656262373135326539353063383565223b733a33323a226431323937613630306561356538306664386632626162303630336134633839223b733a33323a223639623566396534663037306637396663633466386433356635613534363133223b733a33323a223931363737306537343531353636646538663665643466313965643939633034223b733a33323a226138643364353462636166373032333336303962353264376162383838666331223b733a33323a226538353061316263643966356238663432636262613862303366343938623864223b733a33323a226431303961643638623435613338653431623531363534643732653730356565223b733a33323a223464363863323031373132316162643434303138613661626264373466653339223b733a33323a223066656233346338663439626332346530356331646635396439643866326261223b733a33323a223161336235633538663162346264656161336432393363376233396533373833223b733a33323a223838643935353331346563356133623235636134623366626265313564323466223b733a33323a223666313962666330303162636266386165383536393130333532613037326434223b733a33323a226535613636323266363166363964643333343137623366653162616232646533223b733a33323a226336346538366264333938333164343361666334643465363735333535663263223b733a33323a226638316534353263653162653365353636663137633365626330646131366633223b733a33323a226137663837636534393235313838666533373663623838626465346136323461223b733a33323a223061383235336532626132373765343861333630346166383133633530396162223b733a33323a223430323735653939323035633136656662393362636236616237306237303237223b733a33323a223362393533303238393430353438636539333331636339623766626436373032223b733a33323a223630663535636334306435613830323739376236643766623030343332313634223b733a33323a223934646366626638616164633636326631623964323163393631336261373834223b733a33323a226338333466613331663133663861333563616236623735306636313937663635223b733a33323a223830666637326264306662303432386436363235396437366534386465626462223b733a33323a223735363334333561623266386338663161363134373864396666346465393761223b733a33323a223337643334623262323164383866633033653138343737386661636637366330223b733a33323a223836316537386637383665663939366365383062303931356165383662633866223b733a33323a223530646262373335313333363730623137376563396336653361336339346434223b733a33323a226366366136396135323865373638356666333539646136373864613163356137223b733a33323a223661323762643166343562306461383739303764323965376635643238666366223b733a33323a223063383664656633663435313137396531373462356362656362643831616435223b733a33323a226231356633663866633330623238306464363336333638343732316239333166223b733a33323a223964383362313064386338636433373632306531333434663265346134653065223b733a33323a226265646232636265333534353135643734626264653964653363616132633563223b733a33323a223362656162653438306137653038666638303562633361666162323866363735223b733a33323a223032633162633665316166643235613734626261646661636261623166656135223b733a33323a226365643231313533386338333739316232356638366336666233303631643530223b733a33323a223239643937346337623963666161363737343961303265653237383734323437223b733a33323a223563353763383739336163353063313964663437323938393630303461346438223b733a33323a226662643661303763646632326539343563616165353065626633653539373364223b733a33323a223063353731316538323962373230633738666639343162383332653966373864223b733a33323a223035386362346431643363626233613462636534366232653931313039303366223b733a33323a223936313230623763636566323232373730343339333734643539393237323230223b733a33323a223962383738386566373061363363326462383361333661393632393533366136223b733a33323a223564383930613239386133616461613632393737383261343939323839336338223b733a33323a223730633432383462646131303739376235316265366564663538343863646633223b733a33323a223932353564616136343466373339383863333363373234313638616161343338223b733a33323a226433656337636561376166356261646165633531383738616239363032313566223b733a33323a226634643431653539323364343863393835323838383366373834333231333161223b733a33323a226636646233663063356432346539633362373933653237653630613238666163223b733a33323a226430343832633030383139316237306531373762633733313331396237333466223b733a33323a223366373066326430616330353435313462313132646133346661373232303464223b733a33323a226631323939363238643334616132633664323737303437663934376338626531223b733a33323a226562376130663764363737633739353163343266323130616262313334653134223b733a33323a223339613264666664316161643665323939613038623263323838346131313962223b733a33323a223730646136316535616265613861666333393035646239613535366438333336223b733a33323a223136373366653930363733643037366166376235323435353561363062643333223b733a33323a223131313033363738393065653835323164663965653264623661363532656430223b733a33323a226432623133326633623131616138373537336265343661313636646164383563223b733a33323a226266623830313537366661653735393039356362346535336134326634306332223b733a33323a223463633466306436376236656437313362383038373665633431623337356561223b733a33323a226235343630313631306361386537383632396530663466653436613266343732223b733a33323a223663356563323032313538343933353136653538623334333735613166303335223b733a33323a226133383034373830323630643963353134336164323863303436343065343362223b733a33323a226262323336376563626662396534616439346538666532643635393734666663223b733a33323a223937393663303361616334336336313835353061363365343834366162623236223b733a33323a226264636664323461316261633633303038393766626464633736383536383733223b733a33323a223963316637653434393231316665303465323665306530646362646162353139223b733a33323a223731303433326433323134393335626139623430386465623538386132363335223b733a33323a223963626136363037616663663839396339393434363135313866393438336630223b733a33323a226637356664323365613837363831653064626465333531363036373662616266223b733a33323a223833306537626337373062366434666235643031373130323162613336313661223b733a33323a226566363636363561653361666363633331306636653139646335303731356363223b733a33323a223661393134643065346536333161393530363939323435643830653165623335223b733a33323a226237353138383664346639626230663938633362626438323662653761366162223b733a33323a226639663933336231336132633461633563316339626261616366393265333135223b733a33323a223862376161613838613464383337303835616338336136646130303730613564223b733a33323a226463326364393935333865623838633733626533316361393939386364376330223b733a33323a226166653739366332653632313238633965343130386266616336313361663531223b733a33323a223464326162383165646665656564373331643534303539656431376436393936223b733a33323a223165343033653036643264373266666433386139363463386338633138613762223b733a33323a223466646637353338393730363634383333363561643865313265666364383739223b733a33323a223335323536626233383638613861653736393831396235383130353237613464223b733a33323a223863363035303033386163396634323935313465356531646564656334633731223b733a33323a226134333131626262303932343931393564666238353839353533343362366535223b733a33323a226437373265306535383266343761383764323363323834333239396261313462223b733a33323a223737376464626261326436373234636231303261326538313661663635356630223b733a33323a226430393133373063393837653032383836313835626164306135346534616639223b733a33323a223732643530346661373033626166656339396664306539336239356339646431223b733a33323a226362376635333765313961653362313538646232323137663533656635653933223b733a33323a226133643165346339653332323535346239346331613832333763393931643361223b7d733a343a2268617368223b733a36353a2261336431653463396533323235353462393463316138323337633939316433612d6362376635333765313961653362313538646232323137663533656635653933223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f417263686976655265706572746f72795f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226236326230393231373437343761616233653261326166333964653361636335223b733a33323a226637363030366130363863353935306638363634363437366262373762393666223b7d733a343a2268617368223b733a36353a2266373630303661303638633539353066383636343634373662623737623936662d6236326230393231373437343761616233653261326166333964653361636335223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226133383062613761356339376631326535323131393465306564333736333466223b733a33323a223366323864656435323337346266613664633963663332396133346532373130223b7d733a343a2268617368223b733a36353a2233663238646564353233373462666136646339636633323961333465323731302d6133383062613761356339376631326535323131393465306564333736333466223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223938366138363137353732336236316263313763393535313330616662313163223b733a33323a223666646664346666333266383430666231383565613331383035396264613663223b7d733a343a2268617368223b733a36353a2236666466643466663332663834306662313835656133313830353962646136632d3938366138363137353732336236316263313763393535313330616662313163223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f45787472616374546578745f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223265636362666335653466626364346637663064366336613638643431353036223b733a33323a226562353839306230313564346530623630626236346533373163633366616430223b7d733a343a2268617368223b733a36353a2265623538393062303135643465306236306262363465333731636333666164302d3265636362666335653466626364346637663064366336613638643431353036223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f46696c65536964656c6f61645f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226534393662373635326330633231646436376331666338316331623662633631223b733a33323a223631353930643966623638313439633662346666613339623264633136666461223b7d733a343a2268617368223b733a36353a2236313539306439666236383134396336623466666133396232646331366664612d6534393662373635326330633231646436376331666338316331623662633631223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f4869646550726f706572746965735f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223566326235313734626261306663326531346662356638353234313638316136223b733a33323a223165343934343734373238333665383863643364323239376364653333373832223b7d733a343a2268617368223b733a36353a2231653439343437343732383336653838636433643232393763646533333738322d3566326235313734626261306663326531346662356638353234313638316136223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3437313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a323a7b733a33323a226134616262326163346533643134623866376362396665366436616663376561223b733a33323a226362356532376265363463613861363735373563303834316138336139383133223b733a33323a223637376631353039633230653365373766373037653766656638633139306465223b733a33323a223535343234303562333461376666643866396261376138333839383165363565223b7d733a343a2268617368223b733a36353a2235353432343035623334613766666438663962613761383338393831653635652d3637376631353039633230653365373766373037653766656638633139306465223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1676477183);
INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('57edf69a91f417a01e1c1f1499bb21dd', 0x5f5f4c616d696e61737c613a373a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637373539353836302e3732353438323b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a226465633737356136353436393933643463363535396563313531643137323761223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637373539383737383b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637373539393337363b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313637373539393338383b7d733a35383a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637373539383835373b7d733a34353a224c616d696e61735f56616c696461746f725f437372665f73616c745f7369746570616765666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637373539393337363b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226136613336666634323161343934663838363638653130303634623730643436223b733a33323a223461306434306531373834646132303739663839653663613265383163383931223b7d733a343a2268617368223b733a36353a2234613064343065313738346461323037396638396536636132653831633839312d6136613336666634323161343934663838363638653130303634623730643436223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a313335323a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a31333a7b733a33323a223330636466633534656538386637353961643163333936363933663465343961223b733a33323a226333656461613961373239353738316130666664386632666562316430333263223b733a33323a226238666239383361313862633830663839343836333465623034383932666331223b733a33323a226634333162356232336530613232343166306234633630373766353434353135223b733a33323a223236666337653735343537653632393765353433623430303737613830333139223b733a33323a223963623133653132373132316230316634633866303766303666393363663265223b733a33323a226434386362663565356330626462623739353231393734626537626132336530223b733a33323a226431326234316162613332316236623661386661303533343564343266306232223b733a33323a223130303966343431343766333062333962613339323732646536323861333561223b733a33323a223238363533373733633436663135353134343536333265623635643132313131223b733a33323a226133613633373062343038333139306439643631393231373538623836353063223b733a33323a226337303562396665633665663135326431613231336631373830643439613438223b733a33323a223063366361313861353239386134336363353265373435306337396433373936223b733a33323a226633363934396534643439316230306239393932636436366463313136373538223b733a33323a223232386637326237633132653266363463616363313232373931646531353061223b733a33323a226433373939383934303637613064353938343138326237646133373430623833223b733a33323a223933326465333034356231306430666239333736363532386363326462343065223b733a33323a223438623464663130326339366666383930316264323835303765396336646166223b733a33323a223439623737666536346136653566343666643262383334393336623034646230223b733a33323a223039653933376135356662323836316434386239333966663864663336666330223b733a33323a223431353761643966323063623962633265393730333431316262653235303265223b733a33323a226233393032346164646531643833343632313932313863376561346561353931223b733a33323a226438306434346333316233393538323235363937663638653833636561343931223b733a33323a223232363831333239663930376330343332326437306264653064303637366437223b733a33323a223434326465623534356131363166663036633564333330363231633139366263223b733a33323a226238666164346130376136306538356138386632363861636566623734653262223b7d733a343a2268617368223b733a36353a2262386661643461303761363065383561383866323638616365666237346532622d3434326465623534356131363166663036633564333330363231633139366263223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a393833333a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a3131393a7b733a33323a223762336638656366636438346231656233646536616662633035353965653865223b733a33323a226439356532323032353839383762323132353135636165376135336364363532223b733a33323a226334363563303061663838366661343363383661663533303437346537353366223b733a33323a223238613532663233356536626439363539373134643165343136656437623334223b733a33323a223731396563383363326363623766306466393239336136356565316363323335223b733a33323a226434326630326538643033386162373039633631343031376663623865373963223b733a33323a226633623035626362396533353536646634633237653533393132653965363234223b733a33323a223137373038393733386566356335303939303763386561643039303237653934223b733a33323a223866653466363464616530316465656338356461396537346132363333383766223b733a33323a223436323732353162366230613039626466316364613134383362336665633236223b733a33323a223465393335363762363536313031333233346635663835656661306330303838223b733a33323a223036356430656361333065396331646466343136393462623232666265333366223b733a33323a223832366464616639636139303361333438626363663630663339376665323138223b733a33323a226130393435646266393763613738643836313431343639633531366234326264223b733a33323a226461316632383337333336386532393462323539333734303930666366326264223b733a33323a226565393234353838383034356537666330303038316663303032313939326266223b733a33323a223138353830356365373930313463653462653034303439613861336531393231223b733a33323a223633633234343030396162336461363762613265333736393735393634646537223b733a33323a223839333466623865333336653439313738303037346230373135353639376531223b733a33323a223634346332636266356138656634623563633837396331616136643836633663223b733a33323a223139363236313134393132353439383530623665333231666564356563393234223b733a33323a226462386533323665353066383032373530646361373739333239353733313763223b733a33323a226533343033623261306132663066626461623034343038323138663061613536223b733a33323a226663353563633938336339663962366635346635306634323138326435623338223b733a33323a223930626633363635333934366131306538333763306334383137386130333261223b733a33323a223864366464616431643339393939303862313762383365346137343136316365223b733a33323a223364323634366639343635373734326337643731313837646663396461363736223b733a33323a226563303763303633393630303230386361333535303034656363653739323138223b733a33323a223166363537346533313231336131306535363935666439623861633461306563223b733a33323a226433653639656131373633386632386535333730393263653137383331623865223b733a33323a223939636338356463333033386334656634323831393634666133646164316638223b733a33323a223234656534323464333764383361613562663138353939626433343335316364223b733a33323a223132636339363261373261336637386634353532663536306237376366346132223b733a33323a226464633463323861643030313061363932663538376339613964653732613861223b733a33323a226237343036643535613836653336616561653436613861616438626132636561223b733a33323a223032346164643336363034646331353834616465653230626232666432633232223b733a33323a223661396432613965306530333731353836353264323033663931373137386431223b733a33323a226263376531313635336564363331343537343331663530363936333662396230223b733a33323a223138626662323139336161313664363165313437353862313932343337386564223b733a33323a223036353932613961656130343037646330616366356364306666376537396432223b733a33323a226632346339643532646262343132356239613065643731336238653538333839223b733a33323a226235666161346535373562346639643037643036396239623065666662626230223b733a33323a226539326164646636343235366262386232386536313238333431396230396563223b733a33323a223130356465633238333536353463613461393463316438656135653539396165223b733a33323a223435326464393035353063323736623931393531313032613736623830643765223b733a33323a223838643632643065393466616339343530373633333665653539393436323238223b733a33323a223066336365373333303935336130666537333565323763306233326534346135223b733a33323a223534373738396532666462613562653831643961313937623234646531633034223b733a33323a223334646163666663633131663938643837653639373665613262623537373936223b733a33323a223439373732333434646538346365663666316238373632313164363336346630223b733a33323a223234623236343239363333323336626361613534306164643565646462623430223b733a33323a223633373835656464373430633335366663346361353330613033373363313730223b733a33323a226430333762373238316163393265636537636634643863653664643330356434223b733a33323a223766646239386132623235353161306438333062313966393330653239663137223b733a33323a223439313532326261636365313363326539376436363562316161386634653130223b733a33323a223730383437366361356139653438366564613830303934316537373232333533223b733a33323a223662643161613437653466646362316536313434616563643635326262626538223b733a33323a226434343137323436353866313934356166373335356435623065363963313566223b733a33323a223832323036303636346662336438363834626631396636396638663132643338223b733a33323a223130383735666435656165313036353561656562306235643230623935336135223b733a33323a223436626230613032643765336264383235343830316136396232303232363538223b733a33323a226634373036626234613065663835663037643966383465663631626530646532223b733a33323a223961633032343536663331646333386137346332333031626165646266323835223b733a33323a226661616538306530643938636537636136323136393464396237356333336239223b733a33323a226531393765316236653166393032626436336237366632613462363735353263223b733a33323a223833633364636434323132666566323932343661386237333335316430613739223b733a33323a223462333064366331633032323533616262653338666432316639303037323066223b733a33323a226663396434643733313366303435353831653263313764363966613363626262223b733a33323a223330626165376639623264653161663039613966666435356366356336366565223b733a33323a226339303237383063623636656236643462366461633636346139336663653532223b733a33323a223366376538303739633063393365303664336134633038306365383434326232223b733a33323a223837376436323336343738636234623830366264646633633438343530353932223b733a33323a223930386166316132306364313435306334643730323462616663633531663033223b733a33323a226131333465303265313130316135303062323431303432333665623562643861223b733a33323a226235346266363863343534373334353863323335386164316336306165613961223b733a33323a223864663137353933636437353362623237613738623364306663323939303264223b733a33323a226134633462393065393833643632303130323630396130346332666639653438223b733a33323a223661626637343134316266306435326637323538636232646361643735366266223b733a33323a226531663635643963343237346666663231383565373530623630663466643839223b733a33323a223864373134376536386436303536396461376664346361353563386331633330223b733a33323a223438336339343064373239346162323437346139663235613863653766323165223b733a33323a226162393563663330626661663430626532373961366333653565383966613735223b733a33323a223536623236313365333732306663383632323363336164613764613438373731223b733a33323a226163323763386663626530613461633063626231626639336363376635376661223b733a33323a226239653864616630303033623739333939306663663462653231626663616461223b733a33323a226530626535333433623031323337663434666362366264653961386531323638223b733a33323a226165623436373466346236353362623664663838383432653330383435616531223b733a33323a226334326266616635383332613839643738613862623534323833353437313833223b733a33323a226533393330336561633566353336363734623835393462323535626535353230223b733a33323a223231383566616264363362373338306565333731653834353938303232393461223b733a33323a223533303232636165663738366232646166383834663562303466616161363932223b733a33323a223035323630336337376365313431373837623139636337373266363339646264223b733a33323a223939636331313637663539343536666363323562643161626336393339346438223b733a33323a226563623331333532313666316162363765633865633132353463613366313432223b733a33323a223165663237363061386530666533646431646233663035363365393166643265223b733a33323a223865306566643732383362666335613436633962303237363864386333623961223b733a33323a223261333230313161343431653639306466663237356464313364623836373463223b733a33323a223332653361306465303338343034613435373630393362306538316665623932223b733a33323a226261373233633332326638323331643730333662386139393566646334393064223b733a33323a223464646665646636323965643366643034353032646436326535303132333635223b733a33323a223133366638323231393164393662643966303163346137303863626434663233223b733a33323a223132656139623963313966656636666166393533626136373061393438376665223b733a33323a223338616365653436663465313739333032333430313966373230353862643266223b733a33323a223939663166393232366137393636633734376330313731343162373861373731223b733a33323a223362346434356465366534343765306532363664656236353361663865353163223b733a33323a226434623936313065346532643534643336363037316661316233373234343463223b733a33323a223330353663303439366533383464323735633464383161326561386539383238223b733a33323a223533366662663962316161633036343534633762633137653465663331363232223b733a33323a223863643062353266653063623737646434643736313132353930613864323331223b733a33323a226432326463633430653261333839366339343934396561303666366536616433223b733a33323a226439356161386137356662633063303439333561343362303564366166306265223b733a33323a223230323130303739366562393366616662356331643837633863333565323335223b733a33323a223066633930613665363232343662643235363330636430626463393466643436223b733a33323a223137306438343434353866623932313964343539616462643233633964343934223b733a33323a226665346137623066383832613735383035636266623134316265306332633330223b733a33323a223831343664666237653462376339383261623333343562346536363865666662223b733a33323a226232303761363461363537333231316564643865313535316634383439623963223b733a33323a226234363532633133636138643835336162626563353763626432336232333032223b733a33323a226635636638633738326632623837393565623538316532376231376563366632223b733a33323a226265306539373061353432653733353039626637333739343838336131353835223b733a33323a226262323135353762376335303866663538363736326564373365373962653638223b733a33323a223936613538333363626239303966306635663037313939383930353966393538223b733a33323a226633383465366431366163643336383039396465613565393231393566323531223b733a33323a223762613637363931356465313635616433326166623536613939353430386463223b733a33323a223137656561363439393235333236393866656638626564623062356639353837223b733a33323a223732383234666262396163323263663763613935363138396238623734363331223b733a33323a223361646130383065653337633339363466306330666233356361633635366636223b733a33323a226438366338643164393439313134363862343836336237376234636335333237223b733a33323a223536326137373934373830386139653264656530346630303134613463616433223b733a33323a226663326265346332323433666337313632643131653932613234636530303437223b733a33323a226238373963383566636337646130313363393033643063333132613038353134223b733a33323a223138353561306164333334313666666239613062323837653235326636316363223b733a33323a226637313165663639643537316638623333653235633761373332316362613032223b733a33323a226338356161306366393130326334373636333063613239303537333839663864223b733a33323a226335633639343830306435316163353261623963376463623037386537383262223b733a33323a223030653330343037623436363838666139363262386562333662616262646263223b733a33323a223937333239363964383434326236663535386334636634303662346539386466223b733a33323a223334336538333663616138303832326436393034643831613837303336333764223b733a33323a223034623430386532663361336638623464373363633234633137326230376164223b733a33323a223233366636306330613535353963386438376137623234323732393366653731223b733a33323a223062326635616564373439396665346532323232376436356165366532323932223b733a33323a223265633538303463383436373964383437353030653930386462636436383864223b733a33323a223736653132623931353935326238633333346330326233636637313434323935223b733a33323a223031643438663735353036376162363935303838316334333331383838623664223b733a33323a223266656635613262643266323565323030323365303030643166396233366433223b733a33323a226533356538306437353335663737633065376333373161346236376533666663223b733a33323a223665653433346366383439363034613538623163363362333337643833643635223b733a33323a223038376535633931643137333832653730373230343535633662363431636261223b733a33323a223435636430366262353837376665383234346366616264356433633932313432223b733a33323a223363636261643362663366303862386465663862313634666335373135316439223b733a33323a226339356663343236623933363831313837613731656536666362313266366231223b733a33323a223961326637383266303761323331666536636362363032313435376461313535223b733a33323a223437666332303334663536363561383834656362393836333761336139656433223b733a33323a223762336161656431346163396632313730303362613562623064343264376634223b733a33323a223636353139623463326665656336633033326239343831323736353266663135223b733a33323a223338396265353731363137643561633931323563303032633065633432323339223b733a33323a226631333531393762363462616539626338373832343564356631663462633638223b733a33323a223333643432346536346135666435623536333563386264313232366261613036223b733a33323a223430326666396431623438333833303336313738646235666562346165316436223b733a33323a223661656432386136386137343937313131393532666439313434313233623165223b733a33323a223337366663393539626338366364333433643363393134663630306637393337223b733a33323a226431636333336434393737663230393938383235393133616435303939393035223b733a33323a223266623131353836313766656239343438353664313766663062663336383961223b733a33323a226537323633396133633436636539383866353662656431633061313465383362223b733a33323a226539623830396330346663613064303435633762643431353061366465653764223b733a33323a226262393238636464376363616363303733663338646638616238353435653430223b733a33323a226563636661353762336432353439666563373430353432386132653631343333223b733a33323a223664396366623464376364313739613138313636616436396639366566646661223b733a33323a226666633134316136303930343966376138303838333465613063383632363339223b733a33323a223639313836393763363332653330653566653433626538366162396364636566223b733a33323a223263393866366636393532376635623137633132663965323930383063306339223b733a33323a226231636231613061643134326365653234366635613034613862343733653464223b733a33323a223237653133643536303163343764653236363132626337313534303334373435223b733a33323a223865313732656132646664653530376664396664336437623736356363353435223b733a33323a223238343064313266373065653234653261346235666531373566616261346138223b733a33323a223133663231313335363339626662313764356337373937616161333464376635223b733a33323a223135656162633964366663376436363334313566356531383034386231303738223b733a33323a226533313763646161656132386636623034633663383832373366656532643661223b733a33323a223836313839613563343631366262353233353864653433353061316630646539223b733a33323a223565613836353863323863356439663664383035656331313936646436326663223b733a33323a223630616464373035643963333133306465363831326562623132346233653466223b733a33323a223130626439316436333435313339353433353833616461303063366637636432223b733a33323a226133313930633035636437383439356265613165366664656463316334666337223b733a33323a223630616439616639313661653933363837356232336532626466633131613738223b733a33323a226164623733333630373835313231333666366239633464613564323634626537223b733a33323a223837346634313764623362383264343261326134353437333166366636323031223b733a33323a223161306433643738366363613238623464643464646639643662333934396366223b733a33323a223163373962363835306134653437353336663736393031303935303438373864223b733a33323a223131306161636138333932356163343039353261316134366432666532333639223b733a33323a223038653662356562626332333239306634333335373036373439316163393530223b733a33323a223135653739356233326462633731316366323039396434393137613733333939223b733a33323a226234663264376164373234623330616431383234373836366534636564353635223b733a33323a223435633734656666616466303136393662396561356465613961393933306636223b733a33323a226433303563663266363538376338323535343930353738366533633862343336223b733a33323a223365353538333130626639633639313132366439323533313863633163363664223b733a33323a223134356266356633643963633738633164353763643665383462313865303866223b733a33323a226635363831616530366631333638636333613137356533303731616635366236223b733a33323a223064323331376430303032653937353763363766353938383734303132633731223b733a33323a223731643061306634373363333235616331343666366438323439643164393662223b733a33323a223130363661303033373630616165383438303338396664386630366239326631223b733a33323a226631666165326634383763373361383565653239333833636438653436313333223b733a33323a223139366537366339376534363764303263363338616635346435313332323432223b733a33323a223663393334383664353236303466393639306236343932353431393136646465223b733a33323a223236643333633164623463343933653966616132616236613433373164313836223b733a33323a223431323561346233376639346261373830643536386239633334393461353864223b733a33323a223466393330343738653335643262656339623739383137356131623536386632223b733a33323a223565336234333139383836396464303630356330323035643866393366616536223b733a33323a226236393534363339316431383630363835613166333031393135613831336432223b733a33323a223137323861646633663637383734313362666665336332646131323130323731223b733a33323a223932313934653133346131623533373035376334306632316531353265303035223b733a33323a223334643039383266383439303964366438666431393635326630643539656563223b733a33323a223761623766623835336336666365393765383466376464306166386563313665223b733a33323a223961393530366663313263373866346234633233646565643161666430363736223b733a33323a226135383962313335313231653564336566306436366538636462653638316332223b733a33323a226639353730663761326234663739306563333462383664363166666438333438223b733a33323a226333353630316265656435313863656564303733623537343736313034326433223b733a33323a223732626531616562333832303163303465366230633962343064663434633238223b733a33323a226238383931313564623764363636663832303866653938383234646161376263223b733a33323a226635366238653238363162653831356337336635653361346466393538333933223b733a33323a223266366633633334643537303263326336656639353963653065366536663234223b733a33323a223863363665333966346434363531626363333633616463333566373365636330223b733a33323a223837383664663033336161643934316161363331643762343035356333616235223b733a33323a223434633063363564336132333665316234666262626165636563363865356165223b733a33323a226230303738343463653738653339613961366433356530366135356466303937223b733a33323a226462623765313638623561653437626338646133313631316235373862623439223b733a33323a226461616161306462326531326232396636383339646639316633356663636164223b733a33323a223033663333383034346234323361393030333231323866663563663034383833223b733a33323a223734613138373064333033363834366165373264613364643065633233643033223b733a33323a223166346234313935333033326232303361373137653863333336623061366265223b733a33323a223362353764663333663930626264353137346561613038646437633033346131223b733a33323a226366323866373133396638303634313666333364373435343063343436323364223b733a33323a223462653030333063376330333835363566663263636366373063323434386435223b733a33323a226531326139343639333338396337656136653863383030623132356431623361223b733a33323a223033613137643236336136623339613536643838623333613030363237663264223b733a33323a223839303636653036363434633330653436303232663539396261363966633766223b733a33323a223830306162323261636261373366636435363236336361663833306232616461223b733a33323a223138326436616138393363643838393933653136626630646165643766326561223b733a33323a226564306465303538393563353133363361653538373634666665633661623934223b7d733a343a2268617368223b733a36353a2265643064653035383935633531333633616535383736346666656336616239342d3138326436616138393363643838393933653136626630646165643766326561223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f436c65616e55726c5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3535313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a333a7b733a33323a223134363465663661363435333763393238393734383863623131353633663061223b733a33323a223933393833306464633932393565373963343764353332383239616361316464223b733a33323a223930333165386632326430623732373433643938626532656264613565383362223b733a33323a223362396665613766656561613230353539343038376135333838663662666566223b733a33323a226531623930626633643966616439623161633337623662303662663138373030223b733a33323a223362363331613930336332636161333366633963366637646431333035343939223b7d733a343a2268617368223b733a36353a2233623633316139303363326361613333666339633666376464313330353439392d6531623930626633643966616439623161633337623662303662663138373030223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7369746570616765666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3633313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a343a7b733a33323a223532303733646466353537663436356231313130356164636165646636613038223b733a33323a223530656362356432666166336165393066643365376163306563396565353037223b733a33323a223766613762356262383336343138366164363531643436643763326232376137223b733a33323a223965363761353235323333643337636634623839323733373130663635366638223b733a33323a223862373863326164623064636130313238316466613231663837383633323136223b733a33323a223936353638306435383333313035373531323566396539623736663661616436223b733a33323a226433343231323631303537376338656130383163646432393832346462346562223b733a33323a223137626333336661313564326532346362323033373539383538623466666635223b7d733a343a2268617368223b733a36353a2231376263333366613135643265323463623230333735393835386234666666352d6433343231323631303537376338656130383163646432393832346462346562223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1677595860),
('8423e77b4588a37d7598f8def9271461', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313637363533343438362e30303530383b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223334326530356236306531376162316566353933633661623534653336376563223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363533373439363b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313637363533373537323b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313637363533383038363b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f63737266223b613a313a7b733a363a22455850495245223b693a313637363533373531353b7d7d72656469726563745f75726c7c733a32393a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e2f6974656d223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223939363763633539666263326339383732346636336535373535303531643631223b733a33323a226334306631626535356239363930393339393330623031636132336161363934223b7d733a343a2268617368223b733a36353a2263343066316265353562393639303933393933306230316361323361613639342d3939363763633539666263326339383732346636336535373535303531643631223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f417574687c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3232333a7b613a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4f6d656b614d657373656e6765727c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3230353a7b613a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3731313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a353a7b733a33323a223233613335616665343537643065356364653863383566636537356432646234223b733a33323a223230393833623638613636383064646663303930653566616334393639623837223b733a33323a223762656438363462303832313238656231356264646436653737633162323935223b733a33323a223931306365656162316330343635643637323334336538303138356162396666223b733a33323a223531646431616233643064316639323039303464633966316431613938656532223b733a33323a223938373966623237363331373136613435363463613865393639323739666265223b733a33323a223561633762333264356534333763356136353864613635623937626538613162223b733a33323a226264613864363935613463646362643638623831383433663839616263343138223b733a33323a223966333162363766353761386139363934393033613630396630663430613862223b733a33323a223134653131353266333537646463303837636134396438363336613764373563223b7d733a343a2268617368223b733a36353a2231346531313532663335376464633038376361343964383633366137643735632d3966333162363766353761386139363934393033613630396630663430613862223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a333637323a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a34323a7b733a33323a223363373432336135653439383032333932376433626665386531306161623162223b733a33323a223539393864613766353265353462323533386666636263373737643765636564223b733a33323a226361316465323635343937626662626234646466303966666633356632666633223b733a33323a226532623236373637323932346437656261643636626236323337356333633231223b733a33323a226237373862323139663935636266313430636237386132366138353966383537223b733a33323a226633613761383634633637333335623438356461653561393965393338643166223b733a33323a223639383935326134383935653134653764656131396263343936303232326431223b733a33323a223861346435613338626630333130633338306333616363653938393731396430223b733a33323a223839303562306639383137313434613930353661646263323639346634383364223b733a33323a223733613763313632333932343035326431653034626164663931326237363261223b733a33323a223932313366633663643739666265393638356165663931376435393866383939223b733a33323a223963666164633239386133666264386365366139326662623931393662366437223b733a33323a223533333964343239613137396339633664336436373232323962663334353566223b733a33323a223933363038363235313932666534306539326330356638633431663133383139223b733a33323a223063326137343132623438613437663437643638353530373830646539663062223b733a33323a223839623030393766633633656164303362663431363762636138653435656635223b733a33323a223866396164336661666137353837306333386265323563363831663665656132223b733a33323a223664353438316333633865316164643239376636376366643135663136303533223b733a33323a223138353030346639626337373838356465646232616138346138653439333165223b733a33323a223339623137323262613863663436326362316265636363376265343237336237223b733a33323a223234383838343765336533353664386537626331373739313839386531656637223b733a33323a223237303133653231666233313435663033376566663963323562396531626138223b733a33323a226265386263356534656661333034663165306561383030386238323562623133223b733a33323a226564636364346538353134363833373836636338366566636639366534656165223b733a33323a223235656533353465643433616662353265393134326330373962643663393231223b733a33323a226161363561363837343161396536323136353736393638303862333761666563223b733a33323a223337303537393138653633343938373961623365366131663162643564663966223b733a33323a223634313561623635376439643534356561636432393734326662333462616132223b733a33323a223338393061303338393938323764356531366665343464363133303637643561223b733a33323a223839666236323238383535633166626335386163643534313864323832636161223b733a33323a223066303534393163633536643566313265353136633361313138653036326665223b733a33323a226535316133346663633261393135666537666334383834633236666637353265223b733a33323a223133636266393630373164343636393064363432626230326137373866653331223b733a33323a226530393036643037303737653637363866333066363431663261383161323832223b733a33323a226365316439343139653132656630396636373030373434336466393130356166223b733a33323a223932366436373931306465663132323235313937383830363638653430303861223b733a33323a223730346563343037333230366561313561346533316538633762363164653332223b733a33323a223365643561656365616231626636373830663563386531333061393530623933223b733a33323a223264306266323036646137336639383434333930376438323164343836656563223b733a33323a226366376361633065396238346462323763346335366131613430376631633564223b733a33323a223435636132313837346231373963333062336362323132626630373764663234223b733a33323a223738653033616239373836396334333263356136643838313432353662383430223b733a33323a223833353862376233623036303737623234663135663430623632326438323738223b733a33323a226164643165346331643964663237623863363337313263366535386436626365223b733a33323a226161383935396436373366323530636664363063356139613833633132616439223b733a33323a223839333536336135353033323138383065656530613566393265373066303137223b733a33323a226361333330386264393163333865343730613032653638323433363038333132223b733a33323a223035383139323134383835636236373163376665363833386139316166376663223b733a33323a223761656338373932313438313535306335333362383331633161626365643234223b733a33323a226464326635363562326161336439363665666137313665333632393732383731223b733a33323a223837613836653832346262376539356162383064393665366439316438613662223b733a33323a223738313665656664306434633966396161366262303237333138393437356566223b733a33323a223134303139386138653137363439633736353033663836663664376565393330223b733a33323a223734396461303439313038326266363034643939633061333064663535616535223b733a33323a223966663561653334626231356239373565363662666638656333653534356262223b733a33323a223935323963383030633466333066323463393034633134333139653664346138223b733a33323a223765613936653237303764303430303932333666666537386438346136366535223b733a33323a226566333031386561363038663936356236303163346639313937326339616432223b733a33323a223237343862653863363231643837386666363335653663333830663433663233223b733a33323a223638326666663863616430623934333436643563333432356336643634336134223b733a33323a226664353938306164666436636236353733353832393162303934656435373164223b733a33323a223835616465346162663866643035623565643230633037303365633961333235223b733a33323a226233373961613234353165633836656139666633636365656530616564663531223b733a33323a226161643866653136633662616364346361383636333963636262383937373339223b733a33323a226162313066303938316666363765323531373266386136643230633132356361223b733a33323a223534346362633538376634633033343565363962323638393561303161666363223b733a33323a223561363038656363323738343437303361656237643463363937663037626665223b733a33323a223333653362373464663032356632393435623464346261383530666533643733223b733a33323a223063663831666462316234623863393762303165623439666165383430613661223b733a33323a223366633431356163353665343037643832323735646264386561353939613637223b733a33323a223835646163623062636332633966306264353364636236386131353261393132223b733a33323a226332633434343666383537306463633632386533306165653035616639356533223b733a33323a226438653233323134643731623263643735366336653130323630633236616137223b733a33323a223032373666373739383865646134323131666137303964393564393038663661223b733a33323a223764666432393361363832323434333739393232343636626163326261613634223b733a33323a226362346164626136613536326634336632623430346263383366303262326337223b733a33323a223930653731376566363264373739373261383266326565343630303461326463223b733a33323a226231613865663535653737636566653731343130393061306534346363666565223b733a33323a223362613162323439396439666661376438623238313733643364653062643635223b733a33323a223934333466613330626664653661353139323662303963653862333035666239223b733a33323a223739393766306664653266633932396266623762333465396231663964376134223b733a33323a226362333039646130343166653831396536333939646432363339356535343131223b733a33323a223133653464373939663863306232663065623136346561643061653237393865223b733a33323a223835646565336364343237613464386263373631626664366331626433663766223b7d733a343a2268617368223b733a36353a2238356465653363643432376134643862633736316266643663316264336637662d3133653464373939663863306232663065623136346561643061653237393865223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f6d6f64756c655f41726b5f636f6e6669677572655f637372667c433a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a3339313a7b613a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a226664353463633531623333616636363939643566373166316561666439373661223b733a33323a223564613165333766326632396264666436623161626638356662396439313739223b7d733a343a2268617368223b733a36353a2235646131653337663266323962646664366231616266383566623964393137392d6664353463633531623333616636363939643566373166316561666439373661223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d7d, 1676534486);

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
('version', '\"3.2.0\"'),
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
(1, NULL, NULL, 1, 'default', 'default', 'default site', 'Default site created at Docker bootstrap phase', '[{\"type\":\"browse\",\"data\":{\"label\":\"Browse\",\"query\":\"\"},\"links\":[]},{\"type\":\"page\",\"links\":[],\"data\":{\"id\":2,\"label\":null}}]', '[]', '2023-02-15 16:04:55', '2023-02-28 14:48:57', 1, 1);

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
('advancedsearch_configs', 1, '[1]'),
('advancedsearch_main_config', 1, '1'),
('advancedsearch_redirect_itemset', 1, 'true'),
('advancedsearch_restrict_used_terms', 1, 'true'),
('eucookiebar_message', 1, '\"Warning: this site uses cookies or other means to steal your personal data and to allow Google or Facebook to fetch them. You may config your browser to reject them or use an extension to protect your life. See terms and conditions. By visiting this site, you accept them.\"'),
('eucookiebar_options', 1, '\"{\\n    \\\"acceptButton\\\": true,\\n    \\\"acceptText\\\": \\\"OK\\\",\\n    \\\"declineButton\\\": false,\\n    \\\"declineText\\\": \\\"Disable Cookies\\\",\\n    \\\"policyButton\\\": false,\\n    \\\"policyText\\\": \\\"Privacy Policy\\\",\\n    \\\"policyURL\\\": \\\"\\/\\\",\\n    \\\"bottom\\\": true,\\n    \\\"fixed\\\": true,\\n    \\\"zindex\\\": \\\"99999\\\"\\n}\"'),
('pdfviewer_template', 1, '\"common\\/pdf-viewer\"');

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
(5, 1, 'http://omeka.org/s/vocabs/o-module-extracttext#', 'extracttext', 'Extract Text', NULL);

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
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `IDX_BC91F416FDFF2E92` (`thumbnail_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resource_class`
--
ALTER TABLE `resource_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  ADD CONSTRAINT `FK_1F1B251EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

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

# CLAUDE.md

This file gives Claude Code guidance for working in this repository.

## What this project is

Maastricht University Library's Docker Compose environment for **Omeka S**. It runs Omeka S core, its modules and its themes together. The modules are PHP applications built on the Laminas framework. The repo holds no application code of its own. It holds infrastructure: Dockerfiles, compose files, config, and the pinned version of every module in `.env`.

## Hard rules for Claude

- **Never start, create, rebuild or recreate Docker containers.** That covers `docker compose up`, `docker compose build`, `docker run`, `docker compose restart` and anything else that starts a container. It also covers removing containers or volumes: `docker compose down` and `docker volume rm` delete the developer's data. The developer does all functional testing in the running stack.
- If a change needs a rebuild or restart to take effect (for example Dockerfile edits, `.env` version bumps or new volume binds), say so and give the command. Do not run it.
- **You may write and run unit tests** for the Omeka S modules being developed or bug-fixed in `externals/`. See "Unit testing" below.
- Git stays with the developer. Ask before any commit or push.

## Compose stack (`docker-compose.yml`)

| Service | Container | Purpose | Hostname |
|---|---|---|---|
| `omekas` | `omekas` | Omeka S on Apache and PHP-FPM, built from `omeka-s/Dockerfile` | http://omeka.local |
| `db` | `omekas_db` | MySQL 8.0. On first start with an empty volume it loads `db/init-omekas-db.sql` | — |
| `phpmyadmin` | `omekas_phpmyadmin` | Web UI for MySQL | http://db.local |
| `solr` | `omekas_solr` | Solr 9, built from `solr/`, used by AdvancedSearch and SearchSolr. The core name comes from `ENV_SOLR_CORE` | http://solr.local |
| `proxy` | `proxy` | `jwilder/nginx-proxy` reverse proxy on ports 80 and 443. It routes each request by the container's `VIRTUAL_HOST` | — |

Optional add-on compose files:
- `docker-compose-iiif-external.yml` adds iipsrv, Cantaloupe and a standalone Mirador viewer.
- `docker-compose-graphdb.yml` adds a GraphDB triple store, used by the LinkedDataSets module.

The named volumes are `db`, `omeka` (which holds Omeka `files/`) and `solrdata`. The developer's `/etc/hosts` points the `*.local` hostnames at 127.0.0.1.

## How Omeka modules and themes get into the container

**The normal path is baking modules into the image with `omeka-s/Dockerfile`.** Each module has an `ARG ENV_MODULE_<Name>_VERSION` followed by a `RUN curl … && unzip … -d modules/` block. Some blocks add a rename step (GitLab and tag archives unpack to versioned folder names) and a `composer install --no-dev` step. Module versions are pinned in `.env` and passed in as build args in `docker-compose.yml`.

To add or upgrade a module you have to change three things together:
1. `.env`: add or bump `ENV_MODULE_<Name>_VERSION`.
2. `docker-compose.yml`: add `- ENV_MODULE_<Name>_VERSION` under `omekas.build.args`. Skip this when upgrading an existing module.
3. `omeka-s/Dockerfile`: add the `ARG` and `RUN` block. Keep modules in alphabetical order, like the existing blocks.

Some modules are installed from the developer's forks (`mcoonen/...`) using patch-level tags such as `-pl2` or `-mc`. The upstream Daniel-KM download is left commented out above each of those blocks. Keep that pattern.

**The exception is modules and themes under local development.** These are cloned into `externals/`, which is gitignored except for its README. They are volume-bound into the container, which overrides the copy baked into the image:

```yaml
- ./externals/omekas-theme-um:/var/www/html/themes/omekas-theme-um
- ./externals/omekas-helpers:/var/www/html/helper
# pattern for a module under development:
# - ./externals/Omeka-S-module-Foo:/var/www/html/modules/Foo
```

Edits to files in `externals/` show up live in the running container. Every repo in `externals/` is its own git repository with its own history and remote. Do git operations inside that repo, not in this one.

## Other notable files

- `omeka-s/docker-entrypoint.sh`: generates `config/database.ini` from environment variables at runtime, creates the `files/` subdirectories, unpacks the initial ARK database, starts Apache and PHP-FPM, and streams the Omeka, Apache and FPM logs to `docker logs`.
- `omeka-s/config/local.config.php`: the Omeka local config (logger, thumbnailer and so on).
- `omeka-s/composer/`: the composer files for the Omeka root. They pin `jcupitt/vips` for ImageServer's fast tiler.
- `omeka-s/php-config/99-omeka.ini`, `omeka-s/apache-config/000-default.conf` and `proxy/omeka.conf`: PHP, Apache and nginx tuning.
- `db/init-omekas-db.sql`: the seed database dump. Some site and module settings live here, so changing them means editing the dump.
- `solr/`: the Solr image and an entrypoint that creates the core.
- `scripts/load_sample_data/`: a Python script that loads sample data through the Omeka API.
- `README*.md`: the developer's documentation for setup, Solr, Xdebug and PhpStorm, the IIIF servers, and LinkedDataSets with GraphDB.
- `openspec/` and `.claude/skills/openspec-*`: the OpenSpec spec-driven change workflow.

Commit messages reference a Jira ticket in brackets, for example `Upgraded SearchSolr to 3.5.72 [OMS-432]`. Branches are named after the ticket (`OMS-416`).

## Unit testing modules in `externals/`

- Most modules have a `phpunit.xml` and a `tests/` or `test/` directory. Many test bootstraps (`dirname(__DIR__, 3) . '/vendor/autoload.php'` and `CommonTest\Bootstrap`) expect the module to sit inside an Omeka S core checkout at `modules/<Name>`. The host has no Omeka core next to `externals/`, so those bootstraps will not resolve as-is.
- **Do not run DB-backed tests against the development database.** `CommonTest\Bootstrap` and `Omeka\Test\DbTestCase` **drop and recreate the schema**. Prefer pure unit tests that need no database or Omeka services, like `Omeka-S-module-Common/tests/phpunit-unit.xml` with `bootstrap-unit.php`. Mock Laminas services where needed.
- Modules with their own `vendor/` and standalone bootstrap can be tested directly on the host, for example LinkedDataSets with `composer phpunit` (it also has `phpstan`, `phpcs` and `phpmd` scripts).
- Host PHP is 8.5, but the container runs `ENV_PHP_VERSION` (currently 8.2). Write code and tests that work on 8.2.
- Ask the developer before running anything inside the running `omekas` container (`docker exec`). Never start a container to run tests.

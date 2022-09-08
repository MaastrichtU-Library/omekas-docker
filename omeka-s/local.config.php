<?php
return [
    'logger' => [
        'log' => true,
        'priority' => \Laminas\Log\Logger::INFO,
    ],
    'http_client' => [
        'sslcapath' => null,
        'sslcafile' => null,
    ],
    'cli' => [
        'phpcli_path' => null,
    ],
    'thumbnails' => [
        'types' => [
            'large' => ['constraint' => 800],
            'medium' => ['constraint' => 200],
            'square' => ['constraint' => 200],
        ],
        'thumbnailer_options' => [
            'imagemagick_dir' => null,
        ],
    ],
    'translator' => [
        'locale' => 'en_US',
    ],
    'service_manager' => [
        'aliases' => [
            'Omeka\File\Store' => 'Omeka\File\Store\Local',
            'Omeka\File\Thumbnailer' => 'Omeka\File\Thumbnailer\ImageMagick',
        ],
    ],
    'shibboleth' => [
        // This option can be skipped.
        'config' => [
            // Set true if you want to use user accounts managed by Omeka.
            // This option requires a special login page.
            // TODO Use the same login page (login form) for shibboleth and password.
            'shibboleth_password_login' => false,
	    // TODO: Check if the SLO URL is correct
            'shibboleth_url_logout' => '/Shibboleth.sso/Logout',
        ],
        'params' => [
            'attrPrefix' => '',
            'attrValueSeparator' => ';',
            'sessionIdVar' => 'Shib-Session-ID',
            'idpVar' => 'Shib-Identity-Provider',
            'appIdVar' => 'Shib-Application-ID',
            'authInstantVar' => 'Shib-Authentication-Instant',
            'authContextVar' => 'Shib-AuthnContext-Decl',
            // This is the mapped attribute, not the Shibboleth one.
            // So here, `email` is mapped from `mail`.
            //'identityVar' => 'uid',
            'identityVar' => 'email',
            'systemVarsInResult' => true,
            'attrMap' => [
                // LEFT: Omeka attribute, RIGHT: IdP Shibboleth attribute
                // Omeka S has a single name and no unique user name.
                'uid' => 'name',
                //'cn' => 'name',
                'mail' => 'email',
                //'email' => 'email',
                'memberOf' => 'eduPersonAffiliation',
                // 'memberOf' => 'memberOf',
                // 'supannEtablissement' => 'userprofile_institution_id',
                // 'anotherValue' => 'a_user_setting_key',
            ],
            // When the role is not found, use a default role.
            // It should be null or "guest" for security.
            'role_default' => null,
            // Update the role of the user on connection.
            // Warning, if the mapping has an issue and if there is no default
            // role, the user will be deactivated, even admins.
            'role_update' => false,
            // Mapping of the roles for production use.
            'production' => [
                'roles' => [
                    // 'global_admin' => '(memberOf=*xxx-global_admin*)',
                    // 'site_admin' => '(memberOf=*xxx-site_admin*)',
                    // 'editor' => '(memberOf=*xxx-editor*)',
                    // 'reviewer' => '(memberOf=*xxx-reviewer*)',
                    // 'author' => '(memberOf=*xxx-author*)',
                    // 'researcher' => '(shibIdentityProvider=xxxx)',
                    // // These roles require modules.
                    // 'guest' => '(memberOf=*xxx-guest*)',
                    // 'annotator' => '(memberOf=*xxx-annotator*)',
                    'global_admin' => '',
                    'site_admin' => '',
                    'editor' => '',
                    'reviewer' => '',
                    'author' => '',
                    'researcher' => '',
                    // These roles require modules.
                    //'guest' => '',
                    //'annotator' => '',
                ],
            ],
            // Keys to store as user setting when the user is created.
            // Values may be static ('locale' => 'fr') or mapped ('institution').
            // Mapped values (with a numeric id) should be mapped in attrMap
            // above. Mapped keys starting with `userprofile_` in attrMap are
            // automatically appended.
            // Warning: these values are not updated automatically.
            'user_settings' => [
                // Static keys.
                // 'locale' => 'fr',
                // 'guest_agreed_terms' => true,
                // Dynamic keys.
                // 'a_user_setting_key',
            ],
        ],
    ],
];

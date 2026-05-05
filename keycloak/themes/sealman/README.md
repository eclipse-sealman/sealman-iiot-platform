# Sealman Keycloak Theme

This theme is located in `keycloak/themes/sealman` and is mounted into the Keycloak container via a volume mount.

Important files:
- `login/theme.properties` enables the theme and includes the CSS file.
- `login/resources/css/styles.css` contains the complete visual styling.
- `login/resources/img/sealman-logo.svg` is the currently integrated Sealman branding.

If you want to use the exact PNG from the design, also place it at `keycloak/themes/sealman/login/resources/img/logo.png` and adjust the URL accordingly in the CSS file.

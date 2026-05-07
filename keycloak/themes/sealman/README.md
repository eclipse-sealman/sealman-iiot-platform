# Sealman Keycloak Theme

This theme is located in `keycloak/themes/sealman` and is mounted into the Keycloak container via a volume mount.

Important files:
- `login/theme.properties` enables the theme and includes the CSS file.
- `login/resources/css/styles.css` contains the complete visual styling.
- `login/resources/img/logo.png` is the currently integrated Sealman branding used by the CSS.

If you want to use a different branding asset (for example, an SVG), place it in `keycloak/themes/sealman/login/resources/img/` and update the URL accordingly in the CSS file.

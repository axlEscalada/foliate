{pkgs ? import <nixpkgs> {}}: let
  foliate = pkgs.foliate;
in
  pkgs.mkShell {
    buildInputs = with pkgs;
      [
        meson
        ninja
        pkg-config
        gjs
        gtk4
        libadwaita
        webkitgtk_6_0
        gettext
        desktop-file-utils
        appstream-glib
        glib
        gobject-introspection
        dconf
        glib-networking
        gsettings-desktop-schemas
        librsvg
      ]
      ++ foliate.buildInputs;

    shellHook = ''
      export GIO_EXTRA_MODULES=${pkgs.dconf.lib}/lib/gio/modules:${pkgs.glib-networking}/lib/gio/modules:$GIO_EXTRA_MODULES
      export GDK_PIXBUF_MODULE_FILE=${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache
      export XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk4}/share/gsettings-schemas/${pkgs.gtk4.name}:${foliate}/share/gsettings-schemas/${foliate.name}:${foliate}/share:$XDG_DATA_DIRS
      export GI_TYPELIB_PATH=${pkgs.glib}/lib/girepository-1.0:${pkgs.gobject-introspection}/lib/girepository-1.0:${pkgs.gdk-pixbuf}/lib/girepository-1.0:${pkgs.graphene}/lib/girepository-1.0:${pkgs.harfbuzz}/lib/girepository-1.0:${pkgs.pango}/lib/girepository-1.0:${pkgs.gsettings-desktop-schemas}/lib/girepository-1.0:${pkgs.gtk4}/lib/girepository-1.0:${pkgs.librsvg}/lib/girepository-1.0:${pkgs.libadwaita}/lib/girepository-1.0:${pkgs.libsoup}/lib/girepository-1.0:${pkgs.webkitgtk_6_0}/lib/girepository-1.0:$GI_TYPELIB_PATH
    '';
  }

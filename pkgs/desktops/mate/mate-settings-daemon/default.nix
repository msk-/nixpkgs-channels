{ stdenv, fetchurl, pkgconfig, intltool, glib, dbus-glib, libxklavier, libcanberra-gtk3, libnotify, nss, polkit, gnome3, mate, wrapGAppsHook
, pulseaudioSupport ? stdenv.config.pulseaudio or true, libpulseaudio
}:

stdenv.mkDerivation rec {
  name = "mate-settings-daemon-${version}";
  version = "1.20.3";

  src = fetchurl {
    url = "http://pub.mate-desktop.org/releases/${mate.getRelease version}/${name}.tar.xz";
    sha256 = "018f2yg4jd6hy0z7ks0s3jyjgpyi3vhd9j61951v5lb1x8ckzxhk";
  };

  nativeBuildInputs = [
    pkgconfig
    intltool
    wrapGAppsHook
  ];

  buildInputs = [
    dbus-glib
    libxklavier
    libcanberra-gtk3
    libnotify
    nss
    polkit
    gnome3.gtk
    gnome3.dconf
    mate.mate-desktop
    mate.libmatekbd
    mate.libmatemixer
  ] ++ stdenv.lib.optional pulseaudioSupport libpulseaudio;

  configureFlags = stdenv.lib.optional pulseaudioSupport "--enable-pulse";

  meta = with stdenv.lib; {
    description = "MATE settings daemon";
    homepage = https://github.com/mate-desktop/mate-settings-daemon;
    license = with licenses; [ gpl2 lgpl21 ];
    platforms = platforms.unix;
    maintainers = [ maintainers.romildo ];
  };
}

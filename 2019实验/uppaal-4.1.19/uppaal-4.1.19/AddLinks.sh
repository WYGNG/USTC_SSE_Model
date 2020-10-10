#!/bin/sh

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION=`"$HERE/bin-Linux/verifyta" -v | head -n 1 | awk '{ print $3 }'`
NAME="Uppaal-$VERSION"
SCRIPT="$0"

testcommand() {
    command -v $1 >/dev/null 2>&1 || { echo >&2 "$SCRIPT requires $1 but it's not installed. Aborting."; exit 1; }
}

echo -n "Checking that xdg-utils are installed... "
for c in xdg-mime xdg-icon-resource xdg-desktop-icon xdg-desktop-menu ; do
    testcommand $c
done
echo "OK"

echo -n "Installing Uppaal icons... "
for s in 16 24 32 48 64 96 128 ; do
    icon="$HERE/res/icon-"$s"x"$s".png"
    if [ -e "$icon" ] ; then
	xdg-icon-resource install --context apps --size $s "$icon" uppaal-icon || exit 1
	xdg-icon-resource install --context mimetypes --size $s "$icon" application-uppaal-xml || exit 1
    fi
done
echo "OK"

echo -n "Installing desktop and menu icons... "
LAUNCHER="$HOME/.local/share/applications/$NAME.desktop"
cat > "$LAUNCHER" << EOF
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
GenericName=Model Checker
Name=$NAME
Comment=Verify timed automata models
Exec="$HERE/uppaal" %u
Icon=uppaal-icon
Categories=Application;Science;Math;Education;Development;IDE
Terminal=false
StartupNotify=true
MimeType=application/uppaal-xml;application/uppaal-xta;application/vnd.uppaal-xml;application/vnd.uppaal-xta;application/x-uppaal-xml;application/x-uppaal-xta
EOF
xdg-desktop-icon install --novendor "$LAUNCHER" || exit 1
xdg-desktop-menu install --novendor "$LAUNCHER" || exit 1
echo "OK"

echo -n "Installing mime-type associations for Uppaal files... "
cat > /tmp/uppaal-xml-mimetype.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/uppaal-xml">
    <glob pattern="*.xml" weight="10"/>
    <sub-class-of type="application/xml"/>
    <magic priority="60">
      <match type="string" offset="35:100" value="-//Uppaal Team//DTD"/>
    </magic>
    <root-XML namespaceURI="http://www.uppaal.org/2013/Suite" localName="nta" weight="100"/>
    <alias type="application/vnd.uppaal-xml"/>
    <alias type="application/x-uppaal-xml"/>
    <generic-icon name="uppaal-icon"/>
  </mime-type>
</mime-info>
EOF
xdg-mime install /tmp/uppaal-xml-mimetype.xml || exit 1
rm -f /tmp/uppaal-xml-mimetype.xml

cat > /tmp/uppaal-xta-mimetype.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/uppaal-xta">
    <glob pattern="*.xta" weight="80"/>
    <sub-class-of type="text/plain"/>
    <alias type="application/vnd.uppaal-xta"/>
    <alias type="application/x-uppaal-xta"/>
    <generic-icon name="uppaal-icon"/>
  </mime-type>
</mime-info>
EOF
xdg-mime install /tmp/uppaal-xta-mimetype.xml || exit 1
rm -f /tmp/uppaal-xta-mimetype.xml

cat > /tmp/uppaal-ta-mimetype.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/uppaal-ta">
    <glob pattern="*.ta" weight="80"/>
    <sub-class-of type="text/plain"/>
    <alias type="application/vnd.uppaal-ta"/>
    <alias type="application/x-uppaal-ta"/>
    <generic-icon name="uppaal-icon"/>
  </mime-type>
</mime-info>
EOF
xdg-mime install /tmp/uppaal-ta-mimetype.xml || exit 1
rm -f /tmp/uppaal-ta-mimetype.xml

cat > /tmp/uppaal-ugi-mimetype.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/uppaal-ugi">
    <glob pattern="*.ugi" weight="80"/>
    <sub-class-of type="text/plain"/>
    <alias type="application/vnd.uppaal-ugi"/>
    <alias type="application/x-uppaal-ugi"/>
    <generic-icon name="uppaal-icon"/>
  </mime-type>
</mime-info>
EOF
xdg-mime install /tmp/uppaal-ugi-mimetype.xml || exit 1
rm -f /tmp/uppaal-ugi-mimetype.xml

xdg-mime default "$LAUNCHER" "application/uppaal-xml" || exit 1
xdg-mime default "$LAUNCHER" "application/uppaal-xta" || exit 1
xdg-mime default "$LAUNCHER" "application/uppaal-ta" || exit 1

update-mime-database ~/.local/share/mime || exit 1
update-desktop-database ~/.local/share/applications || exit 1

echo "OK"


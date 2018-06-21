# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop gnome2-utils systemd

MY_P="keybase"

DESCRIPTION="Desktop client for keybase.io"
HOMEPAGE="https://keybase.io/"
SRC_URI="https://github.com/keybase/client/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

KEYBASE_DEPEND="
	~app-crypt/keybase-${PV}"

DEPEND="
	sys-apps/yarn
	${KEYBASE_DEPEND}"

RDEPEND="
	${KEYBASE_DEPEND}"

electron_arch() {
	if use x86; then
		echo ia32
	elif use amd64; then
		echo x64
	fi
}

src_unpack() {
	unpack "${MY_P}.tar.gz"
	ln -vs "client-${PV}" "${P}" || die
	mkdir -vp "${S}/src/github.com/keybase" || die
	ln -vs "${S}" "${S}/src/github.com/keybase/client" || die
	sed -i "${S}/packaging/linux/systemd/keybase.gui.service" -e "s,/opt/keybase/Keybase,/usr/bin/Keybase,g" || die
}

src_compile() {
	cd "${S}/shared"
	env NODE_ENV=development yarn || die
	env NODE_ENV=production yarn run package --platform linux --arch "`electron_arch`" --appVersion "${PV}" || die
}

src_install() {
	dodir "/var/lib/keybase"
	insinto "/var/lib/keybase"
	doins -r "${S}/shared/desktop/release/linux-`electron_arch`/Keybase-linux-`electron_arch`"
	fperms +x "/var/lib/keybase/Keybase-linux-`electron_arch`/Keybase"
	dosym "/var/lib/keybase/Keybase-linux-`electron_arch`/Keybase" "/usr/bin/Keybase"

	# Copy in the icon images.
	for size in 16x16 32x32 128x128 256x256 512x512 ; do
		newicon -s ${size} "${S}/media/icons/Keybase.iconset/icon_${size}.png" "${MY_P}.png"
	done

	domenu "${S}/packaging/linux/keybase.desktop"

	systemd_douserunit "${S}/packaging/linux/systemd/keybase.gui.service"
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

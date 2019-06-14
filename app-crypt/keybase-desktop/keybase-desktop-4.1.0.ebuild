# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg systemd

MY_P="keybase-${PV}"

DESCRIPTION="Desktop client for keybase.io"
HOMEPAGE="https://keybase.io/"
SRC_URI="https://github.com/keybase/client/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
FEATURES="-network-sandbox"

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
	gnome-base/gconf
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
}

src_prepare() {
	default
	sed -i "${S}/packaging/linux/systemd/keybase.gui.service" -e "s,/opt/keybase/Keybase,/usr/bin/Keybase,g" || die
	xdg_src_prepare
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
	dosym "${EPREFIX}/var/lib/keybase/Keybase-linux-`electron_arch`/Keybase" "/usr/bin/Keybase"

	# Copy in the icon images.
	for size in 16x16 32x32 128x128 256x256 512x512 ; do
		newicon -s ${size} "${S}/media/icons/Keybase.iconset/icon_${size}.png" "${MY_P}.png"
	done

	domenu "${S}/packaging/linux/keybase.desktop"

	systemd_douserunit "${S}/packaging/linux/systemd/keybase.gui.service"
}

pkg_preinst() {
	xdg_pkg_preinst
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}

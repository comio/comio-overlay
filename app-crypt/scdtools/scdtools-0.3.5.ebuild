# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd fcaps

DESCRIPTION="Tools for Scdaemon and OpenPGP smartcards"
HOMEPAGE="https://incenp.org/dvlpt/scdtools.html"
SRC_URI="https://incenp.org/files/softs/scdtools/0.3/${PN}-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="
	app-crypt/gnupg
	>=dev-libs/libgcrypt-1.6.0
	>=dev-libs/libassuan-2.1.0
	>=dev-libs/libgpg-error-1.11
"

RDEPEND="${DEPEND}"

src_configure() {
	econf
}

src_install() {
	exeinto /usr/bin
	chmod +s "src/scdrand"
	doexe "src/scdrand"
	doexe "src/scdtotp"

	systemd_douserunit "${FILESDIR}/scdrand.service"

	dodoc AUTHORS NEWS README.md
}


pkg_postinst() {
	fcaps cap_sys_admin "usr/bin/scdrand"
}

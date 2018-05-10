# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit pam autotools

DESCRIPTION="Poldi is a PAM module implementing authentication via OpenPGP smartcards."
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="https://github.com/gpg/poldi/archive/release-${PV}.zip -> ${PN}-release-${PV}.zip"
# ftp://ftp.gnupg.org/gcrypt/alpha/poldi/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/pam
	dev-libs/libgcrypt
	>=dev-libs/libgpg-error-0.7
	>=dev-libs/libksba-1.0.2
	dev-libs/libassuan"

RDEPEND=${DEPEND}

PATCHES=(
    "${FILESDIR}/patches-${PV}/" #*.patch
)


S="${WORKDIR}/${PN}-release-${PV}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-maintainer-mode
}
src_install() {
	DESTDIR="${D}" emake install-conf-skeleton
	dopammod ${S}/src/pam/pam_poldi.so
	dodoc AUTHORS COPYING NEWS README THANKS
	doinfo ${S}/doc/poldi.info
}

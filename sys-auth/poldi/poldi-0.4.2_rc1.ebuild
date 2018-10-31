# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit pam autotools

COMMIT_SHORT=d9a9ff9
COMMIT="${COMMIT_SHORT}70ecbc57758a243858d30cbb398b7315e"
DESCRIPTION="Poldi is a PAM module implementing authentication via OpenPGP smartcards."
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=poldi.git;a=snapshot;h=${COMMIT};sf=tgz -> ${PN}-${PV}.tgz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="virtual/pam
	dev-libs/libgcrypt:0
	>=dev-libs/libgpg-error-0.7
	>=dev-libs/libksba-1.0.2
	dev-libs/libassuan"

RDEPEND=${DEPEND}

PATCHES=( "${FILESDIR}/patches-${PV}/" )

S="${WORKDIR}/${PN}-${COMMIT_SHORT}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --enable-maintainer-mode
}
src_install() {
	DESTDIR="${D}" emake install-conf-skeleton
	dopammod "${S}/src/pam/pam_poldi.so"
	dodoc AUTHORS NEWS README THANKS
	doinfo "${S}/doc/poldi.info"
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Tools for Scdaemon and OpenPGP smartcards"
HOMEPAGE="https://incenp.org/dvlpt/scdtools.html"
SRC_URI="https://incenp.org/files/softs/scdtools/0.3/${PN}-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# RESTRICT="strip"

DEPEND="
	app-crypt/gnupg
	>=dev-libs/libgcrypt-1.6.0
	>=dev-libs/libassuan-2.1.0
	>=dev-libs/libgpg-error-1.11
"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/patches/0001-Add-limits.h-include.patch" )

src_configure() {
	econf
}

# The following src_compile function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
#src_compile() {
	# emake is a script that calls the standard GNU make with parallel
	# building options for speedier builds (especially on SMP systems).
	# Try emake first.  It might not work for some packages, because
	# some makefiles have bugs related to parallelism, in these cases,
	# use emake -j1 to limit make to a single process.  The -j1 is a
	# visual clue to others that the makefiles have bugs that have been
	# worked around.

	#emake
#}

src_install() {
	exeinto /usr/bin
	# chmod +s "src/scdrand"
	doexe "src/scdrand"
	doexe "src/scdtotp"

	dodoc AUTHORS NEWS README.md
}

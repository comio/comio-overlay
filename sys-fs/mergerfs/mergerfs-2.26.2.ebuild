# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd

DESCRIPTION="Another (FUSE based) union filesystem"
HOMEPAGE="https://github.com/trapexit/mergerfs"
SRC_URI="https://github.com/trapexit/mergerfs/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+lto"
RESTRICT="mirror"

RDEPEND="
	sys-apps/attr:=
	>=sys-apps/util-linux-2.18
	sys-devel/gettext:=
"

DEPEND="
	${RDEPEND}
"

PATCHES=(
    "${FILESDIR}/custom_cxxflags.patch"
)

src_compile() {
	if use lto; then
		ENABLE_LTO="LTO=1"
	fi
	einfo emake $ENABLE_LTO
	emake $ENABLE_LTO
}

src_install() {
	dobin mergerfs
	dodoc README.md
	doman man/mergerfs.1
}


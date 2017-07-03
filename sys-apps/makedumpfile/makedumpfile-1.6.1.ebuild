# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI=6

inherit flag-o-matic toolchain-funcs

if [ ${PV} = 9999 ]; then
	inherit git-2
	EGIT_REPO_URI="git://git.code.sf.net/p/{PN}/code"
	KEYWORDS=""
else
	SRC_URI="http://downloads.sourceforge.net/project/makedumpfile/${PN}/${PV}/${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="minimize and compress /proc/vmcore for use with crash."
HOMEPAGE="http://sourceforge.net/projects/makedumpfile/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="lzo snappy"

RDEPEND="
	dev-libs/elfutils
	lzo? ( dev-libs/lzo )
	snappy? ( app-arch/snappy )"

DEPEND="${RDEPEND}"

src_compile () {
	MAKE_EXTRA_OPTS="LINKTYPE=dynamic"
	use snappy && MAKE_EXTRA_OPTS="${MAKE_EXTRA_OPTS} USESNAPPY=on"
	use lzo && MAKE_EXTRA_OPTS="${MAKE_EXTRA_OPTS} USELZO=on"

	emake CC="$(tc-getCC)" ${MAKE_EXTRA_OPTS} CFLAGS_ARCH="${CFLAGS}"
}

src_install () {
	emake DESTDIR="${D}" install

	dodoc README COPYING IMPLEMENTATION
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils pax-utils systemd unpacker user

COMMIT=0864c5acc6a44267048b0860019d380896035832
DESCRIPTION="A script that moves a folder to RAM (tmpfs) and can sync it to disk any time thanks to bind mounts."
HOMEPAGE="https://github.com/bobafetthotmail/folder2ram"

SRC_URI="https://github.com/bobafetthotmail/folder2ram/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${PN}-${COMMIT}"

PATCHES=( "${FILESDIR}/00-fix-systemd-path.patch" )

src_install() {
	exeinto "/sbin"
	doexe "debian_package/sbin/${PN}"
}

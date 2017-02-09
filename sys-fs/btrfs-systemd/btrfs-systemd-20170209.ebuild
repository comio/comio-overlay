# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
KEYWORDS="~amd64 ~x86"

inherit eutils systemd

DESCRIPTION="Small utilities for Btrfs."
HOMEPAGE="https://btrfs.wiki.kernel.org/index.php/Main_Page"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
IUSE=""
DEPEND="sys-fs/btrfs-progs"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	exeinto /usr/sbin/
	doexe "${FILESDIR}/btrfs-scrub-all"
	systemd_dounit "${FILESDIR}/btrfs-scrub.service"
	systemd_dounit "${FILESDIR}/btrfs-scrub.timer"
}

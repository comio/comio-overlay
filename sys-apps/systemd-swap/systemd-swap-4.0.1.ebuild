# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd

DESCRIPTION="Script for manage swap on zswap, zram, files or block devices."
HOMEPAGE="https://github.com/Nefelim4ag/${PN}"

SRC_URI="https://github.com/Nefelim4ag/${PN}/archive/${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	exeinto "/usr/bin"
	doexe "systemd-swap"
	insinto "/etc/systemd"
	doins "swap.conf"
	systemd_dounit "${S}/systemd-swap.service"
	dodoc "README.md"
}

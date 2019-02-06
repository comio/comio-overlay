# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="My systemd services"
HOMEPAGE="https://github.com/comio/comio-overlay"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

inherit systemd

src_unpack()
{
	einfo "unpack"
	mkdir -p "${WORKDIR}/${P}"
}

src_install()
{
	systemd_dounit "${FILESDIR}/internet-online.target"
	systemd_dounit "${FILESDIR}/wait-hdmi.service"
	systemd_dounit "${FILESDIR}/wait-internet.service"
}

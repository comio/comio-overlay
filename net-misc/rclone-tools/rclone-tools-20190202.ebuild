# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
KEYWORDS="~amd64 ~x86"

inherit eutils systemd

DESCRIPTION="rclone support utility."
HOMEPAGE="https://github.com/comio/rclone-tools"
COMMIT="acc831ad53d8914102a9c282a0b61d772da42069"
SRC_URI="https://github.com/comio/rclone-tools/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	exeinto /usr/sbin/
	doexe mount.rclone
	systemd_newunit rclone-mount@.service.system rclone-mount@.service
	systemd_newuserunit rclone-mount@.service.user rclone-mount@.service
}

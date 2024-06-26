# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
KEYWORDS="~amd64 ~x86"

inherit systemd

DESCRIPTION="rclone support utility."
HOMEPAGE="https://github.com/comio/rclone-tools"
COMMIT="0a1874f48bbd6ca6a1d71f8f9d286b1548f68681"
SRC_URI="https://github.com/comio/rclone-tools/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="net-misc/rclone"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	exeinto /usr/sbin/
	doexe mount.rclone
	systemd_newunit rclone-mount@.service.system rclone-mount@.service
	systemd_newuserunit rclone-mount@.service.user rclone-mount@.service
}

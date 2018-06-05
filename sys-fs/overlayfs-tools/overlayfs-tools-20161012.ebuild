# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
KEYWORDS="~amd64 ~x86"

inherit eutils systemd

DESCRIPTION="OverlayFS support utility."
HOMEPAGE="https://github.com/comio/overlayfs-tools"
COMMIT="483dcec7c52f424c3a73999839d5ef170a115308"
SRC_URI="https://github.com/comio/overlayfs-tools/archive/${COMMIT}.zip"

LICENSE="GPL-3"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	exeinto /usr/sbin/
	doexe overlay
	doexe overlay-sync
	keepdir /etc/overlay-sync
	systemd_dounit systemd/overlay-sync@.service
}

# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_SRC="github.com/ncw/${PN}"
EGO_PN="${EGO_SRC}"

KEYWORDS="~amd64 ~x86"
SRC_URI="https://${EGO_SRC}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Sync files to and from Google Drive, S3, Swift, Cloudfiles, Dropbox, ..."
HOMEPAGE="http://rclone.org"
LICENSE="MIT"
SLOT="0"
IUSE=""
DEPEND="dev-go/cli"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/bin
	doexe "${S}/${PN}"
	doman "${S}/src/${EGO_SRC}/${PN}.1"
}
# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

SRC_URI="https://github.com/creativeprojects/resticprofile/archive/refs/tags/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz
    https://www.comio.it/distfiles/${PN}-${PV}-deps.tar.xz"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Configuration profiles manager for restic backup"
HOMEPAGE="https://creativeprojects.github.io/resticprofile/"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="app-backup/restic"
RDEPEND="${DEPEND}"

src_compile() {
    ego build
}

src_install() {
    dodoc -r LICENSE README.md examples contrib
    newbashcomp contrib/completion/bash-completion.sh resticprofile
    dobin resticprofile
}

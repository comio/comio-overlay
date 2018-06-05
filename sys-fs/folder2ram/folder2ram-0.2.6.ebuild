# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils systemd unpacker user

COMMIT=b8cdd21eb4e68d86cda08b95fd565052711bf801
DESCRIPTION="A script that moves a folder to RAM (tmpfs)."
HOMEPAGE="https://github.com/bobafetthotmail/folder2ram"

SRC_URI="https://github.com/bobafetthotmail/folder2ram/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	exeinto "/sbin"
	doexe "debian_package/sbin/${PN}"
}

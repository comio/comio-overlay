# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	AUTOTOOLS_AUTORECONF="1"
	EGIT_REPO_URI="https://github.com/google/${PN}.git"
else
	SRC_URI="https://github.com/google/${PN}/releases/download/${P}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit linux-info

DESCRIPTION="Small C tool for Linux filesystem encryption "
HOMEPAGE="https://github.com/google/fscryptctl"

LICENSE="APACHE-2"
SLOT="0"
IUSE=""
RESTRICT=""

COMMON_DEPEND=""

DEPEND="${COMMON_DEPEND}"

RDEPEND="${COMMON_DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD="1"

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists; then
		ewarn "Cannot check the linux kernel configuration."
	else
		if ! linux_chkconfig_present EXT4_ENCRYPTION && \
		   ! linux_chkconfig_present F2FS_ENCRYPTION ; then
			ewarn "Please enable encryption for required FS:"
			ewarn ""
			ewarn "    CONFIG_EXT4_ENCRYPTION=y"
			ewarn ""
			ewarn "and/or"
			ewarn ""
			ewarn "    CONFIG_F2FS_ENCRYPTION=y"
			ewarn ""
			ewarn "in /usr/src/linux/.config"
		fi
	fi
}

src_compile() {
    emake
}

src_install() {
	exeinto /usr/bin
	doexe "${S}/fscryptctl"
}

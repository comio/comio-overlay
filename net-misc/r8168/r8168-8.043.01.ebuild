# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-info linux-mod eutils

DESCRIPTION="r8168 driver for Realtek 8111/8168 PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="http://12244.wpc.azureedge.net/8012244/drivers/rtdrivers/cn/nic/0006-${P}.tar.bz2 -> ${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

MODULE_NAMES="r8168(net:${S}/src)"
BUILD_TARGETS="modules"
CONFIG_CHECK="!R8169"

ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter (CONFIG_R8169) to be DISABLED"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_install() {
	linux-mod_src_install
	dodoc README
}

sign_module()
{
	if linux_chkconfig_present MODULE_SIG ; then
		local modulename libdir srcdir objdir i n
		local sig_hash=$(eval echo $(linux_chkconfig_string MODULE_SIG_HASH))
		local signing_key=$(eval echo $(linux_chkconfig_string MODULE_SIG_KEY_SRCPREFIX)$(linux_chkconfig_string MODULE_SIG_KEY))

		strip_modulenames;
		for i in ${MODULE_NAMES};
		do
			unset libdir srcdir objdir
			for n in $(find_module_params ${i})
			do
				eval ${n/:*}=${n/*:/}
			done

			libdir=${libdir:-misc}
			srcdir=${srcdir:-${S}}
			objdir=${objdir:-${srcdir}}

			einfo "Signing ${modulename} module"

			cd "${KERNEL_DIR}"
			scripts/sign-file ${sig_hash} ${signing_key} "${KERNEL_DIR}/certs/signing_key.x509" "/lib/modules/${KV_FULL}/${libdir}/${modulename}.${KV_OBJ}" || die "Error signing ${modulename} module"
			cd "${OLDPWD}"
		done
	fi
}

pkg_postinst()
{
	sign_module
	linux-mod_pkg_postinst
}


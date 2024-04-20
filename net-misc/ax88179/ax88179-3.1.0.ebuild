# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

ASIX_FILE_NAME="asix_usb_nic_linux_driver_v${PV}"

DESCRIPTION="ASIX USB3.0/2.0 Gigabit Ethernet Network Adapter"
HOMEPAGE="https://www.asix.com.tw/en/product/USBEthernet/Super-Speed_USB_Ethernet/AX88179"

SRC_URI="https://www.asix.com.tw/en/support/download/file/1739 -> ${ASIX_FILE_NAME}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

IUSE="ptp"

CONFIG_CHECK="~!USB_NET_AX88179_178A"
WARNING_USB_NET_AX88179_178A="CONFIG_USB_NET_AX88179_178A is enabled. ${P} will not be loaded unless kernel driver AX88179 (CONFIG_USB_NET_AX88179_178A) is DISABLED."

S="${WORKDIR}/${ASIX_FILE_NAME}"

src_compile() {
	local modlist=( ax_usb_nic=kernel/drivers/net/usb/:. )
	local modargs=(
		# Build parameters
		KERNELDIR="${KV_OUT_DIR}"
		ENABLE_PTP_FUNC=$(usex ptp y n)
	)
	
	ENABLE_PTP_SUPPORT=$(usex ptp y n)


	linux-mod-r1_src_compile
}

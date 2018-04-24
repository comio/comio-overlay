# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="5"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches https://git.linuxtv.org/media_tree.git https://github.com/b-rad-NDi/Ubuntu-media-tree-kernel-builder"
IUSE="experimental"

MEDIATREE_SRC="linuxtv-mediatree-patches"
MEDIATREE_RELEASE="4.16.3-mediatree"
MEDIATREE_BASE="v${MEDIATREE_RELEASE}"
MEDIATREE_FILE="${MEDIATREE_BASE}.zip"
MEDIATREE_URI="https://github.com/comio/${MEDIATREE_SRC}/archive/${MEDIATREE_FILE}"

UBUNTUMEDIATREE_RELEASE="069672f5d46be58d3f7f2bf5abd84caf55f5fc1b"
UBUNTUMEDIATREE_BASE="Ubuntu-media-tree-kernel-builder-${UBUNTUMEDIATREE_RELEASE}"
UBUNTUMEDIATREE_FILE="${UBUNTUMEDIATREE_BASE}.zip"
UBUNTUMEDIATREE_URI="https://github.com/b-rad-NDi/Ubuntu-media-tree-kernel-builder/archive/${UBUNTUMEDIATREE_RELEASE}.zip"

DESCRIPTION="Full sources including the LinuxTV.org Media Tree patches and Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	${MEDIATREE_URI} ${UBUNTUMEDIATREE_URI} -> ${UBUNTUMEDIATREE_FILE}"

UNIPATCH_EXCLUDE="0101-media-vivid-check-if-the-cec_adapter-is-valid.patch1
	0306-media-rc-oops-in-ir_timer_keyup-after-device-unplug.patch1
	0365-media-atomisp_fops.c-disable-atomisp_compat_ioctl32.patch1"

src_unpack() {
	UNIPATCH_LIST=""
	UNIPATCH_STRICTORDER="yes"

	einfo "Preparing LinuxTV Media Tree patches... "
	unpack "${MEDIATREE_FILE}"
	for f in "${WORKDIR}/${MEDIATREE_SRC}-${MEDIATREE_RELEASE}/mediatree/"*.patch; do
		UNIPATCH_LIST+=" ${f}:1"
	done

	einfo "Preparing Ubuntu Media Tree patches... "
	unpack "${UBUNTUMEDIATREE_FILE}"
	for f in "${WORKDIR}/${UBUNTUMEDIATREE_BASE}/patches/mainline-extra/tip/"*/*.patch; do
		UNIPATCH_LIST+=" ${f}:1"
	done

	kernel-2_src_unpack

	rm -rf "${WORKDIR}/${MEDIATREE_SRC}-${MEDIATREE_RELEASE}"
	rm -rf "${WORKDIR}/${UBUNTUMEDIATREE_BASE}"
}

pkg_postinst() {
	kernel-2_pkg_postinst

	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="2"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
GHOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches https://git.linuxtv.org/media_tree.git"
IUSE="experimental"

MEDIATREE_SRC="linuxtv-mediatree-patches"
MEDIATREE_RELEASE="4.16.1-mediatree"
MEDIATREE_BASE="v${MEDIATREE_RELEASE}"
MEDIATREE_FILE="${MEDIATREE_BASE}.zip"
MEDIATREE_URI="https://github.com/comio/${MEDIATREE_SRC}/archive/${MEDIATREE_FILE}"

DESCRIPTION="Full sources including the LinuxTV.org Media Tree patches and Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${MEDIATREE_URI}"

src_unpack() {
	unpack "${MEDIATREE_FILE}"

	einfo "Preparing LinuxTV Media Tree patches... "

	UNIPATCH_LIST=""
	for f in "${WORKDIR}/${MEDIATREE_SRC}-${MEDIATREE_RELEASE}/mediatree/"*.patch; do
		UNIPATCH_LIST+=" ${f}:1"
	done
	UNIPATCH_STRICTORDER="yes"
	einfo "done."

	kernel-2_src_unpack
}

pkg_postinst() {
	kernel-2_pkg_postinst

	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
GHOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches https://git.linuxtv.org/media_tree.git"
IUSE="experimental"

MEDIATREE_RELEASE="20180323"
MEDIATREE_BASE="linuxtv-mediatree-patches"
MEDIATREE_FILE="${MEDIATREE_RELEASE}-${MEDIATREE_BASE}.zip"
MEDIATREE_URI="https://github.com/comio/linuxtv-mediatree-patches/archive/${MEDIATREE_FILE}"

DESCRIPTION="Full sources including the LinuxTV.org Media Tree patches and Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${MEDIATREE_URI}"

# UNIPATCH_LIST=""
# UNIPATCH_STRICTORDER=""

# ${DISTDIR}/${MEDIATREE_FILE}:1

# S="${WORKDIR}/linux-${PV}"

src_prepare() {
	einfo "Apply LinuxTV Media Tree patches"
	unpack "${MEDIATREE_FILE}"
	eapply "${S}/${MEDIATREE_BASE}-${MEDIATREE_RELEASE}-${MEDIATREE_BASE}/"
	rm -rf "${S}/${MEDIATREE_BASE}-${MEDIATREE_RELEASE}-${MEDIATREE_BASE}/"

	default
}

pkg_postinst() {
	kernel-2_pkg_postinst

	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

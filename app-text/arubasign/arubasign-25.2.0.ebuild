# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg-utils

DESCRIPTION="Aruba digital signature client"
HOMEPAGE="https://www.pec.it"
SRC_URI="
	amd64? (
		https://updatesfirma.aruba.it/downloads/ArubaSign-latest-LINUX.tar.zst -> ArubaSign-${PV}-LINUX.tar.zst
	)
"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
BDEPEND=""

RESTRICT="mirror bindist"

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=(
)

QA_DESKTOP_FILE="usr/share/applications/arubasign.desktop"
QA_PREBUILT="*"
# QA_MULTILIB_PATHS=(
# )

src_install() {
	# Remove Debian specific files
	exeinto /usr/bin
	doexe ./usr/bin/arubasign || die

	domenu ./usr/share/applications/arubasign.desktop || die
	doicon ./usr/share/pixmaps/arubasign.png || die

	insinto /opt
	cp -R ./opt/arubasign "${D}/opt" || die

	local SANDBOX="${D}/opt/arubasign/app/lin-x64/chrome-sandbox"
	if [ -f "${SANDBOX}" ]; then
		einfo "Setting permissions for chrome-sandbox ${SANDBOX}"
		chown root:root "${SANDBOX}"
		chmod 4755 "${SANDBOX}"
	else
		einfo "File chrome-sandbox ${SANDBOX} does not exist"
	fi
}


pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

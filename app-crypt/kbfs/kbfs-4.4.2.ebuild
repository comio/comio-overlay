#B Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-build systemd

KEYBASE_P="keybase-${PV}"
DESCRIPTION="Keybase Filesystem (KBFS)"
HOMEPAGE="https://keybase.io/docs/kbfs"
SRC_URI="https://github.com/keybase/client/archive/v${PV}.tar.gz -> ${KEYBASE_P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-crypt/gnupg
	sys-fs/fuse
	"

MY_S="${WORKDIR}/client-${PV}"

src_unpack() {
	unpack "${KEYBASE_P}.tar.gz"
	ln -vs "${MY_S}" "${S}" || die
	mkdir -p "${MY_S}/src/github.com/keybase" || die
	ln -vs "${MY_S}" "${MY_S}/src/github.com/keybase/client" || die
}

src_compile() {
	cd ${MY_S}
	EGO_PN="github.com/keybase/client/go/kbfs/kbfsfuse" \
		EGO_BUILD_FLAGS="-tags production -o ${T}/kbfsfuse" \
		golang-build_src_compile
	EGO_PN="github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase" \
		EGO_BUILD_FLAGS="-tags production -o ${T}/git-remote-keybase" \
		golang-build_src_compile
	EGO_PN="github.com/keybase/client/go/kbfs/redirector" \
		EGO_BUILD_FLAGS="-tags production -o ${T}/keybase-redirector" \
		golang-build_src_compile
}

src_test() {
	cd ${MY_S}
	EGO_PN="github.com/keybase/client/go//kbfs/kbfsfuse" \
		golang-build_src_test
}

src_install() {
	dobin "${T}/kbfsfuse"
	dobin "${T}/git-remote-keybase"
	dobin "${T}/keybase-redirector"
	systemd_douserunit "${S}/packaging/linux/systemd/kbfs.service"
}

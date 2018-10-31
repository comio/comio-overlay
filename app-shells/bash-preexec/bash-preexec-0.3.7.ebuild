# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

SRC_URI="https://github.com/rcaloras/${PN}/archive/${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="preexec and precmd hook functions for Bash in the style of Zsh."
HOMEPAGE="https://github.com/rcaloras/bash-preexec"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=app-shells/bash-4.2[plugins]"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc/bash/bashrc.d/
	doins "${S}/bash-preexec.sh"
	dodoc "${S}/README.md"
	dodoc "${S}/LICENSE.md"
}

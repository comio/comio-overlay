# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

# inherit au

SRC_URI="https://github.com/rcaloras/${PN}/archive/${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="preexec and precmd hook functions for Bash in the style of Zsh. They aim to emulate the behavior as described for Zsh."
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

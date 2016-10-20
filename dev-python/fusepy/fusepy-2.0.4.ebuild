# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7,3_{3,4,5}} )

inherit distutils-r1

DESCRIPTION="Python module that provides a simple interface to FUSE and MacFUSE."
HOMEPAGE="http://pypi.python.org/pypi/${PN}"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	"

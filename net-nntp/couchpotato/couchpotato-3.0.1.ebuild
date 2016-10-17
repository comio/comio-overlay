# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_RQ_USE="sqlite(+)"

inherit eutils user python-single-r1 systemd

DESCRIPTION="CouchPotato (CP) is an automatic NZB and torrent downloader."
HOMEPAGE="https://github.com/RuudBurger/CouchPotatoServer#readme"
SRC_URI="https://github.com/CouchPotato/CouchPotatoServer/archive/build/${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	dev-python/pyopenssl
	dev-python/lxml
	sys-apps/systemd
"

DEPEND="
	${RDEPEND}
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/CouchPotatoServer-build-${PV}/"

src_prepare() {
	mv "${S}/init/${PN}.fedora.service" "${S}/init/${PN}.service"
	default
}

pkg_setup() {
	python-single-r1_pkg_setup

	# Create couchpotato group
	enewgroup ${PN}
	# Create couchpotato user, put in couchpotato group
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_install() {
	dodoc README.md

	# Location of data files
	keepdir /var/${PN}
	fowners -R ${PN}:${PN} /var/${PN}

	insinto /etc/${PN}
	insopts -m0660 -o ${PN} -g ${PN}
	doins "${FILESDIR}/settings.conf"

	insinto /var/lib/CouchPotatoServer/
	exeinto /var/lib/CouchPotatoServer/
	doexe CouchPotato.py
	doins -r couchpotato libs version.py

	systemd_dounit "${FILESDIR}/couchpotato.service"
}

pkg_postinst() {
	elog "Couchpotato has been installed with data directories in /var/${PN}"
	elog
	elog "New user/group ${PN}/${PN} has been created"
	elog
	elog "Config file is located in /etc/${PN}/settings.conf"
	elog "Note: Log files are located in /var/${PN}/logs"
	elog
	elog "Visit http://<host ip>:5050 to configure Couchpotato"
	elog
}

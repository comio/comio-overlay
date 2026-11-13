# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="kdemultimedia-lite - merge this to pull in all kdemultimedia-derived packages"
HOMEPAGE="https://apps.kde.org/categories/multimedia/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64 ~ppc64 ~riscv ~x86"
IUSE="+cdrom +ffmpeg gstreamer"

RDEPEND="
	kde-apps/dragon
	kde-apps/juk
	kde-apps/kmix
	kde-apps/kwave
	media-sound/elisa
	media-sound/kasts
	media-sound/krecorder
	cdrom? (
		media-sound/audex
		kde-apps/audiocd-kio
		kde-apps/k3b
		kde-apps/libkcddb
	)
	ffmpeg? ( kde-apps/ffmpegthumbs )
	gstreamer? ( kde-apps/kamoso )
"

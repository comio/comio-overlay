# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A virtual for the flacon that install also dependices"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="aac ape mp3gain tta vorbis vorbisgain wavpack"

RDEPEND="
	media-sound/flacon
	aac? ( media-libs/faac )
	ape? ( media-sound/mac )
	mp3gain? ( media-sound/mp3gain )
	tta? ( media-sound/ttaenc )
	vorbis? ( media-sound/vorbis-tools )
	vorbisgain? ( media-sound/vorbisgain )
	mp3gain? ( media-sound/mp3gain )
	wavpack? ( media-sound/wavpack )
"

# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler32@1.2.0
	ahash@0.8.6
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.4
	anstyle@1.0.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.4.1
	block@0.1.6
	bumpalo@3.14.0
	byteorder@1.5.0
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	chrono-systemd-time@0.3.0
	clap@4.4.10
	clap_builder@4.4.9
	clap_derive@4.4.7
	clap_lex@0.6.0
	cocoa@0.20.2
	color_quant@1.1.0
	colorchoice@1.0.0
	core-foundation@0.7.0
	core-foundation-sys@0.7.0
	core-foundation-sys@0.8.6
	core-graphics@0.19.2
	crc32fast@1.3.2
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	crossterm@0.26.1
	crossterm_winapi@0.9.1
	csv@1.3.0
	csv-core@0.1.11
	deflate@0.7.20
	directories-next@2.0.0
	dirs@4.0.0
	dirs-sys@0.3.7
	dirs-sys-next@0.1.2
	either@1.9.0
	fallible-iterator@0.2.0
	fallible-streaming-iterator@0.1.9
	filedescriptor@0.8.2
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	getrandom@0.1.16
	getrandom@0.2.11
	gif@0.10.3
	hashbrown@0.14.3
	hashlink@0.8.4
	heck@0.4.1
	humantime@2.1.0
	iana-time-zone@0.1.58
	iana-time-zone-haiku@0.1.2
	image@0.22.5
	inflate@0.4.5
	itertools@0.10.5
	itoa@1.0.9
	jpeg-decoder@0.1.22
	js-sys@0.3.66
	libc@0.2.150
	libredox@0.0.1
	libsqlite3-sys@0.25.2
	lock_api@0.4.11
	log@0.4.20
	lzw@0.10.0
	malloc_buf@0.0.6
	memchr@2.6.4
	memoffset@0.9.0
	mio@0.8.9
	num-derive@0.2.5
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.2.4
	num-traits@0.2.17
	objc@0.2.7
	once_cell@1.18.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	path-absolutize@3.1.1
	path-dedot@3.1.1
	pkg-config@0.3.27
	png@0.15.3
	ppv-lite86@0.2.17
	proc-macro2@0.4.30
	proc-macro2@1.0.70
	quote@0.6.13
	quote@1.0.33
	rand@0.7.3
	rand@0.8.5
	rand_chacha@0.2.2
	rand_chacha@0.3.1
	rand_core@0.5.1
	rand_core@0.6.4
	rand_hc@0.2.0
	rayon@1.8.0
	rayon-core@1.12.0
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex@1.10.2
	regex-automata@0.4.3
	regex-syntax@0.8.2
	rusqlite@0.28.0
	ryu@1.0.15
	scoped_threadpool@0.1.9
	scopeguard@1.2.0
	serde@1.0.193
	serde_derive@1.0.193
	serde_json@1.0.108
	shellexpand@2.1.2
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.11.2
	strsim@0.10.0
	syn@0.15.44
	syn@2.0.39
	thiserror@1.0.50
	thiserror-impl@1.0.50
	tiff@0.3.1
	unicode-ident@1.0.12
	unicode-segmentation@1.10.1
	unicode-xid@0.1.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	wasi@0.9.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.89
	wasm-bindgen-backend@0.2.89
	wasm-bindgen-macro@0.2.89
	wasm-bindgen-macro-support@0.2.89
	wasm-bindgen-shared@0.2.89
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.51.1
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	x11@2.21.0
	zerocopy@0.7.28
	zerocopy-derive@0.7.28
"

inherit cargo readme.gentoo-r1

DESCRIPTION="McFly replaces your default ctrl-r shell history search with an intelligent search engine that takes into account your working directory and the context of recently executed commands. McFly's suggestions are prioritized in real time with a small neural network."
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/cantino/mcfly"
SRC_URI="${CARGO_CRATE_URIS}"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install

	insinto /usr/share/${PN}
	doins ${PN}.{bash,fish,zsh}

	# create README.gentoo
	local DISABLE_AUTOFORMATTING="yes"
	local DOC_CONTENTS=\
"To start using ${PN}, add the following to your shell:

~/.bashrc
eval \"\$(mcfly init bash)\"

~/.config/fish/config.fish
mcfly init fish | source

~/.zsh
eval \"\$(mcfly init zsh)\""
	readme.gentoo_create_doc

	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}

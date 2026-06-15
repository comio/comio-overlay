# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 desktop unpacker xdg

DESCRIPTION="The open source coding agent"
HOMEPAGE="https://github.com/anomalyco/opencode"

SRC_URI="
    amd64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-x64.tar.gz )
    arm64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-arm64.tar.gz )
    desktop? (
        amd64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-desktop-linux-amd64.deb )
        arm64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-desktop-linux-arm64.deb ) )"

IUSE="bash-completion desktop"
RESTRICT="mirror strip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
    desktop? (
        x11-libs/gtk+:3
        x11-libs/libnotify
        dev-libs/nss
        x11-libs/libXScrnSaver
        x11-libs/libXtst
        x11-misc/xdg-utils
        app-accessibility/at-spi2-core
        app-crypt/libsecret
    )
"

BDEPEND="
    bash-completion? (
        app-shells/bash-completion
    )
"

QA_PREBUILT="usr/bin/${PN}
    opt/OpenCode/ai.opencode.desktop
    opt/OpenCode/chrome-sandbox
    opt/OpenCode/chrome_crashpad_handler
    opt/OpenCode/lib*.so
    opt/OpenCode/resources/app.asar.unpacked/node_modules/*/*/*.node
    opt/OpenCode/resources/app.asar.unpacked/node_modules/*/*/prebuilds/*/*.node"

S="${WORKDIR}"

src_unpack() {
    unpacker_src_unpack

    unpacker "${S}/usr/share/doc/opencode/changelog.gz"
    rm "${S}/usr/share/doc/opencode/changelog.gz"
    mv "${S}/changelog" "${S}/usr/share/doc/opencode/"
}

src_install() {
    einfo "Installing OpenCode CLI"
    dobin opencode

    if use bash-completion; then
        einfo "Installing bash completion"
        newbashcomp ${FILESDIR}/${PN}.bash-completion ${PN}
    fi

    if use desktop; then
        einfo "Installing desktop files and icons"
        insinto /opt
        doins -r opt/OpenCode
        fperms 0755 /opt/OpenCode/{ai.opencode.desktop,chrome-sandbox,chrome_crashpad_handler}

        domenu usr/share/applications/*.desktop
        for icon_size in 32 64 128; do
            doicon --size ${icon_size} --theme hicolor ${S}/usr/share/icons/hicolor/${icon_size}x${icon_size}/apps/*.png
        done

        dodoc -r usr/share/doc/opencode/
    fi
}

pkg_postinst() {
    if use desktop; then
        xdg_desktop_database_update
        xdg_icon_cache_update
    fi
}

pkg_postrm() {
    if use desktop; then
        xdg_desktop_database_update
        xdg_icon_cache_update
    fi
}

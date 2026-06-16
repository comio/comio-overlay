# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 desktop unpacker xdg-utils

DESCRIPTION="The open source coding agent"
HOMEPAGE="https://github.com/anomalyco/opencode"

SRC_URI="
    amd64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-x64.tar.gz )
    arm64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-linux-arm64.tar.gz )
    desktop? (
        amd64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-desktop-linux-amd64.deb )
        arm64? ( https://github.com/anomalyco/opencode/releases/download/v${PV}/opencode-desktop-linux-arm64.deb ) )"

IUSE="apparmor bash-completion desktop"
REQUIRED_USE="apparmor? ( desktop )"
RESTRICT="mirror strip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
    apparmor? (
        sec-policy/apparmor-profiles
        sys-apps/apparmor:=
    )
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

QA_PREBUILT="usr/bin/${PN}
    opt/OpenCode/ai.opencode.desktop
    opt/OpenCode/chrome-sandbox
    opt/OpenCode/chrome_crashpad_handler
    opt/OpenCode/lib*.so
    opt/OpenCode/resources/app.asar.unpacked/node_modules/*/*/*.node
    opt/OpenCode/resources/app.asar.unpacked/node_modules/*/*/prebuilds/*/*.node"

S="${WORKDIR}"/

src_unpack() {
    unpacker_src_unpack

    gunzip "${S}/usr/share/doc/opencode/changelog.gz" || die
}

src_install() {
    einfo "Installing OpenCode CLI"
    dobin opencode

    if use bash-completion; then
        einfo "Installing bash completion"
        newbashcomp ${FILESDIR}/${PN}.bash-completion ${PN}
    fi

    if use desktop; then
        if use apparmor; then
            einfo "Installing AppArmor profile"
            insinto /etc/apparmor.d/
            newins opt/OpenCode/resources/apparmor-profile ai.opencode.desktop
        fi

        einfo "Installing desktop files and icons"
        insinto /opt
        doins -r opt/OpenCode
        fperms 0755 /opt/OpenCode/{ai.opencode.desktop,chrome-sandbox,chrome_crashpad_handler}
        dosym "${EPREFIX}/opt/OpenCode/ai.opencode.desktop" "${EPREFIX}/usr/bin/ai.opencode.desktop"

        domenu usr/share/applications/*.desktop
        for icon_size in 32 64 128; do
            doicon --size ${icon_size} --theme hicolor ${S}/usr/share/icons/hicolor/${icon_size}x${icon_size}/apps/*.png
        done

        einfo "Installing documentation"
        dodoc -r usr/share/doc/opencode/
    fi
}

pkg_postinst() {
    if use desktop; then
        xdg_desktop_database_update
        xdg_icon_cache_update
    fi

    if use apparmor && [[ -z ${ROOT} && -e /sys/kernel/security/apparmor/profiles &&
        $(wc -l < /sys/kernel/security/apparmor/profiles) -gt 0 ]]; then
        apparmor_parser -r "${EPREFIX}/etc/apparmor.d/ai.opencode.desktop"
    fi
}

pkg_prerm() {
    if use apparmor && [[ -z ${ROOT} && -e /sys/kernel/security/apparmor/profiles &&
        $(wc -l < /sys/kernel/security/apparmor/profiles) -gt 0 ]]; then
        # unload apparmor profile
        apparmor_parser --remove "${EPREFIX}/etc/apparmor.d/ai.opencode.desktop"
    fi
}

pkg_postrm() {
    if use desktop; then
        xdg_desktop_database_update
        xdg_icon_cache_update
    fi
}

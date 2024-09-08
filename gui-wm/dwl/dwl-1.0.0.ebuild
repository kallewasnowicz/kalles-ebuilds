# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig toolchain-funcs

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/kallewasnowicz/kalles-ebuilds.git"
	inherit git-r3
else
	MY_PV="${PV/_rc/-rc}"
	SRC_URI="https://github.com/kallewasnowicz/kalles-ebuilds/archive/refs/tags/v${MY_PV}.tar.gz"
	S="${WORKDIR}/dwl-${MY_PV}"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
fi

DESCRIPTION="dwm for Wayland"
HOMEPAGE="https://codeberg.org/dwl/dwl"

LICENSE="CC0-1.0 GPL-3+ MIT"
SLOT="0"
IUSE="X"

if [[ ${PV} == 9999 ]]; then
	COMMON_DEPEND="~gui-libs/wlroots-9999:=[libinput,session,X?]"
else
	COMMON_DEPEND="~gui-libs/wlroots-9999:=[libinput,session,X?]"
fi

COMMON_DEPEND+="
	dev-libs/libinput:=
	dev-libs/wayland
	x11-libs/libxkbcommon
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
"
RDEPEND="
	${COMMON_DEPEND}
	X? (
		x11-base/xwayland
	)
"
# uses <linux/input-event-codes.h>
DEPEND="
	${COMMON_DEPEND}
	sys-kernel/linux-headers
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.32
	>=dev-util/wayland-scanner-1.23
	virtual/pkgconfig
"

src_prepare() {
	restore_config config.h

	default
}

src_compile() {
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)" CC="$(tc-getCC)" \
		XWAYLAND="$(usev X -DXWAYLAND)" XLIBS="$(usev X "xcb xcb-icccm")" dwl
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}

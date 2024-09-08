# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"
ETYPE="sources"
EXTRAVERSION="-kalle" # Not used in kernel-2, just due to most ebuilds have it
K_USEPV="1"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="11"

CKV="$(ver_cut 1-3)"

inherit kernel-2 optfeature
detect_version

# disable all patch from kernel-2
UNIPATCH_LIST_DEFAULT=""

DESCRIPTION="Kalles Custom Kernel"
HOMEPAGE="https://github.com/kallewasnowicz/kalles-ebuilds"
SRC_URI="
	${KERNEL_URI}
	${GENPATCHES_URI}
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0001-amd-pstate.patch -> 0001-amd-pstate.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0002-bbr3.patch -> 0002-bbr3.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0003-block.patch -> 0003-block.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0005-crypto.patch -> 0005-crypto.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0006-fixes.patch -> 0006-fixes.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0008-ksm.patch -> 0008-ksm.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0009-ntsync.patch -> 0009-ntsync.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0010-perf-per-core.patch -> 0010-perf-per-core.patch
    https://raw.githubusercontent.com/CachyOS/kernel-patches/master/6.10/0012-zstd.patch -> 0012-zstd.patch
"

LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="experimental"
REQUIRED_USE=""

src_prepare() {
    eapply "${DISTDIR}/0001-amd-pstate.patch"
    eapply "${DISTDIR}/0002-bbr3.patch"
    eapply "${DISTDIR}/0003-block.patch"
    eapply "${DISTDIR}/0005-crypto.patch"
    eapply "${DISTDIR}/0006-fixes.patch"
    eapply "${DISTDIR}/0008-ksm.patch"
    eapply "${DISTDIR}/0009-ntsync.patch"
    eapply "${DISTDIR}/0010-perf-per-core.patch"
    eapply "${DISTDIR}/0012-zstd.patch"

    eapply_user
}

pkg_postinst() {
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
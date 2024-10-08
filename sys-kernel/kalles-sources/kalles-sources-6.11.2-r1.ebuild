# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"
ETYPE="sources"
EXTRAVERSION="-kalle" # Not used in kernel-2, just due to most ebuilds have it
K_USEPV="1"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="2"

CKV="$(ver_cut 1-3)"

inherit kernel-2 optfeature
detect_version

UNIPATCH_LIST_DEFAULT=""

DESCRIPTION="Kalles Custom Kernel"
HOMEPAGE="https://github.com/kallewasnowicz/kalles-ebuilds"
SRC_URI="
    ${KERNEL_URI}
    ${GENPATCHES_URI}
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0001-address-masking.patch -> 0001-address-masking.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0002-bbr3.patch -> 0002-bbr3.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0004-fixes.patch -> 0004-fixes.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0005-intel-pstate.patch -> 0005-intel-pstate.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0006-ksm.patch -> 0006-ksm.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0007-ntsync.patch -> 0007-ntsync.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0008-perf-per-core.patch -> 0008-perf-per-core.patch
    https://github.com/CachyOS/kernel-patches/raw/refs/heads/master/6.11/0010-zstd.patch -> 0010-zstd.patch
    https://github.com/sirlucjan/kernel-patches/blob/master/6.11/kbuild-cachyos-patches/0001-Cachy-Allow-O3.patch -> 0099-Cachy-Allow-O3.patch
"

LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="experimental"
REQUIRED_USE=""

src_prepare() {
    eapply "${DISTDIR}/0001-address-masking.patch"
    eapply "${DISTDIR}/0002-bbr3.patch"
    eapply "${DISTDIR}/0004-fixes.patch"
    eapply "${DISTDIR}/0005-intel-pstate.patch"
    eapply "${DISTDIR}/0006-ksm.patch"
    eapply "${DISTDIR}/0007-ntsync.patch"
    eapply "${DISTDIR}/0008-perf-per-core.patch"
    eapply "${DISTDIR}/0010-zstd.patch"
    eapply "${DISTDIR}/0099-Cachy-Allow-O3.patch"

    eapply_user
}

pkg_postinst() {
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

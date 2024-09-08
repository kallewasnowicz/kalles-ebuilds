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
"

LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE="experimental"
REQUIRED_USE=""

src_prepare() {
	files_dir="${FILESDIR}/${PV}"
    eapply "${files_dir}/0001-amd-pstate.patch"
    #eapply "${files_dir}/0001-cpu-6.10-merge-graysky-s-patchset.patch"
    #eapply "${files_dir}/0002-bbr3.patch"
    #eapply "${files_dir}/0003-block.patch"
    #eapply "${files_dir}/0005-fixes.patch"
    #eapply "${files_dir}/0007-ksm.patch"
    #eapply "${files_dir}/0008-ntsync.patch"
    #eapply "${files_dir}/0009-perf-per-core.patch"
    #eapply "${files_dir}/0011-zstd.patch"

    eapply_user
}

pkg_postinst() {
	kernel-2_pkg_postinst
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
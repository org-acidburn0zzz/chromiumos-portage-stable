# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

MY_P="${PN}-${PV/_pre/-PR}"
MY_P="${MY_P/5\.1/51}"

DESCRIPTION="Identify/delete duplicate files residing within specified directories"
HOMEPAGE="https://github.com/adrianlopezroche/fdupes"
SRC_URI="https://github.com/adrianlopezroche/${PN}/archive/${P/5\.1/51}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.51-makefile.patch \
		"${FILESDIR}"/${PN}-1.50_pre2-compare-file.patch \
		"${FILESDIR}"/${PN}-1.50_pre2-typo.patch \
		"${FILESDIR}"/${PN}-1.51-fix-stdin-lvalue.patch

	append-lfs-flags
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dobin fdupes
	doman fdupes.1
	dodoc CHANGES CONTRIBUTORS README TODO
}

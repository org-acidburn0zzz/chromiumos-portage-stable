# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="debug zlib"

# gnutls is an automagic dep.
RDEPEND=">=dev-libs/glib-2.0
	>=net-libs/gnutls-2.12.0
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local myeconfargs=(
		--enable-lfs
		$(use_enable !debug syslog)
		$(use_enable debug)
		$(use_enable zlib gznbd)
	)
	econf "${myeconfargs[@]}"
}

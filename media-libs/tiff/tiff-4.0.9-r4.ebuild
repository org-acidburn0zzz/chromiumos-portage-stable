# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools libtool multilib-minimal

DESCRIPTION="Tag Image File Format (TIFF) library"
HOMEPAGE="http://libtiff.maptools.org"
SRC_URI="http://download.osgeo.org/libtiff/${P}.tar.gz
	ftp://ftp.remotesensing.org/pub/libtiff/${P}.tar.gz"

LICENSE="libtiff"
SLOT="0"
KEYWORDS="*"
IUSE="+cxx jbig jpeg lzma static-libs test zlib"

RDEPEND="
	jpeg? ( >=virtual/jpeg-0-r2:0=[${MULTILIB_USEDEP}] )
	jbig? ( >=media-libs/jbigkit-2.1:=[${MULTILIB_USEDEP}] )
	lzma? ( >=app-arch/xz-utils-5.0.5-r1:=[${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.8-r1:=[${MULTILIB_USEDEP}] )
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20130224-r9
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}"

REQUIRED_USE="test? ( jpeg )" #483132

PATCHES=(
	"${FILESDIR}"/${PN}-4.0.7-pdfium-0006-HeapBufferOverflow-ChopUpSingleUncompressedStrip.patch
	"${FILESDIR}"/${PN}-4.0.7-pdfium-0008-HeapBufferOverflow-ChopUpSingleUncompressedStrip.patch
	"${FILESDIR}"/${P}-CVE-2017-9935.patch #624696
	"${FILESDIR}"/${P}-CVE-2017-9935-fix-incorrect-type.patch #624696
	"${FILESDIR}"/${P}-CVE-2017-18013.patch #645982
	"${FILESDIR}"/${P}-CVE-2018-5784.patch #645730
)

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/tiffconf.h
)

src_prepare() {
	default

	# tiffcp-thumbnail.sh fails as thumbnail binary doesn't get built anymore since tiff-4.0.7
	sed '/tiffcp-thumbnail\.sh/d' -i test/Makefile.am || die

	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		--without-x
		--with-docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable cxx)
		$(use_enable jbig)
		$(use_enable jpeg)
		$(use_enable lzma)
		$(use_enable static-libs static)
		$(use_enable zlib)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"

	# remove useless subdirs
	if ! multilib_is_native_abi ; then
		sed -i \
			-e 's/ tools//' \
			-e 's/ contrib//' \
			-e 's/ man//' \
			-e 's/ html//' \
			Makefile || die
	fi
}

multilib_src_test() {
	if ! multilib_is_native_abi ; then
		emake -C tools
	fi
	emake check
}

multilib_src_install_all() {
	find "${D}" -name '*.la' -delete || die
	rm "${ED}"/usr/share/doc/${PF}/{COPYRIGHT,README*,RELEASE-DATE,TODO,VERSION} || die
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyasn1/pyasn1-0.1.7.ebuild,v 1.19 2014/12/06 10:55:56 jlec Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="ASN.1 library for Python"
HOMEPAGE="http://pyasn1.sourceforge.net/ http://pypi.python.org/pypi/pyasn1"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="doc"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" test/suite.py || die "Tests fail with ${EPYTHON}"
}

src_install() {
	local HTML_DOCS=( doc/pyasn1-tutorial.html )
	use doc && HTML_DOCS=( doc/. )

	distutils-r1_src_install
}

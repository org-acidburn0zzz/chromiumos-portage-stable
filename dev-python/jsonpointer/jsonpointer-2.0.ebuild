# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6,7} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Identify specific nodes in a JSON document (according to draft 08)"
HOMEPAGE="https://github.com/stefankoegl/python-json-pointer https://pypi.org/project/jsonpointer/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" tests.py || die "Tests fail with ${EPYTHON}"
}

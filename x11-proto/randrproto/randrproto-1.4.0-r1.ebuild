# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/randrproto/randrproto-1.4.0-r1.ebuild,v 1.1 2013/02/25 21:51:06 mgorny Exp $

EAPI=4

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org Randr protocol headers"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby24 ruby25 ruby26"

inherit ruby-ng

DESCRIPTION="Virtual ebuild for the Ruby OpenSSL bindings"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	ruby_targets_ruby24? ( dev-lang/ruby:2.4[ssl] )
	ruby_targets_ruby25? ( dev-lang/ruby:2.5[ssl] )
	ruby_targets_ruby26? ( dev-lang/ruby:2.6[ssl] )
"

pkg_setup() { :; }
src_unpack() { :; }
src_prepare() { eapply_user; }
src_compile() { :; }
src_install() { :; }
pkg_preinst() { :; }
pkg_postinst() { :; }
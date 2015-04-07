# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-4.0.1-r1.ebuild,v 1.12 2014/11/26 02:00:24 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc RI.rdoc TODO.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eutils

DESCRIPTION="An extended version of the RDoc library from Ruby 1.8"
HOMEPAGE="https://github.com/rdoc/rdoc/"

LICENSE="Ruby MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

ruby_add_bdepend "
	dev-ruby/racc
	test? (
		virtual/ruby-minitest
	)"

ruby_add_rdepend "=dev-ruby/json-1* >=dev-ruby/json-1.4"

# This ebuild replaces rdoc in ruby-1.9.2 and later.
# ruby 1.8.6 is no longer supported.
RDEPEND="${RDEPEND}
	ruby_targets_ruby19? (
		>=dev-lang/ruby-1.9.2:1.9
	)"

all_ruby_prepare() {
	# Other packages also have use for a nonexistent directory, bug 321059
	sed -i -e 's#/nonexistent#/nonexistent_rdoc_tests#g' test/test_rdoc*.rb || die

	# Remove unavailable and unneeded isolate plugin for Hoe
	sed -i -e '/isolate/d' Rakefile || die

	# Remove licenses line from Hoe definitions so we also use older versions.
	sed -i -e '/licenses/ s:^:#:' Rakefile || die

	epatch "${FILESDIR}/${PN}-3.0.1-bin-require.patch"

	# Remove test that is depending on the locale, which we can't garantuee.
	sed -i -e '/def test_encode_with/,/^  end/ s:^:#:' test/test_rdoc_options.rb || die

	# Remove test depending on FEATURES=userpriv, bug 361959
	sed -i -e '/def test_check_files/,/^  end/ s:^:#:' test/test_rdoc_options.rb || die

	# Avoid the generate rule since it doesn't work on jruby, see below.
	sed -i -e '/:generate/d' Rakefile || die
}

all_ruby_compile() {
	all_fakegem_compile

	if use doc ; then
		ruby -Ilib -S bin/rdoc || die
	fi
}

each_ruby_compile() {
	# Generate the file inline here since the Rakefile confuses jruby
	# into a circular dependency.
	for file in lib/rdoc/rd/block_parser lib/rdoc/rd/inline_parser ; do
		${RUBY} -S racc -l -o ${file}.rb ${file}.ry || die
	done
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb test/test_*.rb || die
}

all_ruby_install() {
	all_fakegem_install

	for bin in rdoc ri; do
		ruby_fakegem_binwrapper $bin /usr/bin/$bin-2

		for version in 19 20; do
			if use ruby_targets_ruby${version}; then
				ruby_fakegem_binwrapper $bin /usr/bin/${bin}${version}
				sed -i -e "1s/env ruby/ruby${version}/" \
					"${ED}/usr/bin/${bin}${version}" || die
			fi
		done
	done
}

# -*- encoding: utf-8 -*-
redcloth_dir = Dir.pwd =~ /redcloth\/tmp/ ? File.expand_path("../../../..", Dir.pwd) : File.expand_path("..", __FILE__)
$LOAD_PATH.unshift File.join(redcloth_dir, 'lib')
require "redcloth/version"

Gem::Specification.new do |s|
  s.name        = "redcloth"
  s.version     = RedCloth::VERSION.to_s
  s.authors     = ["Jason Garber", "why the lucky stiff", "Ola Bini"]
  s.description = "Textile parser for Ruby."
  s.summary     = RedCloth::SUMMARY
  s.email       = "redcloth-upwards@rubyforge.org"
  s.homepage    = "http://redcloth.org"
  s.rubyforge_project = "redcloth"

  s.rubygems_version   = "1.3.7"
  s.default_executable = "redcloth"

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = ["COPYING", "README", "CHANGELOG"]
  s.rdoc_options     = ["--charset=UTF-8"]
  s.require_path     = "lib"

  s.files -= Dir['ext/**/*']
  s.files -= Dir['ragel/*']
  s.files -= Dir['lib/redcloth.jar']
  s.files -= Dir['lib/**/*.dll']
  s.files -= Dir['lib/**/*.bundle']
  s.files -= Dir['lib/**/*.so']
  
  # Rakefile needs to create spec for both platforms (ruby and java), using the
  # $platform global variable.  In all other cases, we figure it out from RUBY_PLATFORM.
  s.platform = $platform || RUBY_PLATFORM[/java/] || 'ruby'
  
  case s.platform.to_s
  when /java/
    s.files += ['lib/redcloth_scan.jar']
  when /mswin|mingw32/
    s.files += Dir['lib/*/*.so']
  else # MRI or Rubinius
    s.files += Dir['ext/**/*.c']
    s.extensions = Dir['ext/**/extconf.rb']
    s.add_development_dependency('rvm')
  end

  s.add_development_dependency('rake', '~> 0.8.7')
  s.add_development_dependency('rspec', '~> 2.1')
  s.add_development_dependency('diff-lcs')
  s.add_development_dependency('rake-compiler', '~> 0.7.1')
end
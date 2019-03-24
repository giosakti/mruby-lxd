require "#{MRUBY_ROOT}/lib/mruby/source"

MRuby::Gem::Specification.new('mruby-lxd') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Giovanni Sakti'
  spec.version = '0.0.1'
  spec.add_dependency('mruby-simplehttp')
end

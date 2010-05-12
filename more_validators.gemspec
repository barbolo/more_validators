Gem::Specification.new do |s|
  
  s.name = 'more_validators'
  s.version = '0.1.0'
  s.date = '2010-05-12'
  
  s.summary = 'Rails gem/plugin that provides a series of validators'
  s.description = 'Rails gem/plugin that implements a series of ActiveRecord validation helpers'
  
  s.authors = ['Rafael Barbolo', 'Ximon Eighteen', 'Dan Kubb', 'Thijs van der Vossen']
  s.email = 'rafael@barbolo.com.br'
  s.homepage = 'http://github.com/barbolo/more_validators'
  
  s.files = ['CHANGELOG',
             'LICENSE',
             'README',
             'Rakefile',
             'init.rb',
             'lib/validates_as_.rb',
             'lib/validates_as_email.rb',
             'test/validates_as_email_test.rb']

  s.test_files = ['test/validates_as_email_test.rb']

  s.has_rdoc = false
  
  s.require_paths = ['lib']
  s.post_install_message = %q{
  ============================================================
  Thanks for installing MoreValidators!
  ------------------------------------------------------------
  Check it out at http://github.com/barbolo/more_validators
  ============================================================
  }
  
end
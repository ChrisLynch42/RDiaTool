Gem::Specification.new do |s|
  s.name        = 'RDiaTool'
  s.version     = '0.0.1'
  s.date        = '2013-12-17'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
  s.executables << 'r_dia_tool'

  s.summary     = "A tool to generate Rails MVC code from Dia database diagram."
  s.description = "Generates Rails MVC code from Dia database diagram.  This can be done continuously throughout the development cycle.  Models, Controllers, Routes and Views can be customized.  Updates can be made to the database diagram and RDiaTool will update the Models, Controllers and Routes without corrupting the customizations.  Views are a all or nothing proposition.  You must either use the generated code or a custom view."
  s.authors     = ["Chris Lynch"]
  s.email       = 'chrislynch42@yahoo.com'
  s.files       = ["lib/r_dia_tool.rb"]
  s.homepage    = 'https://github.com/ChrisLynch42/RDiaTool'
  s.license       = 'GPL v3'
end

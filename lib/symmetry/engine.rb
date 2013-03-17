module Symmetry
  class Engine < ::Rails::Engine
    #isolate_namespace Symmetry
    config.generators do |g|
      #g.template_engine :haml
      g.integration_tool :rspec
      g.test_framework :rspec, view_specs: false
      #g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.orm :active_record
      #g.stylesheets true
      #g.form_builder :simple_form
    end
  end
end

# A sample Guardfile
# More info at https://github.com/guard/guard#readme
if ENV['TMUX']
  notification :tmux,
    display_message: true,
    timeout: 5, # in seconds
    default_message_format: '%s >> %s',
    # the first %s will show the title, the second the message
    # Alternately you can also configure *success_message_format*,
    # *pending_message_format*, *failed_message_format*
    line_separator: ' > ', # since we are single line we need a separator
    color_location: 'status-left-bg' # to customize which tmux element will
end

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'ctags-bundler', :src_path => ["app", "lib", "spec/support"] do
  watch(/^(app|lib|spec\/support)\/.*\.rb$/)
  watch('Gemfile.lock')
end

#guard 'livereload' do
  #watch(%r{app/views/.+\.(erb|haml|slim)$})
  #watch(%r{app/helpers/.+\.rb})
  #watch(%r{public/.+\.(css|js|html)})
  #watch(%r{config/locales/.+\.yml})
  ## Rails Assets Pipeline
  #watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
#end

#guard :rspec, cmd: "spring rspec", :all_on_start => false, debugger: true do
guard :rspec, cmd: 'bundle exec rspec', :all_on_start => false, debugger: true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  ## Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/features/#{m[1]}_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end


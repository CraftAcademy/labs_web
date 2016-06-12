activate :dotenv

Dir['lib/*.rb'].each { |file| require file }

activate :directory_indexes
activate :meta_tags
activate :search_engine_sitemap
activate :sprockets

set :url_root, 'https://labs.craftacademy.se'

# disable layout
page '.htaccess.apache', layout: false

# rename file after build
after_build do
  File.rename 'build/.htaccess.apache', 'build/.htaccess'
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers CurrentPageHelper,
        PartnerLogosHelper,
        MarkdownHelper,
        PossessiveHelper,
        SlugHelper,
        ImageHelper,
        GraduatesHelper,
        RawHelper,
        StatsHelper

set :js_dir, 'javascripts'
set :images_dir, 'images'

sprockets.append_path File.join root, 'bower_components'

set :apply_form_url, 'https://makerssweden.typeform.com/to/UlIfGg'
set :apply_sa_form_url, '//apply.thecraftacademy.co.za'
set :hire_form_url, 'https://makerssweden.typeform.com/to/SQcaqh'
set :class_site_url, 'http://class.craftacademy.se'

# Ignore folders with unused templates
ignore 'elements/*'
ignore 'not_in_use/*'
ignore 'case-studies/*' # as long as we don't present students

# Redirects from old site urls
redirect 'payments/new.html', to: config.apply_form_url
redirect 'apply.html', to: config.apply_form_url
redirect 'apply-for-ronin.html', to: config.apply_form_url
redirect 'blog.html', to: 'https://blog.craftacademy.se'

activate :deploy do |deploy|
  deploy.deploy_method          = :rsync
  deploy.host            = 'craftacademy.se'
  deploy.path            = '/var/www/html/ca-labs'
  deploy.user            = 'soundblab'
  deploy.build_before    = true
  deploy.clean           = true
end

configure :development do
  activate :livereload

  # custom setting for switching off analytics in development
  set :run_analytics, false

  # turn on to view a baseline grid for setting vertical rhythm
  set :show_baseline_grid, false
end

# Build-specific configuration
configure :build do
  # activate :imageoptim do |options|
  #   options.pngout    = false
  #   options.svgo      = false
  # end

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  set :run_analytics, true

  set :show_baseline_grid, false

  # Filewatcher ignore list
  set :file_watcher_ignore, [
    %r{^bin(\/|$)},
    %r{^\.bundle(\/|$)},
    # /^vendor(\/|$)/,
    %r{^node_modules(\/|$)/},
    %r{^\.sass-cache(\/|$)/},
    %r{^\.cache(\/|$)/},
    %r{^\.git(\/|$)/},
    %r{^\.gitignore$/},
    /\.DS_Store/,
    /^\.rbenv-.*$/,
    /^Gemfile$/,
    /^Gemfile\.lock$/,
    /~$/,
    %r{(^|\/)\.?#},
    %r{^tmp\/}
  ]
end

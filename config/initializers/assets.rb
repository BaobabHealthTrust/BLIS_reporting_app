# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
#Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( bootstrap.css )
Rails.application.config.assets.precompile += %w( docs.css )
Rails.application.config.assets.precompile += %w( prettify.css )
Rails.application.config.assets.precompile += %w( bootstrap-responsive.css )
Rails.application.config.assets.precompile += %w( datepicker.css )

Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( bootstrap-dropdown.js )
Rails.application.config.assets.precompile += %w( bootstrap-tab.js )
Rails.application.config.assets.precompile += %w( bootstrap.js )
Rails.application.config.assets.precompile += %w( jquery.validate.min.js )
Rails.application.config.assets.precompile += %w( additional-methods.min.js )
Rails.application.config.assets.precompile += %w( bootstrap-datepicker.js )
Rails.application.config.assets.precompile += %w( spin.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

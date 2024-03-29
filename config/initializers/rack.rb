# frozen_string_literal: true

# Remove 'x-runtime' header
Rails.application.config.middleware.delete(Rack::Runtime)

# Add content_type for some file extension not included in the
# list of defaults: https://github.com/rack/rack/blob/master/lib/rack/mime.rb
Rack::Mime::MIME_TYPES['.webmanifest'] = 'application/manifest+json'

# Enable gzip and brotli compression
Rails.application.config.middleware.use Rack::Deflater
Rails.application.config.middleware.use Rack::Brotli

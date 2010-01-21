# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nasad-files_session',
  :secret      => '226c2649ab24804c025ab567425fe537b8392d0b58b0904e10381e308156879193eb298ee38ba7564fbb76bb810dd10d2db3d0c9733ed0d91061b51202457d24'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

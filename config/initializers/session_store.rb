# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nava_session',
  :secret      => 'afda9b138df1f264f7b9d3412f213fa5c21b02f1942fe01e26b9acf62fe4e096716d937be9b8e8cf9658063197cd4ed43f413f2cd426f98ed8c7f577c8e8049f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

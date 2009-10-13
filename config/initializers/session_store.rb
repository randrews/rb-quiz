# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rb_quiz_session',
  :secret      => '4ae78e5e20ac7fe53c4bd0ca0310f4771fbd23d110d1db9a97aff3441879da71585a3a508272c71c3c25aa7dcf15550c82c506a175b1aefd1af7de749772a17a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

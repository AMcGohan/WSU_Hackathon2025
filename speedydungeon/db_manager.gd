#extends Node
#var db
#var totp_secret = generate_totp_secret()
#
#func hash_password(password: String, salt: String) -> String:
	#var hash = Marshalls.raw_to_base64(password.to_utf8_buffer() + salt.to_utf8_buffer())
	#return hash
	#
#func register_user(username: String, password: String):
	#var salt = str(randi())  # Generate a simple salt
	#var hashed_password = hash_password(password, salt)
	#db.query_with_args("INSERT INTO users (username, password, salt) VALUES (?, ?, ?)", [username, hashed_password, salt])
	#db.query_with_args("UPDATE users SET totp_secret=? WHERE username=?", [totp_secret, username])
	#print("User registered")
	#
#
#
#
#func generate_totp_secret() -> String:
	#var secret = Marshalls.raw_to_base64(OS.get_unique_id().to_utf8_buffer()) # Simple key generation
	#return secret
	#
#func _ready():
	#db = SQLite.new()
	#db.path = "user://game_data.db"
	#if db.open_db():
		#print("Database connected")
		#create_tables()
	#else:
		#print("Failed to connect to database")
#
#func create_tables():
	#db.query("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT, salt TEXT, totp_secret TEXT)")
	#db.query("CREATE TABLE IF NOT EXISTS stats (user_id INTEGER, score INTEGER, level INTEGER, FOREIGN KEY(user_id) REFERENCES users(id))")

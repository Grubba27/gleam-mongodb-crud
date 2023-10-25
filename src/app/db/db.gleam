import gleam/erlang/os
import gleam/io
import mungo

pub fn get_db() {
  let assert Ok(uri) = os.get_env("MONGO_URI")
  io.println("Connecting to:")
  io.println(uri)
  let assert Ok(db) = mungo.connect(uri)
  db
}

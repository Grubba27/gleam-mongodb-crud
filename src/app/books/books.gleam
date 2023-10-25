import bison/bson
import app/db/db
import mungo

fn books_collection() {
  db.get_db()
  |> mungo.collection("books")
}

pub fn get_books_count() {
  books_collection()
  |> mungo.count_all()
}

pub fn get_book_by_id(id) {
  books_collection()
  |> mungo.find_by_id(id)
}

pub fn insert_book(title: String, body: String, author: String) {
  books_collection()
  |> mungo.insert_one([
    #("title", bson.Str(title)),
    #("body", bson.Str(body)),
    #("author", bson.Str(author)),
  ])
}

pub fn delete_book_by_id(id: String) {
  books_collection()
  |> mungo.delete_one([#("_id", bson.Str(id))])
}

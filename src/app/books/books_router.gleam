import wisp.{Request, Response}
import gleam/dynamic.{Dynamic}
import gleam/json
import gleam/option
import app/books/books

pub type Book {
  Book(title: String, body: String, author: String)
}

fn decode_book(json: Dynamic) -> Result(Book, dynamic.DecodeErrors) {
  let decoder =
    dynamic.decode3(
      Book,
      dynamic.field("title", dynamic.string),
      dynamic.field("body", dynamic.string),
      dynamic.field("author", dynamic.string),
    )
  decoder(json)
}

pub fn index(_req: Request) -> Response {
  let assert Ok(book_count) = books.get_books_count()
  json.object([#("count", json.int(book_count))])
  |> json.to_string_builder
  |> wisp.json_response(200)
}

pub fn create(req: Request) -> Response {
  use json <- wisp.require_json(req)
  let assert Ok(book) = decode_book(json)
  let assert Ok(_id) = books.insert_book(book.title, book.body, book.author)

  json.object([#("created", json.bool(True))])
  |> json.to_string_builder
  |> wisp.json_response(200)
}

pub fn show(_req: Request, id: String) -> Response {
  let assert Ok(book) = books.get_book_by_id(id)
  case option.is_some(book) {
    True -> {
      let assert Ok(book_obj) = option.to_result(book, "Book not found")
      todo
    }

    False -> {
      json.object([#("not_found", json.bool(True))])
      |> json.to_string_builder
      |> wisp.json_response(404)
    }
  }
}

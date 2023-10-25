import wisp.{Request, Response}
import gleam/string_builder
import gleam/json

pub fn index(_req: Request) -> Response {
  let body = string_builder.from_string("<h1>Hello, books!</h1>")
  wisp.ok()
  |> wisp.html_body(body)
}

pub fn create(_req: Request) -> Response {
  json.object([
    #("title", json.string("Hello, Joe!")),
    #("body", json.string("This is a test post.")),
    #("_id", json.string("1234567890")),
    #("author", json.string("Joe Armstrong")),
  ])
  |> json.to_string_builder
  |> wisp.json_response(200)
}

pub fn show(_req: Request, id: String) -> Response {
  json.object([
    #("title", json.string("Hello, Joe!")),
    #("body", json.string("This is a test post.")),
    #("_id", json.string(id)),
    #("author", json.string("Joe Armstrong")),
  ])
  |> json.to_string_builder
  |> wisp.json_response(200)
}
pub fn update(_req: Request, id: String) -> Response {
  json.object([
    #("title", json.string("Hello, Joe!")),
    #("body", json.string("This is a test post.")),
    #("_id", json.string(id)),
    #("author", json.string("Joe Armstrong")),
  ])
  |> json.to_string_builder
  |> wisp.json_response(200)
}

pub fn delete(_req: Request, id: String) -> Response {
  json.object([
    #("title", json.string("Hello, Joe!")),
    #("body", json.string("This is a test post.")),
    #("_id", json.string(id)),
    #("author", json.string("Joe Armstrong")),
  ])
  |> json.to_string_builder
  |> wisp.json_response(200)
}

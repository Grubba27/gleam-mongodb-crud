import wisp.{Request, Response}
import gleam/string_builder
import gleam/http.{Delete, Get, Post}
import app/config
import app/books/books_router

/// The HTTP request handler- your application!
///
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use _req <- config.middleware(req)

  // Later we'll use templates, but for now a string will do.
  case wisp.path_segments(req) {
    // This matches the root path.
    [] -> root(req)
    ["books"] -> {
      // This matches paths like /books/
      case req.method {
        Get -> books_router.index(req)
        Post -> books_router.create(req)
        _ -> wisp.method_not_allowed(allowed: [Get, Post])
      }
    }
    ["books", id] -> {
      // This matches paths like /books/:id
      case req.method {
        Get -> books_router.show(req, id)
        _ -> wisp.method_not_allowed(allowed: [Get])
      }
    }
    // This matches all other paths.
    _ -> wisp.not_found()
  }
}

fn root(req: Request) -> Response {
  use <- wisp.require_method(req, Get)
  let body = string_builder.from_string("<h1>Hello, Joe!</h1>")
  wisp.ok()
  |> wisp.html_body(body)
}

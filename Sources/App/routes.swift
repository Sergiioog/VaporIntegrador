import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TodoController())

    app.get("proyectos") { req in
        PublicarProyecto.query(on: req.db).all()
    }

    // Ruta para crear un nuevo proyecto
    app.post("proyectos") { req -> EventLoopFuture<PublicarProyecto> in
        let proyecto = try req.content.decode(PublicarProyecto.self)
        return proyecto.save(on: req.db).map { proyecto }
    }
}

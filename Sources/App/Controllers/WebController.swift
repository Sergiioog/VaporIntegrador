import Fluent
import Vapor

struct WebController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        routes.get(use: loginWeb)
        routes.get("proyectos",":id", use: mostrarVehiculo)
        routes.get("crearProyecto", use: crearProyecto)
        routes.post("crearProyecto", use: dataProyecto)
    }

    func loginWeb(req: Request) async throws -> View {

        let proyectos = try await PublicarProyecto
            .query(on: req.db)
            .all()

        return try await req.leaf.render("index", Home(title: "Tabla vehiculos", proyectos: proyectos))
    }

    func mostrarVehiculo(req: Request) async throws -> View {
        let id = req.parameters.get("id", as: Int.self)
        guard let miProyecto = try await PublicarProyecto.find(id, on: req.db) else{
            throw Abort(.notFound, reason: "No existe el vehiculo")
        }
        return try await req.leaf.render("proyectos", ProyectoWeb(title: "Crear Proyecto",proyecto: miProyecto))
    }

    func crearProyecto(req: Request) async throws-> View {
        return try await req.leaf.render("crearProyecto")
    }

    func dataProyecto(req: Request) async throws-> View {
        
        let miProyecto = try req.content.decode(PublicarProyecto.self)
        print(miProyecto)
        
        try await miProyecto.create(on: req.db)

        let proyectos = try await PublicarProyecto
             .query(on: req.db)
             .all()
        return try await req.leaf.render("index", Home(title: "Index", proyectos: proyectos))

    }

    
}


struct Home: Encodable {
    let title: String
    let proyectos: [PublicarProyecto]
}

struct ProyectoWeb: Codable {
    let title: String
    let proyecto: PublicarProyecto
}

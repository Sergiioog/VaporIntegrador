import Fluent
import Vapor

struct ProyectoController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")

        api.get("getProyectos", use: getProyectos)
        api.post("postProyecto", use: postProyecto)
        api.delete("deleteProyecto", ":id" , use: deleteProyecto)
        api.put("putProyecto", ":id" , use: putProyecto)

    }
    
    func getProyectos(req: Request) async throws-> [PublicarProyecto] {

        return try await PublicarProyecto
            .query(on: req.db)
            .all()
    }

    func postProyecto(req: Request) async throws-> HTTPStatus{
        let miProyecto = try req.content.decode(PublicarProyecto.self)

        try await miProyecto.create(on: req.db)

        return .created
    }

    func deleteProyecto(req: Request) async throws -> HTTPStatus {

        let id = req.parameters.get("id", as: Int.self)
        
        guard let miProyecto = try await PublicarProyecto.find(id, on: req.db) else{
            throw Abort(.notFound, reason: "No existe el vehiculo")
        }

        try await miProyecto.delete(on: req.db)

        return .ok
    }

    func putProyecto(req: Request) async throws -> PublicarProyecto {
        guard let proyectoID = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: "ID del proyecto no proporcionado")
        }

        guard let proyectoExistente = try await PublicarProyecto.find(proyectoID, on: req.db) else {
            throw Abort(.notFound, reason: "Proyecto no encontrado con el ID proporcionado")
        }

        let datosActualizados = try req.content.decode(PublicarProyecto.self)

        proyectoExistente.nombreProy = datosActualizados.nombreProy ?? proyectoExistente.nombreProy
        proyectoExistente.localizacion = datosActualizados.localizacion ?? proyectoExistente.localizacion
        proyectoExistente.nombreCreador = datosActualizados.nombreCreador ?? proyectoExistente.nombreCreador
        proyectoExistente.disposicion = datosActualizados.disposicion ?? proyectoExistente.disposicion
        proyectoExistente.numInscritos = datosActualizados.numInscritos ?? proyectoExistente.numInscritos
        proyectoExistente.estudios = datosActualizados.estudios ?? proyectoExistente.estudios
        proyectoExistente.cursoRecomendado = datosActualizados.cursoRecomendado ?? proyectoExistente.cursoRecomendado
        proyectoExistente.idiomas = datosActualizados.idiomas ?? proyectoExistente.idiomas
        proyectoExistente.certificaciones = datosActualizados.certificaciones ?? proyectoExistente.certificaciones
        proyectoExistente.descripcionProy = datosActualizados.descripcionProy ?? proyectoExistente.descripcionProy

        try await proyectoExistente.save(on: req.db)

        return proyectoExistente
    }

}

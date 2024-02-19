
import Fluent
import Vapor

func routes(_ app: Application) throws {
   
    try app.register(collection: ProyectoController())
    try app.register(collection: WebController())
    
}


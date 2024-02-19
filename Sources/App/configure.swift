import FluentMySQLDriver
import Leaf
import Vapor

public func configure(_ app: Application) throws {
    
    app.databases.use(.mysql(
        hostname: "113.30.149.27",  // Dirección IP del servidor de la base de datos
        port: 3306,                 // Puerto estándar de MySQL
        username: "usuario-remoto", // Usuario de la base de datos
        password: "1234",           // Contraseña de la base de datos
        database: "baseDatosProyecto", // Nombre de la base de datos
        tlsConfiguration: .forClient(certificateVerification: .none) // Ajustar según las necesidades de seguridad
    ), as: .mysql)


    app.views.use(.leaf)

    try routes(app)
}
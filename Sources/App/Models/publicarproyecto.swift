import Fluent
import Vapor

final class PublicarProyecto: Model, Content {
    static let schema = "publicar_proyecto"
    
   @ID(custom: "id_proy")
    var id: Int?
    
    @Field(key: "nombre_proy")
    var nombreProy: String?
    
    @Field(key: "localizacion")
    var localizacion: String?
    
    @Field(key: "nombre_creador")
    var nombreCreador: String?
    
    @Field(key: "disposicion")
    var disposicion: String?
    
    @Field(key: "num_inscritos")
    var numInscritos: Int?
    
    @Field(key: "estudios")
    var estudios: String?
    
    @Field(key: "curso_recomendado")
    var cursoRecomendado: String?
    
    @Field(key: "idiomas")
    var idiomas: String?
    
    @Field(key: "certificaciones")
    var certificaciones: String?
    
    @Field(key: "descripcion_proy")
    var descripcionProy: String?
    
    init() {}
    
    init(nombreProy: String, localizacion: String, nombreCreador: String, disposicion: String, numInscritos: Int, estudios: String, cursoRecomendado: String, idiomas: String, certificaciones: String, descripcionProy: String) {
    self.nombreProy = nombreProy
    self.localizacion = localizacion
    self.nombreCreador = nombreCreador
    self.disposicion = disposicion
    self.numInscritos = numInscritos
    self.estudios = estudios
    self.cursoRecomendado = cursoRecomendado
    self.idiomas = idiomas
    self.certificaciones = certificaciones
    self.descripcionProy = descripcionProy
}
}
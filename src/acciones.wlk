import colecciones.*

object actualizarObjetos {
	var objetos = []
	
	method actualizarImagen(codigo){
		objetos = coleccionObjetos.objetosFiltrados(codigo)
		objetos.forEach({ objeto => objeto.numeroImagen() })
	}
}

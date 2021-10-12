import colecciones.*
import wollok.game.*
import tony.*

object actualizarObjetos {
	var objetos = []
	
	method actualizarImagen(codigo){
		
		objetos = coleccionObjetos.objetosFiltrados(codigo)
		objetos.forEach({ objeto => objeto.numeroImagen() })
	}
	
	method actualizarCollide(codigo){
		objetos = coleccionObjetos.objetosFiltrados(codigo)
		objetos.forEach({ objeto => game.onCollideDo(tony, self.removeVisual(objeto)) })
	}
	
	method removeVisual(objeto){
		game.removeVisual(objeto)
		tony.addPoints(objeto.points())
		return 0
	}
	
	method actualizar(codigo){
		self.actualizarImagen(codigo)
		//self.actualizarCollide(codigo)
		tony.guardarMoneda()
	}
	
}

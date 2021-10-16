import wollok.game.*
import objetosParaImplementar.*
import tony.*

class Direccion {
	
	//para los objetos que se mueven solos, aca se podra configurar para que tambien cambie de imagen un Zombi
}

object arriba inherits Direccion {
	method mover(objeto){
		objeto.position(objeto.position().up(1))
	}
}

object abajo inherits Direccion {
	method mover(objeto){
		objeto.position(objeto.position().down(1))
	}
}

object derecha inherits Direccion {
	method mover(objeto){
		objeto.position(objeto.position().right(1))
	}
}

object izquierda inherits Direccion {
	method mover(objeto){
		objeto.position(objeto.position().left(1))
	}
}
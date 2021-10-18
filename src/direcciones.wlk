import wollok.game.*
import objetosParaImplementar.*
import tony.*

//para los objetos que se mueven solos, aca se podra configurar para que tambien cambie de imagen un Zombi
class Direccion {
	

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

object movimientos{
	
	method devuelveNum() = 0.randomUpTo(4).roundUp()	
		
	method movimientoColeccion(coleccion){
		const number = self.devuelveNum()
		if (number == 1){
			coleccion.forEach({z => arriba.mover(z)})
		}else if (number == 2){
			coleccion.forEach({z => abajo.mover(z)})
		}else if (number == 3){
			coleccion.forEach({z => derecha.mover(z)})
		}else if (number == 4){
			coleccion.forEach({z => izquierda.mover(z)})
		}
	}
	
	method movimientoObjeto(objeto){
		const number = self.devuelveNum()
		if (number == 1){
			arriba.mover(objeto)
		}else if (number == 2){
			arriba.mover(objeto)
		}else if (number == 3){
			arriba.mover(objeto)
		}else if (number == 4){
			arriba.mover(objeto)
		}
	}
}


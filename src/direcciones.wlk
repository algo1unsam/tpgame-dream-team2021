import wollok.game.*
import objetosParaImplementar.*
import tony.*

//para los objetos que se mueven solos, aca se podra configurar para que tambien cambie de imagen un Zombi


object movimientos{
	
	const der = ""
	const izq = ""
	const fren = ""
	const espal = ""
	
	method moverUp(objeto){
		objeto.position(objeto.position().up(1))
	}
	
	method moverDown(objeto){
		objeto.position(objeto.position().down(1))
	}
	
	method moverRight(objeto){
		objeto.position(objeto.position().right(1))
	}
	
	method moverLeft(objeto){
		objeto.position(objeto.position().left(1))
	}
	
	method movimiento(personaje){
		personaje.coordenadas().clear()
		var aux = []
		aux.addAll([personaje.position().x(), personaje.position().y()])
		personaje.coordenadas(aux)
	}
	
	
	method puntoX (personaje) = personaje.coordenadas().get(0)
	
	method puntoY (personaje) = personaje.coordenadas().get(1)
	
	
	//Metodos para mover al Zombi hasta Tony
	//fijarse en el objeto AtaqueZombi!! mas abajo
	method moverYorX (personaje) = (self.puntoY(personaje) - self.puntoY(tony)).abs() > (self.puntoX(personaje) - self.puntoX(personaje)).abs()	
		
	method moverY(personaje){
		if(self.puntoY(personaje) - self.puntoY(tony) > 0){
			self.moverDown(personaje)
			personaje.perfil("fren")
			self.movimiento(personaje)
		}else if (self.puntoY(personaje) - self.puntoY(tony) < 0){
			self.moverUp(personaje)
			personaje.perfil("espal")
			self.movimiento(personaje)
		}
		
	}
	
	method moverX(personaje){
		if(self.puntoX(personaje) - self.puntoX(tony) > 0){
			self.moverLeft(personaje)
			//100.times({i => self.perfil("izq_0")})
			personaje.perfil("izq_1")
			self.movimiento(personaje)
		}else if (self.puntoX(personaje) - self.puntoX(tony) < 0){
			self.moverRight(personaje)
			//100.times({i => self.perfil("der_0")}) 
			personaje.perfil("der_1")
			self.movimiento(personaje)
		}
	}
	
	
	
	method moverArriba(personaje){
		self.moverUp(personaje)
		personaje.perfil("espal")
		self.movimiento(personaje)
	}
	
	method moverAbajo(personaje){
		self.moverDown(personaje)
		personaje.perfil("fren")
		self.movimiento(personaje)
	}
	
	method moverDerecha(personaje){
		self.moverRight(personaje)
		//100.times({i => self.perfil("der_0")}) 
		personaje.perfil("der")
		self.movimiento(personaje)
	}
	
	method moverIzquierda(personaje){
		self.moverLeft(self)
		//100.times({i => self.perfil("izq_0")})
		personaje.perfil("izq")
		self.movimiento(personaje)
	}
	//metodo para mover a los zombis con un numero aleatorio.
	method moverZombi(number,personaje){
		if (number == 1 and self.puntoY(personaje) < 9){
			self.moverArriba(personaje)
		}else if (number == 2 and self.puntoY(personaje) > 0){
			self.moverAbajo(personaje)
		}else if (number == 3 and self.puntoX(personaje) < 9){
			self.moverDerecha(personaje)
		}else if (number == 4 and self.puntoX(personaje) > 0){
			self.moverIzquierda(personaje)
		}
	}
	
	method devuelveNum() = 0.randomUpTo(4).roundUp()	
		
	method movimientoColeccion(coleccion){
		const number = self.devuelveNum()
		if (number == 1){
			coleccion.forEach({z => self.moverUp(z)})
		}else if (number == 2){
			coleccion.forEach({z => self.moverDown(z)})
		}else if (number == 3){
			coleccion.forEach({z => self.moverRight(z)})
		}else if (number == 4){
			coleccion.forEach({z => self.moverLeft(z)})
		}
	}
	
	method movimientoObjeto(objeto){
		const number = self.devuelveNum()
		if (number == 1){
			self.moverUp(objeto)
		}else if (number == 2){
			self.moverDown(objeto)
		}else if (number == 3){
			self.moverRight(objeto)
		}else if (number == 4){
			self.moverLeft(objeto)
		}
	}
}


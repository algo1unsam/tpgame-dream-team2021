import wollok.game.*
import objetosParaImplementar.*
import tony.*
import escenario.*

//para los objetos que se mueven solos, aca se podra configurar para que tambien cambie de imagen un Zombi

class MovimientosAbstractos{
	const der = ""
	const izq = ""
	const fren = ""
	const espal = ""
	
	method moverUp(objeto,number){
		objeto.position(objeto.position().up(number))
	}
	
	method moverDown(objeto,number){
		objeto.position(objeto.position().down(number))
	}
	
	method moverRight(objeto,number){
		objeto.position(objeto.position().right(number))
	}
	
	method moverLeft(objeto,number){
		objeto.position(objeto.position().left(number))
	}
	
	method puedoMoverArriba(objeto,escenarioActual)
	
	method puedoMoverAbajo(objeto,escenarioActual)
	
	method puedoMoverDerecha(objeto,escenarioActual)
	
	method puedoMoverIzquierda(objeto,escenarioActual)		
	
	method puntoX (personaje) = personaje.position().x()
	
	method puntoY (personaje) = personaje.position().y()
	
	
	//Metodos para mover al Zombi hasta Tony
	//fijarse en el objeto AtaqueZombi!! mas abajo
	method moverYorX (personaje) = (self.puntoY(personaje) - self.puntoY(tony)).abs() > (self.puntoX(personaje) - self.puntoX(personaje)).abs()	
		
	method moverY(personaje){
		if(self.puntoY(personaje) - self.puntoY(tony) > 0){
			self.puedoMoverAbajo(personaje,escenario.nivel())
			personaje.perfil("fren")
			//self.movimiento(personaje)
		}else if (self.puntoY(personaje) - self.puntoY(tony) < 0){
			self.puedoMoverArriba(personaje,escenario.nivel())
			personaje.perfil("espal")
			//self.movimiento(personaje)
		}
		
	}
	
	method moverX(personaje){
		if(self.puntoX(personaje) - self.puntoX(tony) > 0){
			self.puedoMoverIzquierda(personaje,escenario.nivel())
			//100.times({i => self.perfil("izq_0")})
			personaje.perfil("izq_1")
			
		}else if (self.puntoX(personaje) - self.puntoX(tony) < 0){
			self.puedoMoverDerecha(personaje,escenario.nivel())
			//100.times({i => self.perfil("der_0")}) 
			personaje.perfil("der_1")
			
		}
	}
	
	
	
	method moverArriba(personaje){
		self.moverUp(personaje,1)
		personaje.perfil("espal")
	}
	
	method moverAbajo(personaje){
		self.moverDown(personaje,1)
		personaje.perfil("fren")
	}
	
	method moverDerecha(personaje){
		self.moverRight(personaje,1)
		//100.times({i => self.perfil("der_0")}) 
		personaje.perfil("der")
	}
	
	method moverIzquierda(personaje){
		self.moverLeft(self,1)
		//100.times({i => self.perfil("izq_0")})
		personaje.perfil("izq")
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
	
	method devuelveNum(min,max) = min.randomUpTo(max).roundUp()	
	
	method devuelveNumEntre(min,max){
		var num = (min-1).randomUpTo(max).roundUp()
		if (num == min or num ==max) {
			return num
		}else{
			return self.devuelveNumEntre(min,max)
		}
	}
		
		
	method positivoNegativo() = if(self.devuelveNum(0,4) >= 3) self.devuelveNum(0,4) * -1 else self.devuelveNum(0,4)
		
	method movimientoColeccion(coleccion){
		const number = self.devuelveNum(0,4)
		if (number == 1){
			coleccion.forEach({z => self.moverUp(z,1)})
		}else if (number == 2){
			coleccion.forEach({z => self.moverDown(z,1)})
		}else if (number == 3){
			coleccion.forEach({z => self.moverRight(z,1)})
		}else if (number == 4){
			coleccion.forEach({z => self.moverLeft(z,1)})
		}
	}
	
	method movimientoObjeto(objeto){
		const number = self.devuelveNum(0,4)
		if (number == 1){
			self.moverUp(objeto,1)
		}else if (number == 2){
			self.moverDown(objeto,1)
		}else if (number == 3){
			self.moverRight(objeto,1)
		}else if (number == 4){
			self.moverLeft(objeto,1)
		}
	}
}



object movimientos inherits MovimientosAbstractos{
	override method puedoMoverArriba(objeto,escenarioActual){
		const destino = objeto.position().up(1)
		if( escenarioActual.noPasar().contains(destino) or objeto.position().y()> 9){
			
		}else{
			self.moverUp(objeto,1)
		}
	}
	
	override method puedoMoverAbajo(objeto,escenarioActual){
		const destino = objeto.position().down(1)
		if(escenarioActual.noPasar().contains(destino) or objeto.position().y()<0){
			
		}else{
			self.moverDown(objeto,1)
		}
	}
	
	override method puedoMoverDerecha(objeto,escenarioActual){
		const destino = objeto.position().right(1)
		if(escenarioActual.noPasar().contains(destino) or objeto.position().x() > 9){
			
		}else{
			self.moverRight(objeto,1)
		}
	}
	
	override method puedoMoverIzquierda(objeto,escenarioActual){
		const destino = objeto.position().left(1)
		if(escenarioActual.noPasar().contains(destino)  or objeto.position().x() <= 0){
			
		}else{
			self.moverLeft(objeto,1)
		}
	}
	
}

object movimientosTony inherits MovimientosAbstractos{
	override method puedoMoverArriba(objeto,escenarioActual){
		const destino = objeto.position().up(1)
		if( escenarioActual.noPasar().contains(destino) or objeto.position().y()> 9){
			
		}else{
			self.moverUp(objeto,1)
		}
	}
	
	override method puedoMoverAbajo(objeto,escenarioActual){
		const destino = objeto.position().down(1)
		if(escenarioActual.noPasar().contains(destino) or objeto.position().y()<0){
			
		}else{
			self.moverDown(objeto,1)
		}
	}
	
	override method puedoMoverDerecha(objeto,escenarioActual){
		const destino = objeto.position().right(1)
		if(escenarioActual.noPasar().contains(destino) or objeto.position().x() > 9){
			
		}else{
			self.moverRight(objeto,1)
		}
	}
	 
	 
	override method puedoMoverIzquierda(objeto,escenarioActual){
		const destino = objeto.position().left(1)
		if(escenarioActual.noPasar().contains(destino)  or objeto.position().x() <= 0){
			
		}else{
			self.moverLeft(objeto,1)
		}
	}
}

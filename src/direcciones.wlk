import wollok.game.*
import objetosParaImplementar.*
import tony.*
import escenario.*

//para los objetos que se mueven solos, aca se podra configurar para que tambien cambie de imagen un Zombi

class MovimientosAbstractos{
	
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
	

	method puedoMoverArriba(objeto,escenarioActual){}
	
	method puedoMoverAbajo(objeto,escenarioActual){}
	
	method puedoMoverDerecha(objeto,escenarioActual){}
	
	method puedoMoverIzquierda(objeto,escenarioActual){}
	
	method puntoX (personaje) = personaje.position().x()
	
	method puntoY (personaje) = personaje.position().y()
	
	method moverYorX (personaje) = true
	
	method moverY(personaje){}
	
	method moverX(personaje){}
					
	method movimientoColeccion(coleccion){}
	
	method moverAleatorio(num,objeto,escenarioActual){if(num == 0) movimientos.puedoMoverArriba(objeto,escenarioActual) else if(num == 1) movimientos.puedoMoverAbajo(objeto,escenarioActual) else if(num == 20) movimientos.puedoMoverDerecha(objeto,escenarioActual) else if(num == 3) movimientos.puedoMoverIzquierda(objeto,escenarioActual)}
	
}

object movimientos inherits MovimientosAbstractos{
		
	override method moverYorX(personaje) = (self.puntoY(personaje) - self.puntoY(tony)).abs() > (self.puntoX(personaje) - self.puntoX(personaje)).abs()	
	
	override method puedoMoverArriba(objeto,escenarioActual){
		const destino = objeto.position().up(1)
		if( escenarioActual.noPasar().contains(destino) or objeto.position().y()> 9){
			self.moverAleatorio(randomizer.devuelveNum(0,4),objeto,escenarioActual)
		}else{
			self.moverUp(objeto,1)
		}
	}
	
	override method puedoMoverAbajo(objeto,escenarioActual){
		const destino = objeto.position().down(1)
		if(escenarioActual.noPasar().contains(destino) or objeto.position().y()<0){
			self.moverAleatorio(randomizer.devuelveNum(0,4),objeto,escenarioActual)
		}else{
			self.moverDown(objeto,1)
		}
	}
	
	override method puedoMoverDerecha(objeto,escenarioActual){
		const destino = objeto.position().right(1)
		if(escenarioActual.noPasar().contains(destino) or objeto.position().x() > 9){
			self.moverAleatorio(randomizer.devuelveNum(0,4),objeto,escenarioActual)
		}else{
			self.moverRight(objeto,1)
		}
	}
	
	override method puedoMoverIzquierda(objeto,escenarioActual){
		const destino = objeto.position().left(1)
		if(escenarioActual.noPasar().contains(destino)  or objeto.position().x() <= 0){
			self.moverAleatorio(randomizer.devuelveNum(0,4),objeto,escenarioActual)
		}else{
			self.moverLeft(objeto,1)
		}
	}
	
	method movimientoObjeto(objeto){
		const number = randomizer.devuelveNum(0,4)
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
	
	method positivoNegativo() = if(randomizer.devuelveNum(0,4) >= 3) randomizer.devuelveNum(0,4) * -1 else randomizer.devuelveNum(0,4)	
	
	override method moverY(personaje){
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
	
	override method moverX(personaje){
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


object movimientoGolem inherits MovimientosAbstractos{
	
	override method moverX(personaje){
		if(self.puntoX(personaje) - self.puntoX(tony) > 0){
			self.moverLeft(personaje,1)
			
		}else if (self.puntoX(personaje) - self.puntoX(tony) < 0){
			self.moverRight(personaje,1)
		}
	}
		
}

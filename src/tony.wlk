import wollok.game.*
import elementos.*
import objetosParaImplementar.*
import enemigos.*
import direcciones.*
import escenario.*

object tony {
	var property position = game.center()
	var property perfil = "fren"
	var property image = self.perfil()
	var property salud = 13
	var vidas = 3
	var property points = 0
	 
	method image() = "tony_" + self.perfil() +".png"
	 
 	method puntoX () = self.position().x()
	
	method puntoY () = self.position().y()
 
 	method coordenadas() = [self.position().x(), self.position().y()]
 
 	method moverArriba(){
 		movimientosTony.puedoMoverArriba(self,escenario.nivel()) 
 		self.perfil("es")				 
 	}
 	
 	method moverAbajo(){
 		movimientosTony.puedoMoverAbajo(self,escenario.nivel())
 		self.perfil("fren")
 	}
 	
 	method moverDerecha(){
 		movimientosTony.puedoMoverDerecha(self,escenario.nivel())
 		self.perfil("der")
 	} 
 	
 	method moverIzquierda(){
 		movimientosTony.puedoMoverIzquierda(self,escenario.nivel())
 		self.perfil("izq")
 	}
 
 	method atacar(danio){
 		const objetosDebajo = game.colliders(self)
 		objetosDebajo.forEach({ objeto =>  objeto.recibirDanio(danio) })
 	}
 
	//method aumentarPoder(){
	//	poder += pociones.sum({ pocion => pocion.mana() })
	//}
	
	method restarSalud(menosSalud){
		if (salud - menosSalud > 0){
			salud -= menosSalud
		//game.say(tony,"Me ataco un Zombi, mi salud es :" + salud)			
		} else {
			self.restaVida()
		}
	}
	
	method recuperaSalud(masSalud){
		if (salud + masSalud <= 13){
			salud += masSalud
		}else {
			salud = 13
		}
	}
	
	
	method restaVida(){
		if(self.sigueConVida()){
			coleccionVidas.removerVida()
			vidas -= 1
			salud = 13						
		}else{
			escenario.morirTony()
		}
	}
	
	method sigueConVida() = vidas > 0
		
	method addPoints(addPoint){
		points += addPoint	
	}
	
	method points() = points
	
	
}
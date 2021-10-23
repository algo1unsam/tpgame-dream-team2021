import wollok.game.*
import elementos.*
import objetosParaImplementar.*
import enemigos.*
import direcciones.*

object tony {
	var property codigo = 0
	var property position = game.center()
	var property perfil = "tony_fren.png"
	var property image = self.perfil()
	var property salud = 13
	var vidas = 3
	var pociones = []
	var armadura = []
	var poder = 0
	var points = 0
	 
 	method puntoX () = self.position().x()
	
	method puntoY () = self.position().y()
 
 	method coordenadas() = [self.position().x(), self.position().y()]
 
 	method moverArriba(){
 		movimientos.moverUp(self) 
 		self.perfil("tony_fren.png")				 
 	}
 	
 	method moverAbajo(){
 		movimientos.moverDown(self)
 		self.perfil("tony_es.png")
 	}
 	
 	method moverDerecha(){
 		movimientos.moverRight(self)
 		self.perfil("tony_der.png")
 	} 
 	
 	method moverIzquierda(){
 		movimientos.moverLeft(self)
 		self.perfil("tony_izq.png")
 	}
 
 	method atacar(danio){
 		const objetosDebajo = game.colliders(self)
 		objetosDebajo.forEach({ objeto =>  objeto.recibirDanio(danio) })
 	}
 
	method aumentarPoder(){
		poder += pociones.sum({ pocion => pocion.mana() })
	}
	
	method restarSalud(menosSalud){
		if (salud - menosSalud > 0){
			salud -= menosSalud
		//game.say(tony,"Me ataco un Zombi, mi salud es :" + salud)
		self.estadoSalud()
		} else {
			salud = 0
		}
	}
	
	method recuperaSalud(masSalud){
		if (salud + masSalud <= 13){
			salud += masSalud
		}else {
			salud = 13
		}
	}
	
	method estadoSalud(){
		if (salud <= 0){
			self.restaVida()
			if (self.sigueConVida()){
				salud = 13
			}
			else{
				game.say(self,"Me he quedado sin vidas")
			}
		}
	}
	
	
	method restaVida(){
		vidas -= 1
	}
	
	method sigueConVida() = vidas > 0
	
	method poder(){
		game.say(self,"He Aumentado mi poder a :" + poder)
	}
	
	method addPoints(addPoint){
		points += addPoint	
	}
	
	method points() = points
	
	//method objetosDebajo(codigoTony){
	//	var objetosDebajo = game.colliders(self)
	//	return coleccionObjetos.filtrarObjetosPorCodigo(codigoTony,objetosDebajo) 
	//}
	
	//method guardarMoneda(){
	//	const monedasDebajo = self.objetosDebajo(1)
	//	
	//	if(!monedasDebajo.isEmpty()){
	//		monedasDebajo.forEach({ moneda => self.addPoints(moneda.points())
	//								game.removeVisual(moneda) })
	//		}			
	//	}
	
	//method entrarCueva()
	
}
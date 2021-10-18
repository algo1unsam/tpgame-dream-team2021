import wollok.game.*
import elementos.*
import objetosParaImplementar.*

object tony {
	var property codigo = 0
	var property position = game.center()
	const property image = "zombi_fren.png"
	var salud = 100
	var vidas = 3
	var pociones = []
	var armadura = []
	var poder = 0
	var points = 0
	 
 	method puntoX () = self.position().x()
	
	method puntoY () = self.position().y()
 
 
 	method atacar(danio){
 		const objetosDebajo = game.colliders(self)
 		objetosDebajo.forEach({ objeto =>  objeto.recibirDanio(danio) })
 	}
 
	method aumentarPoder(){
		poder += pociones.sum({ pocion => pocion.mana() })
	}
	
	method restarSalud(menosSalud){
		salud -= menosSalud
		game.say(tony,"Me ataco un Zombi, mi salud es :" + salud)
		self.estadoSalud()
	}
	
	method estadoSalud(){
		if (salud <= 0){
			self.restaVida()
			if (self.sigueConVida()){
				salud = 100
			}
			else{
				game.say(tony,"Me he quedado sin vidas")
			}
		}
	}
	
	method restaVida(){
		vidas -= 1
	}
	
	method sigueConVida() = vidas > 0
	
	method poder(){
		game.say(tony,"He Aumentado mi poder a :" + poder)
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
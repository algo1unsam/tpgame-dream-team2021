import wollok.game.*
import elementos.*
import objetosParaImplementar.*
import colecciones.*

object tony {
	var property codigo = 0
	var property position = game.center()
	const property image = "zombi_fren.png"
	var pociones = []
	var armadura = []
	var poder = 0
	var points = 0
 
	method aumentarPoder(){
		poder += pociones.sum({ pocion => pocion.mana() })
	}
	
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
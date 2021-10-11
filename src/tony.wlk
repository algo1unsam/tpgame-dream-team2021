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
 
	method aumentarPoder(){
		poder += pociones.sum({ pocion => pocion.mana() })
	}
	
	method poder(){
		game.say(tony,"He Aumentado mi poder a :" + poder)
	}
	
	method guardarPocion(){
		const pocionesDebajo = game.colliders(self)
		
		//valido que existe alguna
		if(pocionesDebajo.isEmpty()){
			self.error("No hay pociones aquí")
		}
		else{
			pocionesDebajo.forEach({
									pocion => pociones.add(pocion)
											  game.removeVisual(pocion)
			})
			game.say(self,"Poción común")
			
		}
	}
	
}
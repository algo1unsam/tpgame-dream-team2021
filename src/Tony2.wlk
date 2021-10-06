import wollok.game.*
import elementos.*

object tony {
	var property position = game.center()
	const property image = "pepita.png"
	var pociones = []
	var armadura = []
	var poder = 0
	
	method aumentarPoder(){
		poder += pociones.sum({ pocion => pocion.mana() })
	}
	
	method guardarPocion(){
		const pocionesDebajo = [new Pocion()] //game.colliders(self)
		
		//valido que existe alguna
		if (pocionesDebajo.notEmpty()){
			pociones.add(pocionesDebajo)
		}
		else{
			self.error("No hay pociones aquí")
		}
	}
	
}

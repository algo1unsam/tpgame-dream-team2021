import wollok.game.*
import cultivos.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	var cultivos_cosechados = []
	var dinero = 0
	
	//le paso un sembrarMaiz, en la posicion que tiene
	//y va cambiando
	method sembrarMaiz(){
		game.addVisual(new Maiz(position = position))
	}
	
	method sembrarTrigo(){
		game.addVisual(new Trigo(position = position))
	}
	
	method sembrarTomaco(){
		game.addVisual(new Tomaco(position = position))
	}
	
	method regarCultivosDebajo(){
		const cultivosDebajo = self.cultivosDebajo()
		cultivosDebajo.forEach({ cultivo => cultivo.regar() })
	}
	
	method cultivosDebajo(){
		const cultivosDebajo = game.colliders(self)
		
		//valido que existe alguno
		
		if (cultivosDebajo.isEmpty()){
			self.error("No hay cultivos acá!")
		}
		return cultivosDebajo
	}
	
	method cosechar(){
		//veo los cultivos que hay debajo
		const cultivosDebajo = self.cultivosDebajo()
		//recorro cada cultivo, guardandolo si se cosechó
		//y removiendolo del juego
		cultivosDebajo.forEach({ cultivo => 
			
			if(cultivo.esAdulta() == true){
				cultivos_cosechados.add(cultivo)
				game.removeVisual(cultivo)}
			else{
				
				self.error("No está listo para cosechar!")
			}
		})
	}
	
	method vender(){
		dinero += cultivos_cosechados.sum({ cultivo => cultivo.valor() })
		cultivos_cosechados = []
		game.say(self,"Dinero generado: " + dinero)
	}
	
	method finanzas(){
		game.say(self, "tengo " + dinero + " monedas, " + "y " + cultivos_cosechados.size() + " cultivos" )
	}
}
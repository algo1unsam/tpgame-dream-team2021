import wollok.game.*
import objetosParaImplementar.*
import tony.*

class Objetos{
	
	method chocasteCon(personaje){
		
	}
}

class Pocion inherits Objetos{

	var property mana = 100
	const property position = game.at(1,1)
	method image() = "pocion2no-bg.png"
}

class PocionVeneno inherits Pocion{

	
}

class Zombi inherits Objetos{

	var vida = 100
	const property position = randomizer.emptyPosition()
	method image() = "zombi_fren.png"
}

class Coin inherits Objetos{

	const property points = 10
	const property position = randomizer.emptyPosition()
	const property coin = true
	var numero = 0
	
	override method chocasteCon(personaje){
		personaje.addPoints(self.points())
		monedero.removerMoneda(self)
	}
	
	method image() { 
		// TODO: hacer que devuelva la imagen que corresponde
		return "moneda_" + numero + ".png"
	}
	
	
	method numeroImagen(){
		if(numero < 3){
			numero += 1
		}
		
		else{
			numero = 0
		}
		return numero
	}
}

object cueva inherits Objetos{

	var property image = "entrada_cueva.png"
	const property position = game.at(8,9)
	
	override method chocasteCon(personaje){
		if(personaje.points() > 50){
			escenario.removerVisualEscenario()
			escenario.escenarioDos()
		}
		else{
			game.say(tony,"Todavía no tengo suficientes monedas")
		}
	}
	
}

object monedero{
	var monedas = []
	
	method generarMoneda(maxMonedas){
		if (monedas.size() <= maxMonedas){
		const monedaNueva = new Coin(position = randomizer.emptyPosition())
		game.addVisual(monedaNueva)
		monedas.add(monedaNueva)
		}
	}
	
	method girarMonedas() = monedas.forEach({ objeto => objeto.numeroImagen() })
	
	method removerMoneda(moneda){
		monedas.remove(moneda)
		game.removeVisual(moneda) 
	}
}

object escenario{
	
	method configuracionEscenario(){
		//Configuracion del escenario, colliders, visuales, y teclas
		
		//visual algunos
		game.addVisualCharacter(tony)
		game.height(10)
		game.width(10)
		
		
		//Juego Corriendo cosas
		game.onTick(6000, "agregaMonedas", { => monedero.generarMoneda(5)  })
		game.onTick(200,"actualiza imagen objetos", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
		keyboard.a().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		
		//Teclado	
		keyboard.a().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
	}
	
	method escenarioUno(){
		//configuracion del escenario 1
		game.ground("pasto50x50.jpg")
	 	game.addVisual(cueva)
		//4.times({ i => (game.addVisual(new Pocion(position = randomizer.emptyPosition()) ) ) })
		self.configuracionEscenario()
	}
	
	method escenarioDos(){
		//configuracion del escenario 2
		
		//no se logra modificar el fondo al cambiar de escenario
		game.ground("piedra50x50.png")
		self.configuracionEscenario()
	}
	
	method removerVisualEscenario(){
		//remover todos los visuales del escenario
		game.clear()
	}
}
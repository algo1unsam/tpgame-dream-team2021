import elementos.*
import tony.*
import wollok.game.*
import objetosParaImplementar.*
import enemigos.*


object escenario{
	
	method configuracionEscenario(){
		//Configuracion del escenario, colliders, visuales, y teclas
		
		//visual algunos
		game.addVisualCharacter(tony)		
		game.height(10)
		game.width(10)
		
		
		//Juego Corriendo cosas
		game.addVisual(barraDeVida)
		game.onTick(15000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		
		//Pociones
		pociones.pocionesCurativas(randomizer.emptyPosition())
		pociones.pocionesCurativas(randomizer.emptyPosition())
		pociones.pocionesVeneno(randomizer.emptyPosition())
		
		//quedo deprecado dado que ahora los zombis dan monedas
		//game.onTick(6000, "agregaMonedas", { => monedero.generarMoneda(5)  })
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })		
		game.onTick(200,"actualiza imagen objetos", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
		keyboard.a().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		//keyboard.s().onPressDo {game.say(tony, "position: " + tony.position().x())} //para probar el metodo .position()
		
		//Teclado
		keyboard.x().onPressDo { tony.atacar(101) }	
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

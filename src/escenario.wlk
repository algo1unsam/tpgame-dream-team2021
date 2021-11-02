import elementos.*
import tony.*
import wollok.game.*
import objetosParaImplementar.*
import enemigos.*


object escenario{
	
	var property arboleda = [new Arbol(position = game.at(0,9)),new Arbol(position = game.at(1,9)),
							new Arbol(position = game.at(2,9)),new Arbol(position = game.at(4,9)),
							new Arbol(position = game.at(5,9)),new Arbol(position = game.at(7,9)),
							new Arbol(position = game.at(8,9)),new Arbol(position = game.at(9,9)),
							new Arbol(position = game.at(-1,8)),new Arbol(position = game.at(9,8)),
							new Arbol(position = game.at(-1,5)),new Arbol(position = game.at(9,7)),
							new Arbol(position = game.at(-1,4)),new Arbol(position = game.at(9,6)),
							new Arbol(position = game.at(-1,3)),new Arbol(position = game.at(9,5)),
							new Arbol(position = game.at(-1,2)),new Arbol(position = game.at(9,4)),
							new Arbol(position = game.at(-1,1)),new Arbol(position = game.at(9,3)),
							new Arbol(position = game.at(9,2)),new Arbol(position = game.at(9,1)),
							new Arbol(position = game.at(-1,0)),new Arbol(position = game.at(9,0)),
							new Arbol(position = game.at(-1,9))
	]
	var property noPasar = #{game.at(0,9),game.at(1,9),game.at(2,9),game.at(4,9),game.at(5,9),
							game.at(7,9),game.at(8,9),game.at(9,9),game.at(-1,9),game.at(-1,8),
							game.at(-1,6),game.at(-1,5),game.at(-1,4),game.at(-1,3),game.at(-1,2),
							game.at(-1,1),game.at(-1,0),game.at(9,9),game.at(9,8),game.at(9,7),
							game.at(9,6),game.at(9,5),game.at(9,4),game.at(9,3),game.at(9,2),
							game.at(9,1),game.at(9,0),game.at(0,10),game.at(1,10),game.at(2,10),
							game.at(4,10),game.at(5,10),game.at(7,10),game.at(8,10),game.at(9,10),
							game.at(0,0),game.at(1,0),game.at(2,0),game.at(3,0),game.at(4,0),
							game.at(5,0),game.at(6,0),game.at(7,0),game.at(8,0),game.at(9,0)
	}
	
	method configuracionEscenario(){
		//Configuracion del escenario, colliders, visuales, y teclas
		tony.escenario(self)
		//visual algunos
		arboleda.forEach({a => a.visual()})
		game.addVisualCharacter(tony)		
		game.height(11)
		game.width(10)
		
		game.addVisual(tablon)
		
		//Juego Corriendo cosas
		game.addVisual(barraDeVida)
		game.addVisual(tonyVidas)
		game.onTick(15000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		
		
		
		//quedo deprecado dado que ahora los zombis dan monedas
		//game.onTick(6000, "agregaMonedas", { => monedero.generarMoneda(5)  })
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })		
		game.onTick(200,"actualiza imagen objetos", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})

		//keyboard.s().onPressDo {game.say(tony, "position: " + tony.position().x())} //para probar el metodo .position()
		
		//Teclado
		keyboard.x().onPressDo { tony.atacar(101) }	
		keyboard.p().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		keyboard.w().onPressDo {tony.moverArriba()}
		keyboard.s().onPressDo {tony.moverAbajo()}
		keyboard.d().onPressDo {tony.moverDerecha()}
		keyboard.a().onPressDo {tony.moverIzquierda()}
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

import elementos.*
import tony.*
import wollok.game.*
import objetosParaImplementar.*
import enemigos.*

object escenario{
	
	var property arboleda = [new Arbol(position = game.at(0,9)),new Arbol(position = game.at(1,9)),
							new Arbol(position = game.at(2,9)),new Arbol(position = game.at(4,9)),
							new Arbol(position = game.at(5,9)),new Arbol(position = game.at(7,9)),
							new Arbol(position = game.at(8,9)),
							new Arbol(position = game.at(-1,8)),
							new Arbol(position = game.at(-1,5)),
							new Arbol(position = game.at(-1,4)),
							new Arbol(position = game.at(-1,3)),new Arbol(position = game.at(9,5)),
							new Arbol(position = game.at(-1,2)),new Arbol(position = game.at(9,4)),
							new Arbol(position = game.at(-1,1)),new Arbol(position = game.at(9,3)),
							new Arbol(position = game.at(9,2)),new Arbol(position = game.at(9,1)),
							new Arbol(position = game.at(-1,0)),new Arbol(position = game.at(9,0)),
							new Arbol(position = game.at(-1,9))]
	
	var property arboleda2 = [new Arbol(position = game.at(9,9)),new Arbol(position = game.at(9,8)),new Arbol(position = game.at(9,7))]
	
	var property columnas = [new ColumnaPiedra(position = game.at(0,9)),new ColumnaPiedra(position = game.at(1,9)),
							new ColumnaPiedra(position = game.at(2,9)),new ColumnaPiedra(position = game.at(4,9)),
							new ColumnaPiedra(position = game.at(5,9)),new ColumnaPiedra(position = game.at(7,9)),
							new ColumnaPiedra(position = game.at(8,9)),
							new ColumnaPiedra(position = game.at(0,8)),
							new ColumnaPiedra(position = game.at(0,5)),
							new ColumnaPiedra(position = game.at(0,4)),
							new ColumnaPiedra(position = game.at(0,3)),new ColumnaPiedra(position = game.at(9,5)),
							new ColumnaPiedra(position = game.at(0,2)),new ColumnaPiedra(position = game.at(9,4)),
							new ColumnaPiedra(position = game.at(0,1)),new ColumnaPiedra(position = game.at(9,3)),
							new ColumnaPiedra(position = game.at(9,2)),new ColumnaPiedra(position = game.at(9,1)),
							new ColumnaPiedra(position = game.at(0,0)),new ColumnaPiedra(position = game.at(9,0)),
							new ColumnaPiedra(position = game.at(0,9))]
	
	var property columnas2 = [new ColumnaPiedra(position = game.at(9,9)),new ColumnaPiedra(position = game.at(9,8)),new ColumnaPiedra(position = game.at(9,7))]
	
	
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
	
	method configuracionEscenarioAux(valor){
		if (valor==1){
		game.ground("pasto50x50.jpg")	
		arboleda.forEach({a => a.visual()})
		game.addVisual(cueva)
		arboleda2.forEach({a => a.visual()})
		game.onTick(15000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })		
		}
		
		else if(valor == 2){
		game.addVisual(fondoCueva)	
		columnas.forEach({a => a.visual()})
		columnas2.forEach({a => a.visual()})
		game.onTick(15000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })			
		}
		
	}
	
	method configuracionEscenario(valor){
		//Configuracion del escenario, colliders, visuales, y teclas
		
		tony.escenario(self)
		//visual algunos			
		game.height(11)
		game.width(10)
		
		self.configuracionEscenarioAux(valor)
		game.addVisualCharacter(tony)
		game.addVisual(tablon)
		game.addVisual(monedasTablon)
		//Juego Corriendo cosas
		
		game.addVisual(barraDeVida)
		game.addVisual(tonyVidas)
		
		game.onTick(200,"actualiza imagen objetos", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
		
		//Teclado
		keyboard.x().onPressDo { tony.atacar(101) }	
		keyboard.p().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		keyboard.w().onPressDo {tony.moverArriba()}
		keyboard.s().onPressDo {tony.moverAbajo()}
		keyboard.d().onPressDo {tony.moverDerecha()}
		keyboard.a().onPressDo {tony.moverIzquierda()}
	}
	
	method escenario(valor){
		//configuracion del escenario 1 	
		//4.times({ i => (game.addVisual(new Pocion(position = randomizer.emptyPosition()) ) ) })
		self.configuracionEscenario(valor)
	}
	
	method removerVisualEscenario(){
		//remover todos los visuales del escenario
		game.clear()
	}
}



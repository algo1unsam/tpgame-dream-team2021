import elementos.*
import tony.*
import wollok.game.*
import objetosParaImplementar.*
import enemigos.*

object escenario{
	
	var property nivel
		
	method iniciarNivel(nuevoNivel){
		tony.points(0)
		nuevoNivel.configuracionFondo()
		nuevoNivel.configuracionInicial()
		nuevoNivel.configuracionTeclado()
		nuevoNivel.instanciarObjetos()
		nuevoNivel.bloqueados()
		nuevoNivel.configuracionVisual()
		nuevoNivel.configuracionEscenario()
		self.nivel(nuevoNivel)
	}
	
	method removerNivel(){
		nivel.removerVisualEscenario()
	}
}

class Nivel{
	var property objetos = []
	var property objetosExtra = []	
	var property noPasar = []
			
	method configuracionInicial(){
		tony.escenario(self)
		//visual algunos			
		game.height(11)
		game.width(10)
		game.addVisualCharacter(tony)		
		game.onTick(200,"actualiza imagen objetos", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
	}
	
	method configuracionTeclado(){
		keyboard.x().onPressDo { tony.atacar(101) }	
		keyboard.p().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		keyboard.w().onPressDo {tony.moverArriba()}
		keyboard.s().onPressDo {tony.moverAbajo()}
		keyboard.d().onPressDo {tony.moverDerecha()}
		keyboard.a().onPressDo {tony.moverIzquierda()}
	}
		
	method bloqueados(){
		noPasar.addAll(#{game.at(0,9),game.at(1,9),game.at(2,9),game.at(4,9),game.at(5,9),
					   game.at(7,9),game.at(8,9),game.at(9,9),game.at(-1,9),game.at(-1,8),
					   game.at(-1,6),game.at(-1,5),game.at(-1,4),game.at(-1,3),game.at(-1,2),
					   game.at(-1,1),game.at(-1,0),game.at(9,9),game.at(9,8),game.at(9,7),
					   game.at(9,6),game.at(9,5),game.at(9,4),game.at(9,3),game.at(9,2),
					   game.at(9,1),game.at(9,0),game.at(0,10),game.at(1,10),game.at(2,10),
					   game.at(4,10),game.at(5,10),game.at(7,10),game.at(8,10),game.at(9,10),
					   game.at(0,0),game.at(1,0),game.at(2,0),game.at(3,0),game.at(4,0),
					   game.at(5,0),game.at(6,0),game.at(7,0),game.at(8,0),game.at(9,0)})
	}
	method removerVisualEscenario(){
		//remover todos los visuales del escenario
		game.clear()
	}
	
	method configuracionFondo(){}
	
	method instanciarObjetos(){}
	
	method configuracionVisual(){}
	
	method configuracionEscenario(){		
		
	}		
	
}

class Nivel1 inherits Nivel{
	
	override method configuracionFondo(){
		game.addVisual(fondoPasto)	
	}
	
	override method instanciarObjetos(){
		objetos.add(new Arbol(position = game.at(0,9)))
		objetos.add(new Arbol(position = game.at(1,9)))
		objetos.add(new Arbol(position = game.at(2,9)))
		objetos.add(new Arbol(position = game.at(4,9)))
		objetos.add(new Arbol(position = game.at(5,9)))
		objetos.add(new Arbol(position = game.at(7,9)))
		objetos.add(new Arbol(position = game.at(8,9)))
		objetos.add(new Arbol(position = game.at(-1,8)))
		objetos.add(new Arbol(position = game.at(-1,5)))
		objetos.add(new Arbol(position = game.at(-1,4)))
		objetos.add(new Arbol(position = game.at(-1,3)))
		objetos.add(new Arbol(position = game.at(-1,2)))
		objetos.add(new Arbol(position = game.at(-1,1)))
		objetos.add(new Arbol(position = game.at(9,2)))
		objetos.add(new Arbol(position = game.at(-1,0)))
		objetos.add(new Arbol(position = game.at(-1,9)))
		objetos.add(new Arbol(position = game.at(9,5)))
		objetos.add(new Arbol(position = game.at(9,4)))	
		objetos.add(new Arbol(position = game.at(9,3)))	
		objetos.add(new Arbol(position = game.at(9,1)))
		objetos.add(new Arbol(position = game.at(9,0)))
		
		objetosExtra.add(new Arbol(position = game.at(9,9)))
		objetosExtra.add(new Arbol(position = game.at(9,8)))
		objetosExtra.add(new Arbol(position = game.at(9,7)))		
		
	}
	
	override method configuracionVisual(){		
		objetos.forEach({a => a.visual()})		
		game.addVisual(cueva)	
		objetosExtra.forEach({a => a.visual()})
		game.addVisual(tablon)
		game.addVisual(monedasTablon)
		game.addVisual(barraDeVida)
		game.addVisual(tonyVidas)
	}
	
	override method configuracionEscenario(){
		
		game.onTick(15000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })	
	}
		
}

class Nivel2 inherits Nivel{
	
	override method configuracionFondo(){
		game.addVisual(fondoCueva)	
	}
	
	override method instanciarObjetos(){
		objetos.add(new ColumnaPiedra(position = game.at(0,9)))
		objetos.add(new ColumnaPiedra(position = game.at(1,9)))
		objetos.add(new ColumnaPiedra(position = game.at(2,9)))
		objetos.add(new ColumnaPiedra(position = game.at(4,9)))
		objetos.add(new ColumnaPiedra(position = game.at(5,9)))
		objetos.add(new ColumnaPiedra(position = game.at(7,9)))
		objetos.add(new ColumnaPiedra(position = game.at(8,9)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,8)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,5)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,4)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,3)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,2)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,1)))
		objetos.add(new ColumnaPiedra(position = game.at(9,2)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,0)))
		objetos.add(new ColumnaPiedra(position = game.at(-1,9)))
		objetos.add(new ColumnaPiedra(position = game.at(9,5)))
		objetos.add(new ColumnaPiedra(position = game.at(9,4)))	
		objetos.add(new ColumnaPiedra(position = game.at(9,3)))	
		objetos.add(new ColumnaPiedra(position = game.at(9,1)))
		objetos.add(new ColumnaPiedra(position = game.at(9,0)))
		
		objetosExtra.add(new ColumnaPiedra(position = game.at(9,9)))
		objetosExtra.add(new ColumnaPiedra(position = game.at(9,8)))
		objetosExtra.add(new ColumnaPiedra(position = game.at(9,7)))
		
		
	}
	
	override method configuracionVisual(){		
		objetos.forEach({a => a.visual()})	
		game.addVisual(cueva)
		objetosExtra.forEach({a => a.visual()})
		game.addVisual(tablon)
		game.addVisual(monedasTablon)
		game.addVisual(barraDeVida)
		game.addVisual(tonyVidas)
	}
	
	override method configuracionEscenario(){
		game.onTick(12000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		game.onTick(78000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(500, "moverZombis", { => ataqueZombi.moverALosZombis()  })	
	}
}
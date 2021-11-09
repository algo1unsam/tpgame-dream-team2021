import elementos.*
import tony.*
import wollok.game.*
import objetosParaImplementar.*
import enemigos.*

object escenario{
	
	var property nivel
		
	method iniciarNivel(nuevoNivel){
		tony.points(0)
		//prueba, despues borrar el golem
		
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
	
	method perderVida(){
		self.removerNivel()
		self.iniciarNivel(nivel)
	}
	
}

class Nivel{
	var property objetos = []
	var property objetosExtra = []	
	var property noPasar = []
			
	method configuracionInicial(){}
	
	method configuracionTeclado(){
		keyboard.x().onPressDo { tony.atacar(101) }	
		keyboard.p().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		keyboard.w().onPressDo {tony.moverArriba()}
		keyboard.s().onPressDo {tony.moverAbajo()}
		keyboard.d().onPressDo {tony.moverDerecha()}
		keyboard.a().onPressDo {tony.moverIzquierda()}
		keyboard.enter().onPressDo {self.pressEnter()}
	}
		
	method bloqueados(){
		noPasar.addAll(objetos.map({i => i.position()}))
		noPasar.addAll(objetosExtra.map({i => i.position()}))
		noPasar.addAll(#{game.at(0,0),game.at(1,0),game.at(2,0),game.at(3,0),game.at(4,0),
					   game.at(5,0),game.at(6,0),game.at(7,0),game.at(8,0),game.at(9,0)})
	}
	method removerVisualEscenario(){
		//remover todos los visuales del escenario
		game.clear()
	}	
	
	method configuracionGolem(){
		game.onTick(200, "actualiza imagen golem", { => golem.numeroImagen(21)})
		game.onTick(2000, "mover golem", { => golem.sigueATony()  })
		game.onTick(2000, "golem ataca", { => golem.atacar()})
	}
	
	method configuracionZombis(){
		game.onTick(15000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })
	}
	
		
	method configuracionFondo(){}
	
	method instanciarObjetos(){}
	
	method configuracionVisual(){}
	
	method moverObjetosVisual(){}	

	method configuracionEscenario(){}	
	
	method pressEnter(){}
}

class Portada inherits Nivel{
	
	override method configuracionFondo(){
		game.addVisual(fondoPortada)	
	}
	
	override method pressEnter(){
		const nivel1 = new Nivel1()
		escenario.removerNivel()
		escenario.iniciarNivel(nivel1)
	}
}

class Nivel1 inherits Nivel{
	
	override method configuracionInicial(){
		//visual algunos			
		game.height(11)
		game.width(10)
		game.addVisualCharacter(tony)		
		game.onTick(200,"actualiza imagen monedas", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
	}
	
	override method configuracionFondo(){
		game.addVisual(fondoPasto)	
	}
	
	override method instanciarObjetos(){
		objetos.add(new Arbol(position = game.at(0,8)))
		objetos.add(new Arbol(position = game.at(0,9)))
		objetos.add(new Arbol(position = game.at(1,9)))
		objetos.add(new Arbol(position = game.at(2,9)))
		objetos.add(new Arbol(position = game.at(4,9)))
		objetos.add(new Arbol(position = game.at(5,9)))
		objetos.add(new Arbol(position = game.at(7,9)))
		objetos.add(new Arbol(position = game.at(8,9)))		
		objetos.add(new Arbol(position = game.at(0,5)))
		objetos.add(new Arbol(position = game.at(0,4)))
		objetos.add(new Arbol(position = game.at(0,3)))
		objetos.add(new Arbol(position = game.at(0,2)))
		objetos.add(new Arbol(position = game.at(0,1)))
		objetos.add(new Arbol(position = game.at(9,2)))
		objetos.add(new Arbol(position = game.at(0,0)))
		objetos.add(new Arbol(position = game.at(0,9)))
		objetos.add(new Arbol(position = game.at(9,5)))
		objetos.add(new Arbol(position = game.at(9,4)))	
		objetos.add(new Arbol(position = game.at(9,3)))	
		objetos.add(new Arbol(position = game.at(9,2)))	
		objetos.add(new Arbol(position = game.at(9,1)))
		objetos.add(new Arbol(position = game.at(9,0)))
		
		objetos.add(new Roca(position = game.at(5,4)))
		objetos.add(new Roca(position = game.at(3,5)))
		objetos.add(new Roca(position = game.at(6,2)))
		
		objetosExtra.add(new Arbol(position = game.at(9,9)))
		objetosExtra.add(new Arbol(position = game.at(9,8)))
		objetosExtra.add(new Arbol(position = game.at(9,7)))	
		objetosExtra.add(new Arbol(position = game.at(9,6)))	
		
	}
	
	override method configuracionVisual(){		
		objetos.forEach({a => a.visual()})		
		game.addVisual(cueva)	
		objetosExtra.forEach({a => a.visual()})
		game.addVisual(tablon)
		game.addVisual(monedasTablon)
		game.addVisual(barraDeVida)
		coleccionVidas.image()
		game.addVisual(golem)
	}
	
	override method configuracionEscenario(){
		self.configuracionGolem()
		self.configuracionZombis()
	}
		
}

class Nivel2 inherits Nivel{
	
	override method configuracionInicial(){
		//visual algunos			
		game.height(11)
		game.width(10)
		game.addVisualCharacter(tony)		
		game.onTick(200,"actualiza imagen monedas", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
	}
	
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
		objetos.add(new ColumnaPiedra(position = game.at(0,8)))
		objetos.add(new ColumnaPiedra(position = game.at(0,5)))
		objetos.add(new ColumnaPiedra(position = game.at(0,4)))
		objetos.add(new ColumnaPiedra(position = game.at(0,3)))
		objetos.add(new ColumnaPiedra(position = game.at(0,2)))
		objetos.add(new ColumnaPiedra(position = game.at(0,1)))
		objetos.add(new ColumnaPiedra(position = game.at(9,2)))
		objetos.add(new ColumnaPiedra(position = game.at(0,0)))
		objetos.add(new ColumnaPiedra(position = game.at(0,9)))
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
		game.onTick(200, "actualiza imagen golem", { => golem.numeroImagen(21)})
		game.onTick(500, "moverGolem", { => golem.sigueATony()  })
		game.addVisual(tablon)
		game.addVisual(monedasTablon)
		game.addVisual(barraDeVida)		
		coleccionVidas.image()
	}
	
	
	override method configuracionEscenario(){
		game.onTick(12000, "hordaZombis", { => ataqueZombi.generarHordaZombi(3)})
		game.onTick(78000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(500, "moverZombis", { => ataqueZombi.moverALosZombis()  })	
	}
}
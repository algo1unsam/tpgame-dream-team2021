import wollok.game.*
import objetosParaImplementar.*
import tony.*
import direcciones.*

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
//modifique Zombi y configure sus movimientos, la idea es mejorarlo para que cada vez se acerque a Tony!
//Cuando un Zombi choca a Tony le quita salud, pensaba en que si toni se encuentra la posicion cercana al zombi y lo ataque, el zombi muera.
class Zombi inherits Objetos{

	var vida = 100
	var property position = randomizer.emptyPosition()
	method image() = "zombi_fren.png"
	
	override method chocasteCon(personaje){
		tony.restarSalud(2)
	}
		
	method moverZombi(number){
		if (number == 1){
			arriba.mover(self)
		}else if (number == 2){
			abajo.mover(self)
		}else if (number == 3){
			derecha.mover(self)
		}else if (number == 4){
			izquierda.mover(self)
		}
	}	
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
	var property position = game.at(8,9)
	
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

//genera una coleccion de Zombis
//Hasta ahora los zombis se mueven cuando se agrega uno nuevo, tengo que mejorar para que se muevan todo el tiempo.
object ataqueZombi{
	var zombis = []
	
	method generarZombis(maxZombis){
		if (zombis.size() <= maxZombis){
			const nuevoZombi = new Zombi(position = randomizer.emptyPosition())
			game.addVisual(nuevoZombi)
			zombis.add(nuevoZombi)
			self.moverALosZombis()
		}
	}
	
	method moverALosZombis(){
		zombis.forEach({z => z.moverZombi(self.devuelveNum())})
		//game.onTick(2000, "mueveZombi", { self.movimiento(1.randomUpTo(4))})
	}
	
	method devuelveNum() = 0.randomUpTo(4).roundUp()
	
	//method movimiento(number){
	//	if (number == 1){
	//		zombis.forEach({z => arriba.mover(z)})
	//	}else if (number == 2){
	//		zombis.forEach({z => abajo.mover(z)})
	//	}else if (number == 3){
	//		zombis.forEach({z => derecha.mover(z)})
	//	}else if (number == 4){
	//		zombis.forEach({z => izquierda.mover(z)})
	//	}
	//}
		
}

//Mi idea es que aca aparezcan tres zombis a la vez..
object hordaDeZombi{
	
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
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
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
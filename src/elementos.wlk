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
//Los zombis ya se acercan a Tony (ver que se aprecien cada zombi cuando ataca a Tony)
//Cuando un Zombi choca a Tony le quita salud, pensaba en que si toni se encuentra la posicion cercana al zombi y lo ataque, el zombi muera.
class Zombi inherits Objetos{

	var vida = 100
	var property position = randomizer.emptyPosition()
	var property perfil = "fren"	
	var property coordenadas = [] //[x, y]
	
	method image() = "zombi_"+self.perfil()+".png"
	
	override method chocasteCon(personaje){
		tony.restarSalud(2)
	}
		
	method movimiento(){
		coordenadas.clear()
		var aux = []
		aux.addAll([self.position().x(), self.position().y()])
		self.coordenadas(aux)
	}
	
	//mi duda es si hara falta una variable de coordenadas o solo con position().x() y position().Y() funcionaria? probar..
	method puntoX () = self.coordenadas().get(0)
	
	method puntoY () = self.coordenadas().get(1)
	
	//metodo para mover a los zombis con un numero aleatorio.
	method moverZombi(number){
		if (number == 1 and self.puntoY() < 9){
		  //if (number == 1){
			arriba.mover(self)
			self.perfil("espal")
			self.movimiento()
		}else if (number == 2 and self.puntoY() > 0){
		   //else if (number == 2){
			abajo.mover(self)
			self.perfil("fren")
			self.movimiento()
		}else if (number == 3 and self.puntoX() < 9){
		   //else if (number == 3){
			derecha.mover(self)
			100.times({i => self.perfil("der_0")}) 
			self.perfil("der_1")
			self.movimiento()
		}else if (number == 4 and self.puntoX() > 0){
		   //else if (number == 4){
			izquierda.mover(self)
			100.times({i => self.perfil("izq_0")})
			self.perfil("izq_1")
			self.movimiento()
			
		}
	}
	
	//Metodos para mover al Zombi hasta Tony
	//fijarse en el objeto AtaqueZombi!! mas abajo
	method moverYorX () = (self.puntoY() - tony.puntoY()).abs() > (self.puntoX() - tony.puntoX()).abs()	
		
	method sigueATony(){
		if(self.moverYorX()){
			if(self.puntoY() - tony.puntoY() >= 0){
				abajo.mover(self)
				self.perfil("fren")
				self.movimiento()
			}else{
				arriba.mover(self)
				self.perfil("espal")
				self.movimiento()
			}
		}else{
			if(self.puntoX() - tony.puntoX() >= 0){
				izquierda.mover(self)
				100.times({i => self.perfil("izq_0")})
				self.perfil("izq_1")
				self.movimiento()
			}else{
				derecha.mover(self)
				100.times({i => self.perfil("der_0")}) 
				self.perfil("der_1")
				self.movimiento()
			}
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


//Cuando se interactua con la cueva y se cumple la condicion, se modificar el escenario
//todavía no logré hacer que cambie el fondo con el game.ground("imagen")
object cueva inherits Objetos{

	var property image = "entrada_cueva_mejorada.png"
	var property position = game.at(8,8)
	
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


//Se generan monedas y colección de monedas y se les modifica la 
//imagen para dar sensación de movimiento
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
	var property zombis = []	
	
	method generarZombis(maxZombis){
		if (zombis.size() <= maxZombis){
			const nuevoZombi = new Zombi(position = randomizer.emptyPosition())
			var aux = []
			aux.addAll([nuevoZombi.position().x(), nuevoZombi.position().y()])
			nuevoZombi.coordenadas(aux)			
			game.addVisual(nuevoZombi)
			//game.say(nuevoZombi,"position [" + nuevoZombi.puntoX()+" "+nuevoZombi.puntoY()+"]")
			//game.say(nuevoZombi,"position " + nuevoZombi.coordenadas().get(0))
			zombis.add(nuevoZombi)
			//self.moverALosZombis()
		}
	}		
	
	method moverALosZombis(){
		if (zombis.size()>0){
			//zombis.forEach({z => z.moverZombi(self.devuelveNum())})
			zombis.forEach({z => z.sigueATony()})
		//game.onTick(2000, "mueveZombi", { self.movimiento(1.randomUpTo(4))})
		}
	}
	
	//metodo que me devuelve un nro random
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

//Horda zombi formada por 3 zombis
//idea de aumentar cantidad de iteraciones de zombis cada vez que pasa tiempo
object hordaDeZombi{
	//var contador = 0
	
	method generarHordaZombi(n) = n.times({ i => ataqueZombi.generarZombis(ataqueZombi.zombis().size() + n - i) })  //n.times({ i => self.incrementandoZombisyDificultad() })

	//method incrementandoZombisyDificultad(n,i){
	//	ataqueZombi.generarZombis(ataqueZombi.zombis().size() + n - i)
	//	game.onTick(18000, "Incrementador de zombis", { => contador = n + 1})
	//}
	
	//method contador(){
	//	return contador
	//}
}

object escenario{
	
	method configuracionEscenario(){
		//Configuracion del escenario, colliders, visuales, y teclas
		
		//visual algunos
		game.addVisualCharacter(tony)		
		game.height(10)
		game.width(10)
		
		
		//Juego Corriendo cosas
		game.onTick(18000, "hordaZombis", { => hordaDeZombi.generarHordaZombi(3)})
		game.onTick(6000, "agregaMonedas", { => monedero.generarMoneda(5)  })
		game.onTick(8000, "agregaZombis", { => ataqueZombi.generarZombis(3)  })
		game.onTick(1000, "moverZombis", { => ataqueZombi.moverALosZombis()  })		
		game.onTick(200,"actualiza imagen objetos", { => monedero.girarMonedas()})
		game.onCollideDo(tony,{algo => algo.chocasteCon(tony)})
		keyboard.a().onPressDo {game.say(tony, "Puntaje Total: " + tony.points())}
		//keyboard.s().onPressDo {game.say(tony, "position: " + tony.position().x())} //para probar el metodo .position()
		
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
import wollok.game.*
import objetosParaImplementar.*
import tony.*
import direcciones.*
import escenario.*

class Objetos{
	//agregando polimorfismo a todas las clases
	//----------------------------------------
	
	//para que no joda con que hay que inicializar clases con valor de vida
	var property vida = 0
	
	
	//para que no haya problema al interactuar con tony
	method chocasteCon(personaje){
		
	}
	
	
	//para que no haya problema con los zombis
	method recibirDanio(danio){
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

	var property vida = 100
	var property position = randomizer.emptyPosition()
	var property perfil = "fren"	
	var property coordenadas = [] //[x, y]
	
	method image() = "zombi_"+self.perfil()+".png"
	
	override method recibirDanio(danio){
		vida -= danio
		self.zombiVivo()
	} 
	
	method zombiVivo(){
		if(self.vida() <= 0){
			ataqueZombi.removerZombi(self)
			game.removeVisual(self)
			monedero.generarMoneda(5,self.position())
		}
	}
	
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
	var property position = randomizer.emptyPosition()
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
	
	method generarMoneda(maxMonedas,position){
		if (monedas.size() <= maxMonedas){
		const monedaNueva = new Coin(position = position)
		movimientos.movimientoObjeto(monedaNueva)
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
	
	//metodo que me devuelve un nro random -- Desplazado a direcciones
	method devuelveNum() = 0.randomUpTo(4).roundUp()
	
	//Horda zombi formada por 3 zombis
	//idea de aumentar cantidad de iteraciones de zombis cada vez que pasa tiempo
	method generarHordaZombi(n) = n.times({ i => self.generarZombis(self.zombis().size() + n - i) })  //n.times({ i => self.incrementandoZombisyDificultad() })
	
	
	//se remueve el zombi de la colección
	method removerZombi(zombi) = zombis.remove(zombi)
		
}

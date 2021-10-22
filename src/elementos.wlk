import wollok.game.*
import objetosParaImplementar.*
import tony.*
import direcciones.*
import escenario.*
import enemigos.*

class Objetos{
	//agregando polimorfismo a todas las clases
	//----------------------------------------
	var property position = randomizer.emptyPosition()  
	
	method image()
	//para que no haya problema al interactuar con tony
	method chocasteCon(personaje){
		
	}
	
}

class Pocion inherits Objetos{	
	//const property position = randomizer.emptyPosition()           //= game.at(1,1)
	override method image() = "pocion1.png"
	
	override method chocasteCon(personaje){
		personaje.recuperaSalud(4)
		pociones.removerPocion(self)
	}
}

class PocionVeneno inherits Objetos{
	
	//const property position = randomizer.emptyPosition()
	override method image() = "pocion2.png"
	override method chocasteCon(personaje){
		personaje.restarSalud(4)
		pociones.removerPocion(self)
	}	
}

class Coin inherits Objetos{

	const property points = 10
	//var property position = randomizer.emptyPosition()
	const property coin = true
	var numero = 0
	
	override method chocasteCon(personaje){
		personaje.addPoints(self.points())
		monedero.removerMoneda(self)
	}
	
	override method image() { 
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

	override method image() = "entrada_cueva_mejorada.png"
	override method position () = game.at(8,8)
	
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



object pociones {
	var property pociones = []
	
	method pocionesCurativas(posicion){
		const nuevaPocion = new Pocion(position = posicion)
		game.addVisual(nuevaPocion)
		pociones.add(nuevaPocion)
	}
	
	method pocionesVeneno(posicion){
		const nuevaPocion = new PocionVeneno(position = posicion)
		game.addVisual(nuevaPocion)
		pociones.add(nuevaPocion)
	}
	
	method removerPocion(pocion){
		pociones.remove(pocion)
		game.removeVisual(pocion)
	}
} 

object barraDeVida {
	const property position = game.at(6,0)
	var saludTony = 13
	method image() = "barra-"+saludTony+".png"
	
	method restarBarra(salud) {
		if(saludTony - salud > 0){
			saludTony -= salud
		}else{
			saludTony = 0
		}
	}
	
	method sumarBarra(salud) {
		if(saludTony + salud < 13){
			saludTony += salud
		}else {
			saludTony = 13
		}
	}
	
	method barraLlena(){
		saludTony = 13
	}
	
	
}
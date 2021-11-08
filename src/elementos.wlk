import wollok.game.*
import objetosParaImplementar.*
import tony.*
import direcciones.*
import escenario.*
import enemigos.*

class Elementos{
	//agregando polimorfismo a todas las clases
	//----------------------------------------
	
	method image()
	//para que no haya problema al interactuar con tony
	method chocasteCon(personaje)
}

//Algunos objetos generaban conflicto al heredar el position, los objetos solo tiene como padre a "Elementos"
class Objetos inherits Elementos{
	var property position = randomizer.emptyPosition() 
}

class Pocion inherits Objetos{	
	const property salud
	
	override method image() = "pocion" + self.actualizarImagen() + ".png"
	
	override method chocasteCon(personaje){
		personaje.recuperaSalud(self.salud())
		pociones.removerPocion(self)
	}
	
	method actualizarImagen() = if(salud < 0) "2" else "1"
}


class Coin inherits Objetos{

	const property points = 10
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
	
	method numeroImagen() = if(numero < 3) numero += 1 else numero = 0

}

//Cuando se interactua con la cueva y se cumple la condicion, se modificar el escenario
//todavía no logré hacer que cambie el fondo con el game.ground("imagen")
object cueva inherits Elementos{
	var property position = game.at(8,8)	

	override method image() = "entrada_cueva_mejorada.png"
	
	override method chocasteCon(personaje){
		if(personaje.points() > 50){
			escenario.removerNivel()
			var nivel2 = new Nivel2() 
			escenario.iniciarNivel(nivel2)
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
	
	method generarMoneda(maxMonedas,position){ self.limiteMonedas(maxMonedas,position) }
	
	method limiteMonedas(maxMonedas,position){ 
		if (monedas.size() <= maxMonedas) 
		{  const monedaNueva = new Coin(position = position)
           self.agregarYGirarMoneda(monedaNueva)} }
	
	method agregarYGirarMoneda(moneda){
		movimientos.movimientoObjeto(moneda)
		self.agregarMoneda(moneda)
	}
	
	method agregarMoneda(moneda){
		game.addVisual(moneda)
		monedas.add(moneda)
	}
	
	method girarMonedas() = monedas.forEach({ objeto => objeto.numeroImagen() })
	
	method removerMoneda(moneda){
		monedas.remove(moneda)
		game.removeVisual(moneda) 
	}
}



object pociones {
	var property pociones = []
	
	method generarPocion(posicion){
		const nuevaPocion = new Pocion(position = posicion, salud = movimientos.positivoNegativo() )
		nuevaPocion.actualizarImagen()
		game.addVisual(nuevaPocion)
		movimientos.movimientoObjeto(nuevaPocion)
		pociones.add(nuevaPocion)
	}
	
	
	method removerPocion(pocion){
		pociones.remove(pocion)
		game.removeVisual(pocion)
	}
} 

object barraDeVida inherits Elementos {
	var property position = game.at(6,0)
	//var saludTony = 13
	
	
	//la barra se actualiza en función de la vida que tiene el objeto tony
	override method image() = "barraVida/barra-" + tony.salud() + ".png"
	
	
	//no nos deja tener el método solamente en la clase abstracta
	override method chocasteCon(personaje){}
	
}

object tonyVidas{
	var property position = game.at(4,0)
	method image() = "tony_fren_vida.png"
}

object tablon{
	var property position = game.at(0,0)
	
	method image() = "fondo_tablones.png"	
	
}

object monedasTablon{
	var property position = game.at(1,0)
	
	method image() = "monedita.png"
}

object fondoCueva inherits Elementos {
	var property position = game.at(0,1)
	override method image() = "Fondo Rocas.jpg"
	override method chocasteCon(personaje){}
}

object fondoPasto inherits Elementos {
	var property position = game.at(0,1)
	override method image() = "pasto50x50.jpg"
	override method chocasteCon(personaje){}
}

	
class ColumnaPiedra inherits Elementos{
	var property position
	override method image() = "elementosEscenario/Columnas.png"
	method visual() = game.addVisual(self)
	override method chocasteCon(personaje){}
}

class Roca inherits Elementos{
	var property position
	override method image() = "elementosEscenario/roca.png"
	method visual() = game.addVisual(self)
	override method chocasteCon(personaje){}
}


class Arbol inherits Elementos{
	var property position
	override method image() = "elementosEscenario/arbol_1.png"
	method visual() = game.addVisual(self)
	override method chocasteCon(personaje){}
}
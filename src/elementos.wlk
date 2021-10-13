import wollok.game.*
import objetosParaImplementar.*


class Objetos{
	
	method chocasteCon(personaje){
		
	}
}

class Pocion inherits Objetos{
	var property codigo = 4
	var property mana = 100
	const property position = game.at(1,1)
	method image() = "pocion2no-bg.png"
}

class PocionVeneno inherits Pocion{
	var property codigo = 3
	
}

class Zombi inherits Objetos{
	var property codigo = 2
	var vida = 100
	const property position = randomizer.emptyPosition()
	method image() = "zombi_fren.png"
}

class Coin inherits Objetos{
	var property codigo = 1
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
	var property codigo = -1
	var property image = "entrada_cueva.png"
	const property position = game.at(8,9)
	
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
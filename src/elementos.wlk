import wollok.game.*
import objetosParaImplementar.*


class Pocion {
	var property codigo = 4
	var property mana = 100
	const property position = game.at(1,1)
	method image() = "pocion2no-bg.png"
}

class PocionVeneno inherits Pocion{
	var property codigo = 3
	
}

class Zombi{
	var property codigo = 2
	var vida = 100
	const property position = randomizer.emptyPosition()
}

class Coin{
	var property codigo = 1
	const puntos = 10
	const property position = randomizer.emptyPosition()
	const property coin = true
	var numero = 0
	
	
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

object cueva{
	var property codigo = -1
	var property image = "entrada_cueva.png"
	const property position = game.at(5,9)
}
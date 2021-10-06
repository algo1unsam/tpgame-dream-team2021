import wollok.game.*
import objetosParaImplementar.*


class Pocion {
	var property mana = 100
	const property position = game.at(1,1)
	method image() = "Ladrillo50x50.png"
}

class PocionVeneno inherits Pocion{
	
}

class Zombi{
	var vida = 100
	const property position = randomizer.emptyPosition()
}
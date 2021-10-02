import wollok.game.*

class Maiz {
	
	const property position
	var property esAdulto = false
	const property valor = 150
	//method position() {
	// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(1, 1)
	//}
	
	method image() {
		const sufijo = if (esAdulto) "adult" else "baby"
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_" + sufijo + ".png"
	}
	
	method regar(){
		esAdulto = true
	}
	
	method esAdulta(){
		if(esAdulto){
			return true
		}
	}
}

class Trigo {
	
	
	const property position
	var property esAdulto = 0
	method valor() = esAdulto * 100
	//method position() {
	// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(1, 1)
	//}
	
	method image() { 
		// TODO: hacer que devuelva la imagen que corresponde
		return "wheat_" + esAdulto + ".png"
	}
	
	method regar(){
		if(esAdulto < 3){
			esAdulto += 1
		}
		else if(esAdulto == 3){
			esAdulto = 0
		}
	}
	
		method esAdulta(){
		if(esAdulto >= 2){
			return true
		}
	}
}

class Tomaco {
	
	var property position
	var property esAdulto = false
	const property valor = 80
	//method position() {
	// TODO: hacer que aparezca donde lo plante Hector
	//	return game.at(1, 1)
	//}
	
	method image() {
		const sufijo = if (esAdulto) "" else "_baby"
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco" + sufijo + ".png"
	}
	
	method regar(){
		if(not esAdulto){
			position = position.up(1)
			esAdulto = true
		}
	}
	
	method esAdulta(){
		return true
	}
}
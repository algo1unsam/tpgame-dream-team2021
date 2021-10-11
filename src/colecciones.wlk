import wollok.game.*
import elementos.*


object coleccionObjetos{
	var objetos = []
	
	method objetosFiltrados(codigo){
		//Devuelve los objetos filtrados por codigo
		objetos = game.allVisuals()
		objetos = objetos.filter({ objeto => objeto.codigo() == 1 })
		return objetos
	}
	
	//Filtra los objetos por el codigo solicitado
	//method filtrarObjetosPorCodigo(codigo) = objetos.filter({ objeto => objeto.codigo(codigo) == 1 })
}

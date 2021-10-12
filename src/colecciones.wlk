import wollok.game.*
import elementos.*


object coleccionObjetos{
	var objetos = []
	
	method objetosFiltrados(codigo){
		//Devuelve los objetos filtrados por codigo
		objetos = game.allVisuals()				
		return self.filtrarObjetosPorCodigo(codigo,objetos)
	}
	
	//Filtra los objetos por el codigo solicitado
	method filtrarObjetosPorCodigo(codigo,objetosParametro) = objetosParametro.filter({ objeto => objeto.codigo() == codigo })
}

import wollok.game.*
import elementos.*
import objetosParaImplementar.*
import tony.*
import direcciones.*

class Personajes inherits Elementos {
	var property vida
	
	var property position = randomizer.emptyPosition()
		//para que no haya problema con los zombis
	method recibirDanio(danio)
	
}

//Los zombis ya se acercan a Tony (ver que se aprecien cada zombi cuando ataca a Tony)
//Cuando un Zombi choca a Tony le quita salud, pensaba en que si toni se encuentra la posicion cercana al zombi y lo ataque, el zombi muera.

class Zombi inherits Personajes{

	var property perfil = "fren"	
	override method image() = "zombi_"+ self.perfil() +".png"
	
	override method recibirDanio(danio){
		vida -= danio 
		self.zombiVivo()
	} 
	
	method queDropea(){
		 if(movimientos.devuelveNum(0,4) == 4){ monedero.generarMoneda(5,self.position())}
		 else if (movimientos.devuelveNum(0,4) == 3){  pociones.generarPocion(self.position())}
}	
	method zombiVivo(){
		if(self.vida() <= 0){
			ataqueZombi.removerZombi(self)
			game.removeVisual(self)
			self.queDropea()
		}
	}
	
	override method chocasteCon(personaje) = game.schedule(1000,{ => self.restarSalud(personaje)})

	method restarSalud(personaje) = 
		if(self.siMismaPosicion(personaje)) personaje.restarSalud(2)
		else                                personaje.restarSalud(0)

	method siMismaPosicion(personaje) = self.position() == personaje.position()
	
	
	method sigueATony(){
		if(movimientos.moverYorX(self)){ movimientos.moverY(self)	}
		else                           { movimientos.moverX(self) }
	}	
		
}

//genera una coleccion de Zombis
//Hasta ahora los zombis se mueven cuando se agrega uno nuevo
object ataqueZombi{
	var property zombis = []	
	
	method generarZombis(maxZombis){
		if (zombis.size() <= maxZombis){
			const nuevoZombi = new Zombi(position = game.at(movimientos.devuelveNumEntre(3,6),10), vida = 100)					
			game.addVisual(nuevoZombi)			
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

object golem inherits Elementos{
	
	var property numero = 1
	
	var property estado = "activando_"
	
	var property position = game.at(5,8)
	
	override method chocasteCon(tony){}
	
	override method image() = "Golem/golem_" + estado + numero  + ".png"	
	
	//cuando activa el golem y ataca(además modifica animación)
 /* 	method rampage(){
		game.onTick(200,"actualiza imagen golem", { => self.numeroImagen(4)})
		game.schedule(3500,{game.removeTickEvent("actualiza imagen golem")})
		numero = 1
		self.estado()
		game.onTick(200,"actualiza golem rampage",{ => self.numeroImagen(10)})
		game.schedule(3500,{game.removeTickEvent("actualiza golem rampage")})
		numero = 1
		self.estado()
	}*/
	
	method numeroImagen(valor) = if(numero < valor) numero += 1 else numero = 1

	method estado() = if (estado == "") estado = "activando_" else estado = ""

}
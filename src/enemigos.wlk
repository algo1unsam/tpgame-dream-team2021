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
	var property coordenadas = [] //[x, y]
	override method image() = "zombi_"+ self.perfil() +".png"
	
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
			const nuevoZombi = new Zombi(position = randomizer.emptyPosition(), vida = 100)
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
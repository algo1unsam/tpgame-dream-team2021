import wollok.game.*
import elementos.*
import objetosParaImplementar.*
import tony.*
import direcciones.*

class Personajes inherits Objetos {
	var property vida
	
		//para que no haya problema con los zombis
	method recibirDanio(danio){
	
	}
	
}

//Los zombis ya se acercan a Tony (ver que se aprecien cada zombi cuando ataca a Tony)
//Cuando un Zombi choca a Tony le quita salud, pensaba en que si toni se encuentra la posicion cercana al zombi y lo ataque, el zombi muera.

class Zombi inherits Personajes{

	var property perfil = "fren"	
	var property coordenadas = [] //[x, y]
	
	override method image() = "zombi_"+self.perfil()+".png"
	
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
	
	override method chocasteCon(personaje){
		tony.restarSalud(2)
	}
		
	method movimiento(){
		coordenadas.clear()
		var aux = []
		aux.addAll([self.position().x(), self.position().y()])
		self.coordenadas(aux)
	}
	
	//mi duda es si hara falta una variable de coordenadas o solo con position().x() y position().Y() funcionaria? probar..
	method puntoX () = self.coordenadas().get(0)
	
	method puntoY () = self.coordenadas().get(1)
	
	//metodo para mover a los zombis con un numero aleatorio.
	method moverZombi(number){
		if (number == 1 and self.puntoY() < 9){
		  //if (number == 1){
			arriba.mover(self)
			self.perfil("espal")
			self.movimiento()
		}else if (number == 2 and self.puntoY() > 0){
		   //else if (number == 2){
			abajo.mover(self)
			self.perfil("fren")
			self.movimiento()
		}else if (number == 3 and self.puntoX() < 9){
		   //else if (number == 3){
			derecha.mover(self)
			100.times({i => self.perfil("der_0")}) 
			self.perfil("der_1")
			self.movimiento()
		}else if (number == 4 and self.puntoX() > 0){
		   //else if (number == 4){
			izquierda.mover(self)
			100.times({i => self.perfil("izq_0")})
			self.perfil("izq_1")
			self.movimiento()
			
		}
	}
	
	//Metodos para mover al Zombi hasta Tony
	//fijarse en el objeto AtaqueZombi!! mas abajo
	method moverYorX () = (self.puntoY() - tony.puntoY()).abs() > (self.puntoX() - tony.puntoX()).abs()	
		
	method sigueATony(){
		if(self.moverYorX()){
			if(self.puntoY() - tony.puntoY() >= 0){
				abajo.mover(self)
				self.perfil("fren")
				self.movimiento()
			}else{
				arriba.mover(self)
				self.perfil("espal")
				self.movimiento()
			}
		}else{
			if(self.puntoX() - tony.puntoX() >= 0){
				izquierda.mover(self)
				100.times({i => self.perfil("izq_0")})
				self.perfil("izq_1")
				self.movimiento()
			}else{
				derecha.mover(self)
				100.times({i => self.perfil("der_0")}) 
				self.perfil("der_1")
				self.movimiento()
			}
		}
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
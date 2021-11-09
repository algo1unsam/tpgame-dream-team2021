import wollok.game.*
object randomizer {
		
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
	method devuelveNum(min,max) = min.randomUpTo(max).roundUp()	
	
	method devuelveNumEntre(min,max){
		const num = (min-1).randomUpTo(max).roundUp()
		if (num == min or num ==max) {
			return num
		}else{
			return self.devuelveNumEntre(min,max)
		}
	}	
	
}

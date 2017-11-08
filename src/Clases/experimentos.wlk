import material.*

class Experimento{
	
	method materialesRequeridos(_companiero)
	method efecto(_companiero)
	
}

object construirUnaBateria inherits Experimento {
	 override method materialesRequeridos(_companiero){
	 	return #{_companiero.mochila().find({material => material.gramosDeMetal() > 200})} +
	 	 	   #{_companiero.mochila().find({material => material.esRadioactivo()})}   
	 }
	 
	override method efecto(_companiero){
		var bateria = new Bateria(self.materialesRequeridos(_companiero))
		_companiero.companiero().restarEnergia(5)
		_companiero.mochila().add(bateria)
	}
}

object construirUnCircuito inherits Experimento {
	override method materialesRequeridos(_companiero){
		return _companiero.mochila().filter({material => material.electricidadQueConduce() >= 5})
	}
	
	override method efecto(_companiero){
		var circuito = new Circuito(self.materialesRequeridos(_companiero))
		_companiero.mochila().add(circuito)
	}
		
}

object construirUnShockElectrico inherits Experimento {
	override method materialesRequeridos(_companiero){
		return #{self.materialConductor(_companiero)} + #{self.materialGenerador(_companiero)}
	}
	
	override method efecto(_companiero){
		_companiero.companiero().sumarEnergia(self.energiaQueIncrementa(_companiero))
	}
	
	method materialConductor(_companiero){
		return _companiero.mochila().find({material => material.electricidadQueConduce() > 0})
		
	}
	
	method materialGenerador(_companiero){
		return _companiero.mochila().find({material => material.energiaQueGenera() > 0})
	}
	
	method energiaQueIncrementa(_companiero){
		return self.materialConductor(_companiero).electricidadQueConduce() * 
			   self.materialGenerador(_companiero).energiaQueGenera() 
	}
	
	
}
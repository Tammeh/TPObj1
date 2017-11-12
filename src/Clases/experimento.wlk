import material.*

class Experimento{
	//Retorna un conjunto de materiales que tiene compañero en su mochila, si los encuentra,
	//para realizar un experimento
	method materialesRequeridos(_companiero)
	//Genera un efecto, propio del experimento, en el compañero que lo ha realizado
	method efecto(_companiero, _materialesNecesarios)
	
}

object construirUnaBateria inherits Experimento {
	 override method materialesRequeridos(_companiero){
	 	return #{_companiero.mochila().find({material => material.gramosDeMetal() > 200})} +
	 	 	   #{_companiero.mochila().find({material => material.esRadioactivo()})}   
	 }
	 
	override method efecto(_companiero, _materialesNecesarios){
		var bateria = new Bateria(_materialesNecesarios)
		_companiero.companiero().restarEnergia(5)
		_companiero.mochila().add(bateria)
	}
}

object construirUnCircuito inherits Experimento {
	override method materialesRequeridos(_companiero){
		return _companiero.mochila().filter({material => material.electricidadQueConduce() >= 5})
	}
	
	override method efecto(_companiero ,_materialesNecesarios){
		var circuito = new Circuito(_materialesNecesarios)
		_companiero.mochila().add(circuito)
	}
		
}

object construirUnShockElectrico inherits Experimento {
	override method materialesRequeridos(_companiero){
		return #{self.materialConductor(_companiero)} + #{self.materialGenerador(_companiero)}
	}
	
	override method efecto(_companiero, _materialesNecesarios){
		_companiero.companiero().sumarEnergia(self.energiaQueIncrementa(_companiero))
	}
	//Retorna un material conductor
	method materialConductor(_companiero){
		return _companiero.mochila().find({material => material.electricidadQueConduce() > 0})
		
	}
	//Retorna un material generador
	method materialGenerador(_companiero){
		return _companiero.mochila().find({material => material.energiaQueGenera() > 0})
	}
	//Retorna la energia que incrementa un shock electrico
	method energiaQueIncrementa(_companiero){
		return self.materialConductor(_companiero).electricidadQueConduce() * 
			   self.materialGenerador(_companiero).energiaQueGenera() 
	}
	
	
}

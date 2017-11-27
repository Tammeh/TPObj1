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
	 	   return estrategia.estrategiaElegida().materialesConstruirBateria(_companiero)
	 }
	 
	override method efecto(_companiero, _materialesNecesarios){
		var bateria = new Bateria(_materialesNecesarios)
		_companiero.companiero().restarEnergia(5)
		_companiero.mochila().add(bateria)
	}
}

object construirUnCircuito inherits Experimento {
	override method materialesRequeridos(_companiero){
	 	   return estrategia.estrategiaElegida().materialesConstruirCircuito(_companiero)
	}
	
	override method efecto(_companiero ,_materialesNecesarios){
		var circuito = new Circuito(_materialesNecesarios)
		_companiero.mochila().add(circuito)
	}
		
}

object construirUnShockElectrico inherits Experimento {
	override method materialesRequeridos(_companiero){
		return #{estrategia.estrategiaElegida().materialConductor(_companiero.mochila())} + #{estrategia.estrategiaElegida().materialGenerador(_companiero.mochila())}
	}
	
	override method efecto(_companiero, _materialesNecesarios){
		_companiero.companiero().sumarEnergia(self.energiaQueIncrementa(_materialesNecesarios))
	}
	//Retorna la energia que incrementa un shock electrico
	method energiaQueIncrementa(_materiales){
		return estrategia.estrategiaElegida().materialConductor(_materiales).electricidadQueConduce() * 
			   estrategia.estrategiaElegida().materialGenerador(_materiales).energiaQueGenera() 
	}
	
	
}

object estrategia{
	var estrategiaElegida = alAzar
	method estrategiaElegida() = estrategiaElegida
	method estrategiaElegida(estrategia){estrategiaElegida = estrategia}
}

object alAzar{
	method materialesConstruirBateria(_companiero){
		if(!_companiero.mochila().any({material => material.gramosDeMetal() > 200}) && !_companiero.mochila().any({material => material.esRadioactivo()})){
			self.error("No hay materiales que cumplan esas condiciones")
	 	}
	 	return #{_companiero.mochila().find({material => material.gramosDeMetal() > 200})} +
	 	 	   #{_companiero.mochila().find({material => material.esRadioactivo()})}
	}
	method materialesConstruirCircuito(_companiero){
		return _companiero.mochila().filter({material => material.electricidadQueConduce() >= 5})
	}
	method materialConductor(_materiales){
		if(!_materiales.any({material => material.electricidadQueConduce() > 0})){
			self.error("No hay materiales que cumplan esas condiciones")
		}
		return _materiales.find({material => material.electricidadQueConduce() > 0})
	}
	//Retorna un material generador
	method materialGenerador(_materiales){
		if(!_materiales.any({material => material.energiaQueGenera() > 0})){
			self.error("No hay materiales que cumplan esas condiciones")
		}
		return _materiales.find({material => material.energiaQueGenera() > 0})
	}
}

object menorCantidadDeMetal{
	method materialesConstruirBateria(_companiero){
		if(!_companiero.mochila().any({material => material.gramosDeMetal() > 200}) && !_companiero.mochila().any({material => material.esRadioactivo()})){
			self.error("No hay materiales que cumplan esas condiciones")
	 	}
	 	var listaFiltradaPorMetal = _companiero.mochila().filter({material => material.gramosDeMetal() > 200})
	 	var listaFiltradaPorRadioactivo = _companiero.mochila().filter({material => material.esRadioactivo()})
	 	return #{listaFiltradaPorMetal.min({material => material.gramosDeMetal()})} +
	 	 	   #{listaFiltradaPorRadioactivo.min({material => material.gramosDeMetal()})}
	}
	method materialesConstruirCircuito(_companiero){
		return _companiero.mochila().filter({material => material.electricidadQueConduce() >= 5})
	}
	method materialConductor(_materiales){
		if(!_materiales.any({material => material.electricidadQueConduce() > 0})){
			self.error("No hay materiales que cumplan esas condiciones 1 ")
		}
		var listaFiltradaPorConduccion = _materiales.filter({material => material.electricidadQueConduce() > 0})
		return listaFiltradaPorConduccion.min({material => material.gramosDeMetal()})
	}
	//Retorna un material generador
	method materialGenerador(_materiales){
		if(!_materiales.any({material => material.energiaQueGenera() > 0})){
			self.error("No hay materiales que cumplan esas condiciones 2")
		}
		var listaFiltradaPorGeneracion = _materiales.filter({material => material.energiaQueGenera() > 0})
		return listaFiltradaPorGeneracion.min({material => material.gramosDeMetal()})
	}
}

object mejorGeneradorElectrico{
	method materialesConstruirBateria(_companiero){
		if(!_companiero.mochila().any({material => material.gramosDeMetal() > 200}) && !_companiero.mochila().any({material => material.esRadioactivo()})){
			self.error("No hay materiales que cumplan esas condiciones")
	 	}
	 	var listaFiltradaPorMetal = _companiero.mochila().filter({material => material.gramosDeMetal() > 200})
	 	var listaFiltradaPorRadioactivo = _companiero.mochila().filter({material => material.esRadioactivo()})
	 	return #{listaFiltradaPorMetal.max({material => material.energiaQueGenera()})} +
	 	 	   #{listaFiltradaPorRadioactivo.max({material => material.energiaQueGenera()})}
	}
	method materialesConstruirCircuito(_companiero){
		return _companiero.mochila().filter({material => material.electricidadQueConduce() >= 5})
	}
	method materialConductor(_materiales){
		if(!_materiales.any({material => material.electricidadQueConduce() > 0})){
			self.error("No hay materiales que cumplan esas condiciones")
		}
		var listaFiltradaPorConduccion = _materiales.filter({material => material.electricidadQueConduce() > 0})
		return listaFiltradaPorConduccion.max({material => material.energiaQueGenera()})
	}
	//Retorna un material generador
	method materialGenerador(_materiales){
		if(!_materiales.any({material => material.energiaQueGenera() > 0})){
			self.error("No hay materiales que cumplan esas condiciones")
		}
		var listaFiltradaPorGeneracion = _materiales.filter({material => material.energiaQueGenera() > 0})
		return listaFiltradaPorGeneracion.max({material => material.energiaQueGenera()})
	}
}

object ecologico{
	method materialesConstruirBateria(_companiero){
		if(!_companiero.mochila().any({material => material.gramosDeMetal() > 200}) && !_companiero.mochila().any({material => material.esRadioactivo()})){
			self.error("No hay materiales que cumplan esas condiciones")
	 	}
	 	var listaFiltradaPorMetal = _companiero.mochila().filter({material => material.gramosDeMetal() > 200})
	 	return #{listaFiltradaPorMetal.findOrElse({material => material.serVivo()}, {=>listaFiltradaPorMetal.find({material => material.esRadioactivo()})})} +
	 	 	   #{_companiero.mochila().find({material => material.esRadioactivo()})}
	}
	method materialesConstruirCircuito(_companiero){
		return _companiero.mochila().filter({material => material.electricidadQueConduce() >= 5})
	}
	method materialConductor(_materiales){
		if(!_materiales.any({material => material.electricidadQueConduce() > 0}) && !_materiales.any({material => material.esRadioactivo()})){
			self.error("No hay materiales que cumplan esas condiciones")
		}
		var listaFiltradaPorConduccion = _materiales.filter({material => material.electricidadQueConduce() > 0})
		return listaFiltradaPorConduccion.findOrElse({material => material.serVivo()}, {=>listaFiltradaPorConduccion.find({material => material.esRadioactivo()})})
	}
	//Retorna un material generador
	method materialGenerador(_materiales){
		if(!_materiales.any({material => material.energiaQueGenera() > 0}) && !_materiales.any({material => material.esRadioactivo()})){
			self.error("No hay materiales que cumplan esas condiciones")
		}
		var listaFiltradaPorGeneracion = _materiales.filter({material => material.energiaQueGenera() > 0})
		return listaFiltradaPorGeneracion.findOrElse({material => material.serVivo()}, {=>listaFiltradaPorGeneracion.find({material => material.esRadioactivo()})})
	}
}


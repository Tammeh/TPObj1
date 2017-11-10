class Companiero {
	const mochila = #{}
	var energia = 100
	
//	constructor(){
//		mochila = #{}	
//	}
	
	method mochila() = mochila
	method energia() = energia
	
	method setEnergia(_energia){
		energia = _energia
	}
	method restarEnergia(_energia){
		energia -= _energia 
	}
	method sumarEnergia(_energia){
		energia += _energia 
	}
	method cantidadDeObjetos(){
		return mochila.size()
	}
	
	
	method puedeRecolectar(unMaterial)
	
	method recolectar(unMaterial)
	
	method darObjetos(unCompaniero){
		unCompaniero.recibir(mochila)
		self.mochila().removeAll(self.mochila())
	}

}

object morty inherits Companiero{
	const capacidadMochila = 3
	
	override method puedeRecolectar(unMaterial){
		return unMaterial.energiaRequeridaRecoleccion() <= energia && self.cantidadDeObjetos() < capacidadMochila
	}
	override method recolectar(unMaterial){
		if (!self.puedeRecolectar(unMaterial)){
			self.error("No puede recolectar el material")
		}
		mochila.add(unMaterial)
		self.restarEnergia(unMaterial.gramosDeMetal())
		
	}
}

object rick inherits Companiero{
	var companiero
	var experimentosQueSabe = #{}
	
	method companiero() = companiero
	method companiero(unCompaniero){ companiero = unCompaniero }
	method experimentosQueSabe() = experimentosQueSabe
	method experimentosQueSabe(unExperimento){ experimentosQueSabe += #{unExperimento} }
	
	//Rick guarda los materiales recibidos en su mochila
	method recibir(unosMateriales){
		mochila.addAll(unosMateriales)
	}
	
	//Retorna un conjunto con los experimentos que puede realizar Rick
	method experimentosQuePuedeRealizar(){
		return experimentosQueSabe.filter({experimento => self.puedeRealizarExperimento(experimento)}).asSet()
	}
	
	//Retorna verdadero si Rick puede realizar el experimento <unExperimento>
	method puedeRealizarExperimento(unExperimento){
		return unExperimento.materialesRequeridos(self).difference(mochila).isEmpty()
	}
	
	//Rick realiza el experimento <unExperimento>. En caso de que pueda realizarlo,
	//rick usa los materiales de su mochila y recibe el efecto del experimento.
	method realizar(unExperimento){
		if(!self.puedeRealizarExperimento(unExperimento)){
			self.error("No puede realizar el experimento")
		}
		mochila.removeAll(unExperimento.materialesRequeridos(self))
		self.recibirEfecto(unExperimento)
	}
	
	//Rick recibe el efecto del experimento <unExperimento>
	method recibirEfecto(unExperimento){
		unExperimento.efecto(self)
	}
	
	//Ambos metodos quedan vacios, ya que no nos interesan para Rick
	override method puedeRecolectar(unMaterial){
		//Dejar vacio
	}
	
	override method recolectar(unMaterial){
		//Dejar vacio
	}
}

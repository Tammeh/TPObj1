class Companiero {
	const mochila
	const capacidadMochila
	var energia = 0
	
	constructor(){
		mochila = #{}
		capacidadMochila = 3
		
	}
	
	method mochila() = mochila
	method energia() = energia
	
	
	
	method puedeRecolectar(unMaterial){
		return unMaterial.gramosDeMetal() <= energia && capacidadMochila < 3
	}
	method recolectar(unMaterial){
		if (!self.puedeRecolectar(unMaterial)){
			self.error("No puede recolectar el material")
		}
	mochila.add(unMaterial)
		
	}
	
	method darObjetos(unCompaniero){
		unCompaniero.mochila().addAll(mochila)
		self.mochila().removeAll()
	}

}

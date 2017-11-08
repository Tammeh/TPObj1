class Companiero {
	const mochila
	var energia = 100
	
	constructor(){
		mochila = #{}	
	}
	
	method mochila() = mochila
	method energia() = energia
	
	method setEnergia(_energia){
		energia = _energia
	}
	method cantidadDeObjetos(){
		return mochila.size()
	}
	
	
	method puedeRecolectar(unMaterial)
	
	method recolectar(unMaterial)
	
	method darObjetos(unCompaniero){
		unCompaniero.mochila().addAll(mochila)
		self.mochila().removeAll()
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
		
	}
}

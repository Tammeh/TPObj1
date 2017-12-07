class Companiero {
	const mochila = #{}
	var energia = 100
	

	//Retorna la mocila del compañero
	method mochila() = mochila
	//Retorna la energia del compañero
	method energia() = energia
	//Configura la energia del compañero en cualquier momento
	method setEnergia(_energia){
		energia = _energia
	}
	//Resta la energia del compañero
	method restarEnergia(_energia){
		energia -= _energia 
	}
	//Suma la energia del compañero
	method sumarEnergia(_energia){
		energia += _energia 
	}
	//Retorna la cantidad de objetos que haya en la mochila del compañero
	method cantidadDeObjetos(){
		return mochila.size()
	}
	
	//Verifica si un compañero puede recolectar un material en especifico
	method puedeRecolectar(unMaterial)
	//Recolecta un material en especifico
	method recolectar(unMaterial)
	//Un compañero entraga sus objetos a otro
	method darObjetos(_companiero){
		self.accionPertinenteDarObjetos(_companiero)		
	}
	method accionPertinenteDarObjetos(_companiero){
		_companiero.recibir(mochila)
		self.mochila().removeAll(self.mochila())
	}

}

class Morty inherits Companiero{
	const capacidadMochila
	
	constructor(_capacidadMochila){
		capacidadMochila= _capacidadMochila
	}
	
	override method puedeRecolectar(unMaterial){
		return self.energiaRequeridaRecoleccion(unMaterial) <= energia && self.cantidadDeObjetos() < self.capacidadMochila()
	}
	
	method energiaRequeridaRecoleccion(unMaterial){
		return unMaterial.energiaRequeridaRecoleccion()
	}
	
	method capacidadMochila(){
		return capacidadMochila
	}
	override method recolectar(_material){
		if (!self.puedeRecolectar(_material)){
			self.error("No puede recolectar el material")
		}
		self.accionPertinenteRecoleccion(_material)
		
	}
	
	method accionPertinenteRecoleccion(_material){
		mochila.add(_material)
		self.restarEnergia(self.energiaRequeridaRecoleccion(_material))
	}
	
}

object summer inherits Morty(2){
	
	override method energiaRequeridaRecoleccion(_material){
		return super(_material)*0.8
	}
	
	override method accionPertinenteDarObjetos(_companiero){
		super(_companiero)
		self.restarEnergia(10)
	}
}

object jerry inherits Morty(3){
	var estaDeBuenHumor = true
	var estaSobreexcitado = false
	
	//TODO declara estos getters pero no se usan nunca
	// Declarar estos mensajes comunica que alguien necesita
	// saber esta informacion pero nadie lo pregunta.
	method estaDeBuenHumor() = estaDeBuenHumor
	method estaSobreExcitado() = estaSobreexcitado
	
	override method capacidadMochila(){
		if (!estaDeBuenHumor){
			return 1
		}
		//TODO capacidadMochila *2 seria mejor super() * 2
		// al usar una variable de instancia de la super clase
		// rompe el encapsulamiento. recomendacion usar un mensaje
		// que resuelva la capacidadMochila (super())
		if (estaSobreexcitado) {
			return capacidadMochila*2
		}
		return super()
	}
	
	override method accionPertinenteDarObjetos(_companiero){
		estaDeBuenHumor = false
		super(_companiero)
	}
	
	override method accionPertinenteRecoleccion(_material){
		if (estaSobreexcitado){
			self.efectoSobreExcitacion()
		}
		if (_material.serVivo()){
			estaDeBuenHumor = true
		}
		if (_material.esRadioactivo()){
			estaSobreexcitado = true
		}		
		super(_material)
	}
	
	method efectoSobreExcitacion(){
		if ((1..4).anyOne() == 1){
			mochila.removeAll(self.mochila())
		}
	}
}

object rick{
	var mochila = #{}
	var companiero
	var experimentosQueSabe = #{}
	
	method mochila() = mochila
	method cantidadDeObjetos() = mochila.size()
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
		if (unExperimento.materialesRequeridos(self).isEmpty()) {
			return false
		}
		return unExperimento.materialesRequeridos(self).difference(mochila).isEmpty()
		
	}
	
	//Rick realiza el experimento <unExperimento>. En caso de que pueda realizarlo,
	//rick usa los materiales de su mochila y recibe el efecto del experimento.
	method realizar(unExperimento){
		if(!self.puedeRealizarExperimento(unExperimento)){
			self.error("No puede realizar el experimento")
		}
		var materialesNecesarios = unExperimento.materialesRequeridos(self)
		mochila.removeAll(materialesNecesarios)
		self.recibirEfecto(unExperimento, materialesNecesarios)
	}
	
	//Rick recibe el efecto del experimento <unExperimento>
	method recibirEfecto(unExperimento, _materialesNecesarios){
		unExperimento.efecto(self, _materialesNecesarios)
	}
}

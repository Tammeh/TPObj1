
class Material {
	method gramosDeMetal()
	method electricidadQueConduce()
	method esRadioactivo()
	method energiaQueGenera()
	method energiaRequeridaRecoleccion(){
		return self.gramosDeMetal()
	}
}

class Lata inherits Material{
	var gramosDeMetal
	
	constructor(_gramosDeMetal){
		gramosDeMetal = _gramosDeMetal
	}
	
	override method gramosDeMetal() = gramosDeMetal
	
	override method electricidadQueConduce() = 0.1 * gramosDeMetal
	
	override method esRadioactivo() = false
	
	override method energiaQueGenera() = 0
	
}

class Cable inherits Material{
	var longitud
	var seccion
	
	constructor(_longitud, _seccion){
		longitud = _longitud
		seccion = _seccion
	}
	override method gramosDeMetal(){
		return ((longitud/1000) * seccion)
	}
	
	override method electricidadQueConduce() = 3 * seccion
	
	override method esRadioactivo() = false
	
	override method energiaQueGenera() = 0
	
}

class Fleeb inherits Material{
	var materialesQueComio
	var anios
	
	constructor(_materialesQueComio, _anios){
		materialesQueComio = _materialesQueComio
		anios = _anios
	}
	override method gramosDeMetal(){
		return materialesQueComio.sum({material => material.gramosDeMetal()})
	}
	
	override method electricidadQueConduce(){
		return materialesQueComio.min({material => material.electricidadQueConduce()}).electricidadQueConduce()
	}
	
	override method esRadioactivo() = return anios > 15
	
	override method energiaQueGenera(){
		return materialesQueComio.max({material => material.energiaQueGenera()}).energiaQueGenera()
	}
	
	override method energiaRequeridaRecoleccion(){
		return super() * 2
	}
}

class MateriaOscura inherits Material{
	var materialBase
	
	constructor(_materialBase){
		materialBase = _materialBase
	}
	override method gramosDeMetal() = materialBase.gramosDeMetal()
	override method electricidadQueConduce() = materialBase.electricidadQueConduce() / 2
	override method esRadioactivo()  = false
	override method energiaQueGenera() = materialBase.energiaQueGenera() * 2
	
}

class Bateria inherits Material{
	const materialesQueLaConstruyeron
	
	constructor(_materialesQueLaConstruyeron){
		materialesQueLaConstruyeron = _materialesQueLaConstruyeron
	}
	
	override method gramosDeMetal() = materialesQueLaConstruyeron.sum({material => material.gramosDeMetal()})
	override method electricidadQueConduce() = 0
	override method esRadioactivo()  = true
	override method energiaQueGenera() = self.gramosDeMetal()*2
	
}

class Circuito inherits Material{
	const materialesQueLaConstruyeron
	
	constructor(_materialesQueLaConstruyeron){
		materialesQueLaConstruyeron = _materialesQueLaConstruyeron
	}
	
	override method gramosDeMetal() = materialesQueLaConstruyeron.sum({material => material.gramosDeMetal()})
	override method electricidadQueConduce() =  (materialesQueLaConstruyeron.sum({material => material.electricidadQueConduce()})*3)
	override method esRadioactivo()  =  materialesQueLaConstruyeron.any({material => material.esRadioctivo()})
	override method energiaQueGenera() = 0
}



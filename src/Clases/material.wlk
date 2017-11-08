
class Material {
	method gramosDeMetal()
	method electricidadQueConduce()
	method esRadioactivo()
	method energiaQueGenera()
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
}

class MateriaOscura{
	var materialBase
	
	constructor(_materialBase){
		materialBase = _materialBase
	}
	method gramosDeMetal() = materialBase.gramosDeMetal()
	method electricidadQueConduce() = materialBase.electricidadQueConduce() / 2
	method esRadioactivo()  = false
	method energiaQueGenera() = materialBase.energiaQueGenera() * 2
}





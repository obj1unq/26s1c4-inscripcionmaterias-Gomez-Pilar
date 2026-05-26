import materiaAprobada.*
class Estudiante {
  const materiasAprobadas = #{}
  const carrerasQueCursa = #{}
  method aprobarMateria(materia, nota) {
    if (self.tieneAprobada(materia)) {
      self.error('Ya aprobaste esta materia')
    } else {
      materiasAprobadas.add(new MateriaAprobada(materia = materia, nota = nota))
    }
  }

  method tieneAprobada(materia) {
    return materiasAprobadas.any({ m => m.materia() == materia })
  }
  
  method cantidadDeMateriasAprobadas() {
    return materiasAprobadas.size()
  }

  method promedio() {
		if (materiasAprobadas.isEmpty()) {
      return 0
    } 
    return materiasAprobadas.sum({ a => a.nota() }) / self.cantidadDeMateriasAprobadas()
	}

  method materiasEnTotalDeMisCarreras() {
    return carrerasQueCursa.flatMap({ c => c.materias() })
  }

  method puedeInscribirseEn(materia) {
    return self.esMateriaDeMisCarreras(materia)
        && !materia.estaInscripto(self)
        && !self.tieneAprobada(materia)
        && materia.requisitos().all({ r => self.tieneAprobada(r) })
  }

  method inscribirseEn(materia) {
    if (self.puedeInscribirseEn(materia)) {
      materia.inscribir(self)
    } else {
      self.error('No cumplis los requisitos para anotarte en esta materia')
    }
  }

  method esMateriaDeMisCarreras(materia) {
    return self.materiasEnTotalDeMisCarreras().contains(materia)
  }

  method materiasEnLasQueEstoyInscripto() {
    return self.materiasEnTotalDeMisCarreras().filter({ m => m.estaInscripto(self) })
  }

  method materiasEnLasQueEstoyEnListaDeEspera() {
    return self.materiasEnTotalDeMisCarreras().filter({ m => m.estudiantesEnListaDeEspera().any({ e => e == self }) })
  }

  method materiasQueSePuedeAnotarDe(carrera) {
    if (!carrerasQueCursa.any({ c => c == carrera })) {
      self.error('No cursas esta carrera')
    }
    return carrera.materias().filter({ m => self.puedeInscribirseEn(m) })
  }

}
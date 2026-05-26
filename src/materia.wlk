class Materia {
    const property carrera
    const property requisitos = #{}
    const property estudiantes = #{}
    const property cupo = 3
    const property listaDeEspera = []

    method estaInscripto(estudiante) {
        return estudiantes.any({ e => e == estudiante }) || listaDeEspera.any({e => e == estudiante})
    }

    method inscribir(estudiante) {
        if (estudiantes.size() < cupo) {
            estudiantes.add(estudiante)
        } else {
            listaDeEspera.add(estudiante)
        }
    }

    method darDeBaja(estudiante) {
        if (estudiantes.any({e => e == estudiante})) {
            estudiantes.remove(estudiante)
            if (!listaDeEspera.isEmpty()) {
                const proximoEnLaLista = listaDeEspera.first()
                listaDeEspera.remove(proximoEnLaLista)
                estudiantes.add(proximoEnLaLista)
            }
        }
    }

    method estudiantesInscriptos() = estudiantes
    method estudiantesEnListaDeEspera() = listaDeEspera
    
}
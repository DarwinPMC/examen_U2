package pe.edu.upeu.asistenciaupeubackend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pe.edu.upeu.asistenciaupeubackend.models.Finca;

@Repository
public interface FincaRepository extends JpaRepository<Finca, Long> {

}

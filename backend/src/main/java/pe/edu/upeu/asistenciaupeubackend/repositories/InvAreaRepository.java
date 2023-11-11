package pe.edu.upeu.asistenciaupeubackend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pe.edu.upeu.asistenciaupeubackend.models.InvArea;

@Repository
public interface InvAreaRepository extends JpaRepository<InvArea, Long> {

}

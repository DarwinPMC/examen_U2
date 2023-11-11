package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistenciaupeubackend.models.Actividad;

/**
 *
 * @author DELL
 */
public interface ActividadService {
    Actividad save(Actividad activiad);

    List<Actividad> findAll();

    Map<String, Boolean> delete(Long id);

    Actividad getActividadById(Long id);

    Actividad update(Actividad activiad, Long id);   
}

package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistenciaupeubackend.dtos.AsistenciaxDto;
import pe.edu.upeu.asistenciaupeubackend.models.Asistenciax;

/**
 *
 * @author DELL
 */
public interface AsistenciaXService {
    Asistenciax save(AsistenciaxDto.AsistenciasxCrearDto asistenciax);

    List<Asistenciax> findAll();

    Map<String, Boolean> delete(Long id);

    Asistenciax getAsistenciaxById(Long id);

    Asistenciax update(AsistenciaxDto.AsistenciasxCrearDto asistenciax, Long id);
}

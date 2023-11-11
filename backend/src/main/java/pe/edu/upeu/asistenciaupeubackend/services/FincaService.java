package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistenciaupeubackend.dtos.FincaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Finca;

public interface FincaService {
    Finca save(FincaDto.FincaCrearDto finca);

    List<Finca> findAll();

    Map<String, Boolean> delete(Long id);

    Finca getFincaById(Long id);

    Finca update(FincaDto.FincaCrearDto finca, Long id);
}

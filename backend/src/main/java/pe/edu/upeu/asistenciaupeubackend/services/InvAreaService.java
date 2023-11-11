package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistenciaupeubackend.dtos.InvAreaDto;
import pe.edu.upeu.asistenciaupeubackend.models.InvArea;

public interface InvAreaService {
    InvArea save(InvAreaDto.InvAreaCrearDto invArea);

    List<InvArea> findAll();

    Map<String, Boolean> delete(Long id);

    InvArea getInvAreaById(Long id);

    InvArea update(InvAreaDto.InvAreaCrearDto invArea, Long id);
}

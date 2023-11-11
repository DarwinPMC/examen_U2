package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.List;
import java.util.Map;

import pe.edu.upeu.asistenciaupeubackend.dtos.EmpresaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Empresa;

public interface EmpresaService {

    Empresa save(EmpresaDto.EmpresaCrearDto empresa);

    List<Empresa> findAll();

    Map<String, Boolean> delete(Long id);

    Empresa getEmpresaById(Long id);

    Empresa update(EmpresaDto.EmpresaCrearDto empresa, Long id);

}

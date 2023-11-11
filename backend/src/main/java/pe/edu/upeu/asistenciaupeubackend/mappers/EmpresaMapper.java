package pe.edu.upeu.asistenciaupeubackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import pe.edu.upeu.asistenciaupeubackend.dtos.EmpresaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Empresa;

@Mapper(componentModel = "spring")
public interface EmpresaMapper {
    EmpresaDto toEmpresaDto(Empresa empresa);

    // @Mapping(target = "id", ignore = true)
    @Mapping(target = "userId", ignore = true)
    Empresa empresaCrearDtoToEmpresa(EmpresaDto.EmpresaCrearDto empresaCrearDto);
}

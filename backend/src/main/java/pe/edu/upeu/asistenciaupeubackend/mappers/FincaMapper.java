package pe.edu.upeu.asistenciaupeubackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import pe.edu.upeu.asistenciaupeubackend.dtos.FincaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Finca;

@Mapper(componentModel = "spring")
public interface FincaMapper {
    FincaDto toFincaDto(Finca finca);

    // @Mapping(target = "id", ignore = true)
    @Mapping(target = "empresaId", ignore = true)
    Finca fincaCrearDtoToFinca(FincaDto.FincaCrearDto fincaCrearDto);
}

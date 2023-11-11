package pe.edu.upeu.asistenciaupeubackend.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import pe.edu.upeu.asistenciaupeubackend.dtos.InvAreaDto;
import pe.edu.upeu.asistenciaupeubackend.models.InvArea;

@Mapper(componentModel = "spring")
public interface InvAreaMapper {
    InvAreaDto toFincaDto(InvArea invArea);

    // @Mapping(target = "id", ignore = true)
    @Mapping(target = "fincaId", ignore = true)
    InvArea invAreaCrearDtoToinvArea(InvAreaDto.InvAreaCrearDto invAreaCrearDto);
}

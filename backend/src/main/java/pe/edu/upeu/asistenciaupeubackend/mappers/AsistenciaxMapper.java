/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.upeu.asistenciaupeubackend.mappers;


import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import pe.edu.upeu.asistenciaupeubackend.dtos.AsistenciaxDto;
import pe.edu.upeu.asistenciaupeubackend.models.Asistenciax;
/**
 *
 * @author DELL
 */
@Mapper(componentModel = "spring")
public interface AsistenciaxMapper {
    AsistenciaxDto toAsistenciaxDto(Asistenciax entidad);

    //@Mapping(target = "id", ignore = true)
    @Mapping(target = "actividadId", ignore = true)
    Asistenciax asistenciasxCrearDtoToAsistenciax(AsistenciaxDto.AsistenciasxCrearDto entidadCrearDto);    
}

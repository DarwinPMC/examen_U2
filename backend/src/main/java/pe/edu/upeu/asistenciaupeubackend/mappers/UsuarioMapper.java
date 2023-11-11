package pe.edu.upeu.asistenciaupeubackend.mappers;


import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import pe.edu.upeu.asistenciaupeubackend.dtos.UsuarioDto;
import pe.edu.upeu.asistenciaupeubackend.models.Usuario;



@Mapper(componentModel = "spring")
public interface UsuarioMapper {

    UsuarioDto toUserDto(Usuario user);

    @Mapping(target = "password", ignore = true)
    Usuario usuarioCrearDtoToUser(UsuarioDto.UsuarioCrearDto usuarioCrearDto);

}

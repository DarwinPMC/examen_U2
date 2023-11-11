package pe.edu.upeu.asistenciaupeubackend.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.models.Rol;

import java.util.Set; // Corrección en la importación

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UsuarioDto {

    private Long id;
    private String nombres;
    private String apellidos;
    private String password;
    private String correo;
    private String token;
    private String dni;
    private String perfilPrin;
    private String estado;
    private String offlinex;
    private Set<Rol> roles;

    public record UsuarioCrearDto(String nombres, String apellidos, String correo, char[] password, String token,
            String dni, String perfilPrin, String estado, String offlinex, Set<Rol> roles) {
    }

}

package pe.edu.upeu.asistenciaupeubackend.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import pe.edu.upeu.asistenciaupeubackend.models.Usuario;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EmpresaDto {
    Long id;
    String nombre;
    String nombreCorto;
    String direccion;
    String ruc;
    String ubigeo;
    Usuario userId;

    public record EmpresaCrearDto(Long id, String nombre,
            String nombreCorto, String direccion, String ruc, String ubigeo, Long userId) {
    }
}

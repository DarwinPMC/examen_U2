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
public class FincaDto {
    Long id;
    String nombre;
    String nHa;
    String zona;
    String distrito;
    String provincia;
    String departamento;
    String tieneBebedero;
    Usuario empresaId;

    public record FincaCrearDto(Long id, String nombre, String nHa, String zona, String distrito, String provincia,
            String departamento, String tieneBebedero, Long empresaId) {
    }
}

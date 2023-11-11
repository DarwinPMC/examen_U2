package pe.edu.upeu.asistenciaupeubackend.dtos;

import java.time.LocalDate;
import java.time.LocalTime;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import pe.edu.upeu.asistenciaupeubackend.models.Actividad;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AsistenciaxDto {
    Long id;
    @JsonFormat(pattern = "yyyy-MM-dd")
    LocalDate fecha;
    @JsonFormat(pattern = "HH:mm:ss")
    LocalTime horaReg;
    String latituda;
    String longituda;
    String tipo;
    int calificacion;
    String cui;
    String tipoCui;
    String entsal;
    Long subactasisId;
    String offlinex;
    @JsonIgnoreProperties({ "asistenciaxs", "inscritos", "subactasisxs", "materialesxs" })
    Actividad actividadId;

    public record AsistenciasxCrearDto(Long id, LocalDate fecha, LocalTime horaReg, String latituda,
            String longituda, String tipo, int calificacion, String cui, String tipoCui, String entsal, 
            Long subactasisId, String offlinex, Long actividadId) {
    }
}

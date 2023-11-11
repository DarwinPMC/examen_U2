package pe.edu.upeu.asistenciaupeubackend.dtos;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.models.Finca;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class InvAreaDto {
    Long id;
    @JsonFormat(pattern = "yyyy-MM-dd")
    LocalDate fechaMes;
    Double pasturaCultivada;
    Double pasturaNatural;
    Double cultivoForrajero;
    Double cultivoParaLlevar;
    Double totalAreas;
    Finca fincaId;

    public record InvAreaCrearDto(Long id, LocalDate fechaMes, Double pasturaCultivada, Double pasturaNatural,
            Double cultivoForrajero, Double cultivoParaLlevar, Double totalAreas, Long fincaId) {
    }
}

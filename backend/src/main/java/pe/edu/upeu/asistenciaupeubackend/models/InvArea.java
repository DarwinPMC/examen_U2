package pe.edu.upeu.asistenciaupeubackend.models;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "vaca_inventarioArea")
public class InvArea {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Basic(optional = false)
    @Column(name = "fechaMes", nullable = false)
    @Temporal(TemporalType.DATE)
    private LocalDate fechaMes;

    @Column(name = "pasturaCultivada", nullable = false)
    private Double pasturaCultivada;

    @Column(name = "pasturaNatural", nullable = false)
    private Double pasturaNatural;

    @Column(name = "cultivoForrajero", nullable = false)
    private Double cultivoForrajero;

    @Column(name = "cultivoParaLlevar", nullable = false)
    private Double cultivoParaLlevar;

    @Column(name = "totalAreas", nullable = false)
    private Double totalAreas;

    @JoinColumn(name = "finca_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Finca fincaId;
}

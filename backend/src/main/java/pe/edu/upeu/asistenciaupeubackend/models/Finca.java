package pe.edu.upeu.asistenciaupeubackend.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name = "vaca_finca")
public class Finca {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "nHa", nullable = false)
    private String nHa;

    @Column(name = "zona", nullable = false)
    private String zona;

    @Column(name = "distrito", nullable = false)
    private String distrito;

    @Column(name = "provincia", nullable = false)
    private String provincia;

    @Column(name = "departamento", nullable = false)
    private String departamento;

    @Column(name = "tieneBebedero", length = 2, nullable = false)
    private String tieneBebedero;

    @JoinColumn(name = "empresa_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Empresa empresaId;
}

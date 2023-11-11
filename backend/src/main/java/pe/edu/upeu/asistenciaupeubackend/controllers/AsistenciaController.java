package pe.edu.upeu.asistenciaupeubackend.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import pe.edu.upeu.asistenciaupeubackend.dtos.AsistenciaxDto;
import pe.edu.upeu.asistenciaupeubackend.models.Asistenciax;
import pe.edu.upeu.asistenciaupeubackend.services.AsistenciaXService;

/**
 *
 * @author DELL
 */
@RestController
@RequestMapping("/asis/asistenciaX")
public class AsistenciaController {
    @Autowired
    private AsistenciaXService asistenciaXService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ResponseEntity<List<Asistenciax>> listActividad() {
        List<Asistenciax> actDto = asistenciaXService.findAll();
        return ResponseEntity.ok(actDto);
    }

    @PostMapping("/crear")
    public ResponseEntity<Asistenciax> createActividad(@RequestBody AsistenciaxDto.AsistenciasxCrearDto actividad) {
        Asistenciax data = asistenciaXService.save(actividad);
        return ResponseEntity.ok(data);
    }

    @GetMapping("/buscar/{id}")
    public ResponseEntity<Asistenciax> getActividadById(@PathVariable Long id) {
        Asistenciax actividad = asistenciaXService.getAsistenciaxById(id);
        return ResponseEntity.ok(actividad);
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteActividad(@PathVariable("id") Long id) {
        Asistenciax actividad = asistenciaXService.getAsistenciaxById(id);
        return ResponseEntity.ok(asistenciaXService.delete(actividad.getId()));
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<Asistenciax> updateActividad(@PathVariable("id") Long id,
            @RequestBody AsistenciaxDto.AsistenciasxCrearDto asistenciaxDetails) {
        Asistenciax updatedAsistenciax = asistenciaXService.update(asistenciaxDetails, id);
        return ResponseEntity.ok(updatedAsistenciax);
    }
}

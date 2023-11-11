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

import pe.edu.upeu.asistenciaupeubackend.dtos.FincaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Finca;
import pe.edu.upeu.asistenciaupeubackend.services.FincaService;

@RestController
@RequestMapping("/api/finca")
public class FincaController {
    @Autowired
    private FincaService fincaService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ResponseEntity<List<Finca>> listFinca() {
        List<Finca> fincaDto = fincaService.findAll();
        return ResponseEntity.ok(fincaDto);
    }

    @PostMapping("/crear")
    public ResponseEntity<Finca> createFinca(@RequestBody FincaDto.FincaCrearDto finca) {
        Finca data = fincaService.save(finca);
        return ResponseEntity.ok(data);
    }

    @GetMapping("/buscar/{id}")
    public ResponseEntity<Finca> getFincaById(@PathVariable Long id) {
        Finca finca = fincaService.getFincaById(id);
        return ResponseEntity.ok(finca);
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteFinca(@PathVariable("id") Long id) {
        Finca finca = fincaService.getFincaById(id);
        return ResponseEntity.ok(fincaService.delete(finca.getId()));
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<Finca> updateFinca(@PathVariable("id") Long id,
            @RequestBody FincaDto.FincaCrearDto finca) {
        Finca updated = fincaService.update(finca, id);
        return ResponseEntity.ok(updated);
    }
}

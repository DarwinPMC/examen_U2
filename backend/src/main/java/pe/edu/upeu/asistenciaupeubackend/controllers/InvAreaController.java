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

import pe.edu.upeu.asistenciaupeubackend.dtos.InvAreaDto;
import pe.edu.upeu.asistenciaupeubackend.models.InvArea;
import pe.edu.upeu.asistenciaupeubackend.services.InvAreaService;

@RestController
@RequestMapping("/api/invArea")
public class InvAreaController {
    @Autowired
    private InvAreaService invAreaService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ResponseEntity<List<InvArea>> listInvArea() {
        List<InvArea> invAreaDto = invAreaService.findAll();
        return ResponseEntity.ok(invAreaDto);
    }

    @PostMapping("/crear")
    public ResponseEntity<InvArea> createInvArea(@RequestBody InvAreaDto.InvAreaCrearDto finca) {
        InvArea data = invAreaService.save(finca);
        return ResponseEntity.ok(data);
    }

    @GetMapping("/buscar/{id}")
    public ResponseEntity<InvArea> getInvAreaById(@PathVariable Long id) {
        InvArea invArea = invAreaService.getInvAreaById(id);
        return ResponseEntity.ok(invArea);
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteFinca(@PathVariable("id") Long id) {
        InvArea invArea = invAreaService.getInvAreaById(id);
        return ResponseEntity.ok(invAreaService.delete(invArea.getId()));
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<InvArea> updateFinca(@PathVariable("id") Long id,
            @RequestBody InvAreaDto.InvAreaCrearDto invArea) {
        InvArea updated = invAreaService.update(invArea, id);
        return ResponseEntity.ok(updated);
    }
}

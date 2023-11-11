/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.upeu.asistenciaupeubackend.controllers;

//import com.google.gson.Gson;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
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

import pe.edu.upeu.asistenciaupeubackend.dtos.EmpresaDto;
import pe.edu.upeu.asistenciaupeubackend.models.Empresa;
import pe.edu.upeu.asistenciaupeubackend.services.EmpresaService;

/**
 *
 * @author DELL
 */
@RestController
@RequestMapping("/api/empresa")
public class EmpresaController {

    @Autowired
    private EmpresaService empresaService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ResponseEntity<List<Empresa>> listEmpresa() {
        List<Empresa> empresaDto = empresaService.findAll();
        return ResponseEntity.ok(empresaDto);
    }

    @PostMapping("/crear")
    public ResponseEntity<Empresa> createEmpresa(@RequestBody EmpresaDto.EmpresaCrearDto empresa) {
        Empresa data = empresaService.save(empresa);
        return ResponseEntity.ok(data);
    }

    @GetMapping("/buscar/{id}")
    public ResponseEntity<Empresa> getEmpresaById(@PathVariable Long id) {
        Empresa empresa = empresaService.getEmpresaById(id);
        return ResponseEntity.ok(empresa);
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteEmpresa(@PathVariable("id") Long id) {
        Empresa empresa = empresaService.getEmpresaById(id);
        return ResponseEntity.ok(empresaService.delete(empresa.getId()));
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<Empresa> updateEmpresa(@PathVariable("id") Long id,
            @RequestBody EmpresaDto.EmpresaCrearDto empresa) {
        Empresa updated = empresaService.update(empresa, id);
        return ResponseEntity.ok(updated);
    }
}

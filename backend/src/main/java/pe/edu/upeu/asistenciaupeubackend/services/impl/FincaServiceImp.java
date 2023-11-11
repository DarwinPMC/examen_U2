package pe.edu.upeu.asistenciaupeubackend.services.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

import pe.edu.upeu.asistenciaupeubackend.dtos.FincaDto;
import pe.edu.upeu.asistenciaupeubackend.exceptions.AppException;
import pe.edu.upeu.asistenciaupeubackend.exceptions.ResourceNotFoundException;
import pe.edu.upeu.asistenciaupeubackend.mappers.FincaMapper;
import pe.edu.upeu.asistenciaupeubackend.models.Finca;
import pe.edu.upeu.asistenciaupeubackend.repositories.FincaRepository;
import pe.edu.upeu.asistenciaupeubackend.services.EmpresaService;
import pe.edu.upeu.asistenciaupeubackend.services.FincaService;

@RequiredArgsConstructor
@Service
@Transactional
public class FincaServiceImp implements FincaService {
    @Autowired
    private FincaRepository fincaRepo;

    @Autowired
    private EmpresaService empresaService;

    private final FincaMapper fincaMapper;

    @Override
    public Finca save(FincaDto.FincaCrearDto finca) {

        Finca matEnt = fincaMapper.fincaCrearDtoToFinca(finca);
        matEnt.setEmpresaId(empresaService.getEmpresaById(finca.empresaId()));
        try {
            return fincaRepo.save(matEnt);
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<Finca> findAll() {
        try {
            return fincaRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Finca finca = fincaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Finca not exist with id :" + id));

        fincaRepo.delete(finca);
        Map<String, Boolean> response = new HashMap<>();
        response.put("Eliminado : ", true);

        return response;
    }

    @Override
    public Finca getFincaById(Long id) {
        Finca findFinca = fincaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Finca not exist with id :" + id));
        return findFinca;
    }

    @Override
    public Finca update(FincaDto.FincaCrearDto finca, Long id) {

        Finca fincaX = fincaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Finca not exist with id :" + id));

        fincaX.setNombre(finca.nombre());
        fincaX.setNHa(finca.nHa());
        fincaX.setProvincia(finca.provincia());
        fincaX.setDepartamento(finca.departamento());
        fincaX.setDistrito(finca.distrito());
        fincaX.setZona(finca.zona());
        fincaX.setTieneBebedero(finca.tieneBebedero());
        fincaX.setEmpresaId(empresaService.getEmpresaById(finca.empresaId()));

        return fincaRepo.save(fincaX);
    }
}

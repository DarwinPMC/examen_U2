package pe.edu.upeu.asistenciaupeubackend.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.dtos.AsistenciaxDto;
import pe.edu.upeu.asistenciaupeubackend.exceptions.AppException;
import pe.edu.upeu.asistenciaupeubackend.exceptions.ResourceNotFoundException;
import pe.edu.upeu.asistenciaupeubackend.mappers.AsistenciaxMapper;
import pe.edu.upeu.asistenciaupeubackend.models.Asistenciax;
import pe.edu.upeu.asistenciaupeubackend.repositories.AsistenciaxRepository;

/**
 *
 * @author DELL
 */

@RequiredArgsConstructor
@Service
@Transactional
public class AsistenciaXServiceImp implements AsistenciaXService {
    @Autowired
    private AsistenciaxRepository asistenciaXRepo;

    @Autowired
    private ActividadService actividadService;

    private final AsistenciaxMapper asistenciaxMapper;

    @Override
    public Asistenciax save(AsistenciaxDto.AsistenciasxCrearDto asistenciax) {

        Asistenciax matEnt = asistenciaxMapper.asistenciasxCrearDtoToAsistenciax(asistenciax);
        matEnt.setActividadId(actividadService.getActividadById(asistenciax.actividadId()));
        System.out.println(asistenciax.fecha());
        System.out.println(asistenciax.horaReg());
        try {
            return asistenciaXRepo.save(matEnt);
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<Asistenciax> findAll() {
        try {
            return asistenciaXRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Asistenciax asistenciax = asistenciaXRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Asistencia not exist with id :" + id));

        asistenciaXRepo.delete(asistenciax);
        Map<String, Boolean> response = new HashMap<>();
        response.put("deleted", true);

        return response;
    }

    @Override
    public Asistenciax getAsistenciaxById(Long id) {
        Asistenciax findAsistencia = asistenciaXRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Asistencia not exist with id :" + id));
        return findAsistencia;
    }

    @Override
    public Asistenciax update(AsistenciaxDto.AsistenciasxCrearDto asistenciax, Long id) {

        Asistenciax asistenciaxx = asistenciaXRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Periodo not exist with id :" + id));
        asistenciaxx.setFecha(asistenciax.fecha());
        asistenciaxx.setHoraReg(asistenciax.horaReg());
        if (asistenciax.latituda() != null) {
            asistenciaxx.setLatituda(asistenciax.latituda());
        }

        if (asistenciax.longituda() != null) {
            asistenciaxx.setLongituda(asistenciax.longituda());
        }
        asistenciaxx.setTipo(asistenciax.tipo());
        asistenciaxx.setCalificacion(asistenciax.calificacion());
        asistenciaxx.setCui(asistenciax.cui());
        asistenciaxx.setTipoCui(asistenciax.tipoCui());
        asistenciaxx.setEntsal(asistenciax.entsal());
        asistenciaxx.setSubactasisId(asistenciax.subactasisId());
        asistenciaxx.setOfflinex(asistenciax.offlinex());
        asistenciaxx.setActividadId(actividadService.getActividadById(asistenciax.actividadId()));

        return asistenciaXRepo.save(asistenciaxx);
    }
}

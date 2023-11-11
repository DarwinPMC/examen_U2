package pe.edu.upeu.asistenciaupeubackend.services.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import pe.edu.upeu.asistenciaupeubackend.dtos.InvAreaDto;
import pe.edu.upeu.asistenciaupeubackend.exceptions.AppException;
import pe.edu.upeu.asistenciaupeubackend.exceptions.ResourceNotFoundException;
import pe.edu.upeu.asistenciaupeubackend.mappers.InvAreaMapper;
import pe.edu.upeu.asistenciaupeubackend.models.InvArea;
import pe.edu.upeu.asistenciaupeubackend.repositories.InvAreaRepository;
import pe.edu.upeu.asistenciaupeubackend.services.FincaService;
import pe.edu.upeu.asistenciaupeubackend.services.InvAreaService;

@RequiredArgsConstructor
@Service
@Transactional
public class InvAreaServiceImp implements InvAreaService {
    @Autowired
    private InvAreaRepository invAreaRepo;

    @Autowired
    private FincaService fincaService;

    private final InvAreaMapper invAreaMapper;

    @Override
    public InvArea save(InvAreaDto.InvAreaCrearDto invArea) {

        InvArea matEnt = invAreaMapper.invAreaCrearDtoToinvArea(invArea);
        matEnt.setFincaId(fincaService.getFincaById(invArea.fincaId()));
        try {
            return invAreaRepo.save(matEnt);
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public List<InvArea> findAll() {
        try {
            return invAreaRepo.findAll();
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        InvArea invArea = invAreaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("InvArea not exist with id :" + id));

        invAreaRepo.delete(invArea);
        Map<String, Boolean> response = new HashMap<>();
        response.put("Eliminado : ", true);

        return response;
    }

    @Override
    public InvArea getInvAreaById(Long id) {
        InvArea findInvArea = invAreaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("InvArea not exist with id :" + id));
        return findInvArea;
    }

    @Override
    public InvArea update(InvAreaDto.InvAreaCrearDto invArea, Long id) {

        InvArea invAreaX = invAreaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("InvArea not exist with id :" + id));

        invAreaX.setFechaMes(invArea.fechaMes());
        invAreaX.setCultivoForrajero(invArea.cultivoForrajero());
        invAreaX.setCultivoParaLlevar(invArea.cultivoParaLlevar());
        invAreaX.setPasturaCultivada(invArea.pasturaCultivada());
        invAreaX.setPasturaNatural(invArea.pasturaNatural());
        invAreaX.setTotalAreas(invArea.totalAreas());
        invAreaX.setFincaId(fincaService.getFincaById(invArea.fincaId()));

        return invAreaRepo.save(invAreaX);
    }
}

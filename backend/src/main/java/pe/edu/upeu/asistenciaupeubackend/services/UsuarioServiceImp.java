package pe.edu.upeu.asistenciaupeubackend.services;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.CharBuffer;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import pe.edu.upeu.asistenciaupeubackend.dtos.CredencialDto;
import pe.edu.upeu.asistenciaupeubackend.dtos.CredencialesDto;
import pe.edu.upeu.asistenciaupeubackend.dtos.UsuarioDto;
import pe.edu.upeu.asistenciaupeubackend.exceptions.AppException;
import pe.edu.upeu.asistenciaupeubackend.exceptions.ResourceNotFoundException;
import pe.edu.upeu.asistenciaupeubackend.mappers.UsuarioMapper;
import pe.edu.upeu.asistenciaupeubackend.models.Rol;
import pe.edu.upeu.asistenciaupeubackend.models.Usuario;
import pe.edu.upeu.asistenciaupeubackend.repositories.UsuarioRepository;

@RequiredArgsConstructor
@Service
@Transactional
public class UsuarioServiceImp implements UsuarioService {

    @Autowired
    private UsuarioRepository userRepository;;

    @Autowired
    private RolService rolService;

    private final PasswordEncoder passwordEncoder;

    private final UsuarioMapper userMapper;

    @Override
    public List<Usuario> findAll() {
        try {
            return userRepository.findAll();
        } catch (Exception e) {
            throw new AppException("Error-" + e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @Override
    public String getContrasenaByCorreo(String correo) {
        Usuario userByCorreo = userRepository.findByCorreo(correo)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado con correo: " + correo));
        return userByCorreo.getPassword();
    }

    @Override
    public Usuario getUsuarioById(Long id) {
        Usuario findUsuario = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User not exist with id :" + id));
        return findUsuario;
    }

    @Override
    public UsuarioDto login(CredencialesDto credentialsDto) {
        Usuario user = userRepository.findByCorreo(credentialsDto.correo())
                .orElseThrow(() -> new AppException("Usuario desconocido", HttpStatus.NOT_FOUND));

        if (passwordEncoder.matches(CharBuffer.wrap(credentialsDto.password()), user.getPassword())) {
            return userMapper.toUserDto(user);
        }

        throw new AppException("Contraseña inválida", HttpStatus.BAD_REQUEST);
    }

    @Override
    public UsuarioDto loginByCorreo(CredencialDto correo) {
        Usuario user = userRepository.findByCorreo(correo.correo())
                .orElseThrow(() -> new AppException("Usuario desconocido", HttpStatus.NOT_FOUND));
        return userMapper.toUserDto(user);
    }

    @Override
    public Usuario update(UsuarioDto.UsuarioCrearDto userUpdate, Long id) {

        Usuario user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no existe con el ID: " + id));

        user.setNombres(userUpdate.nombres());
        user.setApellidos(userUpdate.apellidos());
        user.setCorreo(userUpdate.correo());
        user.setPassword(userUpdate.password().toString());
        user.setPassword(passwordEncoder.encode(CharBuffer.wrap(userUpdate.password())));
        user.setDni(userUpdate.dni());
        user.setPerfilPrin(userUpdate.perfilPrin());
        user.setEstado(userUpdate.estado());
        user.setOfflinex(userUpdate.offlinex());
        user.setRoles(userUpdate.roles());

        return userRepository.save(user);
    }

    @Override
    public UsuarioDto register(UsuarioDto.UsuarioCrearDto userDto) {
        Optional<Usuario> optionalUser = userRepository.findByCorreo(userDto.correo());

        if (optionalUser.isPresent()) {
            throw new AppException("Nombre de Usuario ya existe", HttpStatus.BAD_REQUEST);
        }

        Usuario user = userMapper.usuarioCrearDtoToUser(userDto);
        user.setPassword(passwordEncoder.encode(CharBuffer.wrap(userDto.password())));
        System.out.println("Llego.................");
        System.out.println(userDto.token());

        Set<Rol> roles = new HashSet<>();

        if (userDto.token().equals("admin")) {
            roles.add(rolService.getByRolNombre(Rol.RolNombre.ROLE_ADMIN).get());
        } else {
            roles.add(rolService.getByRolNombre(Rol.RolNombre.ROLE_USER).get());
        }

        user.setRoles(roles);

        Usuario savedUser = userRepository.save(user);

        return userMapper.toUserDto(savedUser);
    }

    @Override
    public UsuarioDto findByLogin(String correo) {
        Usuario user = userRepository.findByCorreo(correo)
                .orElseThrow(() -> new AppException("Usuario desconocido", HttpStatus.NOT_FOUND));
        return userMapper.toUserDto(user);
    }

    @Override
    public Map<String, Boolean> delete(Long id) {
        Usuario asistenciax = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Asistencia not exist with id :" + id));

        userRepository.delete(asistenciax);
        Map<String, Boolean> response = new HashMap<>();
        response.put("Eliminado", true);

        return response;
    }

}

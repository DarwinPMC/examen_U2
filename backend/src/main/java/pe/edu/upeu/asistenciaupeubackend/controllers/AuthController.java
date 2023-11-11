package pe.edu.upeu.asistenciaupeubackend.controllers;

import jakarta.servlet.http.HttpServletRequest;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.net.URI;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;

import pe.edu.upeu.asistenciaupeubackend.configuration.UserAuthenticationProvider;
import pe.edu.upeu.asistenciaupeubackend.dtos.CredencialDto;
import pe.edu.upeu.asistenciaupeubackend.dtos.CredencialesDto;
import pe.edu.upeu.asistenciaupeubackend.dtos.UsuarioDto;
import pe.edu.upeu.asistenciaupeubackend.models.Usuario;
import pe.edu.upeu.asistenciaupeubackend.services.UsuarioService;

@RequiredArgsConstructor
@RestController
@RequestMapping("/asis")
public class AuthController {

    private final UsuarioService userService;
    private final UserAuthenticationProvider userAuthenticationProvider;

    @GetMapping("/buscar/{id}")
    public ResponseEntity<Usuario> getActividadById(@PathVariable Long id) {
        Usuario userById = userService.getUsuarioById(id);
        return ResponseEntity.ok(userById);
    }

    @GetMapping("/buscarPorCorreo/{correo}")
    public ResponseEntity<String> getContrasenaByCorreo(@PathVariable String correo) {
        String contrasena = userService.getContrasenaByCorreo(correo);
        if (contrasena != null) {
            return ResponseEntity.ok(contrasena);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/list")
    public ResponseEntity<List<Usuario>> listActividad() {
        List<Usuario> actDto = userService.findAll();
        return ResponseEntity.ok(actDto);
    }

    @PostMapping("/login")
    public ResponseEntity<UsuarioDto> login(@RequestBody @Valid CredencialesDto credentialsDto,
            HttpServletRequest request) {
        UsuarioDto userDto = userService.login(credentialsDto);
        userDto.setToken(userAuthenticationProvider.createToken(userDto));
        request.getSession().setAttribute("USER_SESSION", userDto.getCorreo());
        return ResponseEntity.ok(userDto);
    }

    @PreAuthorize("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
    @PostMapping("/loginByCorreo")
    public ResponseEntity<UsuarioDto> loginByCorreo(@RequestBody @Valid CredencialDto correo,
            HttpServletRequest request) {
        try {
            UsuarioDto userDto = userService.loginByCorreo(correo);
            if (userDto != null) {
                userDto.setToken(userAuthenticationProvider.createToken(userDto));
                request.getSession().setAttribute("USER_SESSION", userDto.getCorreo());
                return ResponseEntity.ok(userDto);
            } else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PostMapping("/register")
    public ResponseEntity<UsuarioDto> register(@RequestBody @Valid UsuarioDto.UsuarioCrearDto user) {
        System.out.println("Passss...." + user.token());
        UsuarioDto createdUser = userService.register(user);
        createdUser.setToken(userAuthenticationProvider.createToken(createdUser));
        return ResponseEntity.created(URI.create("/users/" + createdUser.getId())).body(createdUser);
    }

    @PutMapping("/editar/{id}")
    public ResponseEntity<Usuario> update(@PathVariable("id") Long id,
            @RequestBody UsuarioDto.UsuarioCrearDto asistenciaxDetails) {
        Usuario updatedAsistenciax = userService.update(asistenciaxDetails, id);
        return ResponseEntity.ok(updatedAsistenciax);
    }

    @PostMapping("/logout")
    public ResponseEntity<String> logout(@RequestHeader("Authorization") String authorizationHeader) {
        String token = authorizationHeader.substring("Bearer ".length());
        userAuthenticationProvider.logout(token);
        return ResponseEntity.ok("Logout exitoso");
    }

    @DeleteMapping("/eliminar/{id}")
    public ResponseEntity<String> eliminarUsuario(@PathVariable Long id) {
        userService.delete(id);
        return ResponseEntity.ok("Usuario eliminado exitosamente");
    }

}

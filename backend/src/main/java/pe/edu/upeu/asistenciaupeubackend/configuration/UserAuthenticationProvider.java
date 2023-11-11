package pe.edu.upeu.asistenciaupeubackend.configuration;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import pe.edu.upeu.asistenciaupeubackend.dtos.UsuarioDto;
import pe.edu.upeu.asistenciaupeubackend.services.UsuarioService;

@RequiredArgsConstructor
@Component
public class UserAuthenticationProvider {

    @Value("${security.jwt.token.secret-key:secret-key}")
    private String secretKey;

    private final UsuarioService userService;
    private final TokenStore tokenStore;

    @PostConstruct
    protected void init() {
        // this is to avoid having the raw secret key available in the JVM
        secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
    }

    public String createToken(UsuarioDto user) {
        Date now = new Date();
        Date validity = new Date(now.getTime() + 3600000); // 1 hour

        Algorithm algorithm = Algorithm.HMAC256(secretKey);
        return JWT.create()
                .withIssuer(user.getCorreo())
                .withIssuedAt(now)
                .withExpiresAt(validity)
                .withClaim("nombres", user.getNombres())
                .withClaim("apellidos", user.getApellidos())
                .sign(algorithm);
    }

    public Authentication validateToken(String token) {

        if (tokenStore.isTokenInvalid(token)) {
            throw new TokenInvalidException("Token inválido"); // Define esta excepción según tus necesidades
        }

        Algorithm algorithm = Algorithm.HMAC256(secretKey);

        JWTVerifier verifier = JWT.require(algorithm)
                .build();

        DecodedJWT decoded = verifier.verify(token);

        UsuarioDto user = UsuarioDto.builder()
                .correo(decoded.getIssuer())
                .nombres(decoded.getClaim("nombres").asString())
                .apellidos(decoded.getClaim("apellidos").asString())
                .build();

        return new UsernamePasswordAuthenticationToken(user, null, Collections.emptyList());
    }

    public Authentication validateTokenStrongly(String token) {
        Algorithm algorithm = Algorithm.HMAC256(secretKey);

        JWTVerifier verifier = JWT.require(algorithm)
                .build();

        DecodedJWT decoded = verifier.verify(token);

        UsuarioDto user = userService.findByLogin(decoded.getIssuer());

        return new UsernamePasswordAuthenticationToken(user, null, Collections.emptyList());
    }

    public void logout(String token) {
        // Invalida el token llamando a tokenStore.invalidateToken(token)
        tokenStore.invalidateToken(token);
        System.out.println("Token invalidado y agregado a la lista de tokens inválidos: " + token);
    }

    public class TokenInvalidException extends RuntimeException {
        public TokenInvalidException(String message) {
            super(message);
        }
    }

}

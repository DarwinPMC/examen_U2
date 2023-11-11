package pe.edu.upeu.asistenciaupeubackend.configuration;

import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

@Component
public class TokenStore {
    private Set<String> invalidTokens = new HashSet<>();

    public boolean isTokenInvalid(String token) {
        return invalidTokens.contains(token);
    }

    public void invalidateToken(String token) {
        invalidTokens.add(token);
    }
}


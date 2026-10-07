package mx.com.psicologia.www;


import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author Ing.Fco.Gaz
 */
public class PruebaBCrypt {
     public static void main(String[] args) {

        String password = "CEBSA";

        String hash = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
        );

        System.out.println("HASH GENERADO:");
        System.out.println(hash);

        boolean correcta = BCrypt.checkpw(
                password,
                hash
        );

        System.out.println(
                "CONTRASENA CORRECTA: " + correcta
        );
    }
    
}

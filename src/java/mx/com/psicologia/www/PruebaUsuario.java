package mx.com.psicologia.www;

/**
 *
 * @author Ing.Fco.Gaz
 */
public class PruebaUsuario {

    public static void main(String[] args) {

        Usuario usuario = new Usuario(
                "admin",
                "admin123",
                "Administrador",
                "ADMIN"
        );

        UsuarioDAO dao = new UsuarioDAO();

        boolean resultado = dao.insertar(usuario);

        if (resultado) {

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "USUARIO CREADO CORRECTAMENTE"
            );

            System.out.println(
                    "Usuario: admin"
            );

            System.out.println(
                    "Rol: ADMIN"
            );

            System.out.println(
                    "================================="
            );

        } else {

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "ERROR AL CREAR EL USUARIO"
            );

            System.out.println(
                    "================================="
            );
        }
    }

}

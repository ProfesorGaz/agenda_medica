
package mx.com.psicologia.www;

import java.sql.Connection;

/**
 *
 * @author Ing.Fco.Gaz
 */
public class PruebaConexion {

    public static void main(String[] args) {

        Connection conexion = Conexion.conectar();

        if (conexion != null) {

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "CONEXION EXITOSA"
            );

            System.out.println(
                    "Base de datos: agenda_medica"
            );

            System.out.println(
                    "================================="
            );

            try {

                conexion.close();

            } catch (Exception e) {

                e.printStackTrace();
            }

        } else {

            System.out.println(
                    "================================="
            );

            System.out.println(
                    "ERROR DE CONEXIÓN"
            );

            System.out.println(
                    "================================="
            );
        }
    }
}

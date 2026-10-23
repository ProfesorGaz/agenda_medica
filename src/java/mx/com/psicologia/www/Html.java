package mx.com.psicologia.www;

/**
 * Utilidad para mostrar texto de la base de datos dentro de HTML
 * sin que el navegador lo interprete como código (evita XSS).
 */
public class Html {

    public static String esc(String texto) {

        if (texto == null) {
            return "";
        }

        StringBuilder sb = new StringBuilder(texto.length() + 16);

        for (char c : texto.toCharArray()) {
            switch (c) {
                case '&':
                    sb.append("&amp;");
                    break;
                case '<':
                    sb.append("&lt;");
                    break;
                case '>':
                    sb.append("&gt;");
                    break;
                case '"':
                    sb.append("&quot;");
                    break;
                case '\'':
                    sb.append("&#39;");
                    break;
                default:
                    sb.append(c);
            }
        }

        return sb.toString();
    }
}

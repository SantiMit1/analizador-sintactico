package servicios;

import lexico.Lexico;
import parser.Parser;
import tabla.Tabla;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.List;

public class Compilador {
    private Lexico lexico;
    private Parser parser;

    public void compilar(File archivo) throws Exception {
        if (archivo == null || !archivo.exists()) {
            throw new FileNotFoundException("No se encontró el archivo a compilar.");
        }
        lexico = new Lexico(new FileReader(archivo));
        parser = new Parser(lexico);
        parser.parse();
        
        Tabla tabla = Tabla.getInstancia();
        tabla.crearArchivo();
    }

    public List<String> getRespuestaLexico() {
        if (lexico != null) {
            return lexico.getRespuesta();
        }
        return null;
    }

    public List<String> getReglasParser() {
        if (parser != null) {
            return parser.getReglasAplicadas();
        }
        return null;
    }
}

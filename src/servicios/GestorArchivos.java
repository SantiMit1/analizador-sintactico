package servicios;

import javax.swing.*;
import java.io.*;

public class GestorArchivos {
    private File archivo;

    public File getArchivo() {
        return archivo;
    }

    public void setArchivo(File archivo) {
        this.archivo = archivo;
    }

    public void guardarArchivo(String contenido) {
        if (archivo != null) {
            try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
                bw.write(contenido);
                JOptionPane.showMessageDialog(null, "Archivo guardado correctamente.");
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(null, "Error al guardar el archivo");
            }
        } else {
            try {
                archivo = new File("./archivo.txt");

                try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
                    bw.write(contenido);
                    JOptionPane.showMessageDialog(null, "Archivo guardado correctamente en:\n" + archivo.getAbsolutePath());
                }

            } catch (IOException ex) {
                JOptionPane.showMessageDialog(null, "Error al guardar el archivo: " + ex.getMessage());
            }
        }
    }

    public String cargarArchivo() {
        JFileChooser fileChooser = new JFileChooser("./");
        int opcion = fileChooser.showOpenDialog(null);
        if (opcion == JFileChooser.APPROVE_OPTION) {
            archivo = fileChooser.getSelectedFile();
            StringBuilder contenido = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new FileReader(archivo))) {
                String linea;
                while ((linea = br.readLine()) != null) {
                    contenido.append(linea).append("\n");
                }
                return contenido.toString();
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(null, "Error al leer el archivo");
            }
        }
        return null;
    }
}

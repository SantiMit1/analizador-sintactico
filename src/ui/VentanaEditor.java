package ui;

import servicios.Compilador;
import servicios.GestorArchivos;

import javax.swing.*;
import java.awt.*;

public class VentanaEditor {
    private JFrame frame;
    private JTextArea editorTexto;
    private final GestorArchivos gestorArchivos;
    private final Compilador compilador;

    public VentanaEditor(GestorArchivos gestorArchivos) {
        this.gestorArchivos = gestorArchivos;
        this.compilador = new Compilador();
    }

    public void mostrar() {
        editorTexto = new JTextArea();
        editorTexto.setText("");
        editorTexto.setFont(new Font("Monospaced", Font.PLAIN, 12));
        JScrollPane panelScrolleable = new JScrollPane(editorTexto);

        JPanel contBotones = new JPanel(new BorderLayout());
        JButton guardar = new JButton("Guardar cambios");
        JButton compilar = new JButton("Compilar");
        JButton salir = new JButton("Salir");
        contBotones.add(guardar, BorderLayout.WEST);
        contBotones.add(compilar, BorderLayout.CENTER);
        contBotones.add(salir, BorderLayout.EAST);

        frame = new JFrame("Editor de texto");
        frame.setLocationRelativeTo(null);
        frame.setSize(800, 600);
        frame.add(panelScrolleable, BorderLayout.CENTER);
        frame.add(contBotones, BorderLayout.SOUTH);

        compilar.addActionListener(e -> {
            gestorArchivos.guardarArchivo(editorTexto.getText());
            try {
                compilador.compilar(gestorArchivos.getArchivo());
                
                VentanaRespuesta ventanaRespuesta = new VentanaRespuesta();
                ventanaRespuesta.mostrar(compilador.getRespuestaLexico());
                
                VentanaTabla ventanaTabla = new VentanaTabla();
                ventanaTabla.mostrar();
                
                VentanaParser ventanaParser = new VentanaParser();
                ventanaParser.mostrar(compilador.getReglasParser());
            } catch (Exception ex) {
                JOptionPane.showMessageDialog(null, "Error al compilar: " + ex.getMessage());
            }
        });

        guardar.addActionListener(e -> gestorArchivos.guardarArchivo(editorTexto.getText()));

        salir.addActionListener(e -> frame.dispose());

        frame.setVisible(true);
    }

    public void cargarContenido(String contenido) {
        if (contenido != null && editorTexto != null) {
            editorTexto.append(contenido);
        }
    }

    public void cerrar() {
        if (frame != null) {
            frame.dispose();
        }
    }

    public JFrame getFrame() {
        return frame;
    }
}

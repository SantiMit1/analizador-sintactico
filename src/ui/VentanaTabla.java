package ui;

import tabla.Tabla;

import javax.swing.*;
import java.awt.*;

public class VentanaTabla {
    private JFrame frame;
    private JTextArea editorTextoTabla;

    public void mostrar() {
        Tabla tabla = Tabla.getInstancia();
        tabla.crearArchivo();

        editorTextoTabla = new JTextArea();
        editorTextoTabla.setEditable(false);
        editorTextoTabla.setText(tabla.toString());
        editorTextoTabla.setFont(new Font("Monospaced", Font.PLAIN, 12));

        JScrollPane panelScrolleable = new JScrollPane(editorTextoTabla);
        JButton salir = new JButton("Salir");

        frame = new JFrame("Tabla de simbolos");
        frame.setLayout(new BorderLayout());
        frame.add(panelScrolleable, BorderLayout.CENTER);
        frame.add(salir, BorderLayout.SOUTH);
        frame.setSize(800, 600);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);

        salir.addActionListener(e -> frame.dispose());
    }

    public void cerrar() {
        if (frame != null) {
            frame.dispose();
        }
    }
}

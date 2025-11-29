package ui;

import javax.swing.*;
import java.awt.*;
import java.util.List;

public class VentanaRespuesta {
    private JFrame frame;
    private JTextArea editorTextoRespuesta;

    public void mostrar(List<String> respuesta) {
        frame = new JFrame("Tokens");
        frame.setSize(800, 600);
        frame.setLocationRelativeTo(null);

        JPanel contRespuesta = new JPanel(new BorderLayout());
        
        editorTextoRespuesta = new JTextArea();
        editorTextoRespuesta.setEditable(false);
        editorTextoRespuesta.setFont(new Font("Monospaced", Font.PLAIN, 12));

        if (respuesta != null) {
            for (String linea : respuesta) {
                editorTextoRespuesta.append(linea + "\n");
            }
        }

        contRespuesta.add(editorTextoRespuesta, BorderLayout.CENTER);

        JScrollPane panelScrolleable = new JScrollPane(contRespuesta);

        JButton salir = new JButton("Salir");
        salir.addActionListener(e -> frame.dispose());

        frame.add(panelScrolleable, BorderLayout.CENTER);
        frame.add(salir, BorderLayout.SOUTH);
        frame.setVisible(true);
    }

    public void cerrar() {
        if (frame != null) {
            frame.dispose();
        }
    }
}

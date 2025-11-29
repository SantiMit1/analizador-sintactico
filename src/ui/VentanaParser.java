package ui;

import javax.swing.*;
import java.awt.*;
import java.util.List;

public class VentanaParser {
    private JFrame frame;
    private JTextArea editorTextoParser;

    public void mostrar(List<String> reglasAplicadas) {
        frame = new JFrame("Reglas");
        frame.setSize(800, 600);
        frame.setLocationRelativeTo(null);

        JPanel contParser = new JPanel(new BorderLayout());

        editorTextoParser = new JTextArea();
        editorTextoParser.setEditable(false);
        editorTextoParser.setFont(new Font("Monospaced", Font.PLAIN, 12));

        if (reglasAplicadas != null) {
            for (String linea : reglasAplicadas) {
                editorTextoParser.append(linea + "\n");
            }
        }

        contParser.add(editorTextoParser);

        JScrollPane panelScrolleable = new JScrollPane(contParser);

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

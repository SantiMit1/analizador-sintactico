package ui;

import servicios.GestorArchivos;

import javax.swing.*;
import java.awt.*;

public class VentanaPrincipal {
    private JFrame frame;
    private final GestorArchivos gestorArchivos;

    public VentanaPrincipal() {
        this.gestorArchivos = new GestorArchivos();
    }

    public void mostrar() {
        frame = new JFrame("TP 1 - Teoria de la computación");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(450, 300);

        JPanel contPrincipal = new JPanel();
        contPrincipal.setLayout(new BorderLayout());

        JPanel contTitulo = new JPanel(new BorderLayout());
        JLabel titulo = new JLabel("TRABAJO PRACTICO N1 - TEORIA DE LA COMPUTACIÓN");
        titulo.setHorizontalAlignment(SwingConstants.CENTER);
        contTitulo.add(titulo, BorderLayout.CENTER);

        JButton crear = new JButton("Crear Archivo nuevo");
        JButton cargar = new JButton("Cargar Archivo");

        JPanel contBotones = new JPanel(new BorderLayout());
        contBotones.add(crear, BorderLayout.WEST);
        contBotones.add(cargar, BorderLayout.EAST);

        contPrincipal.add(contTitulo, BorderLayout.NORTH);
        contPrincipal.add(contBotones, BorderLayout.SOUTH);

        JScrollPane panelScrolleable = new JScrollPane(contPrincipal);
        frame.add(panelScrolleable);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);

        crear.addActionListener(e -> {
            VentanaEditor ventanaEditor = new VentanaEditor(gestorArchivos);
            ventanaEditor.mostrar();
        });

        cargar.addActionListener(e -> {
            VentanaEditor ventanaEditor = new VentanaEditor(gestorArchivos);
            ventanaEditor.mostrar();
            String contenido = gestorArchivos.cargarArchivo();
            ventanaEditor.cargarContenido(contenido);
        });
    }

    public void cerrar() {
        if (frame != null) {
            frame.dispose();
        }
    }
}

# Analizador Sintáctico

Analizador léxico y sintáctico para un lenguaje de programación personalizado, desarrollado como trabajo práctico de Teoría de la Computación.

## 📋 Descripción

Este proyecto implementa un compilador completo que incluye:
- **Análisis Léxico**: Tokenización del código fuente usando JFlex
- **Análisis Sintáctico**: Parsing y validación de la gramática usando Java CUP
- **Tabla de Símbolos**: Gestión de variables y constantes
- **Interfaz Gráfica**: GUI desarrollada en Java Swing para facilitar el uso

## 🚀 Características

- ✅ Reconocimiento de tokens (palabras reservadas, identificadores, constantes)
- ✅ Validación sintáctica según gramática definida
- ✅ Tabla de símbolos con información de tipos y valores
- ✅ Manejo de tipos de datos: INT, FLOAT, STRING
- ✅ Estructuras de control: IF-ELSE, REPEAT-UNTIL
- ✅ Operaciones aritméticas y lógicas
- ✅ Función MAP para operaciones sobre listas
- ✅ Interfaz gráfica intuitiva

## 🛠️ Requisitos

- Java JDK 8 o superior
- JFlex 1.9.1 (incluido en `jflex-full-1.9.1.jar`)
- Java CUP 11b (incluido en `java-cup-11b.jar` y `java-cup-11b-runtime.jar`)

## 📦 Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/SantiMit1/analizador-sintactico.git
cd analizador-sintactico
```

2. Asegurarse de tener Java instalado:
```bash
java -version
```

## 🔧 Compilación

### Generar el analizador léxico:
```bash
java -jar jflex-full-1.9.1.jar src/lexico/Lexico.flex
```

### Generar el parser:
```bash
java -jar java-cup-11b.jar -parser Parser -symbols sym src/parser/Parser.cup
```

### Compilar el proyecto:
```bash
javac -cp ".:java-cup-11b-runtime.jar" src/**/*.java src/*.java
```

## ▶️ Ejecución

```bash
java -cp ".:java-cup-11b-runtime.jar:src" Main
```

Esto abrirá la interfaz gráfica donde podrás:
1. **Crear un archivo nuevo**: Escribir código desde cero
2. **Cargar un archivo**: Abrir archivos de ejemplo como `archivo.txt` o `prueba.txt`

## 📝 Sintaxis del Lenguaje

### Estructura básica:
```
DECVAR
    nombre_variable : TIPO
ENDDECVAR

PROGRAM.SECTION
    // sentencias
ENDPROGRAM.SECTION
```

### Tipos de datos:
- `INT`: Números enteros
- `FLOAT`: Números decimales
- `STRING`: Cadenas de texto

### Ejemplo de programa:
```
DECVAR 
    var1 : INT
    var2 : INT
    var3 : STRING
ENDDECVAR

PROGRAM.SECTION 
    var1 := 1 + 2
    var3 := "Hola mundo"
    var2 := MAP ( + 15 , [ var1, 2 ] )
    IF ( var1 == var2 ) { SHOW var3 }
    REPEAT { var1 := var1 + 1 } UNTIL ( var1 < var2 )
ENDPROGRAM.SECTION
```

### Palabras reservadas:
- Declaración: `DECVAR`, `ENDDECVAR`
- Programa: `PROGRAM.SECTION`, `ENDPROGRAM.SECTION`
- Control: `IF`, `ELSE`, `REPEAT`, `UNTIL`
- Tipos: `INT`, `FLOAT`, `STRING`
- Operaciones: `SHOW`, `MAP`

### Operadores:
- Aritméticos: `+`, `-`, `*`, `/`
- Comparación: `<`, `<=`, `>`, `>=`, `==`, `!=`
- Lógicos: `AND`, `OR`
- Asignación: `:=`

### Constantes:
- Enteros: `123`
- Hexadecimales: `0h1F` o `0H1f`
- Flotantes: `123.45`, `.5`, `1.`
- Cadenas: `"texto entre comillas"`

## 📁 Estructura del Proyecto

```
analizador-sintactico/
├── src/
│   ├── Main.java                 # Punto de entrada
│   ├── lexico/
│   │   ├── Lexico.flex          # Especificación léxica (JFlex)
│   │   └── Lexico.java          # Analizador léxico generado
│   ├── parser/
│   │   ├── Parser.cup           # Especificación sintáctica (CUP)
│   │   ├── Parser.java          # Parser generado
│   │   └── sym.java             # Símbolos del parser
│   ├── tabla/
│   │   ├── Tabla.java           # Tabla de símbolos
│   │   └── Fila.java            # Entrada de la tabla
│   ├── servicios/
│   │   ├── Compilador.java      # Lógica de compilación
│   │   └── GestorArchivos.java  # Manejo de archivos
│   └── ui/
│       ├── VentanaPrincipal.java   # Ventana principal
│       ├── VentanaEditor.java      # Editor de código
│       ├── VentanaParser.java      # Resultados del parsing
│       ├── VentanaTabla.java       # Visualización de tabla
│       └── VentanaRespuesta.java   # Respuestas del léxico
├── archivo.txt                  # Archivo de ejemplo 1
├── prueba.txt                   # Archivo de ejemplo 2
├── ts.txt                       # Salida de tabla de símbolos
├── jflex-full-1.9.1.jar        # Librería JFlex
├── java-cup-11b.jar            # Librería Java CUP
└── java-cup-11b-runtime.jar    # Runtime de Java CUP
```

## 🧪 Archivos de Prueba

El proyecto incluye archivos de ejemplo para probar el analizador:

- **archivo.txt**: Ejemplo básico con declaración de variables y asignación
- **prueba.txt**: Ejemplo completo con todas las características del lenguaje

## 🔍 Tabla de Símbolos

El analizador genera una tabla de símbolos (`ts.txt`) que contiene:
- Nombre del identificador o constante
- Token asociado
- Tipo de dato (para variables)
- Valor (para constantes)
- Longitud (para strings)

## 🎓 Contexto Académico

Este proyecto fue desarrollado como **Trabajo Práctico N°1** para la materia **Teoría de la Computación**.

## 👥 Autor

- Santiago Mitilieri ([@SantiMit1](https://github.com/SantiMit1))

## 📄 Licencia

Este proyecto es de código abierto y está disponible con fines educativos.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request para sugerencias y mejoras.

---

**Nota**: Este es un proyecto académico con fines educativos para el aprendizaje de compiladores y teoría de la computación.

package lexico;
import java_cup.runtime.*;
import java.util.*;
import lexico.tabla.Fila;
import lexico.tabla.Tabla;

%%

%cup
%public
%class Lexico
%line
%column
%char

%{
    private int commentLevel = 0;

    private List<String> respuesta = new ArrayList<>();
    public List<String> getRespuesta() { return respuesta; }

    private Tabla tabla = new Tabla();
    public String stringTabla() { return tabla.toString(); }
    public void crearArchivoTabla() { tabla.crearArchivo(); }

    private Symbol s(int type) {
        return new Symbol(type, yyline, yycolumn, yytext());
    }
    private Symbol s(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

%state COMMENT

ESPACIO       = [ \t\f\n\r\n]+
LETRA         = [a-zA-Z]
DIGITO        = [0-9]
CONST_INT     = {DIGITO}+
CONST_FLOAT   = ({DIGITO}+ "." {DIGITO}* | {DIGITO}* "." {DIGITO}+)
CONST_HEX     = "0"[hH]({DIGITO}|[a-fA-F])+
CONST_STRING  = \"([^\"\n])*\"
ID            = {LETRA}({LETRA}|{DIGITO}|_)*

%%

<YYINITIAL> {

"INT" {
    respuesta.add("Token INT encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.INT);
}
"FLOAT" {
    respuesta.add("Token FLOAT encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.FLOAT);
}
"STRING" {
    respuesta.add("Token STRING encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.STRING);
}

"DECVAR" {
    respuesta.add("Token DECVAR encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.DECVAR);
}
"ENDDECVAR" {
    respuesta.add("Token ENDDECVAR encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.ENDDECVAR);
}

"PROGRAM\\.SECTION" {
    respuesta.add("Token PROGRAM_SECTION encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.PROGRAM_SECTION);
}
"ENDPROGRAM\\.SECTION" {
    respuesta.add("Token ENDPROGRAM_SECTION encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.ENDPROGRAM_SECTION);
}

"SHOW" {
    respuesta.add("Token SHOW encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.SHOW);
}
"MAP" {
    respuesta.add("Token MAP encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.MAP);
}
"REPEAT" {
    respuesta.add("Token REPEAT encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.REPEAT);
}
"UNTIL" {
    respuesta.add("Token UNTIL encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.UNTIL);
}

"IF" {
    respuesta.add("Token IF encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.IF);
}
"ELSE" {
    respuesta.add("Token ELSE encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.ELSE);
}
"NOT" {
    respuesta.add("Token NOT encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.NOT);
}

":=" {
    respuesta.add("Token ASSIGN encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.ASSIGN);
}
"+" {
    respuesta.add("Token PLUS encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.PLUS);
}
"-" {
    respuesta.add("Token MINUS encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.MINUS);
}
"*" {
    respuesta.add("Token MULT encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.MULT);
}
"/" {
    respuesta.add("Token DIV encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.DIV);
}

"<=" {
    respuesta.add("Token LESS_EQUAL encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.LESS_EQUAL);
}
"<" {
    respuesta.add("Token LESS encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.LESS);
}
">=" {
    respuesta.add("Token GREATER_EQUAL encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.GREATER_EQUAL);
}
">" {
    respuesta.add("Token GREATER encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.GREATER);
}

"==" {
    respuesta.add("Token EQUAL encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.EQUAL);
}
"!=" {
    respuesta.add("Token NOT_EQUAL encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.NOT_EQUAL);
}

"&&" {
    respuesta.add("Token AND encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.AND);
}
"||" {
    respuesta.add("Token OR encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.OR);
}

":" {
    respuesta.add("Token COLON encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.COLON);
}
";" {
    respuesta.add("Token SEMICOLON encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.SEMICOLON);
}
"," {
    respuesta.add("Token COMMA encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.COMMA);
}
"(" {
    respuesta.add("Token LPAREN encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.LPAREN);
}
")" {
    respuesta.add("Token RPAREN encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.RPAREN);
}
"[" {
    respuesta.add("Token LBRACKET encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.LBRACKET);
}
"]" {
    respuesta.add("Token RBRACKET encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.RBRACKET);
}
"{" {
    respuesta.add("Token LBRACE encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.LBRACE);
}
"}" {
    respuesta.add("Token RBRACE encontrado: " + yytext() + " en la linea " + yyline);
    return s(sym.RBRACE);
}

"$*" {
    respuesta.add("Inicio comentario anidado en la linea " + yyline);
    commentLevel = 1;
    yybegin(COMMENT);
}

{ID} {
    respuesta.add("Token ID encontrado: " + yytext() + " en la linea " + yyline);
    tabla.agregarFila(new Fila(yytext(), "ID", null, null, null));
    return s(sym.ID, yytext());
}

}

{CONST_INT} {
    try {
        long valor = Long.parseLong(yytext());
        if (valor < -32768 || valor > 32767) {
            respuesta.add("CONST_INT fuera de rango 16 bits: " + yytext() + " en la linea " + yyline);
        } else {
            respuesta.add("Token CONST_INT encontrado: " + yytext() + " en la linea " + yyline);
        }
        tabla.agregarFila(new Fila("_" + yytext(), "CONST_INT", null, yytext(), null));
        return s(sym.CONST_INT, yytext());
    } catch (Exception e) {
        respuesta.add("CONST_INT inválido: " + yytext() + " en la linea " + yyline);
        return s(sym.CONST_INT);
    }
}

{CONST_FLOAT} {
    respuesta.add("Token CONST_FLOAT encontrado: " + yytext() + " en la linea " + yyline);
    tabla.agregarFila(new Fila("_" + yytext(), "CONST_FLOAT", null, yytext(), null));
    return s(sym.CONST_FLOAT, yytext());
}

{CONST_HEX} {
    respuesta.add("Token CONST_HEX encontrado: " + yytext() + " en la linea " + yyline);
    String lexema = yytext().substring(2);
    int valor = Integer.parseInt(lexema, 16);
    tabla.agregarFila(new Fila(yytext(), "CONST_HEX", null, String.valueOf(valor), null));
    return s(sym.CONST_HEX, yytext());
}

{CONST_STRING} {
    respuesta.add("Token CONST_STRING encontrado: " + yytext() + " en la linea " + yyline);
    int len = yytext().length() - 2;
    String nombre = "_" + yytext().substring(1, yytext().length()-1).replace(' ', '_');

    tabla.agregarFila(new Fila(nombre, "CONST_STRING", null, yytext(), len));
    return s(sym.CONST_STRING, yytext());
}

{ESPACIO}   {}

<COMMENT> {

"$*"    { commentLevel++; }

"*$"    {
            commentLevel--;
            if (commentLevel == 0) yybegin(YYINITIAL);
        }

[^]     { /* ignorar */ }

}

[^] {
    respuesta.add("Caracter no permitido <" + yytext() + "> en la linea " + yyline);
}


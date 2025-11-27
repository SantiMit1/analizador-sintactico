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

"INT"                   { respuesta.add("INT " + yytext()); return s(sym.INT); }
"FLOAT"                 { respuesta.add("FLOAT " + yytext()); return s(sym.FLOAT); }
"STRING"                { respuesta.add("STRING " + yytext()); return s(sym.STRING); }

"DECVAR"                { return s(sym.DECVAR); }
"ENDDECVAR"             { return s(sym.ENDDECVAR); }

"PROGRAM\\.SECTION"     { return s(sym.PROGRAM_SECTION); }
"ENDPROGRAM\\.SECTION"  { return s(sym.ENDPROGRAM_SECTION); }

"SHOW"                  { return s(sym.SHOW); }
"MAP"                   { return s(sym.MAP); }
"REPEAT"                { return s(sym.REPEAT); }
"UNTIL"                 { return s(sym.UNTIL); }

"IF"                    { return s(sym.IF); }
"ELSE"                  { return s(sym.ELSE); }
"NOT"                   { return s(sym.NOT); }

":="                    { return s(sym.ASSIGN); }
"+"                     { return s(sym.PLUS); }
"-"                     { return s(sym.MINUS); }
"*"                     { return s(sym.MULT); }
"/"                     { return s(sym.DIV); }

"<="                    { return s(sym.LESS_EQUAL); }
"<"                     { return s(sym.LESS); }
">="                    { return s(sym.GREATER_EQUAL); }
">"                     { return s(sym.GREATER); }

"=="                    { return s(sym.EQUAL); }
"!="                    { return s(sym.NOT_EQUAL); }

"&&"                    { return s(sym.AND); }
"||"                    { return s(sym.OR); }

":"                     { return s(sym.COLON); }
";"                     { return s(sym.SEMICOLON); }
","                     { return s(sym.COMMA); }
"("                     { return s(sym.LPAREN); }
")"                     { return s(sym.RPAREN); }
"["                     { return s(sym.LBRACKET); }
"]"                     { return s(sym.RBRACKET); }
"{"                     { return s(sym.LBRACE); }
"}"                     { return s(sym.RBRACE); }

"$*"                    { commentLevel = 1; yybegin(COMMENT); }

{ID} {
    tabla.agregarFila(new Fila(yytext(), "ID", null, null, null));
    return s(sym.ID, yytext());
}

}

{CONST_INT} {
    try {
        long valor = Long.parseLong(yytext());
        if (valor < -32768 || valor > 32767) {
            respuesta.add("CONST_INT fuera de rango: " + yytext());
        }
        tabla.agregarFila(new Fila("_" + yytext(), "CONST_INT", null, yytext(), null));
        return s(sym.CONST_INT, yytext());
    } catch (Exception e) {
        respuesta.add("CONST_INT inválido: " + yytext());
        return s(sym.CONST_INT);
    }
}

{CONST_FLOAT} {
    tabla.agregarFila(new Fila("_" + yytext(), "CONST_FLOAT", null, yytext(), null));
    return s(sym.CONST_FLOAT, yytext());
}

{CONST_HEX} {
    String lexema = yytext().substring(2);
    int valor = Integer.parseInt(lexema, 16);
    tabla.agregarFila(new Fila(yytext(), "CONST_HEX", null, String.valueOf(valor), null));
    return s(sym.CONST_HEX, yytext());
}

{CONST_STRING} {
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

[^] { respuesta.add("Caracter no permitido <" + yytext() + ">"); }
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
        public List<String> getRespuesta() {
            return respuesta;
        }

        private Tabla tabla = Tabla.getInstancia();
        public String stringTabla() {
            return tabla.toString();
        }
        public void crearArchivoTabla() {
            tabla.crearArchivo();
        }
%}

%state COMMENT

ESPACIO     = [ \t\f\n\r\n]+
LETRA       = [a-zA-Z]
DIGITO      = [0-9]
CONST_INT   = {DIGITO}+
CONST_FLOAT = ({DIGITO}+ "." {DIGITO}* | {DIGITO}* "." {DIGITO}+)
CONST_HEX   = "0"[hH]({DIGITO}|[a-fA-F])+
CONST_STRING = \"([^\"\n])*\"
ID          = {LETRA}({LETRA}|{DIGITO}|_)*

%%

<YYINITIAL> {

"INT"               {respuesta.add("Token INT encontrado, Lexema " + yytext()); return new Symbol(sym.INT, yytext());}
"FLOAT"             {respuesta.add("Token FLOAT encontrado, Lexema " + yytext()); return new Symbol(sym.FLOAT, yytext());}
"UNTIL"             {respuesta.add("Token UNTIL encontrado, Lexema " + yytext()); return new Symbol(sym.UNTIL, yytext());}

"REPEAT"            {respuesta.add("Token REPEAT encontrado, Lexema " + yytext()); return new Symbol(sym.REPEAT, yytext());}
"IF"                {respuesta.add("Token IF encontrado, Lexema " + yytext()); return new Symbol(sym.IF, yytext());}
"ELSE"              {respuesta.add("Token ELSE encontrado, Lexema " + yytext()); return new Symbol(sym.ELSE, yytext());}
"DECVAR"            {respuesta.add("Token DECVAR encontrado, Lexema " + yytext()); return new Symbol(sym.DECVAR, yytext());}
"ENDDECVAR"         {respuesta.add("Token ENDDECVAR encontrado, Lexema " + yytext()); return new Symbol(sym.ENDDECVAR, yytext());}
"ENDPROGRAM\.SECTION" {respuesta.add("Token ENDPROGRAM_SECTION encontrado, Lexema " + yytext()); return new Symbol(sym.ENDPROGRAM_SECTION, yytext());}
"PROGRAM\.SECTION"    {respuesta.add("Token PROGRAM_SECTION encontrado, Lexema " + yytext()); return new Symbol(sym.PROGRAM_SECTION, yytext());}
"SHOW"              {respuesta.add("Token SHOW encontrado, Lexema " + yytext()); return new Symbol(sym.SHOW, yytext());}
"STRING"            {respuesta.add("Token STRING encontrado, Lexema " + yytext()); return new Symbol(sym.STRING, yytext());}
"MAP"               {respuesta.add("Token MAP encontrado, Lexema " + yytext()); return new Symbol(sym.MAP, yytext());}

":="                {respuesta.add("Token ASSIGN encontrado, Lexema " + yytext()); return new Symbol(sym.ASSIGN, yytext());}
"+"                 {respuesta.add("Token PLUS encontrado, Lexema " + yytext()); return new Symbol(sym.PLUS, yytext());}
"-"                 {respuesta.add("Token MINUS encontrado, Lexema " + yytext()); return new Symbol(sym.MINUS, yytext());}
"*"                 {respuesta.add("Token MULT encontrado, Lexema " + yytext()); return new Symbol(sym.MULT, yytext());}
"/"                 {respuesta.add("Token DIV encontrado, Lexema " + yytext()); return new Symbol(sym.DIV, yytext());}
"<"                 {respuesta.add("Token LESS encontrado, Lexema " + yytext()); return new Symbol(sym.LESS, yytext());}
"<="                {respuesta.add("Token LESS_EQUAL encontrado, Lexema " + yytext()); return new Symbol(sym.LESS_EQUAL, yytext());}
">"                 {respuesta.add("Token GREATER encontrado, Lexema " + yytext()); return new Symbol(sym.GREATER, yytext());}
">="                {respuesta.add("Token GREATER_EQUAL encontrado, Lexema " + yytext()); return new Symbol(sym.GREATER_EQUAL, yytext());}
"=="                {respuesta.add("Token EQUAL encontrado, Lexema " + yytext()); return new Symbol(sym.EQUAL, yytext());}
"!="                {respuesta.add("Token NOT_EQUAL encontrado, Lexema " + yytext()); return new Symbol(sym.NOT_EQUAL, yytext());}
"&&"                {respuesta.add("Token AND encontrado, Lexema " + yytext()); return new Symbol(sym.AND, yytext());}
"||"                {respuesta.add("Token OR encontrado, Lexema " + yytext()); return new Symbol(sym.OR, yytext());}

":"                 {respuesta.add("Token COLON encontrado, Lexema " + yytext()); return new Symbol(sym.COLON, yytext());}
";"                 {respuesta.add("Token SEMICOLON encontrado, Lexema " + yytext()); return new Symbol(sym.SEMICOLON, yytext());}
","                 {respuesta.add("Token COMMA encontrado, Lexema " + yytext()); return new Symbol(sym.COMMA, yytext());}
"("                 {respuesta.add("Token LPAREN encontrado, Lexema " + yytext()); return new Symbol(sym.LPAREN, yytext());}
")"                 {respuesta.add("Token RPAREN encontrado, Lexema " + yytext()); return new Symbol(sym.RPAREN, yytext());}
"["                 {respuesta.add("Token LBRACKET encontrado, Lexema " + yytext()); return new Symbol(sym.LBRACKET, yytext());}
"]"                 {respuesta.add("Token RBRACKET encontrado, Lexema " + yytext()); return new Symbol(sym.RBRACKET, yytext());}
"{"                 {respuesta.add("Token LBRACE encontrado, Lexema " + yytext()); return new Symbol(sym.LBRACE, yytext());}
"}"                 {respuesta.add("Token RBRACE encontrado, Lexema " + yytext()); return new Symbol(sym.RBRACE, yytext());}

"$*"                {commentLevel = 1; yybegin(COMMENT);}

{ID}                {
                     tabla.agregarFila(new Fila(yytext(), "ID", null, null, null));
                     respuesta.add("Token ID encontrado, Lexema " + yytext());
                     return new Symbol(sym.ID, yytext());
                   }
      }
{CONST_INT}         {
    try {
        long valor = Long.parseLong(yytext());
        if (valor < -32768 || valor > 32767) {
            respuesta.add("CONST_INT fuera de rango 16 bits: " + yytext() + " en la linea " + yyline);
        } else {
            respuesta.add("Token CONST_INT encontrado, Lexema " + yytext());
            tabla.agregarFila(new Fila("_" + yytext(), "CONST_INT", null, yytext(), null));
            return new Symbol(sym.CONST_INT, yytext());
        }
    } catch (NumberFormatException e) {
        respuesta.add("CONST_INT inválido: " + yytext() + " en la linea " + yyline);
    }
}
{CONST_FLOAT}             {respuesta.add("Token CONST_FLOAT encontrado, Lexema " + yytext());
                           tabla.agregarFila(new Fila("_" + yytext(), "CONST_FLOAT", null, yytext(), null));
                           return new Symbol(sym.CONST_FLOAT, yytext());
      }
{CONST_HEX}               {respuesta.add("Token HEX encontrado, Lexema " + yytext());
                            String lexema = yytext();
                            String hex = lexema.substring(2);
                            int valorDecimal = Integer.parseInt(hex, 16);
                           tabla.agregarFila(new Fila(yytext(), "CONST_HEX", null, String.valueOf(valorDecimal), null));
                            return new Symbol(sym.CONST_HEX, yytext());
      }
{CONST_STRING}            {int largo = yytext().length() - 2;
                           String nombre = "_" + yytext().substring(1, yytext().length() - 1).replace(' ', '_');
                          if (largo > 30) {
                              respuesta.add("CONST_STRING excede el máximo de 30 caracteres: " + yytext() + " en la linea " + yyline);
                          } else {
                              respuesta.add("Token CONST_STRING encontrado, Lexema " + yytext());
                              tabla.agregarFila(new Fila(nombre, "CONST_STRING", null, yytext(), largo));
                                return new Symbol(sym.CONST_STRING, yytext());
                          }
                        }

{ESPACIO}           {/* ignorar */}

<COMMENT> {
"$*"                {
                        commentLevel++;
                        if (commentLevel > 2) {
                            respuesta.add("Comentarios anidados exceden el máximo de 1 nivel en la línea " + yyline);
                        }
                    }

"*$"                {
                        commentLevel--;
                        if (commentLevel == 0) {
                            yybegin(YYINITIAL);
                        }
                    }

[^]                 {/* ignorar cualquier caracter dentro del comentario */}
}

[^]		{ respuesta.add("Caracter no permitido: <" + yytext() + "> en la linea " + yyline); }

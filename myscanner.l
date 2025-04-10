%{
#include "myscanner.h"
%}

%option yylineno

%%

":"                         { return COLON; }
"db_type"                   { return TYPE; }
"db_name"                   { return NAME; }
"db_table_prefix"           { return TABLE_PREFIX; }
"db_port"                   { return PORT; }

[a-zA-Z][_a-zA-Z0-9]*       { return IDENTIFIER; }
[1-9][0-9]*                 { return INTEGER; }

[ \t\n]                     ;  // Ignora espacios, tabulaciones y saltos
.                           { printf("unexpected character\n"); }

%%

int yywrap(void) {
    return 1;
}

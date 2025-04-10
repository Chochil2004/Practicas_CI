%{
#include <stdio.h>

void print_token(const char* type, const char* value) {
    printf("<%s> %s\n", type, value);
}
%}

TAG_OPEN      <[a-zA-Z][a-zA-Z0-9]*(\s+[^>]*)?>
TAG_CLOSE     </[a-zA-Z][a-zA-Z0-9]*>
SELF_CLOSING  <[a-zA-Z][a-zA-Z0-9]*(\s+[^>]*)?/>

ATTR_NAME     [a-zA-Z_:][-a-zA-Z0-9_:.]*
ATTR_VALUE    \"[^"]*\"|\'[^\']*\'

ENTITY        &[a-zA-Z]+;

TEXT          [^<>&\n]+

%%

{TAG_OPEN}         { print_token("TAG_OPEN", yytext); }
{TAG_CLOSE}        { print_token("TAG_CLOSE", yytext); }
{SELF_CLOSING}     { print_token("SELF_CLOSING_TAG", yytext); }

{ATTR_NAME}        { print_token("ATTR_NAME", yytext); }
{ATTR_VALUE}       { print_token("ATTR_VALUE", yytext); }

{ENTITY}           { print_token("ENTITY", yytext); }

{TEXT}             { print_token("TEXT", yytext); }

\n|\t|[ ]+         ;  // Ignorar espacios y saltos de línea

.                  { printf("<UNKNOWN> %s\n", yytext); }

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}


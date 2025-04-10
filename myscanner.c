#include <stdio.h>
#include "myscanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;
extern FILE *yyin;

char *names[] = {NULL, "db_type", "db_name", "db_table_prefix", "db_port"};

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *archivo = fopen(argv[1], "r");
        if (!archivo) {
            perror("No se pudo abrir el archivo");
            return 1;
        }
        yyin = archivo;
    }

    int ntoken, vtoken;
    ntoken = yylex();

    while (ntoken) {
        printf("Token: %s (%d)\n", yytext, ntoken);
        
        if (yylex() != COLON) {
            printf("Syntax error in line %d, Expected a ':' but found %s\n", yylineno, yytext);
            return 1;
        }
        
        vtoken = yylex();
        switch (ntoken) {
            case TYPE:
            case NAME:
            case TABLE_PREFIX:
                if (vtoken != IDENTIFIER) {
                    printf("Syntax error in line %d, Expected an IDENTIFIER but found %s\n", yylineno, yytext);
                    return 1;
                }
                printf("%s is set to %s\n", names[ntoken], yytext);
                break;

            case PORT:
                if (vtoken != INTEGER) {
                    printf("Syntax error in line %d, Expected an INTEGER but found %s\n", yylineno, yytext);
                    return 1;
                }
                printf("%s is set to %s\n", names[ntoken], yytext);
                break;

            default:
                printf("Syntax error in line %d\n", yylineno);
        }

        ntoken = yylex();
    }

    return 0;
}

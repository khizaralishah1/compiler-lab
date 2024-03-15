%{
#include <stdio.h>
#include <string.h>
%}
%option noyywrap

%%
"|"                  { printf("Token: PIPE\n"); }
":-"                 { printf("Token: ASSIGN\n"); }
"Name:-"            { printf("Token: NAME_LABEL\n"); }
"Reg_Number:-"      { printf("Token: REG_LABEL\n"); }
"Deptt:-"           { printf("Token: DEPT_LABEL\n"); }
[ \t]               ;  // Ignore whitespaces and tabs
[0-9]+              { printf("Token: INTEGER, Value: %s\n", yytext); }
[a-zA-Z][a-zA-Z0-9_]* { printf("Token: IDENTIFIER, Value: %s\n", yytext); }
[-:a-zA-Z0-9]+      { printf("Token: INVALID, Value: %s\n", yytext); }
\n                  { printf("Token: NEWLINE\n"); }
.                   { printf("Token: INVALID CHARACTER: %s\n", yytext); }
%%

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    yyin = input_file;

    yylex();

    fclose(input_file);

    return 0;
}

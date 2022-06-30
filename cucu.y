
%{
#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#define fp fprintf

extern FILE *yyin,*yyout;
extern char *yytext;
FILE *out;
void yyerror(char *s) {fp(out,"ERROR\n");}
int yylex();

%}

%union{
int nums;
char *st;
}

%token<st> IDS IF ELSE WHILE  ASSIGN  OP DAST LS RS LP RP SEM LB RB  DATA RET MAIN DQ STR PRINT SCAN COMMA
%token<nums> NMS

%%

start : start begin
       | begin
       ;

begin :  vdc  
        | fdc 
        | fdf
        | fc | print_s | scan_s
        | If
        | While
        | stmts
        ;

fdf :   DATA IDS LP arguments RP LB bodies RB {fp(out,"Ident-%s\n",$2);}
        | DATA IDS LP  RP LB bodies RB {fp(out,"Ident-%s\n",$2);}
            ; 

fdc : DATA IDS LP arguments RP SEM {fp(out,"Variable- %s ",$1);
          fp(out,"Function Declaration: %s \n",$2);}
          ;
print_s: PRINT LP STR RP SEM | PRINT LP STR COMMA IDS RP SEM | PRINT LP STR COMMA IDS COMMA IDS RP SEM    ;     
scan_s : SCAN LP STR COMMA "&" IDS RP SEM  | SCAN LP STR COMMA "&" IDS COMMA "&" IDS RP SEM;                   
stmts:     IDS ASSIGN expr SEM                      {fp(out,"Variable: %s  ",$1}    
          | IDS LS expr RS ASSIGN expr SEM         {fp(out,"Variable: %s  ",$1);}
           | IDS OP OP  SEM                      {fp(out,"Variable: %s  ",$1);}    
           ;
           
fc :       IDS LP calling RP SEM {fp(out,"Var- %s ",$1);fp(out,"\nFUN ends\nFUN-CALL\n");}
           | IDS LP RP SEM {fp(out,"Var- %s ",$1);fp(out,"\nFUN ends\nFUN-CALL\n");}
           | RET  expr SEM               {fp(out," RET\n");}  
           | RET LP expr RP SEM  {fp(out," RET\n");}
          ;

calling :  expr {fp(out,"FUN-ARG\n");}
          | calling COMMA expr {fp(out,"FUN-ARG\n");}                 
          ;
                     
vdc :    DATA IDS  SEM {fp(out,"local variable %s\n",$2);}
        | DATA IDS ASSIGN NMS SEM {fp(out,":= \nlocal variable: %s\n",$2);}
        | DATA IDS LS expr RS SEM {fp(out,"local variable: %s\n",$2);}
        | DATA IDS LS expr RS ASSIGN expr SEM   {fp(out,":= \nLocal variable- %s  ",$2);}
        | DATA IDS LS expr RS SEM
        ;
                   
bodies :   begin
          | bodies begin
          ;   
        
arguments : DATA IDS {fp(out,"Ident-main\n");fp(out,"function argument: %s\n",$2);}
           | arguments COMMA DATA IDS {fp(out,"function argument: %s\nFunction body\n",$4);}
           ;
               

If:  IF LP expr RP LB bodies RB {fp(out," Ident-if\n");}
         |IF LP expr RP LB bodies RB ELSE LB bodies RB {fp(out,"  Ident-if "); 
         fp(out," Ident-else \n");}
         ;
        
While: WHILE LP expr RP LB bodies RB {fp(out," Ident-While\n");}
       ; 

expr : expr OP expr        
     | LP expr RP 
     | LS expr RS
     | expr COMMA expr
     | IDS expr 
     ;
base : IDS {fp(out,"VAR- %s  ",$1);} 
      | NMS  {fp(out," CONST: %d  ",$1);}
      ;     


%%

int yywrap(void) {
 return 1;
}

int main(int argc[],char *argv[]){
yyin=fopen(argv[1],"r");
yyout=fopen("Lexer.txt","w");
out=fopen("Parser.txt","w");
yyparse();

return 0;
}






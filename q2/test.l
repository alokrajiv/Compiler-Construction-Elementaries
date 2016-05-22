%{
#include <stdio.h>
#define T_DATA_DIRECTIVE 10
#define T_ID 43
#define T_COLON 23
#define T_INT_NUM 42
#define T_WORD_DIRECTIVE 13
#define T_TEXT_DIRECTIVE 19
#define T_GLOBL_DIRECTIVE 20
#define T_LOAD_WORD 29
#define T_STORE_WORD 34
#define T_END_DIRECTIVE 22
#define T_COMMA 26
#define T_REG 41
%}
id  [a-z]+[A-Za-z0-9]*
num [0-9]
spec [ \n\t]+
%%
.data	{printf("token = %d:T_DATA_DIRECTIVE\n",T_DATA_DIRECTIVE);}
.word	{printf("token = %d:T_WORD_DIRECTIVE\n",T_WORD_DIRECTIVE);}
.text	{printf("token = %d:T_TEXT_DIRECTIVE\n",T_TEXT_DIRECTIVE);}
.globl  {printf("token = %d:T_GLOBL_DIRECTIVE\n",T_GLOBL_DIRECTIVE);}
.end    {printf("token = %d:T_GLOBL_DIRECTIVE\n",T_GLOBL_DIRECTIVE);}
lw      {printf("token = %d:T_LOAD_WORD\n",T_LOAD_WORD);}
sw      {printf("token = %d:T_STORE_WORD\n",T_STORE_WORD);}
$t{num} {printf("token = %d:T_REG:reg_no=%d\n",T_REG,regno(yytext));}
{id}	{printf("token = %d:T_ID:%s\n",T_ID,yytext);}
{num}+  {printf("token = %d:T_INT_NUM:%d\n",T_INT_NUM,atoi(yytext));}
:       {printf("token = %d:T_COLON\n",T_COLON);}
,       {printf("token = %d:T_COMMA\n",T_COMMA);}
{spec}  {;}
.	{printf("%s is NOT VALID\n",yytext);}
%%

int regno(char* c){
    return atoi(&c[2])+8;
}
int main(){ 
    yylex(); 
    return 0;
}


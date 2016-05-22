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
#define T_ADD 35
int var_holder[26][1];
int reg_holder[24][1];
typedef struct token { 
    int tok_id;
    union {
        int int_val;
        char* str_val;
    };
} token;
#define YY_DECL token *yylex(void)
token tok;
int parseData();
int parseText();
int parseMain();
int regno(char* c);
%}
id  [a-z]+[A-Za-z0-9]*
num [0-9]
spec [ \n\t]+
%%
.data	{
            printf("token = %d:T_DATA_DIRECTIVE\n",T_DATA_DIRECTIVE);
            parseData();
        }
.word	{
            printf("token = %d:T_WORD_DIRECTIVE\n",T_WORD_DIRECTIVE);
            tok.tok_id = T_WORD_DIRECTIVE;
            tok.str_val = yytext;
            return &tok;
        }
.text	{
            printf("token = %d:T_TEXT_DIRECTIVE\n",T_TEXT_DIRECTIVE);
            tok.tok_id = T_TEXT_DIRECTIVE;
            tok.str_val = yytext;
            return &tok;
        }
.globl  {printf("token = %d:T_GLOBL_DIRECTIVE\n",T_GLOBL_DIRECTIVE);
            tok.tok_id = T_GLOBL_DIRECTIVE;
            tok.str_val = yytext;
            return &tok;
        }
.end    {printf("token = %d:T_GLOBL_DIRECTIVE\n",T_END_DIRECTIVE);
            tok.tok_id = T_END_DIRECTIVE;
            tok.str_val = yytext;
            return &tok;
        }
lw      {printf("token = %d:T_LOAD_WORD\n",T_LOAD_WORD);
            tok.tok_id = T_LOAD_WORD;
            tok.str_val = yytext;
            return &tok;
        }
sw      {printf("token = %d:T_STORE_WORD\n",T_STORE_WORD);
            tok.tok_id = T_STORE_WORD;
            tok.str_val = yytext;
            return &tok;
        }
add      {printf("token = %d:T_ADD_WORD\n",T_ADD);
            tok.tok_id = T_ADD;
            tok.str_val = yytext;
            return &tok;
        }
$t{num} {   
            printf("token = %d:T_REG:reg_no=%d\n",T_REG,regno(yytext));
            tok.tok_id = T_REG;
            tok.int_val = regno(yytext);
            return &tok;
        }
{id}	{
            printf("token = %d:T_ID:%s\n",T_ID,yytext);
            tok.tok_id = T_ID;
            tok.str_val = yytext;
            return &tok;
        }
{num}+  {
            printf("token = %d:T_INT_NUM:%d\n",T_INT_NUM,atoi(yytext));
            tok.tok_id = T_INT_NUM;
            tok.str_val = yytext;
            return &tok;
        }
:       {
            printf("token = %d:T_COLON\n",T_COLON);
            tok.tok_id = T_COLON;
            tok.str_val = yytext;
            return &tok;
        }
,       {printf("token = %d:T_COMMA\n",T_COMMA);
            tok.tok_id = T_COMMA;
            tok.str_val = yytext;
            return &tok;
        }
%%


int parseData(){
    int i = 0;
    while(1){
        token* new_tok = yylex();
        token mytok = *new_tok;
        if(mytok.tok_id == T_TEXT_DIRECTIVE){
           parseText();
        }
        if(mytok.tok_id == T_ID){
            int tmp = (int)(*mytok.str_val - 97);
            do{ 
                new_tok = yylex();
                mytok = *new_tok;
            }while(mytok.tok_id != T_INT_NUM);
            var_holder[tmp][0] = atoi(mytok.str_val);
            // printf("%d :: %d \n",tmp,var_holder[tmp][0]);
        }
    }
    
    return 0;
}
int parseText(){
    token* new_tok;
    token mytok;
    do{ 
        new_tok = yylex();
        mytok = *new_tok;
    }while(mytok.tok_id != T_COLON);
    parseMain();
    printf("PPP");
    return 0;
}
int parseMain(){
    token* new_tok;
    token mytok;
    while(1){
        new_tok = yylex();
        mytok = *new_tok;
        if(mytok.tok_id==T_LOAD_WORD){
             mytok = *yylex();
             int reg_no = mytok.int_val;
             do{
                mytok = *yylex();
            }while(mytok.tok_id != T_ID);
            int tmp = (int)(*mytok.str_val - 97);
            reg_holder[reg_no][0] = var_holder[tmp][0];
            printf("%d :: %d",reg_no,var_holder[tmp][0]);
        }
        if(mytok.tok_id==T_ADD){
             int reg_no[3], i = 0;
             do{
                mytok = *yylex();
                if(mytok.tok_id==T_REG){
                    reg_no[i++] = mytok.int_val;
                }
            }while(i<3);
            reg_holder[reg_no[0]][0] = reg_holder[reg_no[1]][0] + reg_holder[reg_no[2]][0];
            //printf("%d\n asbnnasbvmdhbamshjbx",reg_holder[reg_no[0]][0]);
        }
        if(mytok.tok_id==T_STORE_WORD){
             mytok = *yylex();
             int reg_no = mytok.int_val;
             do{
                mytok = *yylex();
            }while(mytok.tok_id != T_ID);
            int tmp = (int)(*mytok.str_val - 97);
            var_holder[tmp][0] = reg_holder[reg_no][0];
        }
        if(mytok.tok_id==T_END_DIRECTIVE){
            printf("-------------------REGISTERS--------------------------\n");
            int kp;
            for(kp=0;kp<24;kp++){
                printf("Reg No. %d : %d\n",kp, reg_holder[kp][0]);
            }
            printf("-------------------REGISTERS--------------------------\n");
            exit(0);
        }
    }
    
    return 0;
}
int regno(char* c){
    return atoi(&c[2])+8;
}
int main(){
    yylex();
    return 0;
}


%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "syntax_tree.h"

// external functions from lex
extern int yylex();
extern int yyparse();
extern int yyrestart();
extern FILE * yyin;

// external variables from lexical_analyzer module
extern int lines;
extern char * yytext;
extern int pos_end;
extern int pos_start;

// Global syntax tree
syntax_tree *gt;

// Error reporting
void yyerror(const char *s);

// Helper functions written for you with love
syntax_tree_node *node(const char *node_name, int children_num, ...);
%}

/* Complete this definition.
   Hint: See pass_node(), node(), and syntax_tree.h.
         Use forward declaring. */
%union {
     struct _syntax_tree_node * node;
	 char * name;
}

/* Your tokens here. */
%token <node> ERROR
%token <node> ADD
%token <node> SUB
%token <node> MUL
%token <node> DIV
%token <node> LT
%token <node> LTE
%token <node> GT
%token <node> GTE
%token <node> EQ
%token <node> NEQ
%token <node> ASSIGN
%token <node> SEMICOLON
%token <node> COMMA
%token <node> LPARENTHESE
%token <node> RPARENTHESE
%token <node> LBRACKET
%token <node> RBRACKET
%token <node> LBRACE
%token <node> RBRACE
%token <node> ELSE
%token <node> IF
%token <node> INT
%token <node> RETURN
%token <node> VOID
%token <node> WHILE
%token <node> IDENTIFIER
%token <node> INTEGER
%token <node> FLOAT             // 这个token 对应float 关键字
%token <node> FLOATPOINT        // 这个token 对应 浮点数值, 如果分不清的同学可以参考type-specifier的文法和对应产生式规则
//%token <node> EOL
//%token <node> BLANK
//%token <node> COMMENT
%type <node> program declaration-list declaration var-declaration type-specifier fun-declaration params param-list param compound-stmt local-declarations statement-list statement expression-stmt selection-stmt iteration-stmt return-stmt expression var simple-expression relop additive-expression addop term mulop factor integer float call args arg-list

/* compulsory starting symbol */
%start program

%%
/* Your rules here. TA has completed many */

program : 	declaration-list {$$ = node( "program", 1, $1); gt->root = $$;}
		;

declaration-list 	: 	declaration-list declaration {$$ = node( "declaration-list", 2, $1, $2);}
					|	declaration {$$ = node( "declaration-list", 1, $1);}
					;

declaration : 	var-declaration {$$ = node( "declaration", 1, $1);}
			| 	fun-declaration {$$ = node( "declaration", 1, $1);}
			;

var-declaration : 	type-specifier IDENTIFIER SEMICOLON {$$ = node( "var-declaration", 3, $1, $2, $3);}
                | 	type-specifier IDENTIFIER LBRACKET INTEGER RBRACKET SEMICOLON {$$ = node( "var-declaration", 6, $1, $2, $3, $4, $5, $6);}
                ;

type-specifier 	: 	INT {$$ = node( "type-specifier", 1, $1);}
				| 	FLOAT { $$ = node( "type-specifier", 1, $1); }
				| 	VOID {$$ = node( "type-specifier", 1, $1);}
				;

fun-declaration : 	type-specifier IDENTIFIER LPARENTHESE params RPARENTHESE compound-stmt {$$ = node( "fun-declaration", 6, $1, $2, $3, $4, $5, $6);}
				;

params 	: 	param-list {$$ = node( "params", 1, $1);}
		|	VOID {$$ = node( "params", 1, $1);}
		;

param-list 	: 	param-list COMMA param {$$ = node( "param-list", 3, $1, $2, $3);}
			| 	param {$$ = node( "param-list", 1, $1);}
			;

param 	: 	type-specifier IDENTIFIER {$$ = node( "param", 2, $1, $2);}
		| 	type-specifier IDENTIFIER LBRACKET RBRACKET {$$ = node( "param", 4, $1, $2, $3, $4);}
		;

compound-stmt 	: 	LBRACE local-declarations statement-list RBRACE {$$ = node( "compound-stmt", 4, $1, $2, $3, $4);}
				;

local-declarations 	: 	local-declarations var-declaration {$$ = node( "local-declarations", 2, $1, $2);}
| 	{$$ = node( "local-declarations",0);}
					;

statement-list 	: 	statement-list statement {$$ = node( "statement-list", 2, $1, $2);}
| 	{$$ = node( "statement-list",0);}
                    ;
// TODO: phase1. 补充其他的文法产生式逻辑

%%

/// The error reporting function.
void yyerror(const char * s)
{
    // TO STUDENTS: This is just an example.
    // You can customize it as you like.
    fprintf(stderr, "error at line %d column %d: %s\n", lines, pos_start, s);
}

/// Parse input from file `input_path`, and prints the parsing results
/// to stdout.  If input_path is NULL, read from stdin.
///
/// This function initializes essential states before running yyparse().
syntax_tree *parse(const char *input_path)
{
    if (input_path != NULL) {
        if (!(yyin = fopen(input_path, "r"))) {
            fprintf(stderr, "[ERR] Open input file %s failed.\n", input_path);
            exit(1);
        }
    } else {
        yyin = stdin;
    }

    lines = pos_start = pos_end = 1;
    gt = new_syntax_tree();
    yyrestart(yyin);
    yyparse();
    return gt;
}

/// A helper function to quickly construct a tree node.
///
/// e.g. $$ = node("program", 1, $1);
syntax_tree_node *node(const char *name, int children_num, ...)
{
    syntax_tree_node *p = new_syntax_tree_node(name);
    syntax_tree_node *child;
    // 这里表示 epsilon结点是通过 children_num == 0 来判断的
    if (children_num == 0) {
        child = new_syntax_tree_node("epsilon");
        syntax_tree_add_child(p, child);
    } else {
        va_list ap;
        va_start(ap, children_num);
        for (int i = 0; i < children_num; ++i) {
            child = va_arg(ap, syntax_tree_node *);
            syntax_tree_add_child(p, child);
        }
        va_end(ap);
    }
    return p;
}

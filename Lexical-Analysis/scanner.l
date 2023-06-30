/* Title: Scanner.l 								*/
/* Description: Flex input file for scanner 	*/

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		\-\-.*\n
comment2	\/\/.*\n
line		[\n]
id		[A-Za-z]([0-9A-Za-z])*(_[0-9A-Za-z]+)*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
real_literal	[0-9]+\.[0-9]*(e|E(\+|\-)?[0-9]+)?
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{comment2}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"=>"	{ ECHO; return(ARROW); }
"<"		{ ECHO; return(RELOP); }
"="		{ ECHO; return(RELOP); }
"/="	{ ECHO; return(RELOP); }
">"		{ ECHO; return(RELOP); }
">="	{ ECHO; return(RELOP); }
"<="	{ ECHO; return(RELOP); }
"+"		{ ECHO; return(ADDOP); }
"-"		{ ECHO; return(ADDOP); }
"*"		{ ECHO; return(MULOP); }
"/"		{ ECHO; return(MULOP); }
"**"	{ ECHO; return(EXPOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return(REDUCE); }
returns		{ ECHO; return(RETURNS); }
rem 	{ ECHO; return(REMOP);}
and		{ ECHO; return(ANDOP); }
or 		{ ECHO; return(OROP); }
not		{ ECHO; return(NOTOP); }
case	{ ECHO; return(CASE); }
else	{ ECHO; return(ELSE); }
endcase	{ ECHO; return(ENDCASE); }
endif	{ ECHO; return(ENDIF); }
if		{ ECHO; return(IF); }
others	{ ECHO; return(OTHERS); }
real	{ ECHO; return(REAL); }
then	{ ECHO; return(THEN); }
when	{ ECHO; return(WHEN); }
true	{ ECHO; return(BOOL_LITERAL); }
false	{ ECHO; return(BOOL_LITERAL); }
{real_literal}	{ECHO; return(REAL_LITERAL); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%

/* Primary scanner action */
int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token)
	{
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}	// End of main()

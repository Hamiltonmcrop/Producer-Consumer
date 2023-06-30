/**
* Title: Listing.h - Project 1
* Description: Header file used for listing.cc
*/

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
void lastLine();
void appendError(ErrorCategories errorCategory, string message);

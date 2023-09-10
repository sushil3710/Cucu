# Cucu: Custom Language Compiler

This project involves the development of a custom programming language along with its compiler. The compiler is divided into two main components: the lexical analyzer and the parser. Each component serves a specific purpose in processing the code written in the custom language.

## Lexical Analyzer
The lexical analyzer is responsible for breaking down the source code into a sequence of tokens. These tokens represent the smallest units of the code, such as keywords, identifiers, operators, and literals. The lexical analyzer identifies various tokens based on a set of predefined rules.

## Parser
The parser processes the tokens generated by the lexical analyzer and builds a syntactic structure known as an Abstract Syntax Tree (AST). The AST represents the hierarchical structure of the code, making it easier to analyze and interpret.

### Usage
To compile and run the lexical analyzer, follow these steps:

**Execute the lexical analyzer with an input file:**
./lexer input_code.txt
The output will be generated in the lex_output.txt file.

**Generate the parser code using the provided Bison file:**
bison -d cucu.y

**Compile the parser code along with the lexer:**
gcc -o parser lex.yy.c cucu.tab.c -lfl

**Execute the parser with an input file:**
./parser input_code.txt

The output will be generated in the Parser.txt file.

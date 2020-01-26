grammar Resource;

file: (statement | NL)* EOF;
statement: section | property | LINE_COMMENT;
section: BRACKET_LEFT (section_id | property)+ BRACKET_RIGHT;
property: key EQUALS value;
key: id ((SLASH | DOT) id)*;
section_id: id (DOT id)*;
value: MINUS? (IDENTIFIER | NUMBER | TRUE | FALSE | NULL | string | constructor | list | dictionary | entry);
constructor: IDENTIFIER PARENTHES_LEFT NL* value? NL* (COMMA NL* value NL*)* NL* PARENTHES_RIGHT;
list: BRACKET_LEFT NL* value? NL* (COMMA NL* value NL*)* NL* BRACKET_RIGHT;
dictionary: BRACE_LEFT NL* entry? (COMMA NL* entry NL*)* NL* BRACE_RIGHT;
entry: string COLON value;
id: IDENTIFIER | NUMBER;
string: STRING_MULTILINE | STRING_DOUBLE_QUOTE | STRING_APHOSTROPHE | RESOURCE;

TRUE: 'true';
FALSE: 'false';
NULL: 'null';
LINE_COMMENT: SEMICOLON ~[\n]*;
EQUALS: '=';
MINUS: '-';
SEMICOLON: ';';
SLASH: '/';
COLON: ':';
COMMA: ',';
DOT: '.';
PARENTHES_LEFT: '(';
PARENTHES_RIGHT: ')';
BRACKET_LEFT: '[';
BRACKET_RIGHT: ']';
BRACE_LEFT: '{';
BRACE_RIGHT: '}';
NL: '\n';
NUMBER: NUMBER_INTEGER | NUMBER_BINARY | NUMBER_HEXADECIMAL | NUMBER_FLOAT;
fragment NUMBER_INTEGER: DIGIT+;
fragment NUMBER_BINARY: '0b' ('0' | '1')+;
fragment NUMBER_HEXADECIMAL: '0x' (DIGIT | 'A'..'F')+;
fragment NUMBER_FLOAT: DIGIT* DOT DIGIT+ ('e' ('-' | '+')? DIGIT+)?;
IDENTIFIER: DIGIT* LETTER (LETTER | DIGIT)*;
fragment LETTER: LOWER_CASE | UPPER_CASE | UNDERSCORE;
fragment LOWER_CASE: 'a'..'z';
fragment UPPER_CASE: 'A'..'Z';
fragment UNDERSCORE: '_';
fragment DIGIT: '0'..'9';
RESOURCE: '"res://' .*? '"';
USER_RESOURCE: '"user://' .*? '"';
STRING_MULTILINE: '"""' .*? '"""';
STRING_DOUBLE_QUOTE: '"' .*? ('"' | NL | EOF);
STRING_APHOSTROPHE: '\'' .*? ('\'' | NL | EOF);
WHITESPACE: (' ' | '\t')+ -> channel(HIDDEN);
ERRCHAR: . -> channel(HIDDEN);

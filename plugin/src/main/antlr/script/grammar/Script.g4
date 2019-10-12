grammar Script;

@header {package script.grammar;}

file: (statement NL+)* EOF;

statement: var_statement | const_statement | func_statement | for_statement | while_statement | class_statement | extends_statement | class_name_statement | enum_statement | if_statement | elif_statement | else_statement | return_statement | signal_statement | assign_statement | expression | PASS | LINE_COMMENT;
var_statement: (EXPORT (PARENTHES_LEFT export_argument? (COMMA export_argument)* PARENTHES_RIGHT)?)? ONREADY? VAR IDENTIFIER (COLON type)? (ASSIGN expression)? (SETGET IDENTIFIER? (COMMA IDENTIFIER)?)?;
export_argument: IDENTIFIER | NUMBER | STRING | type;
const_statement: CONST IDENTIFIER (COLON type)? ASSIGN expression;
func_statement: STATIC? FUNC IDENTIFIER PARENTHES_LEFT func_argument? (COMMA func_argument)* PARENTHES_RIGHT (ARROW type)? COLON;
func_argument: IDENTIFIER (COLON type)?;
for_statement: FOR expression COLON;
while_statement: WHILE expression COLON;
class_statement: CLASS IDENTIFIER COLON;
extends_statement: EXTENDS type;
class_name_statement: CLASS_NAME IDENTIFIER;
enum_statement: ENUM IDENTIFIER? BRACE_LEFT NL* enum_entry (COMMA NL* enum_entry)* BRACE_RIGHT;
enum_entry: IDENTIFIER (ASSIGN NUMBER)? NL*;
if_statement: IF expression COLON;
elif_statement: ELIF expression COLON;
else_statement: ELSE COLON;
return_statement: RETURN expression;
signal_statement: SIGNAL IDENTIFIER;
assign_statement: expression (ASSIGN | ASSIGN_SPECIAL) expression;

expression: value ((OPERATION_SIGN | AND | OR | IN | IS | AS | MINUS | DOT) value)*;
value: (MINUS | NOT)? (IDENTIFIER | NODE | NUMBER | TRUE | FALSE | SELF | STRING | MULTILINE_STRING | array | dictionary | dictionary_lua | invoke | subscribe | in_braces | type);

array: BRACKET_LEFT expression? (COMMA expression)* BRACKET_RIGHT;
dictionary: BRACE_LEFT NL* dictionary_entry? (COMMA NL* dictionary_entry)* BRACE_RIGHT;
dictionary_entry: (STRING | NUMBER) COLON expression NL*;
dictionary_lua: BRACE_LEFT NL* dictionary_lua_entry? (COMMA NL* dictionary_lua_entry)* BRACE_RIGHT;
dictionary_lua_entry: IDENTIFIER ASSIGN expression NL*;
invoke: IDENTIFIER PARENTHES_LEFT expression? (COMMA expression)* PARENTHES_RIGHT;
subscribe: IDENTIFIER BRACKET_LEFT expression BRACKET_RIGHT;
in_braces: PARENTHES_LEFT expression PARENTHES_RIGHT;
type: IDENTIFIER | primitive;
primitive: BOOL | INT | FLOAT | VOID;

EXPORT: 'export';
ONREADY: 'onready';
VAR: 'var';
SETGET: 'setget';
CONST: 'const';
STATIC: 'static';
FUNC: 'func';
FOR: 'for';
WHILE: 'while';
CLASS: 'class';
EXTENDS: 'extends';
CLASS_NAME: 'class_name';
ENUM: 'enum';
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
RETURN: 'return';
PASS: 'pass';
SIGNAL: 'signal';
ASSIGN_SPECIAL: '+=' | '-=' | '*=' | '/=' | '%=' | '&=' | '|=';
ASSIGN: '=';
ARROW: '->';
OPERATION_SIGN: '~' | '*' | '/' | '%' | '+' | '<<' | '>>' | '&' | '^' | '|' | '<' | '>' | '==' | '!=' | '>=' | '<=' | '!' | '&&' | '||';
NOT: 'not';
AND: 'and';
OR: 'or';
IN: 'in';
IS: 'is';
AS: 'as';
SELF: 'self';
TRUE: 'true';
FALSE: 'false';
BOOL: 'bool';
INT: 'int';
FLOAT: 'float';
VOID: 'void';
COMMA: ',';
DOT: '.';
COLON: ':';
PARENTHES_LEFT: '(';
PARENTHES_RIGHT: ')';
BRACKET_LEFT: '[';
BRACKET_RIGHT: ']';
BRACE_LEFT: '{';
BRACE_RIGHT: '}';
IDENTIFIER: IDENTIFIER_START (IDENTIFIER_START | DIGIT)*;
NODE: '$' (LOWER_CASE | UPPER_CASE | '/')*;
MINUS: '-';
NUMBER: MINUS? DIGIT+ '.'? (DIGIT+)?;
STRING: '"' (~["\n])* '"';
MULTILINE_STRING: '"""' .*? '"""';
LINE_COMMENT: '#' ~[\r\n\f]*;
fragment IDENTIFIER_START: LOWER_CASE | UPPER_CASE | '_';
fragment LOWER_CASE: 'a'..'z';
fragment UPPER_CASE: 'A'..'Z';
fragment DIGIT: '0'..'9';

NL: '\n';
WHITESPACE: (' ' | '\t')+ -> channel(HIDDEN);
ERRCHAR: . -> channel(HIDDEN);

grammar fredun;

start: (letDef | typeDef)* ;

letDef: 'let' (recordDeref | tupleDeref | varName) '=' (funcDef | expr) ;
funcDef: '(' argList ')' ':' type '=>' expr ;
typeDef: 'type' type '=' (tuple | record | enum) ;

recordDeref: '{' argWithAssignList (',' spread)? '}' ;
tupleDeref: '(' argList (',' spread)? ')' ;

record: '{' argList (',' spread)? '}' ;
tuple: '(' typeList ')' ;

enum: '{' enumList '}' ;

spread: '...' varName ;

enumList: case* ;
case: 'case' varName ':' (record | type) ;

typeList: type (',' type)* ;
argList: arg (',' arg)* ;
argWithAssignList: argWithAssign (',' argWithAssign)* ;
exprList: expr (',' expr)* ;

arg: varName ':' type ;
argWithAssign: arg ('=' varName)?;

expr: exprTuple | exprRecord | CHAR | QUOTED_STRING | ID ;

exprTuple: '(' exprList? ')' ;
exprRecord: '{' (colonExpr (',' colonExpr)*)? '}' ;

colonExpr: varName ':' expr ;

varName: ID;
type: ID ;


fragment ESCAPED_QUOTE : '\\"';
QUOTED_STRING :   '"' ( ESCAPED_QUOTE | ~('\n'|'\r') )*? '"';
fragment ESCAPED_SINGLE_QUOTE : '\\\'' ;
fragment HEX: [0-9a-zA-Z] ;
fragment UNICODE: '\\u' HEX HEX? HEX? HEX? HEX? ;
CHAR: '\'' (ESCAPED_SINGLE_QUOTE | UNICODE | ~('\n'|'\r')) '\'' ;

ID : [a-zA-Z0-9]+ ;
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
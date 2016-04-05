grammar fredun;

start: (moduleDef | letDef | typeDef | recordDef | enumDef)* ;

moduleDef: 'module' type moduleBlock ;
moduleBlock: '{' (letDef | typeDef | recordDef | enumDef)* '}' ;
letDef: 'let' (recordDeref | tupleDeref | varName) '=' expr ;
funcDef: '(' argList ')' ':' type '=>' expr ;
typeDef: 'type' type '=' tuple ;
recordDef: 'struct' type record ;
enumDef: 'enum' type enumBlock ;

recordDeref: '{' argWithAssignList (',' spread)? '}' ;
tupleDeref: '(' argList (',' spread)? ')' ;

record: '{' argList (',' spread)? '}' ;
tuple: '(' typeList ')' ;

enumBlock: '{' enumList '}' ;

spread: '...' varName ;

enumList: caseBlock* ;
caseBlock: 'case' varName '(' (record | type) ')' ;

constructor: ID constructorVars?;
constructorVars: '(' constructorArgList ')';

constructorArgList: constructorArg (',' constructorArg)* ;
constructorArg: varName (':' type)? ;

typeList: type (',' type)* ;
argList: arg (',' arg)* ;
argWithAssignList: argWithAssign (',' argWithAssign)* ;
exprList: expr (',' expr)* ;

arg: varName ':' type ;
argWithAssign: arg ('=' varName)?;

expr: block | '(' expr ')'
    | expr '.' ID
    | <assoc=right> expr POW expr          // powExpr
    | MINUS expr                           // unaryMinusExpr
    | NOT expr                             // notExpr
    | expr op=(MULT | DIV | MOD) expr      // multiplicationExpr
    | expr op=(PLUS | MINUS) expr          // additiveExpr
    | expr op=(LTEQ | GTEQ | LT | GT) expr // relationalExpr
    | expr op=(EQ | NEQ) expr              // equalityExpr
    | expr AND expr                        // andExpr
    | expr OR expr                         // orExpr
    | '(' argList ')' ':' type '=>' expr
    | exprIf | /*exprTuple |*/ exprRecord | matchExpr
    | const=(CHAR | QUOTED_STRING) | number | ID ;

block: '{' expr* '}' ;

exprTuple: '(' exprList? ')' ;
exprRecord: '{' (colonExpr (',' colonExpr)*)? '}' ;
exprIf: 'if' '(' expr ')' block ('else' block)? ;
matchExpr: 'match' '(' expr ')' matchList ;

matchList: '{' matchCase* '}' ;
matchCase: 'case' constructor ':' expr ;

colonExpr: varName ':' expr ;

varName: ID;
type: ID typeKind? ;
typeKind: '[' type ']' ;

POW: '^';
MINUS: '-';
NOT: '!';
MULT: '*';
DIV: '/';
MOD: '%';
PLUS: '+';
LTEQ: '<=';
GTEQ: '>=';
LT: '<';
GT: '>';
EQ: '==';
NEQ: '!==';
AND: '&';
OR: '|';

fragment ESCAPED_QUOTE: '\\"';
fragment ESCAPED_SINGLE_QUOTE: '\\\'' ;
fragment HEX: [0-9a-zA-Z] ;
fragment UNICODE: '\\u' HEX HEX? HEX? HEX? HEX? ;

QUOTED_STRING: '"' ( ESCAPED_QUOTE | UNICODE | ~('\n'|'\r') )*? '"' ;
CHAR: '\'' (ESCAPED_SINGLE_QUOTE | UNICODE | ~('\n'|'\r')) '\'' ;

fragment XID_Start : [_a-zA-Z] ;
fragment XID_Continue: [0-9_a-zA-Z] ;

number: unary_operator? unsigned_number;

unary_operator: MINUS | PLUS ;

unsigned_number: UNSIGNED_INT | UNSIGNED_HEX | UNSIGNED_FLOAT;

UNSIGNED_INT: [0-9]+ ;
UNSIGNED_HEX: '0x' [0-9a-fA-F]+ ;

UNSIGNED_FLOAT: [0-9]+ '.' [0-9]* Exponent? | '.' [0-9]+ Exponent? | [0-9]+ Exponent;

fragment
Exponent : ('e'|'E') ('+'|'-')? ('0'..'9')+ ;

ID : XID_Start XID_Continue* ;
DOC_COMMENT: '/**' .*? '*/' -> channel(HIDDEN) ;
BLOCK_COMMENT: '/*' .*? '*/' -> channel(HIDDEN) ;
LINE_COMMENT: '//' ~[\r\n]* -> channel(HIDDEN) ;
WS : [ \t\r\n]+ -> channel(HIDDEN) ; // skip spaces, tabs, newlines
% This file shows demo queries that you can use for more advanced
% queries on literals.

% NOTE: Literal representation is under discussion.   We are planning to
% move to the Turtle/SPARQL notation "string"@lang and "42"^^xsd:integer
% and use the value-space internally for supported types. We are working
% on the details and work out a smooth transition process.

/** <examples>

% Direct match

?- rdf(S,P,literal(type(xsd:integer, 42))).
?- rdf(S,P,literal(lang(Lang, 'Amsterdam'))).

% search

?- rdf(S,P,literal(prefix(a), L)).
?- rdf(S,P,literal(between('1920','1940'), type(xsd:integer, V))).

% full text search

?- rdf_find_literals(problem, Literals),
   member(Literal, Literals),
   rdf(S,P,literal(Literal)).

?- rdf_find_literals(stem(walking), Literals).

% language operations

?- lang_equal('EN.gb', 'en.gb').
?- lang_matches('EN.bg', 'en').

*/

% Below are some queries to maintain an RDF database

%%	undefined_predicate(?P) is nondet.
%
%	True when P refers to an RDF predicate that has no properties.

undefined_predicate(P) :-
	rdf_current_predicate(P),
	(   rdf(_,P,_)
	->  \+ rdf(P,_,_)
	).

%%	undefined_class(?Class) is nondet.
%
%	True when P refers to an RDF class that has no properties.

undefined_class(Class) :-
	distinct(Class, rdf_has(_, rdf:type, Class)),
	\+ rdf(Class, _, _).


%%	lod_load(Resource)

lod_load(Resource) :-
	catch(rdf_load(Resource), E, print_message(warning, E)).


/** <examples>

?- undefined_predicate(P).
?- undefined_class(C).
*/

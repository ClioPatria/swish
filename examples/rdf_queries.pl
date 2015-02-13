% This file only contains example queries that can be fired
% directly on any RDF dataset.

/** <examples>

% basic triples

?- rdf(S,P,O).
?- rdf(S,rdf:type,O).
?- rdf_has(S,dc:creator,C).

% Searches

?- rdf(C, rdf:type, rdfs:'Class'), rdf_reachable(S, rdfs:subClassOf, C).
?- rdf(S, rdfs:label, literal(prefix(a), L)).

% enumerate instances

?- rdf_graph(Graph).
?- rdf_current_predicate(P).
?- rdf_current_literal(L).
?- rdf_resource(R).

% information

?- rdf_statistics(triples(Triples)).
?- rdf_current_prefix(Prefix, URI).
?- rdf_predicate_property(Predicate, Property).
?- rdf_graph_property(Graph, Property).
*/

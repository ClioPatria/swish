% This file contains example queries that  you   can  use  to modify the
% triple store. These only work if you are logged on with administrative
% rights to ClioPatria.

/** <examples>

% Prefix handling

?- rdf_register_prefix(ex, 'http://www.example.com/').
?- rdf_equal(foaf:'Person', X), writeln(X).

% Assert triples

?- forall((rdf(S, rdfs:subClassOf, O), rdf(O, rdfs:subClassOf, O2)),
          rdf_assert(S, rdfs:subClassOf, O2, my_entailments)).
?- rdf_statistics(triples_by_graph(my_entailments, Count)).
?- rdf_generation(Generation).

% Remove triples

?- rdf_retractall(S, P, literal(lang(fr,L))).
?- rdf_retractall(_,_,_,my_entailments).

% Graph and data manipulation

?- rdf_load('http://www.w3.org/2000/01/rdf-schema').
?- rdf_unload_graph('http://www.w3.org/2000/01/rdf-schema').
?- rdf_make.
*/

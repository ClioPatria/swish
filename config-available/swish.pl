:- module(conf_swish, []).
:- use_module(cliopatria(hooks)).

/** <module> Add Prolog interaction to ClioPatria
*/

:- multifile user:file_search_path/2.

user:file_search_path(swish_web,      web(.)).
user:file_search_path(swish_examples, cpacks(swish/examples)).

:- use_module(applications(swish)).

%%      cliopatria:menu_item(-Item, -Label) is nondet.
%
%       Add SWISH to the Query menu

cliopatria:menu_item(300=query/swish, 'SWISH Prolog shell').

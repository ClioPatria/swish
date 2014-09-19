:- module(conf_swish, []).
:- use_module(cliopatria(hooks)).

/** <module> Add Prolog interaction to ClioPatria
*/

:- multifile user:file_search_path/2.

% tell SWISH where to find its parts.   The last clause allows adding an
% =examples=  directory  in  the  main   directory  holding  application
% specific examples.

user:file_search_path(swish_web,      web(.)).
user:file_search_path(swish_examples, cpacks(swish/examples)).
user:file_search_path(swish_examples, examples).

% Load swish.  You need this.
:- use_module(applications(swish)).
% Load the authentication hook. When loaded, ClioPatria users with admin
% rights can use SWISH without sandboxing security
:- use_module(library(swish/cp_authenticate)).

%%      cliopatria:menu_item(-Item, -Label) is nondet.
%
%       Add SWISH to the Query menu.

cliopatria:menu_item(300=query/swish, 'SWISH Prolog shell').

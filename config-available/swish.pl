:- module(conf_swish, []).
:- use_module(cliopatria(hooks)).

/** <module> Add Prolog interaction to ClioPatria
*/

:- multifile
	user:file_search_path/2,
	swish_config:config/2.

% tell SWISH where to find its parts.   The last clause allows adding an
% =examples=  directory  in  the  main   directory  holding  application
% specific examples.

user:file_search_path(swish_web, web(.)).
user:file_search_path(example,   cpacks(swish/examples)).
user:file_search_path(example,	 examples).

% Load swish.  You need this.
:- use_module(applications(swish)).
% Load the authentication hook. When loaded, ClioPatria users with admin
% rights can use SWISH without sandboxing security
:- use_module(library(swish/cp_authenticate)).
% Enable logging of SWISH queries and sources if HTTP logging is enabled
:- use_module(library(swish/logging)).
% Make side-effect-free RDF predicates safe
:- if(exists_source(library(semweb/rdf_sandbox))).
:- use_module(library(semweb/rdf_sandbox)).
:- endif.

% Allows users to extend the Examples menu by ticking the Example
% checkbox.
swish_config:config(community_examples, true).

%%      cliopatria:menu_item(-Item, -Label) is nondet.
%
%       Add SWISH to the Query menu.

cliopatria:menu_item(300=query/swish, 'SWISH Prolog shell').

:- module(conf_swish, []).

/** <module> Add Prolog interaction to ClioPatria
*/

:- multifile user:file_search_path/2.

user:file_search_path(swish_web, web(.)).

:- use_module(applications(swish)).

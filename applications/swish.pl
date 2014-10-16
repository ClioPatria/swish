/*  Part of SWI-Prolog

    Author:        Jan Wielemaker
    E-mail:        J.Wielemaker@cs.vu.nl
    WWW:           http://www.swi-prolog.org
    Copyright (C): 2014, VU University Amsterdam

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

    As a special exception, if you link this library with other files,
    compiled with a Free Software compiler, to produce an executable, this
    library does not by itself cause the resulting executable to be covered
    by the GNU General Public License. This exception does not however
    invalidate any other reasons why the executable file might be covered by
    the GNU General Public License.
*/

:- module(swish_app,
	  [
	  ]).
:- use_module(library(pengines)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_server_files)).
:- use_module(library(http/http_json)).

:- use_module(library(swish/config)).
:- use_module(library(swish/page), []).
:- use_module(library(swish/storage)).
:- use_module(library(swish/examples)).
:- use_module(library(swish/help)).
:- use_module(library(swish/highlight)).
:- use_module(library(swish/render)).


		 /*******************************
		 *	       PATHS		*
		 *******************************/

http:location(swish, root(swish), []).

user:file_search_path(render, library(swish/render)).


                 /*******************************
                 *   CREATE SWISH APPLICATION   *
                 *******************************/

:- multifile
	pengines:prepare_module/3.

:- pengine_application(swish).
:- use_rendering(swish:rdf).
:- use_module(swish:library(swish/render)).
:- use_module(swish:library(pengines_io)).
:- use_module(swish:library(semweb/rdf_db)).
:- use_module(swish:library(semweb/rdfs)).
:- use_module(swish:library(semweb/rdf_optimise)).
:- use_module(swish:library(semweb/rdf_litindex)).
:- use_module(swish:library(aggregate)).
pengines:prepare_module(Module, swish, _Options) :-
	pengines_io:pengine_bind_io_to_html(Module).

% Libraries that are nice to have in SWISH, but cannot be loaded
% because they use directives that are considered unsafe.  We load
% them here, so they only need to be imported, which is just fine.

:- use_module(library(clpfd), []).
:- use_module(library(clpb), []).

% rendering libraries

:- use_module(library(swish/render/table), []).
:- use_module(library(swish/render/rdf), []).

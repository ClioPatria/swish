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

:- module(cliopatria_render_rdf,
	  [ term_rendering//3			% +Term, +Vars, +Options
	  ]).
:- use_module(library(semweb/rdf_db)).
:- use_module(components(label)).
:- use_module(library(uri)).
:- use_module(library(swish/render)).

:- register_renderer(rdf, "Render RDF terms").

/** <module> SWISH RDF renderer

Render RDF data.
*/

%%	term_rendering(+Term, +Vars, +Options)//
%
%	Renders Term as a uri.  Furt

term_rendering(Term, _Vars, Options) -->
	{ is_rdf(Term)
	}, !,
	rdf_link(Term, [target('cliopatria-localview'), Options]).

is_rdf(Term) :-
	is_uri(Term), !.
is_rdf(literal(Value)) :-
	ground(Value),
	is_literal(Value).

is_uri(Term) :-
	atom(Term),
	(   uri_is_global(Term)
	->  true
	;   rdf_is_bnode(Term)
	).

is_literal(Atomic) :- is_plain_literal(Atomic).
is_literal(type(Type, Literal)) :- is_uri(Type), is_plain_literal(Literal).
is_literal(lang(Lang, Literal)) :- atom(Lang),   is_plain_literal(Literal).

is_plain_literal(Value) :-
	atomic(Value).

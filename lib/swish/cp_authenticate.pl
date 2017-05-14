/*  Part of SWI-Prolog

    Author:        Jan Wielemaker
    E-mail:        J.Wielemaker@cs.vu.nl
    WWW:           http://www.swi-prolog.org
    Copyright (C): 2014-2017, VU University Amsterdam
			      CWI, Amsterdam

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

:- module(cp_swish_authenticate,
	  [
	  ]).
:- use_module(library(pengines), []).
:- use_module(library(broadcast)).
:- use_module(user(user_db)).

/** <module> SWISH login management

This module provides basic login and  password management facilities for
SWISH.  You can create an authenticated SWISH server by

  1. Loading this library
  2. Add one or more users to the passwd file using swish_add_user/3

     ==
     ?- swish_add_user("Bob", "Bob's secret", []).
     ==

As a result, trying to create the  first pengine (e.g., using _|Run!|_),
the server will challenge the user.  The   logged  in  user is available
through pengine_user/1.
*/

:- multifile
    swish_config:authenticate/2,
    swish_config:user_info/3.

swish_config:authenticate(_Request, User) :-
    logged_on(User).


swish_config:user_info(_Request, local, Info) :-
    logged_on(User),
    findall(Name-Value, cp_user_property(User, Name, Value), Pairs),
    dict_pairs(Info, u, Pairs).

cp_user_property(User, user, User).
cp_user_property(User, name, RealName) :-
    user_property(User, realname(RealName)).
cp_user_property(User, email, Email) :-
    user_property(User, email(Email)).
cp_user_property(User, group, Group) :-
    user_property(User, allow(Allow)),
    (   memberchk(admin(_), Allow)
    ->  Group = admin
    ;   memberchk(write(_,_), Allow)
    ->  Group = writer
    ;   Group = reader
    ).

:- listen(identity_property(Identity, Property),
          cp_identity_property(Identity, Property)).

cp_identity_property(Identity, Property) :-
    _{user:User, identity_provider:local} :< Identity,
    Property =.. [Name,Value],
    cp_user_property(User, Name, Value).


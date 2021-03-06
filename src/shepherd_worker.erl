-module(shepherd_worker).

-export([
    start_link/1,
    start_link/2,
    start_link/3
]).

start_link(F) ->
    {ok, spawn_link(F)}.

start_link(F, A) ->
    {ok, spawn_link(erlang, apply, [F, A])}.

start_link(M, F, A) ->
    {ok, spawn_link(erlang, apply, [M, F, A])}.

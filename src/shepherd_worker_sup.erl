-module(shepherd_worker_sup).

-behaviour(supervisor).

-export([
    start_link/0,
    start_child/2,
    which_children/1
]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link(?MODULE, []).

start_child(SupRef, Args) ->
    supervisor:start_child(SupRef, Args).

which_children(SupRef) ->
    supervisor:which_children(SupRef).

init([]) ->
    ChildSpec = {shepherd_worker, {shepherd_worker, start_link, []}, temporary, 5000, worker, []},
    {ok, {{simple_one_for_one, 0, 1}, [ChildSpec]}}.

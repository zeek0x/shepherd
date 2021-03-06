-module(shepherd_subscribe_sup_sup).

-behaviour(supervisor).

-export([
    start_link/0,
    start_child/1,
    which_children/0
]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_child(SubscribeId) ->
    supervisor:start_child(?MODULE, [SubscribeId]).

which_children() ->
    supervisor:which_children(?MODULE).

init([]) ->
    ChildSpec = {shepherd_subscribe_sup, {shepherd_subscribe_sup, start_link, []}, temporary, 5000, supervisor, []},
    {ok, {{simple_one_for_one, 0, 1}, [ChildSpec]}}.

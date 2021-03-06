-module(shepherd_subscribe_sup).

-behaviour(supervisor).

-export([
    start_link/1
]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link(SubscribeId) ->
    supervisor:start_link(?MODULE, [SubscribeId]).

init([_SubscribeId]) ->
    ChildSpecs = [
        % {shepherd_manager, {shepherd_manager, start_link, [self(), SubscribeId]}, permanent, 5000, supervisor, []},
        {shepherd_worker_sup, {shepherd_worker_sup, start_link, []}, permanent, 5000, supervisor, []}
    ],
    {ok, {{one_for_all, 0, 1}, ChildSpecs}}.

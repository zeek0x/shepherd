%%%-------------------------------------------------------------------
%% @doc shepherd top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(shepherd_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    ChildSpec = {shepherd_subscribe_sup_sup, {shepherd_subscribe_sup_sup, start_link, []}, permanent, 5000, supervisor, []},
    {ok, {{one_for_all, 0, 1}, [ChildSpec]}}.

%%====================================================================
%% Internal functions
%%====================================================================

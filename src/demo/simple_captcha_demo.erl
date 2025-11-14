-module(simple_captcha_demo).

-export([start_web_server/0]).

start_web_server()->

	simple_captcha_ets:init(),
%%	simple_captcha_ets:destroy(),

	application:start(crypto),
	application:start(cowlib),
	application:start(ranch),
	application:start(cowboy),

	Routes = route_helper:routes(),
	Dispatch = cowboy_router:compile(Routes),
	Port = 8080,
	TransOpts = #{socket_opts => [{port, Port}]},
	ProtoOpts = #{env => #{dispatch => Dispatch}},
	{ok, _} = cowboy:start_clear(http, TransOpts, ProtoOpts).
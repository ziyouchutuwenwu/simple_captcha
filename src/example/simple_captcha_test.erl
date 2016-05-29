-module(simple_captcha_test).

-compile(export_all).

-define(C_ACCEPTORS, 100).

start_web_server()->

	simple_captcha_ets:init(),
%%	simple_captcha_ets:destroy(),

	application:start(crypto),
	application:start(cowlib),
	application:start(ranch),
	application:start(cowboy),

	Routes = route_helper:get_routes(),
	Dispatch = cowboy_router:compile(Routes),
	Port = 8080,
	TransOpts = [{port, Port}],
	ProtoOpts = [{env, [{dispatch, Dispatch}]}],
	cowboy:start_http(http, ?C_ACCEPTORS, TransOpts, ProtoOpts).
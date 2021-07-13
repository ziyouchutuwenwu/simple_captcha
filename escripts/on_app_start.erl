-module(on_app_start).

-export([main/1]).
-export([interprete_modules/0]).

main(_Args) ->
  io:format("~n"),
  interprete_modules().

interprete_modules() ->
  int:ni(cowboy_sub_protocol),
  int:ni(cowboy_req),
  int:ni(cowboy_router),
  int:ni(cowboy_middleware),
  int:ni(cowboy_http),
  int:ni(cowboy_rest),
  int:ni(cowboy_sup),
  int:ni(cowboy_http_handler),
  int:ni(cowboy_app),
  int:ni(cowboy_bstr),
  int:ni(cowboy),
  int:ni(cowboy_websocket_handler),
  int:ni(cowboy_loop_handler),
  int:ni(cowboy_static),
  int:ni(cowboy_websocket),
  int:ni(cowboy_protocol),
  int:ni(cowboy_spdy),
  int:ni(cowboy_handler),
  int:ni(cowboy_clock),
  int:ni(cow_spdy),
  int:ni(cow_cookie),
  int:ni(cow_qs),
  int:ni(cow_http_hd),
  int:ni(cow_multipart),
  int:ni(cow_http_te),
  int:ni(cow_mimetypes),
  int:ni(cow_date),
  int:ni(cow_http),
  int:ni(route_helper),
  int:ni(mochihex),
  int:ni(captcha_check_handler),
  int:ni(simple_captcha),
  int:ni(simple_captcha_test),
  int:ni(captcha_handler),
  int:ni(simple_captcha_ets),
  int:ni(ranch_transport),
  int:ni(ranch),
  int:ni(ranch_listener_sup),
  int:ni(ranch_sup),
  int:ni(ranch_protocol),
  int:ni(ranch_ssl),
  int:ni(ranch_acceptor),
  int:ni(ranch_server),
  int:ni(ranch_tcp),
  int:ni(ranch_acceptors_sup),
  int:ni(ranch_conns_sup),
  int:ni(ranch_app),

  io:format("输入 int:interpreted(). 或者 il(). 查看模块列表~n").
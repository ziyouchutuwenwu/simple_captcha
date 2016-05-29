-module(captcha_check_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  {CryptKey, _} = cowboy_req:cookie(<<"cap">>, Req, <<"">>),
  {ok, PostVals, Req2} = cowboy_req:body_qs(Req),
  CaptchaCode = proplists:get_value(<<"captchaCode">>, PostVals),

  case simple_captcha:check(CryptKey, CaptchaCode) of
    true ->
      {ok, Req3} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], <<"ok">>, Req2),
      {ok, Req3, State};
    _ ->
      {ok, Req3} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], <<"error">>, Req2),
      {ok, Req3, State}
  end.

terminate(_Reason, _Req, _State) ->
  ok.
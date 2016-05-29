-module(captcha_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->
  %CryptKey用于验证的时候用，需本地保存，CapCode为用户提交的数据
  %simple_captcha:check(CryptKey, CapCode)
  {CryptKey, BinPng} = simple_captcha:create(),

  Req2 = cowboy_req:set_resp_cookie(<<"cap">>, CryptKey, [{path, <<"/">>}], Req),
  {ok, Req3} = cowboy_req:reply(200, [{<<"content-type">>, <<"image/png">>}], BinPng, Req2),
  {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
  ok.
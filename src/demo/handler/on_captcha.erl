-module(on_captcha).

-export([init/2]).

init(Req, []) ->
    {CryptedKey, ImgBin} = simple_captcha:create(),

    Req2 = cowboy_req:set_resp_cookie(~"captcha", CryptedKey, Req),
    Req3 = cowboy_req:reply(200, #{~"content-type" => ~"image/png"}, ImgBin, Req2),
    {ok, Req3, undefined}.

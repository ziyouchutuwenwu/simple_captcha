-module(on_captcha_check).

-export([init/2]).

init(Req, []) ->
    Cookies = cowboy_req:parse_cookies(Req),
    CryptedKey = proplists:get_value(~"captcha", Cookies, ~""),

    {ok, PostVals, Req2} = cowboy_req:read_urlencoded_body(Req),
    CaptchaCode = proplists:get_value(~"captchaCode", PostVals, ~""),
    Req3 =
        case simple_captcha:check(CryptedKey, CaptchaCode) of
            true ->
                cowboy_req:reply(200, #{~"content-type" => ~"text/html"}, ~"ok", Req2);
            _ ->
                cowboy_req:reply(200, #{~"content-type" => ~"text/html"}, ~"error", Req2)
        end,
    {ok, Req3, undefined}.

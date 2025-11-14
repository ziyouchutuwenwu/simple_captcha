-module(route_helper).

-export([routes/0]).

routes() ->
    [
        {'_', [
            {"/captcha", on_captcha, []},
            {"/captcha_check", on_captcha_check, []}
        ]}
    ].

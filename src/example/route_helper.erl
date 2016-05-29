-module(route_helper).

-export([get_routes/0]).

get_routes() ->
  [
    {'_', [
      {"/captcha", captcha_handler, []},
      {"/captcha_check", captcha_check_handler, []}
    ]}
  ].
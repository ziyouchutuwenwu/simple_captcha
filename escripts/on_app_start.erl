-module(on_app_start).

-export([main/1]).
-export([interprete_modules/0]).

main(_Args) ->
  io:format("~n"),
  interprete_modules().

interprete_modules() ->
  % int:ni(demo_sup),
  int:i([M || {M, _} <- code:all_loaded(), not code:is_sticky(M), int:interpretable(M) =:= true]),

  % 这个会加载所有的系统库，很卡，慎用
  % int:i([M || M <-[list_to_atom(M) || {M, _, _} <- code:all_available()], not code:is_sticky(M), int:interpretable(M) =:= true]),
  io:format("输入 int:interpreted(). 或者 il(). 查看模块列表~n").
-module(simple_captcha_ets).

-export([init/0, insert/2, find/1, remove/1, destroy/0]).

init() ->
  TableName = ets:new(simple_captcha, [public, named_table]),
  {ok, TableName}.

insert(Key, Value) ->
  ets:insert(simple_captcha, {Key, Value}),
  ok.

find(Key) ->
  Result = (
      try ets:lookup_element(simple_captcha, Key, 2) of
        Value ->
          Value
      catch
        _:_ ->
          ""
      end
  ),
  Result.

remove(Key) ->
  try ets:delete(simple_captcha, Key)
  catch
    _:_ ->
      ok
  end.

destroy() ->
  try ets:delete(simple_captcha)
  catch
    _:_ ->
      ok
  end.
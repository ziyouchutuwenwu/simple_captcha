-module(simple_captcha).

-export([create/0, check/2]).

create() ->
  CryptKey = mochihex:to_hex(crypto:strong_rand_bytes(16)),
  Code = generate_rand(5),

  FileName = lists:flatmap(fun(Item) -> integer_to_list(Item) end, tuple_to_list(erlang:timestamp())),
  File = io_lib:format("/tmp/~s.png", [FileName]),

  Cmd = io_lib:format("convert -background 'none' -fill '#222222' -size 175 -gravity Center -wave 5x100 -swirl 50 -font DejaVu-Serif-Book -pointsize 28 label:~s -draw 'Bezier 10,40 50,35 100,35 150,35 200,50 250,35 300,35' ~s", [Code, File]),
  os:cmd(Cmd),

  {ok, BinPng} = file:read_file(File),
  file:delete(File),

  simple_captcha_ets:insert(Code, CryptKey),

  {erlang:list_to_bitstring(CryptKey), BinPng}.

check(CryptKeyBitString, CodeBitString) ->
  CryptKey = erlang:bitstring_to_list(CryptKeyBitString),
  Code = erlang:bitstring_to_list(CodeBitString),
  CryptKeyFromEts = simple_captcha_ets:find(Code),

  case string:equal(CryptKeyFromEts, CryptKey) of
    true ->
      simple_captcha_ets:remove(code),
      true;
    _ ->
      false
  end.


%private
%% ===== private =====

%% 生成指定长度的验证码
generate_rand(Length) ->
    %% 定义允许的字符集
    AllowedChars = "23456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz",
    Bytes = crypto:strong_rand_bytes(Length),
    lists:map(
      fun(B) ->
          Index = (B rem length(AllowedChars)) + 1,
          lists:nth(Index, AllowedChars)
      end,
      binary_to_list(Bytes)
    ).

do_rand(R) when R > 46, R < 58; R > 64, R < 91; R > 96 ->
  R;

do_rand(_R) ->
  do_rand(47 + random:uniform(75)).

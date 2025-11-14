-module(simple_captcha).

-export([create/0, check/2]).

create() ->
    CryptedKey = mochihex:to_hex(crypto:strong_rand_bytes(16)),
    Code = generate_rand(5),
    FileName = lists:flatmap(
        fun(Item) ->
            integer_to_list(Item)
        end,
        tuple_to_list(erlang:timestamp())
    ),
    File = io_lib:format("/tmp/~s.png", [FileName]),
    Cmd = io_lib:format(
        "convert -background 'none' -fill '#222222' -size 175 -gravity Center -wave 5x100 -swirl 50 -font DejaVu-Serif-Book -pointsize 28 label:~s -draw 'Bezier 10,40 50,35 100,35 150,35 200,50 250,35 300,35' ~s",
        [Code, File]
    ),
    os:cmd(Cmd),
    {ok, ImgBin} = file:read_file(File),
    file:delete(File),
    io:format("Code ~p~n", [Code]),
    io:format("CryptedKey ~p~n", [CryptedKey]),
    simple_captcha_ets:insert(Code, CryptedKey),
    {erlang:list_to_bitstring(CryptedKey), ImgBin}.

check(CryptKeyBitString, CodeBitString) ->
    io:format("CryptKeyBitString ~p~n", [CryptKeyBitString]),
    io:format("CodeBitString ~p~n", [CodeBitString]),
    CryptedKey = erlang:bitstring_to_list(CryptKeyBitString),
    Code = erlang:bitstring_to_list(CodeBitString),
    CryptKeyFromEts = simple_captcha_ets:find(Code),

    case string:equal(CryptKeyFromEts, CryptedKey) of
        true ->
            simple_captcha_ets:remove(code),
            true;
        _ ->
            false
    end.

%private
generate_rand(Length) ->
    Now = erlang:timestamp(),
    Seed = {element(1, Now), element(2, Now), element(3, Now)},
    rand:seed(exsplus, Seed),
    lists:foldl(fun(_I, Acc) -> [do_rand(0) | Acc] end, [], lists:seq(1, Length)).

do_rand(R) when R > 46, R < 58; R > 64, R < 91; R > 96 ->
    R;
do_rand(_R) ->
    do_rand(47 + rand:uniform(75)).

%% http://erlang.org/doc/apps/common_test/write_test_chapter.html
-module(template_SUITE).

-include_lib("common_test/include/ct.hrl").

-compile(export_all).

suite() ->
  [
    {timetrap, {seconds, 20}},
      {userdata,[
        {info, "this is a common test template."}
      ]}
  ].

groups() ->
  [
    {my_group,
      %% [parallel, {repeat, 10}],
      [],
      [test_case1, test_case2]}
  ].

all() ->
  [
    {group, my_group},
    test_case3
  ].

init_per_suite(Config) ->
  ct:log("init_per_suite~n"),
  Config.

end_per_suite(_Config) ->
  ct:log("end_per_suite~n"),
  ok.

init_per_group(Group, Config) ->
  ct:log("init_per_group~p~n",[Group]),
  Config.

end_per_group(Group, Config) ->
  ct:log("end_per_group~p~n",[Group]),
  Config.

init_per_testcase(TestCase, Config) ->
  ct:log("init_per_testcase~p~n",[TestCase]),
  Config.

end_per_testcase(TestCase, Config) ->
  ct:log("end_per_testcase~p~n",[TestCase]),
  Config.

%% --------------------------------------------------------
test_case1(_Config) ->
  ct:log("in test_case1~n"),
  {skip, "Not implemented."}.

test_case2(_Config) ->
  ct:log("in test_case2~n"),
  1=1.

test_case3(_Config) ->
  ct:log("in test_case3~n"),
  1=1.

test_case4(_Config) ->
  ct:log("in test_case4~n"),
  1=1.
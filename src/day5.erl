-module(day5).
-compile([export_all]).


run_day5a() ->
  Contents = readlines("input/day5_input"),
  Input = format_contents(Contents),
%%  Ind = -1,
%%  Bla = try lists:nth(Ind, Input) of
%%      Res -> Res
%%  catch
%%      _Exception:_Reason -> exit
%%  end ,
  io:format("List: ~p~n", [Input]),
  io:format("~p~n~p~n", [Input, move(Input, 0, 2, [])]).

%%check(Input) ->
%%  [Current | Rest] = Input,
%%  case move(Input, 0, Current, []) of
%%    {exited_list, _} -> exited;
%%    {present, PrevOfList, Found, RestOfList} ->;
%%  end



move([], _, _, Prev_list) ->
  {exited_list, Prev_list};

move([Current | Rest], Counter, Target, Prev) ->
  io:format("Current: ~p, Count: ~p/~p, Rest:~p, Prev_list: ~p~n", [Current, Counter, Target, Rest, Prev]),
%%  timer:sleep(1000),
  case Counter >= Target of
    true -> {present, Prev, Current, Rest};
    false -> move(Rest, Counter + 1, Target, Prev ++ [Current])
  end.

%%move_backward([H | T], Counter, Target)->


%%---------------------------------

format_contents(Input) ->
  Lines = string:split("2\n0\n-1\n0", "\n", all),
%%  Lines = string:split(Input, "\n", all),
  To_int = fun(X) -> {Integer, _Rest} = string:to_integer(X), Integer end,
  [To_int(Entry) || Entry <- Lines].

readlines(FileName) ->
  {ok, Device} = file:open(FileName, [read]),
  try get_all_lines(Device)
  after file:close(Device)
  end.

get_all_lines(Device) ->
  case io:get_line(Device, "") of
    eof -> [];
    Line -> Line ++ get_all_lines(Device)
  end.
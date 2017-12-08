-module(day2).

-compile([export_all]).

run_day2a() ->
  Contents = readlines("input/day2_input"),
  Input = format_contents(Contents),
  Extremes = [{lists:max(Row), lists:min(Row)} || Row <- Input],
  Differences = [Max - Min || {Max, Min} <- Extremes],
  Checksum = lists:foldl(fun(X, Sum) -> X + Sum end, 0, Differences),
  io:format("~p~n", [Checksum]).

run_day2b() ->
  Contents = readlines("input/day2_input"),
  Input = format_contents(Contents),
  io:format("~p~n", [Input]),
  Results = [find_dividable(X) || X <- Input],
  io:format("~p~n", [Results]),
  Sum_2a = lists:foldl(fun(X, Sum) -> X + Sum end, 0, Results),
  io:format("~p~n", [Sum_2a]).


find_dividable(Row) ->
  [Current | Rest] = Row,
  case find_dividable(Current, Rest, []) of
    {match, Result} -> Result;
    no_match -> find_dividable(Rest)
  end.

find_dividable(_Current, [], _Acc) ->
  no_match;
%%
%%find_dividable(match, _Current, Result) ->
%%  {match, Result};

find_dividable(Current, [Next | Rest], Acc) ->
  case Current > Next of
    true ->
      io:format("---~p is bigger than ~p ||| ", [Current, Next]),
      case Current rem Next of
        0 -> io:format("~p / ~p has rem 0, good_match !!~n", [Current, Next]),
%%          find_dividable(match, Current, Current / Next);
          {match, Current / Next};
        _Else -> io:format("~p / ~p has rem ~p, bad_match~n", [Current, Next, _Else]),
          find_dividable(Current, Rest, Acc)
      end;
    false ->
      io:format("---~p is NOT bigger than ~p ||| ", [Current, Next]),
      case Next rem Current of
        0 -> io:format("~p / ~p has rem 0, good_match !!~n", [Next, Current]),
          {match, Next / Current};
        _Else -> io:format("~p / ~p has rem ~p, bad_match~n", [Next, Current, _Else]),
          find_dividable(Current, Rest, Acc)
      end
  end.



format_contents(Input) ->
  Lines = string:split(Input, "\n", all),
  Rows = [string:split(N, "\t", all) || N <- Lines],
  [lists:map(fun(X) ->
    {Integer, _Rest} = string:to_integer(X),
    Integer end,
    Row) || Row <- Rows].

%%https://stackoverflow.com/questions/2475270/how-to-read-the-contents-of-a-file-in-erlang
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
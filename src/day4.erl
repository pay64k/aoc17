-module(day4).
-compile([export_all]).


run_day4a() ->
  Contents = readlines("input/day4_input"),
  Input = format_contents(Contents),
  Result = [{maps:size(make_map(X)), length(X)} || X <- Input],
  Amount = [1 || {X, Y} <- Result, X == Y],
  io:format("Result: ~p~n", [lists:foldl(fun(X, Sum) -> X + Sum end, 0, Amount)]).

run_day4b() ->
  Contents = readlines("input/day4_input"),
  Input = format_contents(Contents),
  io:format("Input: ~p~n", [Input]),
  Res = [[lists:sort(Word) || Word <- Row] || Row <- Input],
  io:format("Res: ~p~n", [Res]),
  Result = [{maps:size(make_map(X)), length(X)} || X <- Res],
  Amount = [1 || {X, Y} <- Result, X == Y],
  io:format("Result: ~p~n", [lists:foldl(fun(X, Sum) -> X + Sum end, 0, Amount)]).

%%---------------------------------

make_map(List) ->
  make_map(List, maps:new()).

make_map([], Acc) ->
  Acc;

make_map([H | T], Acc) ->
  make_map(T, maps:put(H, 0, Acc)).

%%---------------------------------

format_contents(Input) ->
  Lines = string:split(Input, "\n", all),
  Rows = [string:split(N, " ", all) || N <- Lines],
  [Entry || Entry <- Rows].

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
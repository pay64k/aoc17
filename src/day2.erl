-module(day2).

-compile([export_all]).

run() ->
  Contents = readlines("input/day2_input"),
  Input = format_contents(Contents),
  Extremes = [{lists:max(Row), lists:min(Row)} || Row <- Input],
  Differences = [ Max - Min || {Max, Min} <- Extremes],
  Checksum = lists:foldl(fun(X, Sum) -> X + Sum end, 0, Differences),
  io:format("~p~n", [Checksum]).

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
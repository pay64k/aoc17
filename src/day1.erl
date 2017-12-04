-module(day1).
%% API
-compile([export_all]).

run() ->
%%  {ok, Input} = {ok, "123123"},%read_input("input/day1_input"),
  {ok, Input} = read_input("input/day1_input"),
%%  io:fwrite("Input:~n~p~n",[Input]),
  Converted = convert_string_to_integer_list(Input),
%%  io:fwrite("Conv:~n~p~n", [Conv]),
  Res = day_2a(Converted ++ Converted, lists:flatlength(Converted)),
%%  io:fwrite("Res:~n~p~n", [Res]),
  Sum_1a = lists:foldl(fun(X, Sum) -> X + Sum end, 0, Res),
  io:fwrite("Sum 2a: ~p~n", [Sum_1a]).

day_1a(Input, Len) ->
  day_1a(Input, _Index = 0, Len, []).

day_1a(_List, Index, Len, Acc) when Index >= Len ->
  Acc;

day_1a([H | T], Index, Len, Acc) ->
  H_next = check_next_in_list_1a(T),
  case H of
    H_next ->
      day_1a(T, Index + 1, Len, Acc ++ [H_next]);
    _Else ->
      day_1a(T, Index + 1, Len, Acc)
  end.

check_next_in_list_1a([H | _T]) ->
  H;
check_next_in_list_1a([]) ->
  empty.

%%-------------------------------------

day_2a(Input, Len) ->
  day_2a(Input, _Index = 0, _Step = round(Len / 2), Len, []).

day_2a(_List, Index, _Step, Len, Acc) when Index >= Len ->
  Acc;

day_2a([H | T], Index, Step, Len, Acc) ->
  H_next = lists:nth(Step, T),%find_next_digit(T, Step),
  case H of
    H_next ->
      day_2a(T, Index + 1, Step, Len, Acc ++ [H_next]);
    _Else ->
      day_2a(T, Index + 1, Step, Len, Acc)
  end.
%%
%%check_next_in_list_2a([H | _T], Steps) ->
%%  H.

%%find_next_digit(List, Steps) ->
%%  check_next(List, _Current = 1, Steps).
%%
%%check_next(_List, Current, Steps) ->
%%
%%
%%check_next(_List, Current, Steps) when Current >= Steps ->
%%  not_equal.




%%-------------------------------------

read_input(File) ->
  {ok, Device} = file:open(File, [read]),
  file:read_line(Device).

convert_string_to_integer_list(String) ->
  convert_string_to_integer_list(String, []).

convert_string_to_integer_list([], Acc) ->
  Acc;
convert_string_to_integer_list([H | T], Acc) ->
%%  io:fwrite("H:~p , T:~p ~n",[H, T]),
  Acc2 = Acc ++ [erlang:list_to_integer([H])],
  convert_string_to_integer_list(T, Acc2).

%%http://erlang.org/doc/efficiency_guide/listHandling.html

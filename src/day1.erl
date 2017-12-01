-module(day1).
%% API
-compile([export_all]).

run() ->
  Input = "123",%read_input("input/day1_input"),
  io:fwrite("Input:~n~p~n",[Input]),
  Conv = convert_string_to_integer_list(Input),
  io:fwrite("Conv:~n~p~n",[Conv]).


read_input(File)->
  {ok, Device} = file:open(File,[read]),
  file:read_line(Device).

convert_string_to_integer_list(String)->
  convert_string_to_integer_list(String,[]).

convert_string_to_integer_list([],Acc)->
  Acc;
convert_string_to_integer_list([H|T], Acc)->
  io:fwrite("H:~p , T:~p ~n",[H, T]),
  [Acc | string:list_to_integer(H)],
  convert_string_to_integer_list(T,Acc).

%%http://erlang.org/doc/efficiency_guide/listHandling.html

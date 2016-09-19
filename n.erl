-module(n).
-export([start_nano_server/0]).

start_nano_server() ->
  {ok, Listen} = gen_tcp:listen(2345,
    %% [binary, {packet,4}, {reuseaddr, true}, {active,true}]),
    [binary, {reuseaddr, true}, {active, true}]),
  {ok, Socket} = gen_tcp:accept(Listen),
  gen_tcp:close(Listen),
  loop(Socket).

loop(Socket) ->
  receive
    {tcp, Socket, Bin} ->
      Str = binary_to_list(Bin),
      io:format("server receive:~s~n", [Str]),
      Reply = "Receive:" ++ Str,
      gen_tcp:send(Socket, list_to_binary(Reply)),
      loop(Socket);
    {tcp_closed, Socket} ->
      io:format("Server socket closed~n")
  end.


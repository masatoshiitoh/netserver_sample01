-module(ntime).
-export([start_nano_server/0]).


-spec start_nano_server() -> any().
start_nano_server() ->
  {ok, Listen} = gen_tcp:listen(2345,
    %% [binary, {packet,4}, {reuseaddr, true}, {active,true}]),
    [binary, {reuseaddr, true}, {active, true}]),
  {ok, Socket} = gen_tcp:accept(Listen),
  gen_tcp:close(Listen),
  send_one(Socket).

loop(Socket) ->
  receive
    {tcp, Socket, Bin} ->
      Str = binary_to_list(Bin),
      io:format("server receive:~s~n", [Str]),
      Reply = "Receive:" ++ Str,
      gen_tcp:send(Socket, list_to_binary(Reply)),
      loop(Socket);
    {tcp_closed, Socket} ->
      gen_tcp:close(Socket),
      io:format("Server socket closed ~p~n",[1])
  end.

send_one(Socket) ->
      Reply = io_lib:format("hello from server~p~n", [1]),
      gen_tcp:send(Socket, list_to_binary(Reply)),
      receive after 1000 -> 0 end,
      send_one(Socket).


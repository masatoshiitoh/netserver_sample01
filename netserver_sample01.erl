%%
%%

module(netserver_sample01).


run(Port) ->
	bind
	listen
	accept
	loop().


loop() ->
	io_lib:format(),
	write,
	sleep (1000ms),
	loop().


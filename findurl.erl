
-module(findurl).

-export([find/1, do_tests/0]).

-define(URL_MATCHER, ".").

find(Bin) when is_binary(Bin) ->
    find(binary_to_list(Bin));
find(Text) ->
  {match, Matches} = regexp:matches(Text, ?URL_MATCHER),
  extract(Matches, Text, []).

extract([], _Text, Extracted) ->
    lists:reverse(Extracted);
extract( [{Start, Length} | Rest], Text, Extracted) -> 
    extract(Rest, Text, [string:substr(Text, Start, Length)| Extracted]).

do_tests() ->
  [] = find("Hi.there. How are you?"),
  ["http://google.com"] = find("Have you tried http://google.com ?"),
  ok.

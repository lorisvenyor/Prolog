% FACTS
route(dublin, cork, 200, 'fct').
route(cork, dublin, 200, 'fct').
route(cork, corkAirport, 20, 'fc').
route(corkAirport, cork, 25, 'fc').
route(dublin, dublinAirport, 10, 'fc').
route(dublinAirport, dublin, 20, 'fc').
route(dublinAirport, corkAirport, 225, 'p').
route(corkAirport, diblinAirport, 225, 'p').

% foot: 5km/h
% car: 80km/h
% train: 100km/h
% plane: 500km/h

mode(f, 5).
mode(c, 80).
mode(t, 100).
mode(p, 500).

intersectingmode([], _, []).         

intersectingmode([X | ModesWant], ModesAvail, [X | ModesInter]) :-      
    intersectingmode(ModesWant, ModesAvail, ModesInter), 
    member(X, ModesAvail).

intersectingmode([_ | ModesWant], ModesAvail, ModesInter) :- 
    intersectingmode(ModesWant, ModesAvail, ModesInter).

intersectinglist(First, Second, List) :- 
    atom_chars(First, List1), atom_chars(Second, List2), 
    intersectingmode(List1, List2, List).


fastestmode([Mode], Mode, Speed) :- mode(Mode, Speed).

fastestmode([X | Mode], X, Speed) :- mode(X, Speed), 
    fastestmode(Mode, _, Speed1),
    Speed > Speed1.

fastestmode([_ | Mode], X, Speed1) :- mode(_, Speed),
    fastestmode(Mode, X, Speed1),
    Speed1 > Speed. 



getroute(Source, Destination, SeenRoute, Final, Transpo, Time) :- 
    route(Source, Destination, Distance, Mode), append([Destination, Source],
    SeenRoute, List), reverse(List, Final), 
    intersectinglist(Transpo, Mode, ListMode), fastestmode(ListMode, _, Speed), 
    Time is (Distance / Speed).

getroute(Source, Destination, SeenRoute, Final, Transpo, TotalTime) :- 
    route(Source, Area, Distance, Mode),
    not(member(Area, SeenRoute)), 
    intersectinglist(Transpo, Mode, ListMode),
    fastestmode(ListMode, _, Speed),
    getroute(Area, Destination, [Source|SeenRoute], Final, Transpo, Time),
    TotalTime is Time + (Distance / Speed).


quickestroute(Source, Destination, Final, Transpo, BestTime) :- 
    getroute(Source, Destination, [], _, Transpo, _), 
    findall(Time, getroute(Source, Destination, [], Final, Transpo, Time), ListTimes), 
    min_member(BestTime, ListTimes),
    getroute(Source, Destination, [], Final, Transpo, BestTime).


journey(S, D, M) :- quickestroute(S, D, AllRoutes, M, Time), !,
    atomic_list_concat(AllRoutes, " -> ", String),
    write("Quickest Journey: "), write(String),
    write("\n"), 
    write("Time: "), write(Time), write(" hrs").

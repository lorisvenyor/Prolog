# CA208-Logic

Second Year Computer Applications and Software Engineering Individual Assignment on Prolog

A map is described by a series of facts of the form route(Src,Dest, Distance, Modes) where predicate route defines a route between Src and Dest. The has length Distance. The route has several Modes by which it can be travelled. Modes is a string that represented the available modes of travel. If Modes contains f it can be travelled by foot, if Modes contains c it can be travelled by car, if Modes contains t it can be travelled by train, and if Modes contains p it can be travelled by plane. The average speed for each mode of travel is:

foot: 5km/h
car: 80km/h
train: 100km/h
plane: 500km/h
For example, a possible set of facts are:

route(dublin, cork, 200, 'fct').
route(cork, dublin, 200, 'fct').
route(cork, corkAirport, 20, 'fc').
route(corkAirport, cork, 25, 'fc').
route(dublin, dublinAirport, 10, 'fc').
route(dublinAirport, dublin, 20, 'fc').
route(dublinAirport, corkAirport, 225, 'p').
route(corkAirport, diblinAirport, 225, 'p').
Write a Prolog predicate journey(S, D, M) that calclates the quickest journey between S and D only using the travel modes included in the string M. Your predicate must be able to handle cycles in a set of facts.

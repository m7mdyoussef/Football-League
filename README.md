# Football-League
Football-League is a simple Football Competitions Viewer application that consisting of 3 screens to show a list of Competitions, teams in
each league and team information.

The Architecture used is MVVM with RX Swift, although it’s a simple project and I could simply use MVC, I preferred to choose MVVM as it’s better and easier in testing and decoupling the view and view model.

Design Patterns: 
- Decorator Design Pattern in View Controller to extend the functionally of the view controller in an easy way to edit and maintain.
- Observer Design Pattern to update the listeners once the data changes.
- singleton Design Pattern For Local Data base Source.

Apis:
- Competitions: http://api.football-data.org/v4/competitions
- Competition details: http://api.football-data.org/v4/competitions/{id}
- Teams: http://api.football-data.org/v4/competitions/{id}/teams

xcode: 13.3

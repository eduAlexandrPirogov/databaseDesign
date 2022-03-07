drop schema public cascade;
create schema public;

create table commentators(
id serial,
name varchar(50),
surname varchar(50),
birth date,
primary key(id)
);

create table commentators_squad(
id serial,
main_commentator_id int references commentators(id),
second_commentator_id int references commentators(id),
primary key(id)
);

create table referees(
id serial,
name varchar(50),
surname varchar(50),
birth date,
primary key(id)
);

create table referees_squad(
id serial,
main_ref int references referees(id),
side_ref int references referees(id),
var_Ref int references referees(id),
primary key(id)
);

create table fc_teams(
id serial primary key,
title varchar(100)
);

create table stadiums(
id serial,
fc_id int8 references fc_teams(id),
title varchar(100),
seats int,
primary key(id)
);

create table fc_in_match(
id serial,
fc_home int references fc_teams(id),
fc_away int references fc_teams(id),
date date,
primary key(id)
);

create table countries
(
id serial,
title varchar(100),
primary key(id)
);

create table sponsors
(
id serial,
title varchar(100),
primary key(id)
);


create table tournament
(
id serial,
title varchar(100),
teamsCount int ,
pricePool int,
primary key(id)
);

create table league
(
country_id int references countries(id),
primary key(id)
) inherits(tournament) ;

create table kick_offs
(
country_id int references countries(id),
sponsor_id int references sponsors(id),
primary key(id)
) inherits(tournament) ;

create table matches
(
id serial primary key,
commentators_squad_id int references commentators_squad(id),
referees_squad_id int references referees (id),
tournament_id int references tournament(id),
fc_in_matches_id int references fc_in_match(id)
);

create table positions
(
id serial primary key,
position varchar(10)
);

create table players
(
id serial primary key,
fc_id int references fc_teams(id),
main_pos int references positions(id),
name varchar(50),
surname varchar(50),
birth date
);

create table awards(
id serial primary key,
votes int
);

create table goals_of_seasons
(
player_id int references players(id),
match_id int references matches(id)
) inherits(awards);

create table golden_ball
(
player_id int references players(id)
) inherits(awards);

create table tv_partners
(
id serial primary key,
title name
);

create table contracts_partners_tournaments
(
id serial primary key,
tv_partners_id int references tv_partners(id),
tournament_id int references tournament(id)
);

create table managers
(
id serial primary key,
fc_id int references fc_teams(id),
name varchar(100),
surname varchar(100),
birth date
);

create table goals_by_player
(
id serial primary key,
player_id int references players(id),
match_id int references matches(id),
scored_to_team int references fc_teams(id),
at_minute int,
at_second int
);

create table assists_by_player
(
id serial primary key,
player_id int references players(id),
match_id int references matches(id),
at_minute int,
at_second int
);



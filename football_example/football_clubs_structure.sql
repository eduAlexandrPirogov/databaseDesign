drop schema football_club_structure cascade;
create schema football_club_structure;

create table countries
(
   id serial,
   title varchar,
   primary key(id)
);

create table agents
(
	id serial,
	name varchar,
	surname varchar,
	education varchar(150),
	career_start date,
	primary key(id)
);

create table players
(
	id serial,
	country_id int,
	name varchar,
	surname varchar,
	primary key(id),
	constraint fk_country_player
		foreign key(country_id) references countries(id)
);

create table managers
(
   id serial,
   name varchar,
   surname varchar,
   birthdate date,
   start_manager date,
   education_country_id int,
   primary key(id),
   constraint fk_edu_country
   	foreign key(education_country_id) references countries(id)
);

create table goalkeeper_coachs
(
   id serial,
   name varchar,
   surname varchar,
   birthdate date,
   start_manager date,
   goalkeeper_minutes int,
   education_country_id int,
   primary key(id),
   constraint fk_edu_country
   	foreign key(education_country_id) references countries(id)
);

create table tactical_coachs
(
   id serial,
   name varchar,
   surname varchar,
   birthdate date,
   start_manager date,
   tactical_style varchar(100),
   education_country_id int,
   primary key(id),
   constraint fk_edu_country
   	foreign key(education_country_id) references countries(id)
);

create table physical_coach
(
   id serial,
   name varchar,
   surname varchar,
   birthdate date,
   start_manager date,
   education varchar(100),
   education_country_id int,
   primary key(id),
   constraint fk_edu_country
   	foreign key(education_country_id) references countries(id)
);

create table scouts 
(
   id serial,
   name varchar,
   surname varchar,
   birthdate date,
   start_scouts date,
   education_country_id int,
   primary key(id),
   constraint fk_edu_country
   	foreign key(education_country_id) references countries(id)
);

create table manager_squads
(
	guid bigserial,
	id int8,
	manager_id int,
	goalkeeper_coach int,
	physical_coach int,
	tactical_coach int,
	date_start date,
	date_end date, 
	primary key(id),
	unique(guid, id),
    constraint fk_manager_squad
   		foreign key(manager_id) references managers(id),
    constraint fk_goalkeeper_coachs_squad
   		foreign key(goalkeeper_coach) references goalkeeper_coachs(id),
    constraint fk_physical_coachs_squad
   		foreign key(physical_coach) references physical_coach(id),
    constraint fk_tactical_coachs_squad
   		foreign key(tactical_coach) references tactical_coachs(id)
	
);

create table football_clubs
(
	id serial,
	title varchar,
	country_id int,
	primary key(id),
	constraint fk_fc_country
		foreign key(country_id) references countries(id)
);

create table scouts_contracts
(
	id bigserial,
	scout_id int,
	fc_id int,
	date_start date,
	date_expire date,
	contract_sum int,
	primary key(id),
	constraint fk_scouts_contracts_fc
		foreign key(fc_id) references football_clubs(id),
	constraint fk_scouts_contracts_scouts
		foreign key(scout_id) references scouts(id)
);

create table stadiums
(
	id bigserial,
	fc_id int,
	title varchar,
	seats int,
	primary key(id),
	constraint fk_stadium_fc 
		foreign key(fc_id) references football_clubs(id)
);


create table managers_squads_contracts
(
	id bigserial,
	fc_id int,
	squad_id int,
	contract_sum int,
	contract_start date,
	contract_expire date,
	primary key(id),
	constraint fk_ms_contract_fc
		foreign key(fc_id) references football_clubs(id),
	constraint fk_ms_manager_squads_fc
		foreign key(squad_id) references manager_squads(id)
);



create table injuries
(
   id serial,
   player_id int8,
   type varchar,
   date_start date,
   date_end date,
   primary key(id),
   constraint fk_injuries
   	foreign key (player_id) references
   		players(id)
);

create table agents_players_contracts
(
   id bigserial,
   player_id int8,
   agent_id int8,
   begin_date date,
   exparation_date date,
   contract_sum int8,
   primary key(id, player_id, agent_id),
   constraint fk_contract_player_w_agents
   		foreign key(player_id) references players(id),
   constraint fk_contract_agents_w_players
   		foreign key(agent_id) references agents(id)
);

create table transfers
(
	id bigserial,
	player_id int,
	fc_id_from int,
	fc_id_to int,
	transfer_date date,
	transfer_sum int,
	primary key(id),
	constraint fk_transfers_players
		foreign key(player_id) references players(id),
	constraint fk_transfers_fc_to
		foreign key(fc_id_from) references football_clubs(id),
	constraint fk_transfers_fc_from
		foreign key(fc_id_to) references football_clubs(id)
);

create table players_fc_contracts
(
	id bigserial,
	player_id int,
	fc_id int,
	date_start date,
	date_expire date,
	player_month_salary int,
	primary key(id),
	constraint fk_constracts_players
		foreign key(player_id) references players(id),
	constraint fk_constracts_fc
		foreign key(fc_id) references football_clubs(id)
);







 

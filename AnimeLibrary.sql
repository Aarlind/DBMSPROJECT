
create database AnimeLibrary
use AnimeLibrary

create table Anime
(
	EmriAnimese varchar(40) PRIMARY KEY,
	Zhanri varchar(10) not null,
	DataLansimit date ,
	DataMbarimit date, 
	Buxheti money
	
);
create table Manga (
	ISBN char (30) PRIMARY KEY,
	Zhanri varchar(10) not null,
	Buxheti decimal,
	DataLansimit date ,
	DataMbarimit date, 
	NrIFaqeve char(5) not null,
	NumriK char(4),
	Titulli varchar(30) not null,
	FK_EmriAnimese varchar(40) foreign key references Anime(EmriAnimese)
);
ALTER TABLE [Manga]
ALTER COLUMN [NrIFaqeve] int not null

GO
create table StreamingPlatform(
	Emri_Stream varchar(30) Primary Key
);
alter table StreamingPlatform
add StreamServers varchar(20) not null;

GO
create table Transmetohet(
	EmriAnimese varchar(40),
	Emri_Stream varchar(30),
	Primary key(EmriAnimese, Emri_Stream),
	foreign key(EmriAnimese) references Anime(EmriAnimese),
	foreign key(Emri_Stream) references StreamingPlatform(Emri_Stream)
);

go
create table ShtepiaBotuese(
Emri_ShtepiseB varchar(30) Primary Key
);

create table Boton(
ISBN char (30),
Emri_ShtepiseB varchar(30),
Primary Key(ISBN, Emri_ShtepiseB),
foreign key (ISBN) references Manga(ISBN),
foreign key(Emri_ShtepiseB) references ShtepiaBotuese(Emri_ShtepiseB)
);


create table Orari(
	Orari_Id char(10) primary key,
	DataO date not null, 
	Koha time not null
);


create table StudioAnimimi(
	Emri_Studios varchar(30) primary key,
	Nr_Punterove int not null, 
	Nr_Paisjeve int not null
);
ALTER TABLE [StudioAnimimi]
ALTER COLUMN [Nr_Punterove] int not null
ALTER TABLE [StudioAnimimi]
ALTER COLUMN [Nr_Paisjeve] int not null

create table Autori(
	Nr_Id int identity(1,1) Primary Key,
	Emri varchar(15) not null,
	Mbiemri varchar(15) not null,
	Qyteti varchar(15) not null,
	ZipKodi char(5) not null,
	Emri_Rruges varchar(20),
	Nr_Shtepise char(3)
);


create table Telefoni(
	Nr_Tel char(15),
	Nr_ID int not null references Autori(Nr_ID),
	constraint Nr_Tel_Pk primary key(Nr_Tel, Nr_ID)
);

create table Email(
	Email char(25),
	Nr_ID int not null references Autori(Nr_ID),
	constraint Email_Pk primary key(Email, Nr_ID)
);

create table Aktori(
	Nr_Id_Aktori int identity(1,1) Primary Key,
	Emri varchar(15) not null,
	Mbiemri varchar(15) not null,
	Pervoja_Punes varchar(30),
	Paga money default 800
);
alter table [Aktori] 
alter column [Pervoja_Punes] varchar(40) not null

create table Bashkepunojne(
Primary key(Nr_ID, Nr_ID_Aktori),
	Nr_ID int not null references Autori(Nr_ID),
	Nr_ID_Aktori int not null references Aktori(Nr_ID_Aktori),
);


create table PerformancaLive(
	EmriAnimese varchar(40),
	Emri_Stream varchar(30),
	Nr_ID_Aktori int,
	Nr_ID int,
	Primary key(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID),
	foreign key(Nr_ID, Nr_ID_Aktori) references Bashkepunojne(Nr_ID, Nr_ID_Aktori),
	foreign key(EmriAnimese) references Anime(EmriAnimese),
	foreign key(Emri_Stream) references StreamingPlatform(Emri_Stream),
	foreign key(Nr_ID_Aktori) references Aktori(Nr_ID_Aktori),
	foreign key(Nr_ID) references Autori(Nr_ID)
);

create table Ka(
	Emri_Stream varchar (30),
	Orari_ID char(10),
	Primary key(Emri_Stream, Orari_Id),
	foreign key(Emri_Stream) references StreamingPlatform(Emri_Stream),
	foreign key(Orari_ID) references Orari(Orari_ID)
);
	
create table Audienca(
	Audienca_ID int identity(10,10) Primary key,
	Emri varchar(20) not null,
	Mbiemri varchar(20) not null,
);


create table EmailAudienca(
	EmailAudienca char(25) not null,
	Audienca_ID int not null references Audienca(Audienca_ID),
	constraint EmailA_Pk primary key(EmailAudienca, Audienca_ID)
);

create table Lexuesi(
	Audienca_ID_Lexuesi int identity(10,10) not null references Audienca(Audienca_ID),
	Vleresimi int check(Vleresimi between 1 and 10) not null,
	Analiza varchar(50),
	Primary key(Audienca_ID_Lexuesi)
);
create table Shikuesi(
	Audienca_ID_Shikuesi int identity(10,10) not null references Audienca(Audienca_ID),
	Parashikimi varchar(50),
	Komenti varchar(50),
	Primary key(Audienca_ID_Shikuesi),
	
);
alter table [Shikuesi]
add Vleresimi int check(Vleresimi between 1 and 10) 


create table Vlereson(
	Audienca_ID int,
	EmriAnimese varchar(40),
	ISBN char(30),
	Primary key(Audienca_ID, EmriAnimese, ISBN),
	foreign key(Audienca_ID) references Audienca(Audienca_ID),
	foreign key(EmriAnimese) references Anime(EmriAnimese),
	foreign key(ISBN) references Manga(ISBN),
);

create table AutoriAnimeManga(
	Nr_ID int,
	EmriAnimese varchar(40),
	ISBN char (30),
	Primary key(Nr_ID, EmriAnimese, ISBN),
	foreign key(Nr_ID) references Autori(Nr_ID),
	foreign key(EmriAnimese) references Anime(EmriAnimese),
	foreign key(ISBN) references Manga(ISBN)
);


create table Cmimi(
	EmriAnimese varchar(40) not null references Anime(EmriAnimese),
	ISBN char(30) not null references Manga(ISBN),
	Lloji varchar(10) not null unique,
	NrIVleresimeve int not null,
	NrICmimeve int not null,
	constraint Lloji_Pk primary key(EmriAnimese, ISBN, Lloji)
--	FK_EmriAnimese varchar(40) foreign key references Anime(EmriAnimese),
--	FK_ISBN char(30) foreign key references Manga(ISBN)
);


create table Personazhi(
	ID_Personazhi int identity(1,1),
	EmriAnimese varchar(40),
	ISBN char(30),
	Primary key(ID_Personazhi, EmriAnimese, ISBN),
	foreign key(EmriAnimese) references Anime(EmriAnimese),
	foreign key(ISBN) references Manga(ISBN)
);
Alter table Personazhi 
add Gjinia char(1), check(Gjinia IN('M', 'F'));
Alter table Personazhi 
add EmriP varchar(30) not null, Mbiemri varchar(30), Roli varchar(30), check(Roli IN('Protagonist', 'Antagonist', 'Deuteragonist', 'Terciar'))
Alter table Personazhi 
add [Nr_Id_Aktori] int foreign key references Aktori(Nr_Id_Aktori)
alter table [Anime]
ADD [Fk_Orari_ID] char(10) foreign key references Orari(Orari_ID),
[Fk_EStudios] varchar (30) foreign key references StudioAnimimi(Emri_Studios)
alter table Cmimi 
alter column Lloji varchar(50) not null

ALTER TABLE Autori
add Paga money default 1000

	



-----------INSERTIMI I VLERAVE BRENDA TABELAVE------------------
insert into Orari(Orari_Id, DataO, Koha) values('1', '02/15/2022', '15:30');
insert into Orari(Orari_Id, DataO, Koha) values('2', '06/16/2022', '20:00');
insert into Orari(Orari_Id, DataO, Koha) values('3', '01/17/2022', '19:15');
insert into Orari(Orari_Id, DataO, Koha) values('4', '03/18/2022', '12:35');
insert into Orari(Orari_Id, DataO, Koha) values('5', '06/19/2022', '11:45');
insert into Orari(Orari_Id, DataO, Koha) values('6', '08/20/2022', '13:15');
insert into Orari(Orari_Id, DataO, Koha) values('7', '11/21/2022', '19:00');
insert into Orari(Orari_Id, DataO, Koha) values('8', '10/22/2022', '18:15');
insert into Orari(Orari_Id, DataO, Koha) values('9', '12/23/2022', '10:15');
insert into Orari(Orari_Id, DataO, Koha) values('10', '11/24/2022', '09:35');
insert into Orari(Orari_Id, DataO, Koha) values('11', '12/25/2022', '08:15');
insert into Orari(Orari_Id, DataO, Koha) values('12', '05/26/2022', '05:00');
insert into Orari(Orari_Id, DataO, Koha) values('13', '09/27/2022', '07:05');
insert into Orari(Orari_Id, DataO, Koha) values('14', '03/28/2022', '05:45');
insert into Orari(Orari_Id, DataO, Koha) values('15', '08/29/2022', '23:20');
insert into Orari(Orari_Id, DataO, Koha) values('16', '05/30/2022', '22:20');
insert into Orari(Orari_Id, DataO, Koha) values('17', '09/01/2022', '00:10');
insert into Orari(Orari_Id, DataO, Koha) values('18', '02/02/2022', '13:10');
insert into Orari(Orari_Id, DataO, Koha) values('19', '01/03/2022', '14:20');
insert into Orari(Orari_Id, DataO, Koha) values('20', '05/04/2022', '11:30');
insert into Orari(Orari_Id, DataO, Koha) values('21', '09/06/2022', '10:00');
insert into Orari(Orari_Id, DataO, Koha) values('22', '06/10/2022', '14:40');
insert into Orari(Orari_Id, DataO, Koha) values('23', '04/09/2022', '19:35');
insert into Orari(Orari_Id, DataO, Koha) values('24', '02/15/2022', '21:35');
insert into Orari(Orari_Id, DataO, Koha) values('25', '02/15/2022', '20:30');

insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio1', '6', '10');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio2', '16', '32');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio3', '22', '45');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio4', '31', '54');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio5', '2', '8');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio6', '4', '11');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio7', '54', '87');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio8', '62', '69');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio9', '121', '199');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio10', '12', '25');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio11', '54', '87');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio12', '621', '1023');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio13', '142', '341');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio14', '14', '17');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio16', '12', '220');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio17', '224', '330');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio18', '76', '89');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio19', '84', '126');
insert into StudioAnimimi(Emri_Studios, Nr_Punterove, Nr_Paisjeve) values('Studio20', '292', '410');



insert into StreamingPlatform values('Stream1', 'Server 1');
insert into StreamingPlatform values('Stream2', 'Server 2');
insert into StreamingPlatform values('Stream3', 'Server 3');
insert into StreamingPlatform values('Stream4', 'Server 4');
insert into StreamingPlatform values('Stream5', 'Server 5');
insert into StreamingPlatform values('Stream6', 'Server 6');
insert into StreamingPlatform values('Stream7', 'Server 7');
insert into StreamingPlatform values('Stream8', 'Server 8');
insert into StreamingPlatform values('Stream9', 'Server 9');
insert into StreamingPlatform values('Stream10', 'Server 10');
insert into StreamingPlatform values('Stream11', 'Server 11');
insert into StreamingPlatform values('Stream12', 'Server 12');
insert into StreamingPlatform values('Stream13', 'Server 13');
insert into StreamingPlatform values('Stream14', 'Server 14');
insert into StreamingPlatform values('Stream15', 'Server 15');
insert into StreamingPlatform values('Stream16', 'Server 16');
insert into StreamingPlatform values('Stream17', 'Server 17');
insert into StreamingPlatform values('Stream18', 'Server 18');
insert into StreamingPlatform values('Stream19', 'Server 19');
insert into StreamingPlatform values('Stream20', 'Server 20');
insert into StreamingPlatform values('Stream21', 'Server 21');
insert into StreamingPlatform values('Stream22', 'Server 22');
insert into StreamingPlatform values('Stream23', 'Server 23');
insert into StreamingPlatform values('Stream24', 'Server 24');
insert into StreamingPlatform values('Stream25', 'Server 25');
insert into StreamingPlatform values('Stream26', 'Server 26');
insert into StreamingPlatform values('Stream27', 'Server 27');
insert into StreamingPlatform values('Stream28', 'Server 28');
insert into StreamingPlatform values('Stream29', 'Server 29');
insert into StreamingPlatform values('Stream30', 'Server 30');
								
insert into Ka(Emri_Stream, Orari_ID) values('Stream1', '1');
insert into Ka(Emri_Stream, Orari_ID) values('Stream2', '2');
insert into Ka(Emri_Stream, Orari_ID) values('Stream3', '3');
insert into Ka(Emri_Stream, Orari_ID) values('Stream4', '4');
insert into Ka(Emri_Stream, Orari_ID) values('Stream5', '5');
insert into Ka(Emri_Stream, Orari_ID) values('Stream6', '6');
insert into Ka(Emri_Stream, Orari_ID) values('Stream7', '7');
insert into Ka(Emri_Stream, Orari_ID) values('Stream8', '8');
insert into Ka(Emri_Stream, Orari_ID) values('Stream9', '9');
insert into Ka(Emri_Stream, Orari_ID) values('Stream10', '10');
insert into Ka(Emri_Stream, Orari_ID) values('Stream11', '11');
insert into Ka(Emri_Stream, Orari_ID) values('Stream12', '12');
insert into Ka(Emri_Stream, Orari_ID) values('Stream13', '13');
insert into Ka(Emri_Stream, Orari_ID) values('Stream14', '14');
insert into Ka(Emri_Stream, Orari_ID) values('Stream15', '15');
insert into Ka(Emri_Stream, Orari_ID) values('Stream16', '16');
insert into Ka(Emri_Stream, Orari_ID) values('Stream17', '17');
insert into Ka(Emri_Stream, Orari_ID) values('Stream18', '18');
insert into Ka(Emri_Stream, Orari_ID) values('Stream19', '19');
insert into Ka(Emri_Stream, Orari_ID) values('Stream20', '20');
insert into Ka(Emri_Stream, Orari_ID) values('Stream21', '21');
insert into Ka(Emri_Stream, Orari_ID) values('Stream22', '22');
insert into Ka(Emri_Stream, Orari_ID) values('Stream23', '23');
insert into Ka(Emri_Stream, Orari_ID) values('Stream24', '24');
insert into Ka(Emri_Stream, Orari_ID) values('Stream25', '25');
		
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Demon Slayer', 'Action', '01/02/2019', '04/04/2025', '5288000', '25', 'Studio6');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Attack on Titan', 'Action', '12/05/2012', '10/06/2022', '122880', '20', 'Studio8');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Naruto Shipudden', 'Action', '12.24.2010', '10.04.2019', '431000', '12', 'Studio3');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('My Hero Academia', 'Action', '01.19.2008', '02.06.2022', '80000', '5', 'Studio14');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Haikyuu', 'Sport', '01.02.2013', '05.25.2019', '81000', '3', 'Studio6');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Death Note', 'Psycholog.', '10.21.2004', '10.07.2015', '411000', '13', 'Studio11');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Dragon Ball', 'Shonen', '09.11.2000', null, '200000', '4', 'Studio6');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Fruits Basket', 'Romance', '01.26.2009', '08.11.2018', '910000', '12', 'Studio5');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values(' Ouran High School Host Club', 'Comedy', '02.10.2014', '09.03.2020', '220000','17', 'Studio11');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('One Piece', 'Adventure', '08.25.1998', null, '150000', '12', 'Studio6');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Sorcerous Stabber Orphen: Wayward Journe', 'Adventure', '09.10.2020', '01.01.2022', '250000', '3', 'Studio3');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('The Seven Deadly Sins', 'Adventure', '01.11.2014', '01.01.2020', '1250000', '19', 'Studio8');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('10 Tokyo Warriors', 'Adventure', '01.20.2004', '05.03.2010', '3250000', '12', 'Studio14');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Fullmetal Alchemist', 'Action', '01.23.2016', '02.12.2019', '2250000', '9', 'Studio5');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Dragon Ball GT', 'Action', '09.30.1983', '05.12.2001', '2250000', '13', 'Studio1');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Dragon Ball Super', 'Action', '09.22.1986', '03.06.1995', '2250000', '14', 'Studio8');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Dragon Ball Z', 'Action', '01.26.1986', '06.11.2001', '2250000', '20', 'Studio14');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Dragon Ball Z Kai', 'Action', '03.13.1999', '01.11.2005', '2250000', '23', 'Studio11');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Ghost Hunt', 'Horror', '09.10.2004', '02.12.2011', '190000', '25', 'Studio20');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Naruto', 'Action', '03.01.2014', '01.12.2019', '2530000', '10', 'Studio8');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Gintama', 'Comedy', '09.11.2009', '09.05.2015', '1450000', '9', 'Studio6');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Space Dandy', 'Comedy', '09.11.2014', null, '670000', '6', 'Studio10');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Food Wars: Shokugeki no Soma', 'Comedy', '05.02.2014', null, '17000', '6', 'Studio4');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Another', 'Horror', '05.02.2014', null, '117000', '3', 'Studio10');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Blood: The Last Vampire', 'Horror', '09.12.2000', null, '117000', '5', 'Studio13');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Monster', 'Horror', '08.04.1911', '05.01.2021', '222010', '2', 'Studio3');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Monster1', 'Horror', '08.05.1972', '01.05.2021', '112310', '1', 'Studio1');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Detective Conan: The Scarlet Bullet', 'Mystery', '09.25.2012', '01.05.2022', '3112310', '1', 'Studio20');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('Summer Ghost', 'Fantasy', '11.15.2012', '11.02.2031', '3112310', '10', 'Studio1');
insert into Anime(EmriAnimese, Zhanri, DataLansimit, DataMbarimit, Buxheti, Fk_Orari_ID, Fk_EStudios) values('B The Beginning', 'Action', '12.15.2019', '11.02.2033', '4312310', '10', 'Studio2');

---------------
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese) values('971-3-22-148411-1', 'Action', '5288000', '01/02/2019', '04/04/2025', 150, 'I', 'Kapitulli', 'Demon Slayer');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('692-0-15-118242-7', 'Action', '122880', '02/05/2012', '10/06/2022', 230, 'II', 'Kapitulli', 'Attack on Titan');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('513-9-65-138159-0', 'Action', '431000', '10.04.2010', '10.04.2019', 1220, 'III', 'Kapitulli', 'Naruto Shipudden');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('967-2-32-128652-6', 'Action', '80000', '01.09.2008', '02.06.2022', 410, 'VI', 'Kapitulli', 'My Hero Academia');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('366-5-19-198790-8', 'Sport', '81000', '01.02.2013', '05.04.2019', 110, 'VIII', 'Kapitulli', 'Haikyuu');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('264-8-78-188880-3', 'Psycholog.', '411000', '10.02.2004', '10.07.2015', 150, 'IV', 'Kapitulli', 'Death Note');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('119-7-09-158015-6', 'Shonen', '200000', '09.10.2000', null, 2150, 'X', 'Kapitulli', 'Dragon Ball');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('720-6-16-168729-5', 'Romance', '910000', '01.15.2009', '08.11.2018', 700, 'XI', 'Kapitulli', 'Fruits Basket');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('765-1-12-148638-2', 'Comedy', '220000', '02.18.2014', '09.03.2020', 910, 'IX', 'Kapitulli', ' Ouran High School Host Club');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('068-2-11-123636-1', 'Adventure', '150000', '08.14.1998', null, 1050, 'XIII', 'Kapitulli', 'One Piece');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('061-1-31-323331-5', 'Adventure', '250000', '09.30.2020', '01.01.2022', 1020, 'V', 'Kapitulli', 'Sorcerous Stabber Orphen: Wayward Journe');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('011-4-32-223232-4', 'Adventure', '1250000', '01.21.2004', '01.01.2020', 1220, 'VI', 'Kapitulli', 'The Seven Deadly Sins');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('023-5-05-221231-1', 'Adventure', '325000', '02.21.2002', '01.05.2008', 290, 'II', 'Kapitulli', '10 Tokyo Warriors');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('044-4-95-326237-7', 'Action', '2250000', '02.01.2013', '05.03.2010', 980, 'III', 'Kapitulli', 'Fullmetal Alchemist');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('294-9-78-126936-9', 'Action', '2250000', '03.11.1980', '05.03.1990', 720, 'VI', 'Kapitulli', 'Dragon Ball GT');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('124-1-10-121926-1', 'Action', '2250000', '04.27.1983', '05.03.1987', 1380, 'X', 'Kapitulli', 'Dragon Ball Super');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('111-4-18-526536-5', 'Action', '2250000', '05.19.1990', '05.03.2000', 980, 'III', 'Kapitulli', 'Dragon Ball Z');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('097-7-48-093934-3', 'Action', '2250000', '06.12.1999', '05.03.2001', 280, 'IV', 'Kapitulli', 'Dragon Ball Z Kai');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('765-4-89-122931-1', 'Horror', '190000', '07.14.2002', '05.03.2009', 600, 'IV', 'Kapitulli', 'Ghost Hunt');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('560-5-02-193632-7', 'Action', '2530000', '09.12.2010', '05.03.2015', 2000, 'XV', 'Kapitulli', 'Naruto');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('027-1-66-066964-6', 'Comedy', '1450000', '03.25.2007', '05.03.2012', 400, 'V', 'Kapitulli', 'Gintama');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('192-2-83-006060-9', 'Comedy', '670000', '06.29.2012', '05.03.2018', 650, 'VI', 'Kapitulli', 'Space Dandy');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('222-7-91-019044-4', 'Comedy', '17000', '08.23.2012', '05.03.2019', 150, 'II', 'Kapitulli', 'Food Wars: Shokugeki no Soma');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('315-2-54-113054-5', 'Horror', '117000', '04.12.2012', '05.03.2020', 150, 'III', 'Kapitulli', 'Another');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('219-9-16-998651-0', 'Horror', '117000', '08.04.1998', '05.03.2020', 1150, 'VIII', 'Kapitulli', 'Blood: The Last Vampire');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('531-2-12-14621-1', 'Horror', '222010', '08.04.1911', '05.01.2021', 250, 'VIII', 'Kapitulli', 'Monster');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('315-1-21-336411-2', 'Fantasy', '133010', '09.05.2011', '11.11.2020', 350, 'V', 'Kapitulli', 'Summer Ghost');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('981-2-35-441111-1', 'Mystery', '12212', '08.16.2011', '12.02.2020', 350, 'V', 'Kapitulli', 'Detective Conan: The Scarlet Bullet');
insert into Manga(ISBN, Zhanri, Buxheti, DataLansimit, DataMbarimit, NriFaqeve, NumriK, Titulli, FK_EmriAnimese)  values('113-6-63-041415-0', 'Action', '342212', '07.19.2016', '12.02.2020', 350, 'VI', 'Kapitulli', 'B The Beginning');

 
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Attack on Titan', 'Stream1');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Demon Slayer', 'Stream2');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Death Note', 'Stream3');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Haikyuu', 'Stream3');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Dragon Ball', 'Stream5');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Dragon Ball Z', 'Stream6');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('The Seven Deadly Sins', 'Stream7');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('One Piece', 'Stream8');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Ghost Hunt', 'Stream9');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Fruits Basket', 'Stream10');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Space Dandy', 'Stream11');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Naruto', 'Stream12');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Gintama', 'Stream13');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Food Wars: Shokugeki no Soma', 'Stream14');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Another', 'Stream15');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('My Hero Academia', 'Stream16');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Fullmetal Alchemist', 'Stream17');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Dragon Ball Z Kai', 'Stream19');
insert into Transmetohet(EmriAnimese, Emri_Stream) values(' Ouran High School Host Club', 'Stream21');
insert into Transmetohet(EmriAnimese, Emri_Stream) values('Blood: The Last Vampire', 'Stream22');

 

insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 1');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 2');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 3');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 4');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 5');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 6');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 7');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 8');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 9');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 10');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 11');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 12');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 13');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 14');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 15');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 16');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 17');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 18');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 19');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 20');
insert into ShtepiaBotuese(Emri_ShtepiseB) values('ShtepiaBotuese 21');




insert into Boton(ISBN, Emri_ShtepiseB) values('971-3-22-148411-1', 'ShtepiaBotuese 1');
insert into Boton(ISBN, Emri_ShtepiseB) values('692-0-15-118242-7', 'ShtepiaBotuese 2');
insert into Boton(ISBN, Emri_ShtepiseB) values('513-9-65-138159-0', 'ShtepiaBotuese 3');
insert into Boton(ISBN, Emri_ShtepiseB) values('366-5-19-198790-8', 'ShtepiaBotuese 4');
insert into Boton(ISBN, Emri_ShtepiseB) values('264-8-78-188880-3', 'ShtepiaBotuese 5');
insert into Boton(ISBN, Emri_ShtepiseB) values('119-7-09-158015-6', 'ShtepiaBotuese 6');
insert into Boton(ISBN, Emri_ShtepiseB) values('720-6-16-168729-5', 'ShtepiaBotuese 7');
insert into Boton(ISBN, Emri_ShtepiseB) values('765-1-12-148638-2', 'ShtepiaBotuese 8');
insert into Boton(ISBN, Emri_ShtepiseB) values('068-2-11-123636-1', 'ShtepiaBotuese 9');
insert into Boton(ISBN, Emri_ShtepiseB) values('692-0-15-118242-7', 'ShtepiaBotuese 10');
insert into Boton(ISBN, Emri_ShtepiseB) values('294-9-78-126936-9', 'ShtepiaBotuese 11');
insert into Boton(ISBN, Emri_ShtepiseB) values('219-9-16-998651-0', 'ShtepiaBotuese 12');
insert into Boton(ISBN, Emri_ShtepiseB) values('315-2-54-113054-5', 'ShtepiaBotuese 13');
insert into Boton(ISBN, Emri_ShtepiseB) values('222-7-91-019044-4', 'ShtepiaBotuese 14');
insert into Boton(ISBN, Emri_ShtepiseB) values('192-2-83-006060-9', 'ShtepiaBotuese 15');
insert into Boton(ISBN, Emri_ShtepiseB) values('027-1-66-066964-6', 'ShtepiaBotuese 16');
insert into Boton(ISBN, Emri_ShtepiseB) values('560-5-02-193632-7', 'ShtepiaBotuese 17');
insert into Boton(ISBN, Emri_ShtepiseB) values('765-4-89-122931-1', 'ShtepiaBotuese 18');
insert into Boton(ISBN, Emri_ShtepiseB) values('294-9-78-126936-9', 'ShtepiaBotuese 19');
insert into Boton(ISBN, Emri_ShtepiseB) values('044-4-95-326237-7', 'ShtepiaBotuese 20');
insert into Boton(ISBN, Emri_ShtepiseB) values('531-2-12-14621-1', 'ShtepiaBotuese 15');
insert into Boton(ISBN, Emri_ShtepiseB) values('967-2-32-128652-6', 'ShtepiaBotuese 14');
insert into Boton(ISBN, Emri_ShtepiseB) values('981-2-35-441111-1', 'ShtepiaBotuese 12');
insert into Boton(ISBN, Emri_ShtepiseB) values('315-1-21-336411-2', 'ShtepiaBotuese 12');
insert into Boton(ISBN, Emri_ShtepiseB) values('531-2-12-14621-1', 'ShtepiaBotuese 13');
insert into Boton(ISBN, Emri_ShtepiseB) values('219-9-16-998651-0', 'ShtepiaBotuese 14');
insert into Boton(ISBN, Emri_ShtepiseB) values('315-2-54-113054-5', 'ShtepiaBotuese 14');
insert into Boton(ISBN, Emri_ShtepiseB) values('113-6-63-041415-0', 'ShtepiaBotuese 14');				


insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Yoshitoshi', 'ABe', 'Tokyo', '24561', 'Street1', '23', '1100.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Chako', 'Abeno', 'Kyoto', '26261', 'Street2', '12', '2200.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Mitsuru', 'Adachi', 'Hiroshima', '22161', 'Street3', '2', '1050.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Tadashi', 'Agi', 'Sapporo', '14231', 'Street4', '33', '1420.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Koji', 'Aihara', 'Yokohama', '15234', 'Street5', '41', '1410.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Mizuho', 'Aimoto', 'Nagoya', '6123', 'Street6', '72', '1180.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Michiyo', 'Akaishi', 'Fukoka', '15301', 'Street7', '55', '1920.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Nami', 'Akimoto', 'Koba', '20004', 'Street8', '21', '2155.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Osamu', 'Akimoto', 'Koba', '98512', 'Street9', '35', '1222.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Matsuri', 'Akino', 'Koba', '45102', 'Street10', '56', '1440.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Katsu', 'Aki', 'Nagasaki', '25102', 'Street12', '92', '1500.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Fujio', 'Akatsuka', 'Nara', '40351', 'Street13', '123', '1670.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('George', 'Akiyama', 'Fukoka', '15032', 'Street14', '111', '1810.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Tamayo', 'Akiyama', 'Kanazawa', '19505', 'Street15', '15', '1510.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Amano', 'Akira', 'Kanazawa', '14102', 'Street16', '17', '1480.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Risu', 'Akizuki', 'Kitakyushu', '15102', 'Street17', '26', '1210.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Akira', 'Amano', 'Sendai', '10542', 'Street18', '27', '1890.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Kozue', 'Amano', 'Tokyo', '14032', 'Street19', '20', '1345.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Yoichi', 'Amano', 'Hiroshima', '54221', 'Street20', '1', '1543.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Yoshitaka', 'Amano', 'Sapporo', '21511', 'Street21', '12', '2550.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Mogura', 'Anagura', 'Yokohama', '51161', 'Street22', '154', '3150.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Masahiro', 'Anbe', 'Tokyo', '21781', 'Street23', '489', '4220.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Yuma', 'Ando', 'Nara', '20601', 'Street24', '123', '1655.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Ippongi', 'Bang', 'Osaka', '21161', 'Street25', '335', '1350.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Daichi', 'Banjou', 'Kyoto', '62061', 'Street11', '235', '1980.00');
insert into Autori(Emri, Mbiemri, Qyteti, ZipKodi, Emri_Rruges, Nr_Shtepise, Paga) values('Filan', 'Fisteku', 'Prishtine', '62221', 'Street24', '25', '1770.00');


insert into Telefoni(Nr_Tel, Nr_ID) values('+8178523647', '1');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8188522177', '2');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8198065847', '3');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8128523055', '4');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8118523011', '5');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8128523012', '6');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8138522815', '7');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8198522828', '8');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8168522739', '9');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8178521546', '10');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8148522354', '11');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8138523267', '12');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8128529183', '13');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8118522002', '14');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8178523091', '15');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8138524953', '16');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8148525846', '17');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8168526757', '18');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8198529662', '19');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8168528683', '20');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8168521734', '21');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8178521417', '22');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8178521629', '23');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8108521440', '24');
insert into Telefoni(Nr_Tel, Nr_ID) values('+8108522330', '25');

insert into Email(Email, Nr_ID) values('youshit@gmail.com', '1');
insert into Email(Email, Nr_ID) values('chako@gmail.com', '2');
insert into Email(Email, Nr_ID) values('mitsuru@gmail.com', '3');
insert into Email(Email, Nr_ID) values('tadashi@gmail.com', '4');
insert into Email(Email, Nr_ID) values('koji1@gmail.com', '5');
insert into Email(Email, Nr_ID) values('mizuhp@gmail.com', '6');
insert into Email(Email, Nr_ID) values('mich@gmail.com', '7');
insert into Email(Email, Nr_ID) values('nami@gmail.com', '8');
insert into Email(Email, Nr_ID) values('osamu@gmail.com', '9');
insert into Email(Email, Nr_ID) values('matsuri@gmail.com', '10');
insert into Email(Email, Nr_ID) values('fatso@gmail.com', '11');
insert into Email(Email, Nr_ID) values('fyjt@gmail.com', '12');
insert into Email(Email, Nr_ID) values('grgt@gmail.com', '13');
insert into Email(Email, Nr_ID) values('tamayoa@gmail.com', '14');
insert into Email(Email, Nr_ID) values('amanan@gmail.com', '15');
insert into Email(Email, Nr_ID) values('risu@gmail.com', '16');
insert into Email(Email, Nr_ID) values('akira@gmail.com', '17');
insert into Email(Email, Nr_ID) values('kozue@gmail.com', '18');
insert into Email(Email, Nr_ID) values('yoichi@gmail.com', '19');
insert into Email(Email, Nr_ID) values('yoshitaka@gmail.com', '20');
insert into Email(Email, Nr_ID) values('mogura@gmail.com', '21');
insert into Email(Email, Nr_ID) values('masahira@gmail.com', '22');
insert into Email(Email, Nr_ID) values('yuma@gmail.com', '23');
insert into Email(Email, Nr_ID) values('ipnngi@gmail.com', '24');
insert into Email(Email, Nr_ID) values('daichibanj@gmail.com', '25');


insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Kamiya', 'Hiroshi','AOT, Angel Beats', '1500.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Seki', 'Tomokazu','Hunter X Hunter, Full Metal Panic', '1980.90');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Taneda', 'Risa', 'High School DxD', '2500.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Kaito', 'Ishikawa', 'One Punch Man, Haikyuu', '1200.20');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Seki', 'Tomokazu', 'Fate/Zero, Steins;Gate', '800.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Kaji', 'Yuki', 'Shingeki No Kyojin, Noragami', '1700.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Sugiyama', 'Noriyaki', 'Naruto, Bleach', '2500.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Suzumura', 'Kenichi', 'D-Gray Man, Free!', '3500.80');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Ishida', 'Akira', 'Gundam Seed, Fairytail', '1100.10');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Kugimiya', 'Rie', 'Shakugan no Shana, Fairytail', '1500.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Fukiyama', 'Jun', 'Assassination Classroom, Code GEass', '1500.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Inoue', 'Kazuhiko', 'Naruto, Fruit Basket', '780.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Eguchi', 'Takuya', 'Yugioh!, Inazuma Eleven GO 2', '1850.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Miyano', 'Mamoru', 'Death Note, Full Metal Alchemist', '3250.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Ono', 'Daisuke', 'Koroshitsuji, Shingeki No Kyojin', '2900.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Suzuki', 'Tatsuhisa', 'Iwatobi Swim Club, My Little Monster', '2500.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Koshimizu', 'Ami', 'Kill la Kill, Sailor Moon Crystal', '2100.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Sato', 'Satomi', 'K-On!, Fairytail', '1150.80');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Ise', 'Mariya', 'Pokemon XY, Hunter x Hunter', '1700.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Hiroshi', 'Kamiya', 'Dragon Ball', '805.50');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Daisuke', 'Ono', 'Free!, Naruto Shippuden', '1400.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Colleen', 'Clinkenbeard', 'Pokemon, Gundam Seed', '1480.95');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Christopher', 'Sabat', 'Fruit Basket, One Punch Man', '990.95');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Mamoru', 'Miyano', 'Bleach', '870.00');
insert into Aktori(Emri, Mbiemri, Pervoja_Punes, Paga) values('Monica', 'Rial', 'Code Geass, Monster', '1300.50');



insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('1', '22');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('1', '24');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('1', '25');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('5', '25');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('5', '22');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('5', '12');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('21', '5');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('4', '15');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('4', '13');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('4', '14');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('3', '2');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('16', '10');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('3', '4');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('3', '5');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('4', '22');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('5', '21');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('16', '20');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('17', '19');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('8', '18');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('9', '17');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('11', '16');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('14', '15');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('12', '14');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('13', '13');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('14', '12');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('15', '11');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('13', '10');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('17', '9');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('18', '8');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('19', '7');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('20', '6');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('20', '5');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('22', '4');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('23', '3');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('24', '2');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('25', '1');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('8', '24');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('8', '11');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('9', '11');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('9', '15');
insert into Bashkepunojne(Nr_ID, Nr_ID_Aktori) values('10', '17');



insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Attack on Titan', 'Stream1', '1', '25');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Attack on Titan', 'Stream2', '2', '24');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Demon Slayer', 'Stream2', '3', '23');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Death Note', 'Stream3', '4', '22');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Haikyuu', 'Stream3', '5', '21');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Dragon Ball', 'Stream5', '6', '20');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Dragon Ball Z', 'Stream6', '7', '19');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('The Seven Deadly Sins', 'Stream7', '8', '18');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('One Piece', 'Stream8', '9', '17');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Dragon Ball Super', 'Stream20', '10', '16');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Sorcerous Stabber Orphen: Wayward Journe', 'Stream23', '11', '15');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Dragon Ball GT', 'Stream24', '12', '14');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('10 Tokyo Warriors', 'Stream8', '13', '13');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Ghost Hunt', 'Stream9', '14', '12');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Fruits Basket', 'Stream10', '22', '1');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Space Dandy', 'Stream11', '24', '1');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Naruto', 'Stream12', '17', '9');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Gintama', 'Stream13', '18', '8');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Food Wars: Shokugeki no Soma', 'Stream14', '15', '4');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Another', 'Stream15', '12', '5');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('My Hero Academia', 'Stream16', '21', '5');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Fullmetal Alchemist', 'Stream17', '22', '4');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Dragon Ball Z Kai', 'Stream19', '14', '4');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values(' Ouran High School Host Club', 'Stream21', '15', '9');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Blood: The Last Vampire', 'Stream22', '11', '8');
insert into PerformancaLive(EmriAnimese, Emri_Stream, Nr_ID_Aktori, Nr_ID) values('Blood: The Last Vampire', 'Stream23', '12', '5');

insert into Audienca(Emri, Mbiemri) values('Tanvir', 'Farley');
insert into Audienca(Emri, Mbiemri) values('Eugene', 'Morrow');
insert into Audienca(Emri, Mbiemri) values('Taiba', 'Peacock');
insert into Audienca(Emri, Mbiemri) values('Mirza', 'Gibbs');
insert into Audienca(Emri, Mbiemri) values('Melvin ', 'Washington');
insert into Audienca(Emri, Mbiemri) values('Caris', 'Pickett');
insert into Audienca(Emri, Mbiemri) values('Tiffany', 'Morales');
insert into Audienca(Emri, Mbiemri) values('Harleen', 'Wolf');
insert into Audienca(Emri, Mbiemri) values('Shiv', 'Dickinson');
insert into Audienca(Emri, Mbiemri) values('Beatrix', 'Fernandez');
insert into Audienca(Emri, Mbiemri) values('Cassian', 'ODoherty');
insert into Audienca(Emri, Mbiemri) values('Ramone', 'Reader');
insert into Audienca(Emri, Mbiemri) values('Emir', 'Hudson');
insert into Audienca(Emri, Mbiemri) values('Junior', 'Zimmerman');
insert into Audienca(Emri, Mbiemri) values('Corban', 'Barnes');
insert into Audienca(Emri, Mbiemri) values('Cienna', 'Dunn');
insert into Audienca(Emri, Mbiemri) values('Lola-Rose', 'Finney');
insert into Audienca(Emri, Mbiemri) values('Saxon', 'Vinson');
insert into Audienca(Emri, Mbiemri) values('Andrea', 'Traynor');
insert into Audienca(Emri, Mbiemri) values('Amira', 'Dyer');
insert into Audienca(Emri, Mbiemri) values('Kayson', 'Graham');
insert into Audienca(Emri, Mbiemri) values('Greta', 'Kouma');
insert into Audienca(Emri, Mbiemri) values('Brenna', 'Lewis');
insert into Audienca(Emri, Mbiemri) values('Kimora', 'Robertson');
insert into Audienca(Emri, Mbiemri) values('Bridget', 'Stout');
insert into Audienca(Emri, Mbiemri) values('Tiago', 'Gutierrez');
insert into Audienca(Emri, Mbiemri) values('Mea', 'Cooley');
insert into Audienca(Emri, Mbiemri) values('Alara', 'Medina');
insert into Audienca(Emri, Mbiemri) values('Yolanda', 'Washington');
insert into Audienca(Emri, Mbiemri) values('Cayson', 'Flower');
insert into Audienca(Emri, Mbiemri) values('Ruby-May', 'Santos');
insert into Audienca(Emri, Mbiemri) values('Jordi', 'Hogan');
insert into Audienca(Emri, Mbiemri) values('Ffion', 'Talbot');
insert into Audienca(Emri, Mbiemri) values('Benjamin', 'Hackett');
insert into Audienca(Emri, Mbiemri) values('Isaak', 'Sexton');
insert into Audienca(Emri, Mbiemri) values('Aurora', 'Horn');
insert into Audienca(Emri, Mbiemri) values('Celia', 'Bowers');
insert into Audienca(Emri, Mbiemri) values('Zohaib', 'Palmer');
insert into Audienca(Emri, Mbiemri) values('Jameel', 'Shepherd');
insert into Audienca(Emri, Mbiemri) values('Kiaan', 'Oneal');

insert into EmailAudienca(EmailAudienca, Audienca_ID) values('kian@hotmail.com', '400');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('jsheph@live.com', '390');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('zohaibp@outlook.com', '380');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('cbss@live.com', '370');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('auroraa1@live.com', '360');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('ssaak.s@outlook.com', '350');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('benjhack@live.com', '340');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('ffiont@live.com', '330');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('jordhogan@outlook.com', '320');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('rmsantos@live.com', '310');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('cayson.flower@gmail.com', '300');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('yolandaa@gmail.com', '290');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('alara@outlook.com', '280');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('meacool@live.com', '270');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('tiagogut@outlook.com', '260');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('bridgetst@hotmail.com', '250');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('kimorarob@outlook.com', '240');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('brennalew@outlook.com', '230');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('gretako.m@outlook.com', '220');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('kayson.g@icloud.com', '210');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('amira-d@outlook.com', '200');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('andrea-traynor@icloud.com', '190');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('saxonvin@gmail.com', '180');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('lr1234@hotmail.com', '170');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('cienadunn-123@outlook.com', '160');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('corb-barn@live.com', '150');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('j.zimm@icloud.com', '140');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('emir-hudson1@gmail.com', '130');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('ramoneread@gmail.com', '120');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('cassodh@gmail.com', '110');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('beatrix-fern@live.com', '100');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('shiv123@live.com', '90');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('harleenw@live.com', '80');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('tiffanyt@hotmail.com', '70');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('carispick@hotmail.com', '60');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('melvwash@hotmail.com', '50');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('mirzagibss@gmail.com', '40');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('taibapeac@gmail.com', '30');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('morroveugene@live.com', '20');
insert into EmailAudienca(EmailAudienca, Audienca_ID) values('far-tanvir@icloud.com', '10');

insert into Lexuesi(Vleresimi, Analiza) values('5', 'Analiza1');
insert into Lexuesi(Vleresimi, Analiza) values('7', 'Analiza2');
insert into Lexuesi(Vleresimi, Analiza) values('9', 'Analiza3');
insert into Lexuesi(Vleresimi, Analiza) values('8', 'Analiza4');
insert into Lexuesi(Vleresimi, Analiza) values('2', 'Analiza5');
insert into Lexuesi(Vleresimi, Analiza) values('5', 'Analiza6');
insert into Lexuesi(Vleresimi, Analiza) values('3', 'Analiza7');
insert into Lexuesi(Vleresimi, Analiza) values('4', 'Analiza8');
insert into Lexuesi(Vleresimi, Analiza) values('8', 'Analiza9');
insert into Lexuesi(Vleresimi, Analiza) values('10', 'Analiza10');
insert into Lexuesi(Vleresimi, Analiza) values('6', 'Analiza11');
insert into Lexuesi(Vleresimi, Analiza) values('4', 'Analiza12');
insert into Lexuesi(Vleresimi, Analiza) values('9', 'Analiza13');
insert into Lexuesi(Vleresimi, Analiza) values('2', 'Analiza14');
insert into Lexuesi(Vleresimi, Analiza) values('1', 'Analiza15');

insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi1', 'Komenti1', '5');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi2', 'Komenti2', '2');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi3', 'Komenti3', null);
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi4', 'Komenti4', null);
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi5', 'Komenti5', '2');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi6', 'Komenti6', '3');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi7', 'Komenti7', '7');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi8', 'Komenti8', '10');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi9', 'Komenti9', '7');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi10', 'Komenti10', null);
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi11', 'Komenti11', '4');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi12', 'Komenti12', '9');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi13', 'Komenti13', '1');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi14', 'Komenti14', '8');
insert into Shikuesi(Parashikimi, Komenti, Vleresimi) values('Parashikimi15', 'Komenti15', null);

insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('10', 'Attack on Titan', '692-0-15-118242-7');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('20', 'Demon Slayer', '971-3-22-148411-1');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('30', 'Naruto Shipudden', '513-9-65-138159-0');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('40', 'My Hero Academia', '967-2-32-128652-6');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('50', 'Haikyuu', '366-5-19-198790-8');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('60', 'Death Note', '264-8-78-188880-3');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('70', 'Dragon Ball', '119-7-09-158015-6');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('70', 'Fruits Basket', '720-6-16-168729-5');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('80', ' Ouran High School Host Club', '765-1-12-148638-2');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('90', 'One Piece', '068-2-11-123636-1');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('100', 'Sorcerous Stabber Orphen: Wayward Journe', '061-1-31-323331-5');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('110', 'The Seven Deadly Sins', '011-4-32-223232-4');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('120', '10 Tokyo Warriors', '023-5-05-221231-1');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('130', 'Fullmetal Alchemist', '044-4-95-326237-7');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('140', 'Dragon Ball GT', '294-9-78-126936-9');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('400', 'Dragon Ball Super', '124-1-10-121926-1');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('400', 'Dragon Ball Z', '111-4-18-526536-5');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('400', 'Dragon Ball Z Kai', '097-7-48-093934-3');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('400', 'Naruto', '560-5-02-193632-7');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('400', 'Gintama', '027-1-66-066964-6');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('380', 'Space Dandy', '192-2-83-006060-9');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('320', 'Food Wars: Shokugeki no Soma', '222-7-91-019044-4');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('260', 'Another', '315-2-54-113054-5');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('210', 'Blood: The Last Vampire', '219-9-16-998651-0');
insert into Vlereson(Audienca_ID, EmriAnimese, ISBN) values('220', 'Ghost Hunt', '765-4-89-122931-1');


insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('1', 'Attack on Titan', '692-0-15-118242-7');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('2', 'Demon Slayer', '971-3-22-148411-1');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('3', 'Naruto Shipudden', '513-9-65-138159-0');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('4', 'My Hero Academia', '967-2-32-128652-6');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('5', 'Haikyuu', '366-5-19-198790-8');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('6', 'Death Note', '264-8-78-188880-3');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('7', 'Dragon Ball', '119-7-09-158015-6');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('8', 'Fruits Basket', '720-6-16-168729-5');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('9', ' Ouran High School Host Club', '765-1-12-148638-2');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('10', 'One Piece', '068-2-11-123636-1');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('11', 'Sorcerous Stabber Orphen: Wayward Journe', '061-1-31-323331-5');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('12', 'The Seven Deadly Sins', '011-4-32-223232-4');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('13', '10 Tokyo Warriors', '023-5-05-221231-1');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('14', 'Fullmetal Alchemist', '044-4-95-326237-7');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('15', 'Dragon Ball GT', '294-9-78-126936-9');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('16', 'Dragon Ball Super', '124-1-10-121926-1');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('17', 'Dragon Ball Z', '111-4-18-526536-5');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('18', 'Dragon Ball Z Kai', '097-7-48-093934-3');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('19', 'Ghost Hunt', '765-4-89-122931-1');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('20', 'Naruto', '560-5-02-193632-7');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('21', 'Gintama', '027-1-66-066964-6');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('22', 'Space Dandy', '192-2-83-006060-9');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('23', 'Food Wars: Shokugeki no Soma', '222-7-91-019044-4');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('24', 'Another', '315-2-54-113054-5');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('25', 'Blood: The Last Vampire', '219-9-16-998651-0');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('15', 'Summer Ghost', '315-1-21-336411-2');
insert into AutoriAnimeManga(Nr_ID, EmriAnimese, ISBN) values('16', 'Detective Conan: The Scarlet Bullet', '981-2-35-441111-1');


insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Attack on Titan', '692-0-15-118242-7', 'Anime me e mire e vitit', '5600', '2');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Demon Slayer', '971-3-22-148411-1', 'Anime me e shikuar, Animacioni me i mire', '12700', '2');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Naruto Shipudden', '513-9-65-138159-0', 'Sekuenca me e mire perfundimtare', '10020', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('My Hero Academia', '967-2-32-128652-6', 'Protagonisti me i mire', '422200', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Haikyuu', '366-5-19-198790-8', 'Antagonisti me i mire', '1000500', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Ghost Hunt', '765-4-89-122931-1', 'Ndeshja me e mire', '560012', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Dragon Ball Super', '124-1-10-121926-1', 'Karakteri me i forte', '225200', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Death Note', '264-8-78-188880-3', 'Misteri me i mire', '5231566', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('One Piece', '068-2-11-123636-1', 'Anime me e gjate', '110021', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Fullmetal Alchemist', '044-4-95-326237-7', 'Anime me personazhet me te mire', '980000', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Gintama', '027-1-66-066964-6', 'Komedija me e mire', '120000', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Dragon Ball GT', '294-9-78-126936-9', 'Shikueshmeria me e madhe brenda muajit', '12000', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Another', '315-2-54-113054-5', 'Drejtori me i mire', '32000', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Naruto', '560-5-02-193632-7', 'Manga me e mire', '110600', '1');
insert into Cmimi(EmriAnimese, ISBN, Lloji, NrIVleresimeve, NrICmimeve) values('Blood: The Last Vampire', '219-9-16-998651-0', 'Horrori me i mire', '100200', '1');


insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Attack on Titan', '692-0-15-118242-7', 'M', 'Eren', 'Yeager', 'Protagonist', '1');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Demon Slayer', '971-3-22-148411-1', 'M', 'Tanjiro', 'Kamado', 'Protagonist', '3');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Attack on Titan', '513-9-65-138159-0', 'M', 'Naruto', 'Uzumaki', 'Protagonist', '4');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Demon Slayer', '967-2-32-128652-6', 'F', 'Himiko', 'Toga', 'Antagonist', '6');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Haikyuu', '366-5-19-198790-8', 'M', 'Shoyo', 'Hinata', 'Protagonist', '7');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Ghost Hunt', '765-4-89-122931-1', 'F', 'Mai', 'Taniyama', 'Terciar', '10');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Dragon Ball Super', '124-1-10-121926-1', 'M', 'Goku', null, 'Protagonist', '10');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Death Note', '264-8-78-188880-3', 'M', 'L', null, 'Deuteragonist', '12');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('One Piece', '068-2-11-123636-1', 'M', 'Monkey', 'Luffy', 'Protagonist', '14');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Ghost Hunt', '044-4-95-326237-7', 'F', 'Winry', 'Rockbell', 'Terciar', '20');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Gintama', '027-1-66-066964-6', 'M', 'Gintoki', 'Sakata', 'Protagonist', '18');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Dragon Ball GT', '294-9-78-126936-9', 'M', 'Cell', null, 'Antagonist', '18');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Another', '315-2-54-113054-5', 'F', 'Mei', 'Misaki', 'Protagonist', '25');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Death Note', '023-5-05-221231-1', 'M', 'Kyoshiro', 'Kagami', 'Protagonist', '20');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('Death Note', '219-9-16-998651-0', 'F', 'Saya', 'Otonashi', 'Protagonist', '21');
insert into Personazhi(EmriAnimese, ISBN, Gjinia, EmriP, Mbiemri, Roli, Nr_Id_Aktori) values('B The Beginning', '113-6-63-041415-0', 'F', 'Izanami', null, 'Protagonist', '25');


-------------===============Përditësimi i 20 objekteve duke përdorur kushtet të caktuara=================-------------------

--1. Nderrimi i titullit te Manga-se
UPDATE Manga
set Titulli = 'ABCYZ'

--2. Perditesimi i Dates se Mbarimet tek Anime
UPDATE Anime
set DataMbarimit = '04/15/2027'
where EmriAnimese like 'Demon Slayer'

--3. Perditesimi  i numrit te faqeve
UPDATE Manga
set NrIFaqeve = 530
where ISBN = '513-9-65-138159-0'

--4. Perditesimi i emrit te stream
UPDATE Transmetohet
set Emri_Stream = 'Stream4'
where EmriAnimese like 'Haikyuu'

--5. Perditesimi i Kohes
UPDATE Orari
set Koha = '15:45'
where Orari_Id = '1'

--6. Perditesimi i Kohes dhe Dates
UPDATE Orari 
set Koha = '00:45', DataO = '02/22/2023'
where Orari_Id = '3'

--7. Perditesimi i Qytetit dhe emrit te rruges se Autorit
UPDATE Autori
set Qyteti = 'Tokyo', Emri_Rruges = 'StreetY'
where Nr_Id = '3'

--8. Perditesimi i nr te shtepise tek Autori
UPDATE Autori 
set Nr_Shtepise = '17'
where Nr_Shtepise = '32'

--9. Perditesimi i Email
UPDATE Email
set Email = 'chakooochak@gmail.com'
where Nr_ID = '2'

--10. Rritja e pages per 10% tek Aktoret te cilet kane pagen mbi 1500 
UPDATE Aktori
set Paga = Paga+(Paga*0.1)
where Paga > 1500

--11. Perditesimi i emrit te Audiences
UPDATE Audienca
set Emri = 'Patrick'
where Emri = 'Tanvir'

--12. Perditesimi i emailit te Audiences
UPDATE EmailAudienca 
set EmailAudienca = 'niakkk@outlook.com'
where Audienca_ID = '400'

--13. Perditesimi i analizes tek Lexuesi
update Lexuesi 
set Analiza = 'UpdateAnaliza'
where Vleresimi = '4' or Analiza like 'Analiza1'

--14. Perditesimi i komentit tek Shikuesi
UPDATE Shikuesi
set Komenti = 'UpdateKomenti'
where Parashikimi like 'Parashikimi1'

--15. Nderrimi i Audiences per Animene ne fjale
UPDATE Vlereson
set Audienca_ID = '250'
where EmriAnimese like 'My Hero Academia' 

--16. Ndryshimi i Audiences per Animete dhe Mangat me emer dhe ISBN te caktuar
UPDATE Vlereson
set Audienca_ID = '230'
where EmriAnimese like 'Attack on Titan' or ISBN = '513-9-65-138159-0'

--17. Nderrimi i Emrit te animese dhe ISBN me Autorin me  ID te caktuar
UPDATE AutoriAnimeManga
set EmriAnimese = 'Food Wars: Shokugeki no Soma', ISBN = '222-7-91-019044-4'
where Nr_ID = '25'

--18. Perditesimin e numrit te vleresimeve 
UPDATE Cmimi
set NrIVleresimeve = '10023000'
where EmriAnimese like 'Demon Slayer'

--19. Perditesimin e llojit  te cmimit
UPDATE Cmimi
set Lloji = 'Anime me e mire e vitit, Personazhi me i mire'
where ISBN = '692-0-15-118242-7'


--20. Perditesimin e rolit te Personazhit
UPDATE Personazhi 
set Roli = 'Terciar'
where EmriP = 'Kyoshiro'


--21. Perditesimi i nr te telefonit tek Telefoni
UPDATE Telefoni
set Nr_Tel = '+8177777778'
where Nr_ID = '1'

-----------============Fshirja e 10 objekteve=======------------------

--1. Fshirja e Mangase me emrin e animese se caktuar
delete from Cmimi
where NrIVleresimeve = '10020'

--2. Fshirja e Stream-it te caktuar
delete from StreamingPlatform
where Emri_Stream = 'Stream26'

--3. Fshirja e Trensmetimit tek emri i Stream te caktuar
delete from Transmetohet
where Emri_Stream like 'Stream22'

--4. Fshirja e Shtepise Botuese me emer te caktuar
delete from ShtepiaBotuese
where Emri_ShtepiseB like 'ShtepiaBotuese 21'

--5. Fshirja e botimit te librit me ISBN e dhene
delete from Boton
where ISBN = '044-4-95-326237-7'

--6. Fshirja e Autorit me qytet dhe zipkod te dhene
delete from Autori
where Qyteti = 'Prishtine' or ZipKodi = '62221'

--7. Fshirja e nr te Telefonit Personit me ID e caktuar
delete from Telefoni 
where Nr_ID = '25'

--8. Fshirja e emailit te Audiences me ID te caktuar
delete from EmailAudienca
where Audienca_ID = '20'

--9. Fshirja e Lexuesit vleresimi i te cilit eshte 1
delete from Lexuesi
where Vleresimi = '1'

--10. Fshirja e Personazhit i cili fillon me S dhe gjinia 'F'
delete from Personazhi 
where EmriP like 'S%' and Gjinia like 'F'



---------===============Faza e III==================------------
--▪ Të krijoni min. 8 query të thjeshta (4 për student), të realizohen vetëm me një relacion (tabelë)

---Arlind Aliu-----

--1. Te selektohen Animete te cilat kane marre me shume se 1 cmim
select * from 
Cmimi c
where c.NrICmimeve > 1

--2. Te selektohet Anime buxheti i se ciles eshte mbi 520000
select * from
Anime 
where Buxheti > 520000

--3. Te selektohen te gjithe Aktoret e qyetit Tokyo 
select a.Emri, a.Mbiemri, a.Qyteti
from Autori a
where a.Qyteti = 'Tokyo'

--4. Te selektohet Manga Zhanri i se cileve eshte Aksion 
Select * 
from Manga m 
where m.Zhanri like 'Action'

--Të krijoni min. 8 query të thjeshta (4 për student), të realizohen në minimum dy relacione (tabela) e më tepër.

---Arlind Aliu---

--1. Te shfaqen Animete orari i te cileve eshte prej ora 20:30
select a.EmriAnimese, a.Zhanri, a.Buxheti, o.Orari_Id, o.Koha
from Anime a, Orari o 
where a.Fk_Orari_ID = o.Orari_Id and o.Koha = '20:30'

--2. Te shfaqen personazhet e Manga-se gjinia e te cileve eshte Mashkullore dhe Animeja nuk eshte One Piece
select m.ISBN, p.EmriAnimese, p.EmriP, p.Gjinia
from Manga m, Personazhi p
where m.ISBN = p.ISBN and p.Gjinia like 'M' and not m.FK_EmriAnimese like 'One Piece'

--3. Te selektohen Manga-te qe jane botuar ne Shtepine Botuese 14 dhe 15
select * 
from Manga m, Boton b
where b.ISBN = m.ISBN and b.Emri_ShtepiseB IN ('ShtepiaBotuese 14', 'ShtepiaBotuese 15')

--4. Te selektohet Audienca Shikues te cilet nuk kane vleresuar Anime-ne apo Manga-ne
select a.Audienca_ID, a.Emri, a.Mbiemri, sh.Vleresimi, sh.Parashikimi 
from Audienca a, Shikuesi sh
where a.Audienca_ID= sh.Audienca_ID_Shikuesi and sh.Vleresimi is null

--Të krijoni min. 8 query të avancuara (4 për student), të realizuara në minimum dy relacione (tabela) e më tepër

---Arlind Aliu---

--1. Te selektohen Streaming Platform ID Orari i te cileve eshte 20
select sp.StreamServers, k.Emri_Stream, k.Orari_ID
from StreamingPlatform sp inner join Ka k
on sp.Emri_Stream = k.Emri_Stream and k.Orari_ID = '20'

--2. Selekto Anime-te, Manga-te e te cilave kane perfunduar se shkruari
select m.FK_EmriAnimese, m.ISBN,convert(varchar, m.DataLansimit, 13) as [DataLansimit], convert(varchar, m.DataMbarimit, 13) as [DataMbarimit]
from Manga m left join Anime a
on a.EmriAnimese = m.FK_EmriAnimese
where DATEDIFF(DAY,m.DataMbarimit,GETDATE()) < 0

--3. Te shfaqen Aktoret te cilet luajne si Personazh paga e te cileve eshte mes 1200 dhe 1500 duke i listuar sipas pages me te madhe
select a.Nr_Id_Aktori, p.EmriP, p.Mbiemri, p.Roli, a.Paga
from Aktori a right join Personazhi p
on a.Nr_Id_Aktori = p.Nr_Id_Aktori
where a.Paga between 1200 and 1500
order by a.Paga desc

--4. Te shfaqet Audienca qe jane lexues pervec ID te audiences 10, 20, 30, dhe vleresimi qe duhet te jete mbi 5
select a.Audienca_ID, a.Emri, a.Mbiemri, l.Vleresimi
from Audienca a inner join Lexuesi l
on a.Audienca_ID = l.Audienca_ID_Lexuesi
where not a.Audienca_ID in('10', '20', '30') and l.Vleresimi >=5
order by l.Vleresimi asc

-- Të krijoni min. 8 subquery të thjeshta (4 për student).

---Arlind Aliu---

--1. Selekto te gjihte Manga-te numri i faqeve te se cilave eshte me e madhe se mesatarja
select m.FK_EmriAnimese, m.ISBN, m.NrIFaqeve, m.Zhanri, m.DataLansimit, m.DataMbarimit 
from Manga m
where m.NrIFaqeve >
						(select avg(m.NrIFaqeve) as 'nrfaqeve'
						from Manga m)

--2. Selekto Aktoret te cilet nuk kane marre pjese si personazhe 
Select * 
from Aktori a 
where a.Nr_Id_Aktori not in
								(select p.Nr_Id_Aktori
								from Personazhi p)

select (sh.Vleresimi)
from Audienca a, Shikuesi sh, Lexuesi l
where a.Audienca_ID = sh.Audienca_ID_Shikuesi or a.Audienca_ID = l.Audienca_ID_Lexuesi

--3. Te selektohen te gjithe Cmimet nr i vleresimeve me te vogel se mesatarja e te gjithe vleresimeve per te gjithe ato anime qe kan marre vetem nje cmim
select * from
Cmimi c where c.NrIVleresimeve <
									(select avg(c.NrIVleresimeve)
									from Cmimi c) 
and c.NrICmimeve = '1'

--4. Te selektohen te gjitha studiot e animimit nr i punetorve te te cileve eshte me i vogel se maksimumi i punetoreve te te gjitha studiove
Select *
from StudioAnimimi sa
where sa.Nr_Paisjeve <
						(select max(sa.Nr_Punterove)
						from StudioAnimimi sa)
						
--5. 'OPSIONALE' Te gjendet PagaMesatare e Autoreve dhe te shfaqen Aktoret te cilet e kane pagen me te madhe se paga mesatare e te gjithe Autoreve.
WITH AutoriAktoriPaga(PagaMesatare) AS
		(select avg(Paga) as 'AvgP'
		from Autori )
		select ak.Emri, ak.Mbiemri, ak.Nr_Id_Aktori, ak.Paga, ak.Pervoja_Punes
		from Aktori ak, AutoriAktoriPaga a
		where ak.Paga > a.PagaMesatare

--▪ Të krijoni min. 8 subquery të avancuara (4 për student). (min. 1 subquery në klauzolën SELECT, dhe min. 1 subquery ne klauzolën FROM)

---Arlind Aliu---

--1. Selekto vetem ato Anime te cilat kane luajtur Personazhet por qe ato anime nuk te kene mbaruar ende se luajturi
select a.EmriAnimese, a.Zhanri, a.DataMbarimit, a.Buxheti
from Anime a 
where DATEDIFF(DAY,a.DataMbarimit,GETDATE()) < 0 and a.EmriAnimese IN
																	(select p.EmriAnimese
																	from Personazhi p left join Anime a
																	on p.EmriAnimese = a.EmriAnimese )
																	order by DATEDIFF(DAY,a.DataMbarimit,GETDATE()) asc


--2. Te paraqiten Shtepite Botuese te cilat kane publikuar anime, te paraqiten vetem ato shtepi botuese qe kan publikuar me shume se 1 anime (Perdorimi i subquery ne klauzolen SELECT)
select b.Emri_ShtepiseB, count(b.Emri_ShtepiseB) as 'AnimeteEBotuara'
from Boton b where b.Emri_ShtepiseB = 'ShtepiaBotuese 10'
group by b.Emri_ShtepiseB
having count(b.Emri_ShtepiseB) >ANY
									(select count(b.Emri_ShtepiseB)
									from Boton b
									group by b.Emri_ShtepiseB
									)
									order by [AnimeteEBotuara] desc

--3. Te gjenden ato Anime me zhanrin 'Aksion' ku buxheti Anime-se eshte me i madh se mesatarja e numrave te vleresimit (Perdorimi i subquery ne klauzolen FROM)
select a.EmriAnimese, a.Zhanri, a.DataLansimit, a.DataMbarimit, a.Buxheti
from Anime a, (select avg(c.NrIVleresimeve) as NrVleresimeveTeCmimit
from Cmimi c) as NrVleresimeve
where  a.Buxheti > NrVleresimeve.NrVleresimeveTeCmimit 
and a.EmriAnimese =ANY
										(select a.EmriAnimese
										from Anime a
										where a.Zhanri like 'Action')
										order by a.Buxheti asc


--4. Te numerohen se sa Manga kane publikuar autoret dhe ata qe kane publikuar me shume se 1 Manga te gjendet paga mesatare e tyre(Perdorimi i WITH)
WITH AAAM AS
(select a.Emri, a.Mbiemri, count(aam.ISBN) as 'NrManga-ve'
from Autori a inner join AutoriAnimeManga aam
on a.Nr_Id = aam.Nr_ID
	group by a.Emri, a.Mbiemri)
								select avg(a.Paga) as [PAGA MESATARE E AUTOREVE QE KANE ME SHUME SE NJE ANIME] 
								from Autori a, AAAM aaam 
								where aaam.[NrManga-ve] > 1

--5. 'OPISONALE' Te gjenden ato Studio te cilat kane publikuar Anime me shume se sa Studio e cila ka publikuar me se paku Anime (Perdorimi i VIEW)
 /* CREATE VIEW StudiotQeKanePublikuarAnime as
							(select sa.Emri_Studios, count(a.EmriAnimese) as 'SASIA E ANIMEVE QE KANE KRIJUAR'
							from StudioAnimimi sa left join Anime a
							on sa.Emri_Studios = a.Fk_EStudios
							group by sa.Emri_Studios
							having count(a.EmriAnimese) >Any(
															select count(a.EmriAnimese)
															from StudioAnimimi sa inner join Anime a
															on sa.Emri_Studios = a.Fk_EStudios
															group by sa.Emri_Studios)
															)  
select *
from StudiotQeKanePublikuarAnime sqpa
order by [SASIA E ANIMEVE QE KANE KRIJUAR] desc */
														

-- Të krijoni min. 8 query/subquery (4 për student). Duke përdorur operacionet e algjebrës relacionale (Union, Prerja, diferenca, etj.)

--Arlind Aliu---

--1. Te gjenden vetem ato Anime te cilat kane marrur cmim.
(select c.EmriAnimese from Cmimi c)
intersect
(select a.EmriAnimese from Anime a)

--2. Te shfaqen ato Manga te cilet personazhet aktual nuk kane marre pjese, dhe zhanri i te cileve eshte Action
(Select m.FK_EmriAnimese, m.ISBN from Manga m 
where m.Zhanri like 'Action')					
except
(select p.EmriAnimese ,p.ISBN from Personazhi p)

--3. Te gjendet Aktori dhe Autori te cilet kane pagesen me te larte
(select a.Emri, a.Mbiemri, a.Paga 
from Autori a
where a.Paga =ANY (select max(a.Paga) from Autori a))
union
(select ak.Emri, ak.Mbiemri, ak.Paga 
from Aktori ak
where ak.Paga =ANY (select max(ak.Paga) from Aktori ak))

--4. Te gjenden Manga-te qe kane Anime dhe anasjelltas, dhe te gjendet Anime apo Manga buxheti i se ciles eshte me i larti dhe data e mbarimit te se ciles eshte pas vitit 2021 
CREATE VIEW AnimeManga as
(
(select a.EmriAnimese, a.Zhanri, a.DataMbarimit, a.Buxheti from Anime a
where a.DataMbarimit > '12-31-2021')
union
(select m.FK_EmriAnimese, m.Zhanri, m.DataMbarimit, m.Buxheti from Manga m
where m.DataMbarimit > '12-31-2021'))

select * from AnimeManga am 
where am.Buxheti in
					(select max(am.Buxheti) as 'Buxheti me i larte'
					from AnimeManga am)

-- Të krijoni min. 8 Proceduara të ruajtura (Stored Procedure) (4 për student)

---Arlind Aliu---

--1. Te krijohet procedura e cila dergon si parameter Zhanrin dhe shtyp Anime-te me zhaner te caktuar

CREATE PROC Zhanri
	@Zhanri varchar(255),
	@numeroAnimete int = null,
	@numeroZhanrin int = null
	as 
	begin
	set @numeroAnimete  = (select count(*) from Anime); 
	set @numeroZhanrin  = (select count(*) from Anime where @Zhanri = Zhanri ); 

	print 'Gjithsej jane ' +cast((@numeroAnimete) as varchar(255)) + ' Anime, dhe ' + cast((@numeroZhanrin) as varchar(255)) + ' prej tyre jane me Zhanrin ' + @Zhanri + '!'

	end
	Zhanri 'Action'

--2. Te shfaqen se sa botime kane bere Shtepite Botuese varesisht prej ciles Shtepise se deklaruar si parameter

	CREATE PROCEDURE nrBotimeve
	@EmriShtepise varchar(255)
	as
	begin 
	declare @NrBotimeve int = (select count(b.Emri_ShtepiseB) as 'AnimeteEBotuara' from Boton b where b.Emri_ShtepiseB = @EmriShtepise)
	
	print 'Nr i botimeve per '+@EmriShtepise+' eshte '+ cast((@NrBotimeve) as varchar(255)) +'!'
	end
	
	nrBotimeve 'ShtepiaBotuese 14' 

--3. Te printohet se nese Autori me ID e pranuar si parameter ka publikuar nje apo me shume Anime

	CREATE PROCEDURE nrPublikimeveTeAutorit
	@ID int,
	@EmriAutorit varchar(255) = null
	as 
	begin 
		set @EmriAutorit = (select a.Emri from Autori a where a.Nr_Id = @ID)
		declare @NrIPublikimeve int = (select count(aam.EmriAnimese) from AutoriAnimeManga aam where aam.Nr_ID = @ID)
		
		if(@NrIPublikimeve > 1)
			begin
				print 'Autori me emer: '+@EmriAutorit+', ka publikuar me shume se nje Anime!'
			end
		else
			begin
				print 'Autori me emer: '+@EmriAutorit+', ka publikuar vetem nje Anime!'
			end
		end
	
		nrPublikimeveTeAutorit '15'

--4. Te behet krahasimi mes pages se Aktorit dhe Autorit varesisht prej ID se derguar ne parameter dhe te shfaqe per sa eshte me e madhe paga e njeri tjetrit!  

CREATE PROC Paga
@IDAktori int,
@IDAutori int

as 
begin 
	declare @PagaAktorit int = (select a.Paga from Aktori a where a.Nr_Id_Aktori = @IDAktori)
	declare @PagaEAutorit int = (select a.Paga from Autori a where a.Nr_Id = @IDAutori)
	declare @EmriAktorit varchar(255) = (select a.Emri from Aktori a where a.Nr_Id_Aktori = @IDAktori)
	declare @EmriEAutorit varchar(255) = (select a.Emri from Autori a where a.Nr_Id = @IDAutori)
	if(@PagaAktorit > @PagaEAutorit)
		begin 
			declare @sasiaParaveTeAktorit int = @PagaAktorit - @PagaEAutorit
				print 'Paga e Aktorit '+@EmriAktorit+' eshte me e madhe se e Autorit '+@EmriEAutorit+' per '+cast((@sasiaParaveTeAktorit)as varchar(255))+ ' Euro!'
		end
	else if(@PagaAktorit < @PagaEAutorit)
		begin
			declare @sasiaParaveTeAutorit int = @PagaEAutorit - @PagaAktorit 
				print 'Paga e Autorit '+@EmriEAutorit+' eshte me e madhe se e Aktorit'+@EmriAktorit+' per '+cast((@sasiaParaveTeAutorit)as varchar(255))+ ' Euro!'
		end
	else if(@PagaAktorit = @PagaEAutorit)
		begin
			print 'Paga e Aktorit dhe Autorit eshte e njejte'
		end
	else
		begin
			print 'ID e dhena jane gabim!'
		end

	end
Paga '11', '12'


DROP DATABASE IF EXISTS snet1509; 
CREATE DATABASE snet1509; 
USE snet1509;
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id serial PRIMARY KEY, 
	name VARCHAR(50), 
	surname VARCHAR(50), 
	email VARCHAR(100) UNIQUE,
	phone BIGINT, 
	gender CHAR(6),
	birthday DATE,
	hometown VARCHAR(150),
	photo_id BIGINT UNSIGNED,
	pass CHAR(50),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	INDEX(phone),
	INDEX(name, surname), 
	INDEX(email)
);

DROP TABLE IF EXISTS massages;
CREATE TABLE massages(
	id serial PRIMARY KEY,
	frome_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL, 
	body TEXT, 
	is_read BOOL DEFAULT 0, 
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY(frome_user_id) REFERENCES users(id),
	FOREIGN KEY(to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests(
	-- id serial PRIMARY KEY,
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_user_id BIGINT UNSIGNED NOT NULL,
	status ENUM('requested', 'approved', 'unfriended', 'declined') DEFAULT 'requested',
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(initiator_user_id, target_user_id),
	FOREIGN KEY(initiator_user_id) REFERENCES users(id),
	FOREIGN KEY(target_user_id) REFERENCES users(id)
);

ALTER TABLE friend_requests ADD INDEX(initiator_user_id);

DROP TABLE IF EXISTS communities; 
CREATE TABLE communities(
	id serial PRIMARY KEY,
	name VARCHAR(150),
	INDEX communities_name_idx (name)
);

DROP TABLE IF EXISTS users_communities; 
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	is_admin BOOL DEFAULT 0,
	PRIMARY KEY(user_id, community_id),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS posts; 
CREATE TABLE posts(
	id serial PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	metadata json, 
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY(user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS comments; 
CREATE TABLE comments(
	id serial PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	post_id BIGINT UNSIGNED NOT NULL, 
	body TEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
	FOREIGN KEY(user_id) REFERENCES users(id), 
	FOREIGN KEY(post_id) REFERENCES posts(id)
);

DROP TABLE IF EXISTS photos; 
CREATE TABLE photos(
	id serial PRIMARY KEY, 
	user_id BIGINT UNSIGNED NOT NULL,
	description TEXT,
	filename VARCHAR(250),
	FOREIGN KEY(user_id) REFERENCES users(id)
	
);

DROP TABLE IF EXISTS likes; 
CREATE TABLE likes(
	id serial PRIMARY KEY, 
	user_id BIGINT UNSIGNED NOT NULL,
	post_id BIGINT UNSIGNED NOT NULL,
	photo_id BIGINT UNSIGNED NOT NULL, 
	body BOOL DEFAULT 0, 
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(post_id) REFERENCES posts(id), 
	FOREIGN KEY(photo_id) REFERENCES photos(id)
	
);

insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (1, 'Fernande', 'Pepys', 'fpepys0@cisco.com', 'Female', '12.05.2020', 'Rossosh’', '1937699106');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (2, 'Yolanda', 'Edes', 'yedes1@un.org', 'Female', '24.10.2019', 'Nevers', '3898466716');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (3, 'Sibyl', 'Wermerling', 'swermerling2@blog.com', 'Male', '06.05.2020', 'Chóra', '4574483031');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (4, 'Xavier', 'Anthon', 'xanthon3@geocities.jp', 'Male', '12.05.2020', 'Västra Frölunda', '7539731032');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (5, 'Sayer', 'Baudichon', 'sbaudichon4@squarespace.com', 'Male', '14.05.2020', 'Runka', '8992034376');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (6, 'Jesus', 'Beckers', 'jbeckers5@twitpic.com', 'Male', '29.12.2019', 'San Mateo', '2451475355');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (7, 'Carlene', 'McNysche', 'cmcnysche6@wired.com', 'Female', '19.06.2020', 'Uhryniv', '4403244560');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (8, 'Dannie', 'Gusticke', 'dgusticke7@woothemes.com', 'Male', '11.03.2020', 'Tomobe', '7921132380');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (9, 'Valma', 'Agerskow', 'vagerskow8@pen.io', 'Female', '27.05.2020', 'Peña', '1388864659');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (10, 'Candra', 'Lovelace', 'clovelace9@ameblo.jp', 'Female', '17.12.2019', 'Malakand', '3519923792');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (11, 'Munmro', 'Soars', 'msoarsa@amazon.de', 'Male', '25.01.2020', 'Sungailiat', '3577618369');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (12, 'Madlin', 'McDonnell', 'mmcdonnellb@fda.gov', 'Female', '15.02.2020', 'Shelabolikha', '8974692652');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (13, 'Carr', 'Goburn', 'cgoburnc@wikia.com', 'Male', '29.05.2020', 'Sumberrejo', '8745050924');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (14, 'Arny', 'Lowis', 'alowisd@epa.gov', 'Male', '24.10.2019', 'Munturkaju', '8479059660');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (15, 'Taylor', 'Cumming', 'tcumminge@rediff.com', 'Male', '07.04.2020', 'Marija Bistrica', '5881828599');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (16, 'Kathy', 'Rigler', 'kriglerf@weibo.com', 'Female', '26.05.2020', 'Cochadas', '3935173568');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (17, 'Danit', 'Macbane', 'dmacbaneg@skype.com', 'Female', '04.06.2020', 'Krajan Satu', '4683708829');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (18, 'Karlan', 'Craufurd', 'kcraufurdh@godaddy.com', 'Male', '08.10.2019', 'Marseille', '8691955916');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (19, 'Gale', 'Eddisforth', 'geddisforthi@dion.ne.jp', 'Female', '07.08.2020', 'Modot', '2456687640');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (20, 'Kippar', 'Maxsted', 'kmaxstedj@diigo.com', 'Male', '01.03.2020', 'Opi', '1689181455');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (21, 'Stacee', 'Ebbotts', 'sebbottsk@hubpages.com', 'Male', '08.12.2019', 'Jiuhu', '5159989659');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (22, 'Norean', 'Paulmann', 'npaulmannl@altervista.org', 'Female', '23.03.2020', 'Shangzhuang', '3748678216');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (23, 'Nina', 'Dunn', 'ndunnm@accuweather.com', 'Female', '04.08.2020', 'Bulawayo', '2213889308');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (24, 'Teodorico', 'Wickes', 'twickesn@51.la', 'Male', '02.05.2020', 'Lianghe', '2979808771');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (25, 'Olag', 'Koppes', 'okoppeso@bravesites.com', 'Male', '19.01.2020', 'Yanaoca', '5317764562');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (26, 'Roobbie', 'Jacob', 'rjacobp@unblog.fr', 'Female', '23.05.2020', 'Xibu', '3466522523');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (27, 'Mollie', 'Falcus', 'mfalcusq@google.com.br', 'Female', '16.03.2020', 'Sangiyn Dalay', '6381384924');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (28, 'Cindi', 'Breede', 'cbreeder@home.pl', 'Female', '22.10.2019', 'Ban Takhun', '3006000095');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (29, 'Bent', 'Abbie', 'babbies@mediafire.com', 'Male', '01.04.2020', 'Castanheiro do Sul', '8414897467');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (30, 'Estevan', 'Roy', 'eroyt@51.la', 'Male', '12.04.2020', 'Liaonan', '6383953260');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (31, 'Bren', 'Itzkin', 'bitzkinu@digg.com', 'Male', '14.06.2020', 'Baicaogou', '9123003717');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (32, 'Gerty', 'Adan', 'gadanv@furl.net', 'Female', '31.03.2020', 'Fengtang', '2565492811');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (33, 'Rickard', 'Dines', 'rdinesw@dell.com', 'Male', '03.12.2019', 'Bolekhiv', '2607660381');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (34, 'Gearalt', 'Glitherow', 'gglitherowx@is.gd', 'Male', '28.03.2020', 'Baimi', '4076748919');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (35, 'Nataniel', 'Dennehy', 'nodennehyy@pinterest.com', 'Male', '22.09.2020', 'Oborniki Slaskie', '5426070457');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (36, 'Frederica', 'Asche', 'faschez@whitehouse.gov', 'Female', '09.06.2020', 'San Carlos de Bariloche', '4148187141');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (37, 'Blinni', 'Hover', 'bhover10@slideshare.net', 'Female', '25.01.2020', 'Colorado Springs', '7197004239');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (38, 'Adelice', 'Inglesant', 'ainglesant11@comsenz.com', 'Female', '21.02.2020', 'Kyaikto', '4383376638');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (39, 'Sergio', 'Warrack', 'swarrack12@altervista.org', 'Male', '04.09.2020', 'Hongqiao', '9884209734');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (40, 'Lorrie', 'Rannald', 'lrannald13@creativecommons.org', 'Female', '11.05.2020', 'Nässjö', '5143554227');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (41, 'Field', 'Huckle', 'fhuckle14@slashdot.org', 'Male', '29.01.2020', 'Kaolinovo', '1142055829');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (42, 'Dory', 'Deroche', 'dderoche15@sogou.com', 'Male', '26.12.2019', 'Gao', '8978258344');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (43, 'Clarine', 'Loukes', 'cloukes16@google.de', 'Female', '27.04.2020', 'Kurye', '1077409378');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (44, 'Ric', 'Fairholm', 'rfairholm17@eventbrite.com', 'Male', '21.05.2020', 'Cigagade', '5906356608');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (45, 'Justino', 'Bell', 'jbell18@fema.gov', 'Male', '27.01.2020', 'Terong', '7126366238');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (46, 'Brynn', 'Dowsett', 'bdowsett19@is.gd', 'Female', '19.12.2019', 'Elói Mendes', '8015720827');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (47, 'Libbie', 'MacMarcuis', 'lmacmarcuis1a@bravesites.com', 'Female', '24.12.2019', 'Labin', '4077786733');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (48, 'Horatius', 'Frampton', 'hframpton1b@java.com', 'Male', '21.10.2019', 'Ramanavichy', '9671292778');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (49, 'Yves', 'Cannovane', 'yocannovane1c@army.mil', 'Male', '27.08.2020', 'Quyangqiao', '6195459192');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (50, 'Ginnifer', 'Fellowes', 'gfellowes1d@cbsnews.com', 'Female', '18.01.2020', 'Rosh Pinna', '9886198322');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (51, 'Bruis', 'Le Sarr', 'blesarr1e@dailymotion.com', 'Male', '10.05.2020', 'Shangsanji', '1441548283');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (52, 'Truman', 'Athelstan', 'tathelstan1f@telegraph.co.uk', 'Male', '28.11.2019', 'Kristiansand S', '9621029609');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (53, 'Orland', 'Challiner', 'ochalliner1g@infoseek.co.jp', 'Male', '29.06.2020', 'Bucu Kidul', '2875939021');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (54, 'Panchito', 'Climance', 'pclimance1h@toplist.cz', 'Male', '14.10.2019', 'Óbidos', '6986991587');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (55, 'Kerrill', 'Caldeiro', 'kcaldeiro1i@wikispaces.com', 'Female', '03.04.2020', 'Tabug', '2554479389');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (56, 'Derril', 'Sipson', 'dsipson1j@patch.com', 'Male', '10.08.2020', 'Saransk', '5392608249');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (57, 'My', 'Woof', 'mwoof1k@mayoclinic.com', 'Male', '29.03.2020', 'Chupa', '6256755823');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (58, 'Lou', 'Edeson', 'ledeson1l@ted.com', 'Female', '14.08.2020', 'Morawica', '7363721941');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (59, 'Bobinette', 'Oulner', 'boulner1m@businessweek.com', 'Female', '29.02.2020', 'Neglasari', '2107806239');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (60, 'Agnese', 'Randal', 'arandal1n@usgs.gov', 'Female', '07.02.2020', 'Vimieiro', '7154504664');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (61, 'Kakalina', 'Foltin', 'kfoltin1o@mapy.cz', 'Female', '14.01.2020', 'Meadow Lake', '2775910080');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (62, 'Cinda', 'Wetheril', 'cwetheril1p@mail.ru', 'Female', '31.01.2020', 'Lang Suan', '7321488473');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (63, 'Husain', 'Shepherdson', 'hshepherdson1q@networksolutions.com', 'Male', '27.12.2019', 'Koani Ndogo', '7694855060');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (64, 'Jessalin', 'Jecks', 'jjecks1r@gmpg.org', 'Female', '30.05.2020', 'Cumanacoa', '1907460130');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (65, 'Rolph', 'Blitzer', 'rblitzer1s@wired.com', 'Male', '04.12.2019', 'Rio de Moinhos', '5721398382');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (66, 'Deb', 'Norsworthy', 'dnorsworthy1t@epa.gov', 'Female', '27.12.2019', 'Belawang', '9206645380');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (67, 'Rheta', 'Seville', 'rseville1u@google.nl', 'Female', '02.06.2020', 'Sabburah', '8173796483');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (68, 'Christy', 'Jills', 'cjills1v@studiopress.com', 'Female', '10.03.2020', 'Santa Cecilia', '9629864418');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (69, 'Marleah', 'Hoolaghan', 'mhoolaghan1w@prnewswire.com', 'Female', '04.11.2019', 'Landskrona', '8006900013');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (70, 'Hester', 'Kirkby', 'hkirkby1x@miibeian.gov.cn', 'Female', '13.03.2020', 'Beaumont', '4093291450');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (71, 'Oralla', 'Tesoe', 'otesoe1y@latimes.com', 'Female', '25.03.2020', 'Dukoh', '5055775826');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (72, 'Ellary', 'Holbie', 'eholbie1z@blogger.com', 'Male', '20.10.2019', 'Ipil', '9034604607');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (73, 'Cleopatra', 'Amery', 'camery20@cornell.edu', 'Female', '21.07.2020', 'Terezín', '5698739800');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (74, 'Averil', 'Bohan', 'abohan21@virginia.edu', 'Female', '13.07.2020', 'Jundiaí', '6911766394');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (75, 'Amberly', 'Dunckley', 'adunckley22@wired.com', 'Female', '20.11.2019', 'Crasto', '3751489473');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (76, 'Pearce', 'Werrilow', 'pwerrilow23@sogou.com', 'Male', '27.11.2019', 'Stockholm', '4384002698');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (77, 'Lenci', 'Stallen', 'lstallen24@imageshack.us', 'Male', '23.02.2020', 'Orosh', '6415089324');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (78, 'Tripp', 'Impy', 'timpy25@imgur.com', 'Male', '27.11.2019', 'Ami', '2771662715');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (79, 'Tobie', 'Bursnell', 'tbursnell26@pen.io', 'Male', '01.05.2020', 'Bogandinskiy', '4308448505');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (80, 'Benedict', 'Gertz', 'bgertz27@fotki.com', 'Male', '28.06.2020', 'Falavarjan', '3071324190');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (81, 'Kaylyn', 'Tolle', 'ktolle28@berkeley.edu', 'Female', '23.04.2020', 'Aghada', '8033157658');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (82, 'Adolph', 'Dryburgh', 'adryburgh29@elpais.com', 'Male', '04.04.2020', 'Zawichost', '9796101320');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (83, 'Zorine', 'Nobes', 'znobes2a@a8.net', 'Female', '22.02.2020', 'Zoumi', '2703596946');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (84, 'Valma', 'Lerer', 'vlerer2b@elpais.com', 'Female', '23.10.2019', 'Famões', '9356166591');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (85, 'Lila', 'Karolovsky', 'lkarolovsky2c@woothemes.com', 'Female', '08.01.2020', 'Houston', '7131099698');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (86, 'Rosaline', 'Mallett', 'rmallett2d@xrea.com', 'Female', '18.08.2020', 'Xuedian', '8344988546');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (87, 'Lauren', 'Opy', 'lopy2e@ning.com', 'Male', '11.06.2020', 'Nyagan', '2024681586');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (88, 'Clarinda', 'Lacky', 'clacky2f@thetimes.co.uk', 'Female', '11.04.2020', 'Dmitriyevskoye', '1504396544');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (89, 'Sonny', 'Sustin', 'ssustin2g@state.tx.us', 'Female', '15.12.2019', 'Baños', '8412780028');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (90, 'Marlo', 'Choat', 'mchoat2h@rambler.ru', 'Female', '02.01.2020', 'San Isidro', '8586406621');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (91, 'Ceil', 'Gumb', 'cgumb2i@marriott.com', 'Female', '19.12.2019', 'Qusrah', '3825747120');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (92, 'Brandyn', 'Saiens', 'bsaiens2j@google.ru', 'Male', '16.05.2020', 'Habiganj', '9659451380');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (93, 'Jaclyn', 'Attewill', 'jattewill2k@csmonitor.com', 'Female', '02.09.2020', 'La Estrella', '3295876735');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (94, 'Ambur', 'Nekrews', 'anekrews2l@timesonline.co.uk', 'Female', '12.12.2019', 'Tianqian', '2854884856');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (95, 'Park', 'Fabb', 'pfabb2m@soup.io', 'Male', '26.01.2020', 'Trélissac', '1346370680');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (96, 'Dannel', 'Odom', 'dodom2n@kickstarter.com', 'Male', '21.02.2020', 'Wonorejo', '7072506361');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (97, 'Maris', 'Klassmann', 'mklassmann2o@mapy.cz', 'Female', '20.04.2020', 'Auch', '1066142154');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (98, 'Hannah', 'Frankton', 'hfrankton2p@irs.gov', 'Female', '12.10.2019', 'Ganshui', '5001931863');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (99, 'Shani', 'Canavan', 'socanavan2q@engadget.com', 'Female', '28.04.2020', 'Sernur', '9183671538');
insert into users (id, name, surname, email, gender, birthday, hometown, phone) values (100, 'Montague', 'Buske', 'mbuske2r@google.nl', 'Male', '17.01.2020', 'Grahamstown', '7088742178');
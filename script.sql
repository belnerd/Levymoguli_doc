-- Luodaan tietokanta
CREATE DATABASE "levymoguli" /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

-- Luodaan taulu artisteille
CREATE TABLE "artists" (
  "artistid" int NOT NULL AUTO_INCREMENT,
  "firstname" varchar(45) NOT NULL,
  "lastname" varchar(45) NOT NULL,
  "contract" varchar(45) DEFAULT NULL,
  PRIMARY KEY ("artistid")
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- Luodaan taulu bändeille
CREATE TABLE "bands" (
  "bandid" int NOT NULL AUTO_INCREMENT,
  "bandname" varchar(60) NOT NULL,
  PRIMARY KEY ("bandid")
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Luodaan taulu julkaisuille
CREATE TABLE "releases" (
  "releaseid" int NOT NULL AUTO_INCREMENT,
  "releasename" varchar(100) NOT NULL,
  "media" varchar(45) DEFAULT NULL,
  "sales" int DEFAULT NULL,
  "releasedate" date DEFAULT NULL,
  PRIMARY KEY ("releaseid")
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Luodaan liitostaulu artistien ja julkaisuiden välille
CREATE TABLE "artistreleases" (
  "artists_artistid" int NOT NULL,
  "releases_releaseid" int NOT NULL,
  PRIMARY KEY ("artists_artistid","releases_releaseid"),
  KEY "fk_artists_has_releases_releases1_idx" ("releases_releaseid"),
  KEY "fk_artists_has_releases_artists1_idx" ("artists_artistid"),
  CONSTRAINT "fk_artists_has_releases_artists1" FOREIGN KEY ("artists_artistid") REFERENCES "artists" ("artistid"),
  CONSTRAINT "fk_artists_has_releases_releases1" FOREIGN KEY ("releases_releaseid") REFERENCES "releases" ("releaseid")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Luodaan liitostaulu bändien julkaisuille
CREATE TABLE "bandreleases" (
  "bands_bandid" int NOT NULL,
  "releases_releaseid" int NOT NULL,
  PRIMARY KEY ("bands_bandid","releases_releaseid"),
  KEY "fk_bands_has_releases_releases1_idx" ("releases_releaseid"),
  KEY "fk_bands_has_releases_bands1_idx" ("bands_bandid"),
  CONSTRAINT "fk_bands_has_releases_bands1" FOREIGN KEY ("bands_bandid") REFERENCES "bands" ("bandid"),
  CONSTRAINT "fk_bands_has_releases_releases1" FOREIGN KEY ("releases_releaseid") REFERENCES "releases" ("releaseid")
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Luodaan liitostaulu bändien ja artistien välille (jäsenet) sekä vyörytyssäännöt
CREATE TABLE "members" (
  "bands_bandid" int NOT NULL,
  "artists_artistid" int NOT NULL,
  PRIMARY KEY ("bands_bandid","artists_artistid"),
  KEY "fk_bands_has_artists_artists1_idx" ("artists_artistid"),
  KEY "fk_bands_has_artists_bands_idx" ("bands_bandid"),
  CONSTRAINT "fk_bands_has_artists_artists1" FOREIGN KEY ("artists_artistid") REFERENCES "artists" ("artistid") ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT "fk_bands_has_artists_bands" FOREIGN KEY ("bands_bandid") REFERENCES "bands" ("bandid") ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Luodaan käyttöliittymän käyttäjiä varten taulu
CREATE TABLE "users" (
  "ID" int NOT NULL AUTO_INCREMENT,
  "USERNAME" varchar(100) DEFAULT NULL,
  "EMAIL" varchar(100) DEFAULT NULL,
  "ROLE" varchar(100) DEFAULT NULL,
  "PASS" varchar(100) DEFAULT NULL,
  PRIMARY KEY ("ID")
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Luodaan valmiit näkymät artistien, bändien ja bändin jäsenien myynneille
CREATE ALGORITHM=UNDEFINED DEFINER="doadmin"@"%" SQL SECURITY DEFINER VIEW "ArtistSales" AS select concat("artists"."lastname",' ',"artists"."firstname") AS "Artisti","releases"."releasename" AS "Levy","releases"."sales" AS "Myynti" from (("artists" join "artistreleases" on(("artists"."artistid" = "artistreleases"."artists_artistid"))) join "releases" on(("artistreleases"."releases_releaseid" = "releases"."releaseid"))) order by concat("artists"."lastname",' ',"artists"."firstname");

CREATE ALGORITHM=UNDEFINED DEFINER="doadmin"@"%" SQL SECURITY DEFINER VIEW "BandSales" AS select "bands"."bandname" AS "Bandi","releases"."releasename" AS "Levy","releases"."sales" AS "Myynti" from (("bands" join "bandreleases" on(("bands"."bandid" = "bandreleases"."bands_bandid"))) join "releases" on(("bandreleases"."releases_releaseid" = "releases"."releaseid"))) order by "bands"."bandname";

CREATE ALGORITHM=UNDEFINED DEFINER="doadmin"@"%" SQL SECURITY DEFINER VIEW "BandSalesPerMember" AS select "bands"."bandname" AS "Bandi","releases"."releasename" AS "Levy","releases"."sales" AS "Myynti",count("members"."artists_artistid") AS "Jasenia",("releases"."sales" / count("members"."artists_artistid")) AS "osuus" from ((("bands" join "bandreleases" on(("bands"."bandid" = "bandreleases"."bands_bandid"))) join "members" on(("bands"."bandid" = "members"."bands_bandid"))) join "releases" on(("bandreleases"."releases_releaseid" = "releases"."releaseid"))) group by "bands"."bandname";

-- Lisätään tauluihin dataa
INSERT INTO artists (firstname,lastname,contract)
VALUES
('Anssi','Pasi','fixed'),
('Paavo','Kepponen','royalty'),
('Sulo','Sointu','special'),
('Rikhard','Lokki',null),
('Kita','Ra','royalty'),
('Esa','Keppi','royalty'),
('Bertil','Laergh','royalty'),
('Kirk','Una','royalty'),
('Mörö','Kölli','special'),
('Veli','Vir','special'),
('Bob','Pasanen','royalty'),
('Seppo','Salminen','fixed');

INSERT INTO bands (bandname) VALUES 
('Vaimeat'), ('Sointu'), ('Hamstrings'), ('Diabolous');

INSERT INTO members (bands_bandid,artists_artistid) VALUES
(2,3),(1,3),(1,1),(1,4),
(3,5),(3,8),(3,11),(3,12),
(4,6),(4,7),(4,9),(4,10);

INSERT INTO releases (releasename,releasedate,media,sales)
VALUES
('Sulosoinnut','2021-11-11','CD',0),
('Now Diabolous','2020-12-12','CD',666666),
('Tense','2020-05-05','digital',123434421),
('Äänet','2021-01-01','CD',21123),
('Alkuperäinen keppostelija','2018-02-02','CD',54354),
('Tyhjä käsi','2010-10-10','CD',65645);

INSERT INTO artistreleases(artists_artistid,releases_releaseid) VALUES
(1,6),(2,5);

INSERT INTO bandreleases(bands_bandid,releases_releaseid) VALUES
(1,4),(2,1),(3,3),(4,2);

-- Lisätään yksi käyttäjä
INSERT INTO users
(USERNAME, EMAIL, ROLE, PASS)
VALUES ('poke','poke@levymoguli.com','USER','mon');
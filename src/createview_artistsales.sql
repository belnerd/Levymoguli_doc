CREATE VIEW ArtistSales AS
SELECT concat(lastname,' ',firstname) AS Artisti,releasename AS Levy,sales AS Myynti FROM artists
INNER JOIN artistreleases ON artists.artistid = artistreleases.artists_artistid
INNER JOIN releases ON artistreleases.releases_releaseid = releases.releaseid
ORDER BY Artisti ASC;
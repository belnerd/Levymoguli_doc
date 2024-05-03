CREATE VIEW BandSalesPerMember AS
SELECT bandname AS Bandi,releasename AS Levy,sales AS Myynti,count(artists_artistid) AS Jasenia,(sales/count(artists_artistid)) AS osuus FROM bands
INNER JOIN bandreleases ON bands.bandid = bandreleases.bands_bandid
INNER JOIN members ON bands.bandid = members.bands_bandid
INNER JOIN releases ON bandreleases.releases_releaseid = releases.releaseid
GROUP BY Bandi;
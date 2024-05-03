CREATE VIEW BandSales AS
SELECT bandname AS Bandi,releasename AS Levy,sales AS Myynti FROM bands
INNER JOIN bandreleases ON bands.bandid = bandreleases.bands_bandid
INNER JOIN releases ON bandreleases.releases_releaseid = releases.releaseid
ORDER BY Bandi ASC;
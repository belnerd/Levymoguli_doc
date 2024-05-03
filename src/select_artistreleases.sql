SELECT artistid,lastname,firstname,releaseid,releasename,sales FROM artists
INNER JOIN artistreleases ON artists.artistid = artistreleases.artists_artistid
INNER JOIN releases ON artistreleases.releases_releaseid = releases.releaseid;
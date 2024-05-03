SELECT bandid,bandname,releaseid,releasename,sales FROM bands
INNER JOIN bandreleases ON bands.bandid = bandreleases.bands_bandid
INNER JOIN releases ON bandreleases.releases_releaseid = releases.releaseid;
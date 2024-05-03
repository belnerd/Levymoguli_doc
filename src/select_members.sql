SELECT bandid,bandname,artistid,lastname,firstname FROM bands
INNER JOIN members ON bands.bandid = members.bands_bandid
INNER JOIN artists ON members.artists_artistid = artists.artistid
ORDER BY bandid;
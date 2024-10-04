SELECT track.trackid as trackid
    ,track.name as track
    ,album.title as title
    ,artist.name as artist
    ,genre.name as genre
    ,mediatype.name as mediatype
    ,track.composer as composer
    ,to_char((track.milliseconds / 1000) * INTERVAL'1 second', 'MI:SS') as duration
    ,round(track.milliseconds/1000,0) as seconds
    ,track.unitprice
    ,'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S") }}'::timestamp as dbt_time
FROM {{source('stg','track')}} track
    join {{source('stg','album')}} album on track.albumid = album.albumid
    join {{source('stg','artist')}} artist on album.artistid = artist.artistid
    join {{source('stg','genre')}} genre on track.genreid = genre.genreid
    join {{source('stg','mediatype')}} mediatype on track.mediatypeid = mediatype.mediatypeid
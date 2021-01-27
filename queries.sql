-- 1. which origin have artists(group by)
SELECT country, COUNT(*) as artist_origin
from artists
group by country
order by COUNT(*) desc;
--2. finding top 5 songs by popularity(self join)
SELECT
    s.name songs,
    p.popularity rank
FROM
    songs s
INNER JOIN songs p ON s.attribute_id = p.attribute_id and s.artist_id = p.artist_id
ORDER BY p.popularity DESC
LIMIT 5;
--3. Finding artists name, song, genre and tempo in descending order(left join)
SELECT a.artists artist, s.name song,g.genres genre, at.tempo tempo
FROM artists a LEFT JOIN songs s ON a.id=s.artist_id
LEFT JOIN genres g ON s.artist_id=g.artist_id
LEFT JOIN music_attributes at ON g.artist_id=at.artist_id
ORDER BY tempo DESC;
--4. Information about artists and their songs(right join)
SELECT a.artists artist, a.artists country, a.birth, s.name songs
FROM artists a RIGHT JOIN songs s ON a.id=s.artist_id
GROUP BY artists,birth,name;
--5. Finding songs which danceability is higher avg(subquery in where statement)
SELECT a.artists as artist, s.name as song, d.danceability as danceability
FROM SONGS S   
JOIN ARTISTS A
  ON S.ARTIST_ID=A.ID
JOIN MUSIC_ATTRIBUTES D 
  ON  a.id=d.artist_id
WHERE danceability > (SELECT AVG(danceability) FROM music_attributes )
--6. Finding less popular songs and their genres(subquery in from statement)
SELECT g.genres genre, s.name song
FROM genres g  JOIN songs s
ON s.artist_id=g.artist_id
WHERE popularity IN (SELECT popularity FROM songs WHERE popularity<50);
--7. partition by
WITH popular_music AS(
SELECT DISTINCT name, release_date, duration_ms 
FROM songs
WHERE release_date IN (2020)
AND popularity>50
AND mode='1')

SELECT 
name , release_date, duration_ms,
ROW_NUMBER() OVER (PARTITION BY release_date)
FROM popular_music;

select distinct(release_date),  MIN(duration_ms) over (partition by release_date) as minimum_duration,
AVG(duration_ms) over (partition by release_date) as average_duration,
MAX(duration_ms) over (partition by release_date) as maximum_duration
from songs;
--8. VIEWS
CREATE VIEW MUSIC_GENRES
AS
     SELECT
     songs.artist_id, 
     name AS SongName, 
     COUNT(genres.genres) AS GenresQuantity
     FROM songs
          JOIN genres ON songs.artist_id = genres.artist_id
     GROUP BY songs.artist_id, 
              name
     ORDER BY COUNT(genres.genres) DESC;
SELECT * FROM MUSIC_GENRES;
--9. Finding number of songs that have genre as jazz
SELECT g.genres, count(*) as jazz
FROM genres g
WHERE genres LIKE '%jazz%'
GROUP BY genres;

DROP TABLE IF EXISTS music_attributes;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS artists;
CREATE TABLE artists(

	artists VARCHAR(255),
	id int ,
	country varchar,
	birth int
	
)
		
CREATE TABLE genres(
	 	
	    genres varchar,
	    artist_id int,
	    attribut_id int
	   
);


CREATE TABLE songs(
	 	duration_ms	 int,
	    explicit int,
	    attribute_id int,
	    artist_id int,	
	    mode int,
	    name varchar,
	    popularity int,
	    release_date int
	)
CREATE TABLE music_attributes(
	
	 	valence float,
	    acousticness float,
		danceability float,
		energy float,
	    artist_id int,
	    instrumentalness float,
	    liveness float,
	    loudness float,
	    tempo float,
	    id int 
	    
);

COPY artists
	FROM 'C:\Users\User\Desktop\data\artists.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY genres
	FROM 'C:\Users\User\Desktop\data\genres.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY songs
	FROM 'C:\Users\User\Desktop\data\songs.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY music_attributes
	FROM 'C:\Users\User\Desktop\data\attributes.csv' (DELIMITER ',', FORMAT CSV, HEADER);
	
                                                                                         
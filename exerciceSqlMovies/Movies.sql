-- Exo 1 Nom et année de naissance des artistes nés avant 1950 :

SELECT nom, 'annee de naissance'
FROM artiste
WHERE annéeNaiss <= 1950
ORDER BY annéeNaiss DESC;


-- Exo 2 Titre de tous les drames :

SELECT genre, titre
FROM film 
WHERE genre = "Drame";


-- Exo 3 Quels rôles a joué Bruce Willis :

SELECT nomRôle, titre
FROM artiste NATURAL JOIN role NATURAL JOIN film
WHERE idActeur = idArtiste AND nom = 'Willis' AND prénom = 'Bruce';


-- Exo 4 Qui est le réalisateur de Memento :

SELECT nom, prénom, idRéalisateur
FROM artiste NATURAL JOIN film
WHERE idArtiste = idRéalisateur AND titre = 'Memento';


-- Exo 5 Quelles sont les notes obtenues par le film Fargo :

SELECT note
FROM film NATURAL JOIN notation
WHERE titre = 'Fargo';


-- Exo 6 Qui a joué le rôle de Chewbacca?

SELECT nom, prénom, titre, nomRôle
FROM role NATURAL JOIN artiste NATURAL JOIN film
WHERE idArtiste = idActeur AND nomRôle = 'Chewbacca';


-- Exo 7 Dans quels films Bruce Willis a-t-il joué le rôle de John McClane?

SELECT titre, nomRôle, nom, prénom
FROM film NATURAL JOIN role NATURAL JOIN artiste
WHERE idArtiste = idActeur AND nom = 'Willis' AND prénom = 'Bruce' AND nomRôle = 'John McClane';


-- Exo 8 Nom des acteurs de 'Sueurs froides' :

SELECT nom, prénom, titre, nomRôle
FROM film NATURAL JOIN role NATURAL JOIN artiste
WHERE idActeur = idArtiste AND titre = 'Sueurs froides';


-- Exo 9 Quelles sont les films notés par l'internaute Prénom0 Nom0

SELECT titre, note, nom, prénom 
FROM internaute, film, notation
WHERE prénom = 'Prénom0' AND nom = 'Nom0';


-- Exo 10 Films dont le réalisateur est Tim Burton, et l’un des acteurs Johnny Depp.

SELECT titre
FROM film F, artiste A, artiste B, role R
WHERE  F.idRéalisateur = A.idArtiste AND R.idActeur = B.idArtiste  AND a.nom = 'Burton' AND a.prénom = 'Tim' AND B.nom = 'Depp' AND b.prénom = 'Johnny';


-- Exo 11 Titre des films dans lesquels a joué ́Woody Allen. Donner aussi le rôle :

SELECT film.titre, role.nomRôle, artiste.nom
FROM film, role, artiste
WHERE film.idFilm = role.idFilm AND role.idActeur = artiste.idArtiste AND artiste.nom = 'Allen' AND artiste.prénom = 'Woody';


-- Exo 12 Quel metteur en scène a tourné dans ses propres films ? Donner le nom, le rôle et le titre des films :

SELECT artiste.nom, role.nomRôle, film.titre
FROM film , artiste , role 
WHERE film.idRéalisateur = artiste.idArtiste 
AND role.idActeur = artiste.idArtiste
AND film.idfilm = role.idFilm


-- Exo 13 Titre des films de Quentin Tarantino dans lesquels il n’a pas joué :

SELECT film.titre
FROM film, artiste, role
WHERE film.idRéalisateur = artiste.idArtiste AND film.idFilm = role.idFilm AND role.idActeur = artiste.idArtiste AND artiste.nom = 'Tarantino' AND artiste.prénom = 'Quentin';


-- Exo 14 Quel metteur en scène a tourné ́en tant qu’acteur ? Donner le nom, le rôle et le titre des films dans lesquels cet artiste a joué :

SELECT role.nomRôle, artiste.nom, artiste.prénom, film.titre
FROM film, artiste, role
WHERE film.idRéalisateur = role.idActeur AND role.idFilm = film.idFilm AND artiste.idArtiste = role.idActeur;


-- Exo 15 Donnez les films de Hitchcock sans James Stewart :

SELECT film.titre, artiste.nom, artiste.prénom, role.nomRôle
FROM film, artiste A, artiste B, role 
WHERE film.idFilm = role.idFilm 
AND role.idActeur = B.idArtiste 
AND A.idArtiste = film.idRéalisateur 
AND artiste.nom = 'Hitchcock';
AND NOT EXISTS
SELECT 1
FROM role
WHERE A.
AND A.nom = 'Stewart'
AND A.prénom = 'James'


-- Exo 16 Dans quels films le réalisateur a-t-il le même prénom que l’un des interprètes ? (titre, nom du réalisateur, nom de l’interprète). Le réalisateur et l’interprète ne doivent pas être la même personne.

SELECT film.titre, realisateur.nom AS nom_realisateur, interprete.nom AS nom_interprete
FROM film
JOIN artiste AS realisateur ON film.idRéalisateur = realisateur.idArtiste
JOIN role ON film.idFilm = role.idFilm
JOIN artiste AS interprete ON role.idActeur = interprete.idArtiste
WHERE realisateur.prénom = interprete.prénom AND realisateur.idArtiste != interprete.idArtiste;


-- Exo 17 Les films sans rôle

SELECT film.titre
FROM film
LEFT JOIN role ON film.idFilm = role.idFilm
WHERE role.idActeur IS NULL;


-- Exo 18 Quelles sont les films non notés par l'internaute Prénom1 Nom1 :

-- version 1

SELECT f.titre
FROM film f
LEFT JOIN notation n ON f.idFilm = n.idFilm AND n.email = 'Prénom1 Nom1'
WHERE n.idFilm IS NULL;

-- version 2 

SELECT film.titre
FROM film
WHERE film.idFilm NOT IN (
    SELECT notation.idFilm
    FROM notation
    WHERE notation.email = 'Prénom1 Nom1'
);


-- Exo 19 Quels acteurs n’ont jamais réalisé de film ?

-- version 1

SELECT artiste.nom, artiste.prénom
FROM artiste
LEFT JOIN film ON artiste.idArtiste = film.idRéalisateur
WHERE film.idRéalisateur IS NULL

-- verdio 2

SELECT artiste.nom, artiste.prénom
FROM artiste
WHERE artiste.idArtiste NOT IN (
    SELECT film.idRéalisateur
    FROM film
)


-- Exo 20 Quelle est la moyenne des notes de Memento :

SELECT AVG(notation.note) AS Moyenne_Notes
FROM film
JOIN notation ON film.idFilm = notation.idFilm
WHERE film.titre = 'Memento';


-- Exo 21 id, nom et prénom des réalisateurs, et nombre de films qu’ils ont tournés :

SELECT artiste.idArtiste, artiste.nom, artiste.prénom, COUNT(film.idFilm) as nombre_de_films
FROM artiste
JOIN film ON artiste.idArtiste = film.idRéalisateur
GROUP BY artiste.idArtiste, artiste.nom, artiste.prénom;


-- Exo 22 Nom et prénom des réalisateurs qui ont tourné au moins deux films :

SELECT artiste.nom, artiste.prenom
FROM film
JOIN artiste ON film.idRéalisateur = artiste.idArtiste
GROUP BY film.idRéalisateur
HAVING COUNT(film.idFilm) >= 2;


-- Exo 23 Quels films ont une moyenne des notes supérieure à 7 :

SELECT film.titre, ROUND(AVG(notation.note),2) as moyenne
FROM film 
JOIN notation ON film.idFilm = notation.idFilm
GROUP BY film.titre
HAVING AVG(notation.note) > 7;



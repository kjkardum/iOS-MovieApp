//
//  MovieDomainMapper.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//

import Foundation


class MovieDomainMapper: MapperProtocol<Movie, MovieMO> {
    override func map(_ from: Movie) -> MovieMO {
        let movie = MovieMO(entity: MovieMO.entity(), insertInto: nil)
        movie.tmdbId = from.tmdbId
        movie.adult = from.adult
        movie.backdrop_path = from.backdrop_path
        movie.original_language = from.original_language
        movie.original_title = from.original_title
        movie.overview = from.overview
        movie.popularity = from.popularity
        movie.poster_path = from.poster_path
        movie.release_date = from.release_date
        movie.title = from.title
        movie.video = from.video
        movie.vote_average = from.vote_average
        movie.vote_count = from.vote_count
        movie.liked = from.liked
        return movie
    }
    
    override func map(_ from: MovieMO) -> Movie {
        let movie = Movie(
            tmdbId: from.tmdbId,
            adult: from.adult,
            backdrop_path: from.backdrop_path,
            original_language: from.original_language ?? "",
            original_title: from.original_title ?? "",
            overview: from.overview ?? "",
            popularity: from.popularity,
            poster_path: from.poster_path,
            release_date: from.release_date ?? "",
            title: from.title ?? "",
            video: from.video,
            vote_average: from.vote_average,
            vote_count: from.vote_count,
            genres: (from.genres?.allObjects as? [GenreMO] ?? []).map { Genre(id: $0.tmdbId, name: $0.name ?? "") },
            groups: (from.groups?.allObjects as? [MovieGroupMO] ?? []).map { Group(type: $0.type) },
            liked: from.liked
        )
        return movie
    }
}

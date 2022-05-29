//
//  MovieNetworkDomainMapper.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//

import Foundation
import UIKit

class MovieNetworkDomainMapper: MapperProtocol<Movie, SimpleMovieNetworkModel> {
    override func map(_ from: Movie) -> SimpleMovieNetworkModel {
        return SimpleMovieNetworkModel(
            id: Int(truncatingIfNeeded: from.tmdbId),
            adult: from.adult,
            backdrop_path: from.backdrop_path,
            genre_ids: from.genres.map {genre in Int(truncatingIfNeeded: genre.id)},
            original_language: from.original_language,
            original_title: from.original_title,
            overview: from.overview,
            popularity: from.popularity,
            poster_path: nil,
            release_date: from.release_date ?? "",
            title: from.title,
            video: from.video,
            vote_average: from.vote_average,
            vote_count: Int(truncatingIfNeeded: from.vote_count),
            media_type: nil
        )
    }
    override func map(_ from: SimpleMovieNetworkModel) -> Movie {
        let url = URL(string: from.poster_path != nil ? MoviesRepository.base_image_url + from.poster_path! : defaultPosterUrl)
        let data = url != nil ? try? Data(contentsOf: url!) : nil
        
        var movie = Movie(
            tmdbId: Int64(from.id),
            adult: from.adult,
            backdrop_path: from.backdrop_path,
            original_language: from.original_language,
            original_title: from.original_title,
            overview: from.overview,
            popularity: from.popularity,
            poster_path: nil,
            release_date: from.release_date,
            title: from.title,
            video: from.video,
            vote_average: from.vote_average,
            vote_count: Int64(from.vote_count),
            genres: from.genre_ids.map { Genre(id: Int64($0), name: "")},
            groups: [],
            liked: false
        )
        
        DispatchQueue.global(qos: .background).sync {
            let image = data != nil ? UIImage(data: data!)?.jpegData(compressionQuality: 90) : nil
            movie.poster_path = image
        }
        return movie
    }
}

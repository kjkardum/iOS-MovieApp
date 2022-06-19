//
//  MovieMapper.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 28.05.2022..
//

import Foundation
import CoreData
import UIKit

class MovieNetworkDbMapper: MapperProtocol<MovieMO, SimpleMovieNetworkModel> {
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    override func map(_ from: MovieMO) -> SimpleMovieNetworkModel {
        return SimpleMovieNetworkModel(
            id: Int(truncatingIfNeeded: from.tmdbId),
            adult: from.adult,
            backdrop_path: from.backdrop_path,
            genre_ids: (from.genres?.allObjects as? [GenreMO] ?? []).map {genre in Int(truncatingIfNeeded: genre.tmdbId)},
            original_language: from.original_language ?? "",
            original_title: from.original_title ?? "",
            overview: from.overview ?? "",
            popularity: from.popularity,
            poster_path: nil,
            release_date: from.release_date ?? "",
            title: from.title ?? "",
            video: from.video,
            vote_average: from.vote_average,
            vote_count: Int(truncatingIfNeeded: from.vote_count),
            media_type: nil
        )
    }
    
    override func map(_ from: SimpleMovieNetworkModel) -> MovieMO {
        let url = URL(string: from.poster_path != nil ? MoviesRepository.base_image_url + from.poster_path! : defaultPosterUrl)
        let data = url != nil ? try? Data(contentsOf: url!) : nil
        
        
        let movie = MovieMO(context: context)
        let tmdbId = Int64(from.id)
        movie.tmdbId = tmdbId
        movie.adult = from.adult
        movie.backdrop_path = from.backdrop_path
        movie.original_language = from.original_language ?? ""
        movie.original_title = from.original_title ?? ""
        movie.overview = from.overview ?? ""
        movie.popularity = from.popularity
        DispatchQueue.global(qos: .background).sync {
            let image = data != nil ? UIImage(data: data!)?.jpegData(compressionQuality: 90) : nil
            movie.poster_path = image
        }
        movie.release_date = from.release_date
        movie.title = from.title
        movie.video = from.video
        movie.vote_average = from.vote_average
        movie.vote_count = Int64(from.vote_count)
        return movie
    }
}

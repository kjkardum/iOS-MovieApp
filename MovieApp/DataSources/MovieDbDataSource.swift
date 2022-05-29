//
//  MovieDbDataSource.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 28.05.2022..
//

import Foundation
import CoreData
import UIKit

class MovieDbDataSource {
    let networkDbMapper: MapperProtocol<MovieMO, SimpleMovieNetworkModel>
    let domainMapper: MapperProtocol<Movie, MovieMO>
    let context: NSManagedObjectContext
    init(context: NSManagedObjectContext, networkDbMapper: MapperProtocol<MovieMO, SimpleMovieNetworkModel>, domainMapper: MapperProtocol<Movie, MovieMO>) {
        self.context = context
        self.networkDbMapper = networkDbMapper
        self.domainMapper = domainMapper
    }
    
    func saveChanges() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getMovieGenres() -> [GenreMO] {
        return (try? context.fetch(GenreMO.fetchRequest())) ?? []
    }
    
    func updateGenres(genres: [SingleMovieGenreNetworkModel]) {
        let currentGenres = getMovieGenres()
        genres.forEach{ genre in
            if currentGenres.contains(where: { $0.tmdbId == Int64(genre.id)}) { return }
            let genreMO = GenreMO(context: context)
            genreMO.tmdbId = Int64(genre.id)
            genreMO.name = genre.name
        }
    }
    
    func seedCategories() {
        guard let groups = try? context.fetch(MovieGroupMO.fetchRequest()) else { return }
        let seedGroups: [MovieGroupEnum] = [.popular, .recommended, .trendingDay, .trendingWeek, .topRated, .unknown]
        if groups.count == 0 {
            for seedGroup in seedGroups {
                let group = MovieGroupMO(context: context)
                group.type = seedGroup
            }
            saveChanges()
        }
    }
    
    func searchMovies(query: String) -> [MovieMO] {
        let request = MovieMO.fetchRequest() as NSFetchRequest<MovieMO>
        request.predicate = NSPredicate(format: "title LIKE[c] %@", "*" + query + "*")
        let data = try? context.fetch(request)
        return data ?? []
    }
    
    func likeMovie(_ tmdbId: Int64, like: Bool = true) {
        let request = MovieMO.fetchRequest() as NSFetchRequest<MovieMO>
        request.predicate = NSPredicate(format: "tmdbId == %i", tmdbId)
        guard
            let movies = try? context.fetch(request),
            let movie = movies.count > 0 ? movies.first : nil
        else { return }
        movie.liked = like
    }
    
    func getLiked(_ tmdbId: Int64) -> Bool {
        let request = MovieMO.fetchRequest() as NSFetchRequest<MovieMO>
        request.predicate = NSPredicate(format: "tmdbId == %i", tmdbId)
        guard
            let movies = try? context.fetch(request),
            let movie = movies.count > 0 ? movies.first : nil
        else { return false}
        return movie.liked
    }
    
    func getLikedMovies() -> [MovieMO] {
        let request = MovieMO.fetchRequest() as NSFetchRequest<MovieMO>
        request.predicate = NSPredicate(format: "liked == YES")
        
        guard
            let movies = try? context.fetch(request)
        else { return [] }
        return movies
    }
    
    func getMoviesForCategory(_ category: MovieGroupEnum, genre: Int?) -> [MovieMO] {
        let request = MovieGroupMO.fetchRequest() as NSFetchRequest<MovieGroupMO>
        request.predicate = NSPredicate(format: "rawType == %i", category.rawValue)
        guard
            let groups = try? context.fetch(request),
            let group = groups.first,
            let movieSet = group.movies,
            let movies = movieSet.allObjects as? [MovieMO]
        else { return [] }
        var filtered = movies.filter{ movie in
            let genres = movie.genres?.allObjects as? [GenreMO] ?? []
            return genre == nil || genres.contains(where: { $0.tmdbId == genre!})
        }
        if category == .popular || category == .trendingWeek || category == .trendingDay{
            filtered = filtered.sorted(by: { $0.popularity > $1.popularity })
        }
        if category == .topRated {
            filtered = filtered.sorted(by: { $0.vote_average > $1.vote_average })
        }
        return filtered
    }
    
    func updateMoviesForCategory(_ category: MovieGroupEnum, movies: [SimpleMovieNetworkModel], genre: Int?) {
        let genres = getMovieGenres()
        let groups = (try? context.fetch(MovieGroupMO.fetchRequest())) ?? []
        
        let incomingMovies = movies
        let existingMovies = getMoviesForCategory(category, genre: genre)
        
        let updatedMovies = existingMovies.filter { exMov in incomingMovies.contains{inMov in Int64(inMov.id) == exMov.tmdbId } }
        let deletedMovies = existingMovies.filter { exMov in !incomingMovies.contains{inMov in Int64(inMov.id) == exMov.tmdbId } }
        let addedMovies = incomingMovies.filter { inMov in !existingMovies.contains{exMov in Int64(inMov.id) == exMov.tmdbId } }
        
        updatedMovies.forEach{ movie in
            let incomingMovie = incomingMovies.first { Int64($0.id) == movie.tmdbId }!
            movie.vote_count = Int64(incomingMovie.vote_count)
            movie.vote_average = incomingMovie.vote_average
            movie.backdrop_path = incomingMovie.backdrop_path
            if let poster_path = incomingMovie.poster_path {
                if movie.poster_path == nil {
                    DispatchQueue.global(qos: .background).sync {
                        let url = URL(string: MoviesRepository.base_image_url + poster_path)
                        let data = url != nil ? try? Data(contentsOf: url!) : nil
                        let image = data != nil ? UIImage(data: data!)?.jpegData(compressionQuality: 90) : nil
                        movie.poster_path = image
                    }
                }
            }
            movie.popularity = incomingMovie.popularity
            let groups = movie.groups?.allObjects as? [MovieGroupMO] ?? []
            if !groups.contains(where: {$0.type == category}) {
                let group = MovieGroupMO(context: context)
                group.type = category
            }
        }
        
        deletedMovies.forEach{ movie in
            guard
                let group = groups.first(where: { $0.type == category }),
                let _ = genre != nil ? (movie.genres?.allObjects as? [GenreMO])?.first(where: { $0.tmdbId == genre! }) : GenreMO()
            else { return }
            movie.removeFromGroups(group)
            
        }
        addedMovies.forEach{ aMov in
            let request = MovieMO.fetchRequest() as NSFetchRequest<MovieMO>
            request.predicate = NSPredicate(format: "tmdbId == %i", aMov.id)
            guard let existingMoviesWithId = try? context.fetch(request) else { return }
            if (existingMoviesWithId.count > 0) { return }
            let addedMovie = networkDbMapper.map(aMov)
            addMovie(addedMovie, allGenres: genres, movieGenreIds: movies.first { Int64($0.id) == addedMovie.tmdbId}!.genre_ids, groups: groups, toGroup: category)
            
        }
    }
    
    private func addMovie(_ movie: MovieMO, allGenres: [GenreMO], movieGenreIds: [Int], groups: [MovieGroupMO], toGroup: MovieGroupEnum) {
        guard let group = groups.first(where: { $0.type == toGroup }) else {return}
        movieGenreIds.forEach { genreId in
            guard let genre = allGenres.first(where: { $0.tmdbId == genreId }) else { return }
            movie.addToGenres(genre)
        }
        movie.addToGroups(group)
    }
}

//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import Network
import CoreData

class MoviesRepository {
    static let base_image_url = "https://image.tmdb.org/t/p/w500"
    private let networkDataSource: MovieNetworkDataSource
    private let dbDataSource: MovieDbDataSource
    private let networkDbMapper: MapperProtocol<MovieMO, SimpleMovieNetworkModel>
    private let networkDomainMapper: MapperProtocol<Movie, SimpleMovieNetworkModel>
    private let domainMapper: MapperProtocol<Movie, MovieMO>
    
    init (networkService: NetworkServiceProtocol, context: NSManagedObjectContext) {
        self.networkDbMapper = MovieNetworkDbMapper(context: context)
        self.networkDomainMapper = MovieNetworkDomainMapper()
        self.domainMapper = MovieDomainMapper()
        networkDataSource = MovieNetworkDataSource(networkService: networkService)
        dbDataSource = MovieDbDataSource(context: context, networkDbMapper: networkDbMapper, domainMapper: domainMapper)
    }
    
    func seedData() {
        dbDataSource.seedCategories()
        dbDataSource.saveChanges()
    }
    
    func getMovieGenres(onResponse: @escaping (Result<[Genre], NetworkError>) -> Void) {
        let movieGenres = dbDataSource.getMovieGenres()
        print(movieGenres)
        if movieGenres.count > 0 {
            onResponse(.success(movieGenres.map{ Genre(id: $0.tmdbId, name: $0.name ?? "") }))
        }
        networkDataSource.getMovieGenres(onResponse: { result in
            switch (result) {
            case .failure(let error):
                if (movieGenres.count == 0) {
                    onResponse(.failure(error))
                }
                return
            case .success(let value):
                self.dbDataSource.updateGenres(genres: value.genres)
                self.dbDataSource.saveChanges()
                onResponse(.success(value.genres.map { Genre(id: Int64($0.id), name: $0.name) }))
                return
            }
        })
    }
    
    func getPopularMovies(page: Int, genre: Int?, onResponse: @escaping (Result<[Movie], NetworkError>) -> Void){
        let movies = dbDataSource.getMoviesForCategory(.popular, genre: genre)
        let domainMovies = movies.map{ self.domainMapper.map($0) }
        onResponse(.success(domainMovies))
        networkDataSource.getPopularMovies(page: page, onResponse: { result in
            switch (result) {
            case .failure(let error):
                if (movies.count == 0) {
                    onResponse(.failure(error))
                }
                return
            case .success(let value):
                let movieGenres = self.dbDataSource.getMovieGenres()
                movieGenres.forEach{ movieGenre in
                    self.dbDataSource.updateMoviesForCategory(.popular, movies: value.results.filter{ mov in mov.genre_ids.contains(where: { id in Int64(id) == movieGenre.tmdbId})}, genre: Int(truncatingIfNeeded: movieGenre.tmdbId))
                    self.dbDataSource.saveChanges()
                }
                let movies = self.dbDataSource.getMoviesForCategory(.popular, genre: genre)
                let domainMovies = movies.map{ self.domainMapper.map($0) }
                onResponse(.success(domainMovies))
                return
            }
        })
    }
    
    
    func getDayTrendingMovies(page: Int, onResponse: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let movies = dbDataSource.getMoviesForCategory(.trendingDay, genre: nil)
        let domainMovies = movies.map{ self.domainMapper.map($0) }
        onResponse(.success(domainMovies))
        return networkDataSource.getDayTrendingMovies(page: page, onResponse: {result in
            switch (result) {
            case .failure(let error):
                if movies.count == 0 {
                    onResponse(.failure(error))
                }
                return
            case .success(let value):
                self.dbDataSource.updateMoviesForCategory(.trendingDay, movies: value.results, genre: nil)
                let movies = self.dbDataSource.getMoviesForCategory(.trendingDay, genre: nil)
                let domainMovies = movies.map{ self.domainMapper.map($0) }
                onResponse(.success(domainMovies))
                return
            }
        })
    }
    
    func getWeekTrendingMovies(page: Int, onResponse: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let movies = dbDataSource.getMoviesForCategory(.trendingWeek, genre: nil)
        let domainMovies = movies.map{ self.domainMapper.map($0) }
        onResponse(.success(domainMovies))
        return networkDataSource.getWeekTrendingMovies(page: page, onResponse:  {result in
            switch (result) {
            case .failure(let error):
                if movies.count == 0 {
                    onResponse(.failure(error))
                }
                return
            case .success(let value):
                self.dbDataSource.updateMoviesForCategory(.trendingWeek, movies: value.results, genre: nil)
                let movies = self.dbDataSource.getMoviesForCategory(.trendingWeek, genre: nil)
                let domainMovies = movies.map{ self.domainMapper.map($0) }
                onResponse(.success(domainMovies))
                return
            }
        })
    }
    
    func getTopRatedMovies(page: Int, genre: Int?, onResponse: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let movies = dbDataSource.getMoviesForCategory(.trendingWeek, genre: genre)
        let domainMovies = movies.map{ self.domainMapper.map($0) }
        onResponse(.success(domainMovies))
        return networkDataSource.getTopRatedMovies(page: page, onResponse:  {result in
            switch (result) {
            case .failure(let error):
                if movies.count == 0 {
                    onResponse(.failure(error))
                }
                return
            case .success(let value):
                self.dbDataSource.updateMoviesForCategory(.topRated, movies: value.results, genre: genre)
                let movies = self.dbDataSource.getMoviesForCategory(.trendingWeek, genre: genre)
                let domainMovies = movies.map{ self.domainMapper.map($0) }
                onResponse(.success(domainMovies))
                return
            }
        })
    }
    
    func getRecommendedMovies(movieId: Int, genre: Int?, page: Int, onResponse: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let movies = dbDataSource.getMoviesForCategory(.recommended, genre: genre)
        let domainMovies = movies.map{ self.domainMapper.map($0) }
        onResponse(.success(domainMovies))
        return networkDataSource.getRecommendedMovies(movieId: movieId, page: page, onResponse:  {result in
            switch (result) {
            case .failure(let error):
                if movies.count == 0 {
                    onResponse(.failure(error))
                }
                return
            case .success(let value):
                self.dbDataSource.updateMoviesForCategory(.recommended, movies: value.results, genre: genre)
                let movies = self.dbDataSource.getMoviesForCategory(.recommended, genre: genre)
                let domainMovies = movies.map{ self.domainMapper.map($0) }
                onResponse(.success(domainMovies))
                return
            }
        })
    }
    
    func getMovieDetails(movieId: Int, page: Int, onResponse: @escaping (Result<DetailedMovieNetworkModel, NetworkError>) -> Void) {
        return networkDataSource.getMovieDetails(movieId: movieId, page: page, onResponse: onResponse)
    }
    
    func searchMovies(query: String, page: Int, onResponse: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let movies = dbDataSource.searchMovies(query: query)
        onResponse(.success(movies.map{ self.domainMapper.map($0) }))
    }
    
    func likeMovie(_ tmdbId: Int64, like: Bool = true) {
        dbDataSource.likeMovie(tmdbId, like: like)
        dbDataSource.saveChanges()
    }
    
    func getLiked(_ tmdbId: Int64) -> Bool {
        return dbDataSource.getLiked(tmdbId)
    }
}

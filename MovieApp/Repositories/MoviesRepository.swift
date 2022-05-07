//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation
import Network

class MoviesRepository {
    static private let base_url = "https://api.themoviedb.org/3"
    static let base_image_url = "https://image.tmdb.org/t/p/w500"
    private let networkService: NetworkServiceProtocol
    private var apiKey: String = ""
    
    init (networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        loadApiKey()
    }
    
    func getMovieGenres(onResponse: @escaping (Result<MovieGenreNetworkModel, NetworkError>) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                let params = ["api_key" : self.apiKey, "language" : "en-US"]
                self.networkService.get(MoviesRepository.base_url + "/genre/movie/list", queryParams: params, onResponse: onResponse)
            } else {
                onResponse(Result.failure(NetworkError.clientError))
            }
            monitor.cancel()
        }
        monitor.start(queue: queue)
    }
    
    func getPopularMovies(page: Int, onResponse: @escaping (Result<PaginatedNetworkModel<SimpleMovieNetworkModel>, NetworkError>) -> Void){
        let params = ["api_key" : apiKey, "language" : "en-US", "page" : String(page)]
        networkService.get(MoviesRepository.base_url + "/movie/popular", queryParams: params, onResponse: onResponse)
    }
    
    func getDayTrendingMovies(page: Int, onResponse: @escaping (Result<PaginatedNetworkModel<SimpleMovieNetworkModel>, NetworkError>) -> Void) {
        getTrendingMovies(interval: "day", page: page, onResponse: onResponse)
    }
    
    func getWeekTrendingMovies(page: Int, onResponse: @escaping (Result<PaginatedNetworkModel<SimpleMovieNetworkModel>, NetworkError>) -> Void) {
        getTrendingMovies(interval: "week", page: page, onResponse: onResponse)
    }
    
    private func getTrendingMovies(interval: String, page: Int, onResponse: @escaping (Result<PaginatedNetworkModel<SimpleMovieNetworkModel>, NetworkError>) -> Void) {
        let params = ["api_key" : apiKey, "page" : String(page)]
        networkService.get(MoviesRepository.base_url + "/trending/movie/" + interval, queryParams: params, onResponse: onResponse)
    }
    
    func getTopRatedMovies(page: Int, onResponse: @escaping (Result<PaginatedNetworkModel<SimpleMovieNetworkModel>, NetworkError>) -> Void) {
        let params = ["api_key" : apiKey, "language" : "en-US", "page" : String(page)]
        networkService.get(MoviesRepository.base_url + "/movie/top_rated", queryParams: params, onResponse: onResponse)
    }
    
    func getRecommendedMovies(movieId: Int, page: Int, onResponse: @escaping (Result<PaginatedNetworkModel<SimpleMovieNetworkModel>, NetworkError>) -> Void) {
        let params = ["api_key" : apiKey, "language" : "en-US", "page" : String(page)]
        networkService.get(MoviesRepository.base_url + "/movie/" + String(movieId) + "/recommendations", queryParams: params, onResponse: onResponse)
    }
    
    func getMovieDetails(movieId: Int, page: Int, onResponse: @escaping (Result<DetailedMovieNetworkModel, NetworkError>) -> Void) {
        let params = ["api_key" : apiKey, "language" : "en-US", "page" : String(page)]
        networkService.get(MoviesRepository.base_url + "/movie/" + String(movieId), queryParams: params, onResponse: onResponse)
    }
    
    private func loadApiKey() {
        var keys: NSDictionary?
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            if let key = dict["tmdbApiKey"] as? String {
                apiKey = key
            }
        }

    }
}

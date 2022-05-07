//
//  MovieModel.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation
//OVO JE NAPRAVLJENO ZA DZ 1 KAKO BIH MOGAO TESTIRATI PRIKAZ PODATAKA, S OBZIROM NA MOVIEMODEL IZ PACKAGEA u DRUGOJ DZ, OVO JE REDUNDANTNO TE ĆE BITI USKORO MAKNUTO
struct MovieModel {
    let id: Int
    let name: String
    let imageUrl: String
    let shortDescription: String
    let releaseDate: Date
    let releaseCountry: String
    let genres: [String]
    let length: TimeInterval
    let userScorePercentage: Int
    
    let featuredPeople: [MovieFeaturedEntityModel]?
    let cast: [MovieCastModel]?
    let reviews: [MovieReviewModel]?
    let recommendations: [MovieRecommendationModel]?
    
}

extension MovieModel {
    static func getPlaceholderMovie() async -> MovieModel {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let movie = MovieModel(
            id: 0,
            name: "Iron Man",
            imageUrl: "DemoCover.jpg",
            shortDescription: "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.",
            releaseDate: formatter.date(from: "2008/02/05 00:00").unsafelyUnwrapped,
            releaseCountry: "US",
            genres: ["Action", "Science Fiction", "Adventure"],
            length: TimeInterval(hours: 2, minutes: 6),
            userScorePercentage: 76,
            featuredPeople: [
                MovieFeaturedEntityModel(id: 0, name: "Don Heck", role: "Characters"),
                MovieFeaturedEntityModel(id: 1, name: "Jack Kirby", role: "Characters"),
                MovieFeaturedEntityModel(id: 2, name: "Jon Favreau", role: "Director"),
                MovieFeaturedEntityModel(id: 3, name: "Don Heck", role: "Screenplay"),
                MovieFeaturedEntityModel(id: 4, name: "Jack Marcum", role: "Screenplay"),
                MovieFeaturedEntityModel(id: 5, name: "Matt Holloway", role: "Screenplay")
            ],
            cast: nil,
            reviews: nil,
            recommendations: nil)
        return movie;
    }
}

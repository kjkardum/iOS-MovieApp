//
//  MovieGroupMO+CoreDataProperties.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieGroupMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGroupMO> {
        return NSFetchRequest<MovieGroupMO>(entityName: "MovieGroupMO")
    }

    @NSManaged public var rawType: Int64
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension MovieGroupMO {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieMO)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieMO)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension MovieGroupMO : Identifiable {

}

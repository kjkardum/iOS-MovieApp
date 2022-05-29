//
//  GenreMO+CoreDataProperties.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//
//

import Foundation
import CoreData


extension GenreMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreMO> {
        return NSFetchRequest<GenreMO>(entityName: "GenreMO")
    }

    @NSManaged public var tmdbId: Int64
    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension GenreMO {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieMO)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieMO)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension GenreMO : Identifiable {

}

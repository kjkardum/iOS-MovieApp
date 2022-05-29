//
//  MovieMO+CoreDataProperties.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 29.05.2022..
//
//

import Foundation
import CoreData


extension MovieMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieMO> {
        return NSFetchRequest<MovieMO>(entityName: "MovieMO")
    }

    @NSManaged public var tmdbId: Int64
    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: Data?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int64
    @NSManaged public var liked: Bool
    @NSManaged public var genres: NSSet?
    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for genres
extension MovieMO {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreMO)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreMO)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for groups
extension MovieMO {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: MovieGroupMO)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: MovieGroupMO)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}

extension MovieMO : Identifiable {

}

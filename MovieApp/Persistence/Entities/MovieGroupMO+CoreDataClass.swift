//
//  MovieGroupMO+CoreDataClass.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 28.05.2022..
//
//

import Foundation
import CoreData

@objc(MovieGroupMO)
public class MovieGroupMO: NSManagedObject {
    var type: MovieGroupEnum {
        get {
            return MovieGroupEnum(rawValue: rawType) ?? .unknown
        }
        set {
            rawType = newValue.rawValue
        }
    }
}

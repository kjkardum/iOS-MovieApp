//
//  MapperProtocol.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 28.05.2022..
//

import Foundation

class MapperProtocol<TEntity, TModel> {
    func map(_:TEntity) -> TModel {
        fatalError("MapperProtocol should be used as abstract class")
    }
    func map(_:TModel) -> TEntity {
        fatalError("MapperProtocol should be used as abstract class")
    }
}

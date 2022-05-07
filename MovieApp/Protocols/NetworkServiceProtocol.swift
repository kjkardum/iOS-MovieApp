//
//  NetworkServiceProtocol.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation


enum NetworkError: Error {
    case conversionError(String)
    case httpError(String)
    case jsonError(String)
    case clientError
}

protocol NetworkServiceProtocol {
    typealias resultHandler<T> = (Result<T, NetworkError>) -> Void
    
    func get<T: Decodable>(_ url: String, onResponse: @escaping resultHandler<T>)
    func get<T: Decodable>(_ url: String, queryParams: [String : String], onResponse: @escaping resultHandler<T>)
    func post<T: Decodable, BodyType>(_ url: String, body: BodyType, onResponse: @escaping resultHandler<T>) where BodyType: Encodable
    func post<T: Decodable, BodyType>(_ url: String, body: BodyType, queryParams: [String : String], onResponse: @escaping resultHandler<T>) where BodyType: Encodable
}

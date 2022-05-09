//
//  NetworkService.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 07.05.2022..
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    let session: URLSession
    init() {
        session = URLSession.shared
    }
    
    func get<T: Decodable>(_ url: String, onResponse: @escaping (Result<T, NetworkError>) -> Void) {
        get(url, queryParams: [:], onResponse: onResponse)
    }
    
    func get<T: Decodable>(_ url: String, queryParams: [String : String], onResponse: @escaping (Result<T, NetworkError>) -> Void) {
        let urlWithParams = addQueryParamsToUrl(url, queryParams: queryParams)
        guard let request = createUrlRequest(urlWithParams, method: "GET") else {
            onResponse(.failure(.conversionError("Cannot convert url parameters")))
            return
        }
        let dataTask = handleUrLRequest(request, onResponse: onResponse)
        dataTask.resume()
    }
    
    func post<T: Decodable, BodyType>(_ url: String, body: BodyType, onResponse: @escaping (Result<T, NetworkError>) -> Void) where BodyType: Encodable{
        post(url, body: body, queryParams: [:], onResponse: onResponse)
    }
    
    func post<T: Decodable, BodyType>(_ url: String, body: BodyType, queryParams: [String : String], onResponse: @escaping (Result<T, NetworkError>) -> Void) where BodyType: Encodable {
        let urlWithParams = addQueryParamsToUrl(url, queryParams: queryParams)
        guard var request = createUrlRequest(urlWithParams, method: "POST") else {
            onResponse(.failure(.conversionError("Cannot convert url parameters")))
            return
        }
        guard let jsonData = try? JSONEncoder().encode(body) else {
            onResponse(.failure(.conversionError("Cannot convert body to JSON")))
            return
        }
        request.httpBody = jsonData
        let dataTask = handleUrLRequest(request, onResponse: onResponse)
        dataTask.resume()
    }
    
    private func addQueryParamsToUrl(_ url: String, queryParams: [String : String]) -> String {
        var newUrl = url
        if newUrl.contains("?") {
            newUrl = newUrl + "&"
        } else {
            newUrl = newUrl + "?"
        }
        let queryString = queryParams
            .map{ key, value in encodeParameter(key) + "=" + encodeParameter(value)}
            .joined(separator: "&")
        newUrl = newUrl + queryString
        print(newUrl)
        return newUrl
    }
    
    private func encodeParameter(_ queryParameter: String) -> String {
        return queryParameter.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? queryParameter
    }
    
    private func createUrlRequest(_ url: String, method: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func handleUrLRequest<T: Decodable>(_ request: URLRequest, onResponse: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: request) { data, response, err in
            guard err == nil else {
                onResponse(.failure(.clientError))
                return
            }
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                onResponse(.failure(.httpError("Invalid response")))
                return
            }
            guard let data = data else {
                onResponse(.failure(.jsonError("No data")))
                return
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                onResponse(.failure(.jsonError(String(describing: T.self))))
                do {
                    let _ = try JSONDecoder().decode(T.self, from: data)
                } catch {
                    print(error)
                }
                
                return
            }
            onResponse(.success(value))
            
        }
    }
}

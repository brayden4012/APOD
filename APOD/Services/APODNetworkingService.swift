//
//  APODNetworkingService.swift
//  APOD
//
//  Created by Brayden Harris on 6/25/24.
//

import Foundation

class NetworkingService {
    enum NetworkingError: Error {
        case badURL
    }
    
    var host: String {
        "api.nasa.gov"
    }
    
    var apiKey: String {
        "dr4JYK8pYVdC00eCDMd9Lwvsl5iYQohgSw5Jn2sr"
    }
    
    var components: URLComponents {
        var comps = URLComponents()
        comps.host = host
        comps.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return comps
    }
    
    func get(path: String, queryItems: [URLQueryItem] = []) async throws -> (Data, URLResponse) {
        var components = components
        components.path = path
        components.queryItems?.insert(contentsOf: queryItems, at: 0)
        var queryItems = queryItems + [URLQueryItem(name: "api_key", value: apiKey)]
        let query: String = queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        guard let url = URL(string: "https://\(host)/\(path)?\(query)") else { throw NetworkingError.badURL }
        let request = URLRequest(url: url)
        return try await URLSession.shared.data(for: request)
    }
}

final class APODNetworkingService: NetworkingService {
    func getAPOD() async throws -> [APOD] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var thirtyDaysAgoString: String?
        if let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date()) {
            thirtyDaysAgoString = dateFormatter.string(from: thirtyDaysAgo)
        }
        let queryItems = [
            URLQueryItem(name: "start_date", value: thirtyDaysAgoString)
        ]
        let (data, _) = try await get(path: "planetary/apod", queryItems: queryItems)
        return try JSONDecoder().decode([APOD].self, from: data)
    }
}

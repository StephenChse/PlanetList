//
//  NetworkHandler.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import Foundation

enum API: String {
    private static let baseURL = "https://swapi.dev/api/planets/"
    case planetList = "planetList"
    var url: URL {
        return URL(string: API.baseURL)!
    }
}

enum APIError: Error {
    case noData
    case error(Error)
}

protocol NetworkSession {
    func getCall(url: URL) async throws -> Data
}

extension URLSession: NetworkSession {
    func getCall(url: URL) async throws -> Data {
        do  {
            let (data, _) = try await data(from: url)
            return data
        } catch {
            throw APIError.noData
        }
    }
}

class NetworkHandler {
    private let session: NetworkSession
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getCall(url: URL) async throws -> Data {
        return try await session.getCall(url: url)
    }
}

//
//  NetworkSessionMock.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import Foundation

class NetworkSessionMock: NetworkSession {
    var data: Data?
    func getCall(url: URL) async throws -> Data {
        if let data = data {
            return data
        }
        throw APIError.noData
    }
}

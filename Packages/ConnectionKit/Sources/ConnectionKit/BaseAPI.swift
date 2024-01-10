//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

public protocol BaseAPI {
    var baseURL: String { get }
    var session: Session { get }
    var defaultHeaders: [String: String] { get }
}

public extension BaseAPI {
    var baseURL: String { "https://www.themealdb.com/api/json/v1/1" }
    var session: Session { Session.default }
    var defaultHeaders: [String: String] { [:] }
}

public typealias APIResponse<Object: Codable> = Observable<Result<Object, Error>>

public extension BaseAPI {
    func request<Response: Codable>(
        _ method: HTTPMethod,
        endpoint: String,
        headers: [String: String] = [:],
        payload: Parameters? = nil
    ) -> APIResponse<Response> {
        let session = self.session
        let request = session.rx.request(
            method, "\(baseURL)\(endpoint)",
            parameters: payload,
            encoding: URLEncoding.default,
            headers: HTTPHeaders.init(defaultHeaders))
        return request
            .validate()
            .responseJSON()
            .map { dataResponse -> Result<Response, Error> in
                guard let data = dataResponse.data else  {
                    return .failure(APIError.dataFailed)
                }
                
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Response.self, from: data)
                    return .success(result)
                } catch (let error) {
                    debugPrint(error)
                    return .failure(APIError.decodeFailed)
                }
            }
    }
}

//
//  HomeNetworkRouter.swift
//  shoppy
//
//  Created by YasirRomaya on 8/23/21.
//

import Foundation
import Alamofire

enum HttpClientRouter: URLRequestConvertible {
    
    case getHomeData(_ parameters:Parameters? = nil, _ headers:HTTPHeaders? = nil)
    
    
    var baseURL: URL {
        return URL(string: "http://sadad-api.uats-sitegate.com/api/v1")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getHomeData:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getHomeData:
            return "/home"
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getHomeData(_, let headers):
            return headers
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getHomeData(let parameters, _):
            return parameters
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        if let headers = self.headers {
            request.headers = headers
        }
        
        if let parameters = self.parameters {
            request = try encoding.encode(request, with: parameters)
        }
        
        return request
    }
}

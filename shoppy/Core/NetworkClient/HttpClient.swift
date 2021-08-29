//
//  HttpClient.swift
//  shoppy
//
//  Created by YasirRomaya on 8/23/21.
//

import Foundation
import Alamofire

enum RequestResult {
    case success(Data)
    case failure(Error)
}


class HttpClient {
    static let sharedInstance = HttpClient()
    
    func request(_ request: URLRequestConvertible, completionHandler: @escaping (RequestResult) -> ()) {
        
        let session = Session.default
        session.sessionConfiguration.timeoutIntervalForRequest = 120
        session.sessionConfiguration.timeoutIntervalForResource = 120
        
        session.request(request).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

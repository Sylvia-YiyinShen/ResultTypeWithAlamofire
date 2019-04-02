//
//  NetworkService.swift
//  ResultType
//
//  Created by Yiyin Shen on 2/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Alamofire

public class NetworkService {
    private var  sessionManager: SessionManager
    init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionManager = SessionManager(configuration: sessionConfiguration,
                                        serverTrustPolicyManager: nil)
    }

    public func performRequest(url: URL, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        sessionManager.request(urlRequest).responseData { (response) in
            switch response.result {
            case let .success(value):
                success(String("value:\(value)"))
            case let .failure(error):
                failure(String("value:\(error.localizedDescription)"))
            }
        }
    }

    // public func performRequest<T>(url: URL, completionHandler: @escaping (Swift.Result<T, Error>) ->
    public func performRequest(url: URL, completionHandler: @escaping (Swift.Result<String, Error>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        sessionManager.request(urlRequest).responseData { (response) in
            switch response.result {
            case let .success(value):
                completionHandler(.success(String("\(value)")))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }

    public func cancelAllRequest() {
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }

}

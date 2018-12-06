//
//  Networking.swift
//  MobileNOC Test
//
//  Created by Deepak Kumar on 2018-12-03.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation

class MobileNOCServer: NSObject, URLSessionDelegate{

    // MARK: Singleton
    public static let sharedInstance = MobileNOCServer()
    private override init() {}
    
    private let timeout = 5.0
    private let urlString = "https://45.55.43.15:9090/api/machine"
    private let authHeader = "admin@boot.com:admin".data(using: .utf8)?.base64EncodedString() ?? ""
    
    func getResponse(page: Int, completion: @escaping (_ response: MobileNOCResponse?, _ error: Error?) -> Void) -> Void {
        let url = URL(string: "\(urlString)?&size=10&page=\(page)")!
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeout)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Basic \(authHeader)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(MobileNOCResponse.self, from: data!)
                completion(jsonResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - Delegate Function
    // Handling certs
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

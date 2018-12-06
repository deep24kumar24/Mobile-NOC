//
//  MobileNOCModel.swift
//  MobileNOC Test
//
//  Created by Deepak Kumar on 2018-12-04.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation

enum FilterType : Int {
    case all = 0
    case active = 1
    case down = 2
    case allLocation = 3
}

class MobileNOCModel: NSObject {
    
    //MARK:- Singeleton
    public static let instance = MobileNOCModel()
    private override init() {}
    
    
    //MARK: - Variables
    private var page = 0
    private var response: MobileNOCResponse?
    var activeServers = [Content]()
    var downServers = [Content]()
    var totalCounts = 0
    
    //MARK: - Public Methods
    func loadNext() {
        MobileNOCServer.sharedInstance.getResponse(page: page) { (response, error) in
            self.response = response!
            if let contents = response?.content {
                for content in contents {
                    if content.status.id == 1 || content.status.id == 2 {
                        self.activeServers.append(content)
                    } else {
                        self.downServers.append(content)
                    }
                    self.totalCounts += 1
                }
                DispatchQueue.main.async {
                    self.page += 1
                     NotificationCenter.default.post(name: NSNotification.Name("MoreDataDownloaded"), object: nil)
                }
            }
        }
    }
    
    func moreAvailable() -> Bool{
        if let response = response {
            return !response.last
        } else {
            return true
        }
    }
    
}

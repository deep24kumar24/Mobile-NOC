//
//  ListServersViewController.swift
//  MobileNOC Test
//
//  Created by Deepak Kumar on 2018-12-03.
//  Copyright © 2018 deepak. All rights reserved.
//

import Foundation
import UIKit

class ServerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isLoading = false
    var filter : FilterType = .all
    var isSearching = false
    
    //MARK: - View Outlets
    
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var tableViewServers: UITableView!
    @IBOutlet var FilterButtons: Array<FilterButton>!

    
    //MARK: - Override Method
    
    override func viewDidLoad() {
        tableViewServers.register(UINib(nibName: "ServerCell", bundle: nil), forCellReuseIdentifier: "idServerCell")
        NotificationCenter.default.addObserver(self, selector: #selector(dataRecieved), name: NSNotification.Name("MoreDataDownloaded"), object: nil)
        isLoading = true
        filter = .all
        FilterButtons[0].isSelected = true
        MobileNOCModel.instance.loadNext()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: - TableView Delegate & DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch filter {
        case .all, .allLocation:
            counter.text = "\(MobileNOCModel.instance.totalCounts)"
            if section == 0 {
                return MobileNOCModel.instance.downServers.count
            } else if section == 2 {
                return MobileNOCModel.instance.activeServers.count
            } else {
                return 1
            }
        case .active:
            counter.text = "\(MobileNOCModel.instance.activeServers.count)"
            if section == 2 {
                return MobileNOCModel.instance.activeServers.count
            } else {
                return 0
            }
        case .down:
            counter.text = "\(MobileNOCModel.instance.downServers.count)"
            if section == 0 {
                return MobileNOCModel.instance.downServers.count
            } else {
                return 0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 2{
            var content : Content!
            if indexPath.section == 0 {
                content = MobileNOCModel.instance.downServers[indexPath.row]
            } else {
                content = MobileNOCModel.instance.activeServers[indexPath.row]
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "idServerCell") as! ServerCell
            cell.initialize(serverName: content.name, ipAddress: content.ipAddress ?? "", deviceIdSubnetMask: content.ipSubnetMask ?? "", status: content.status.id)
            return cell
        } else if indexPath.section == 1 {
            return (tableView.dequeueReusableCell(withIdentifier: "idSeperator"))!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "idLoadingCell") as! loadingCell
            
            if isLoading {
                isLoading = false
                cell.activityIndicator.isHidden = true
            } else {
                if MobileNOCModel.instance.moreAvailable() {
                    isLoading = true
                    cell.activityIndicator.isHidden = false
                    cell.activityIndicator.startAnimating()
                    MobileNOCModel.instance.loadNext()
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 50
        } else {
            return 80
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func filterChanged(_ sender: FilterButton) {
        for button in FilterButtons {
            button.isSelected = false
        }
        sender.isSelected = true
        isLoading = true
        filter = FilterType(rawValue: sender.tag) ?? .all
        tableViewServers.reloadData()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dataRecieved() {
        isLoading = true
        counter.text = "\(MobileNOCModel.instance.totalCounts)"
        tableViewServers.reloadData()
    }
}


extension ServerListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
    }
}

class loadingCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

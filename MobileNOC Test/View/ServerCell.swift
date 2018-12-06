//
//  ServerCell.swift
//  MobileNOC Test
//
//  Created by Deepak Kumar on 2018-12-04.
//  Copyright © 2018 deepak. All rights reserved.
//

import UIKit

class ServerCell: UITableViewCell {
    
    
    //MARK: - View Outlets
    
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var serverStatusIndicator: UIImageView!
    @IBOutlet weak var serverImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var btnServerChecked: UIButton!
    @IBOutlet weak var btnServerCall: UIButton!
    @IBOutlet weak var btnServerTimer: UIButton!
    @IBOutlet weak var btnServerMute: UIButton!
    @IBOutlet weak var serverName: UILabel!
    @IBOutlet weak var ipAddress: UILabel!
    @IBOutlet weak var deviceIdSubnetMask: UILabel!
    
    
    //MARK: - Public Initializer
    
    func initialize(serverName: String, ipAddress: String, deviceIdSubnetMask: String, status: Int) {
        configureServerPropertyImages()
        addContentViewShadow()
        
        self.serverName.text = serverName
        self.ipAddress.text = ipAddress
        self.deviceIdSubnetMask.text = deviceIdSubnetMask
        setupServerStatus(status: status)
        
        serverStatusIndicator.image = serverStatusIndicator.image!.withRenderingMode(.alwaysTemplate)
        
    }
    
    
    //MARK: - Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        
        innerContentView.backgroundColor = selected ? UIColor(red: 225/255, green: 246/255, blue: 1, alpha: 1.0): UIColor.white
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        innerContentView.backgroundColor = highlighted ? UIColor(red: 225/255, green: 246/255, blue: 1, alpha: 1.0): UIColor.white
    }

    
    //MARK: - Action (Click Events)
    
    @IBAction func serverPropertiesClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    //MARK: - Private Methods
    
    private func configureServerPropertyImages() {
        btnServerChecked.setImage(UIImage(named:"server-properties-check-selected"), for: .selected)
        btnServerCall.setImage(UIImage(named:"server-properties-call-selected"), for: .selected)
        btnServerTimer.setImage(UIImage(named:"server-properties-timer-selected"), for: .selected)
        btnServerMute.setImage(UIImage(named:"server-properties-mute-selected"), for: .selected)
        
        btnServerChecked.setImage(UIImage(named:"server-properties-check-unselected"), for: .normal)
        btnServerCall.setImage(UIImage(named:"server-properties-call-unselected"), for: .normal)
        btnServerTimer.setImage(UIImage(named:"server-properties-timer-unselected"), for: .normal)
        btnServerMute.setImage(UIImage(named:"server-properties-mute-unselected"), for: .normal)
    }
    
    private func setupServerStatus(status: Int) {
        switch status {
        case 1:
            serverStatusIndicator.tintColor = UIColor.green
        case 2:
            serverStatusIndicator.tintColor = UIColor.orange
        case 3:
            serverStatusIndicator.tintColor = UIColor.yellow
        case 4:
            serverStatusIndicator.tintColor = UIColor.red
        default:
            serverStatusIndicator.tintColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
    }
    
    private func addContentViewShadow() {
        innerContentView.layer.shadowOffset = CGSize(width: 1, height: 0)
        innerContentView.layer.shadowColor = UIColor.black.cgColor
        innerContentView.layer.shadowRadius = 3;
        innerContentView.layer.shadowOpacity = 0.25;
    }
    
}

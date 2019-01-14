//
//  ContactCell.swift
//  CodeTestMarinRusi
//
//  Created by Marin Rusi on 2018-12-21.
//  Copyright © 2018 Marin Rusi. All rights reserved.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell {
    
    required init(coder adecoder: NSCoder) {
        fatalError("init(codeer:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.yellow
        setupViewsForContactCell()
    }
    
    let contactNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let contactLastNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let contactDOBLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    let phoneNumberLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    let phoneNumberLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let emailLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let emailLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    
   
    
    /// Setup contactData for cell
    var contactData: ContactBook? {
        didSet {
            guard let name = contactData?.name else { return }
            guard let lastName = contactData?.lastName else { return }
            guard let phoneNumber = contactData?.phoneNumbers else { return }
            guard let dateOfBirth = contactData?.dateOfBirth else { return }
            guard let addresses = contactData?.addresses else { return }
            guard let phoneNumbers = contactData?.phoneNumbers else { return }
            guard let emails = contactData?.emails else { return }
            contactNameLabel.text = name
             contactLastNameLabel.text = lastName
             contactDOBLabel.text = dateOfBirth
             contactNameLabel.text = name
             contactNameLabel.text = name
            print("addresses  count", addresses.addresses.count)
            if (phoneNumbers.phoneNumbers.count == 1) {
            phoneNumberLabel.text = phoneNumbers.phoneNumbers.first
            }
            else if (phoneNumbers.phoneNumbers.count == 2){
                phoneNumberLabel.text = phoneNumbers.phoneNumbers.first
                phoneNumberLabel2.text = phoneNumbers.phoneNumbers[1]
            }
            else if (phoneNumbers.phoneNumbers.count == 3){
                phoneNumberLabel.text = phoneNumbers.phoneNumbers.first
                phoneNumberLabel2.text = phoneNumbers.phoneNumbers[1]
                phoneNumberLabel3.text = phoneNumbers.phoneNumbers[2]
            }
            if (emails.emails.count == 1) {
                emailLabel.text = emails.emails.first
            }
            else if (emails.emails.count == 2){
                emailLabel.text = emails.emails.first
                emailLabel2.text = emails.emails[1]
            }
            else if (emails.emails.count == 3){
                emailLabel.text = emails.emails.first
                emailLabel2.text = emails.emails[1]
                emailLabel3.text = emails.emails[2]
            }
            if (addresses.addresses.count == 1) {
                addressLabel.text = addresses.addresses.first
            }
            else if (addresses.addresses.count == 2){
                addressLabel.text = addresses.addresses.first
                addressLabel2.text = addresses.addresses[1]
            }
            else if (emails.emails.count == 3){
                addressLabel.text = addresses.addresses.first
                addressLabel2.text = addresses.addresses[1]
                addressLabel3.text = addresses.addresses[2]
            }
            
        }
    }
    
    
    
    /// Setup views for ContactCell
    func setupViewsForContactCell() {
        addSubview(contactNameLabel)
        addSubview(contactLastNameLabel)
        addSubview(contactDOBLabel)
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberLabel2)
        addSubview(phoneNumberLabel3)
        addSubview(addressLabel)
        addSubview(addressLabel2)
        addSubview(addressLabel3)
        addSubview(emailLabel)
        addSubview(emailLabel2)
        addSubview(emailLabel3)
        contactNameLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 18, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        contactDOBLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 250, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        emailLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 42, leftConstant: 128, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        emailLabel2.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 62, leftConstant: 128, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        emailLabel3.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 82, leftConstant: 128, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
         contactLastNameLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 128, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
         addressLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 44, leftConstant: 18, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        addressLabel2.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 64, leftConstant: 18, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        addressLabel3.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 84, leftConstant: 18, bottomConstant: 0, rightConstant: 18, widthConstant: 0, heightConstant: contactNameLabel.frame.height)
        
        phoneNumberLabel.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 44, leftConstant: 250, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: phoneNumberLabel.frame.height)
        phoneNumberLabel2.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 64, leftConstant: 250, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: phoneNumberLabel.frame.height)
        phoneNumberLabel3.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 84, leftConstant: 250, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: phoneNumberLabel.frame.height)
    }
    
    
    
    /// Reset cell properties when cell will reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        contactNameLabel.text = ""
        contactLastNameLabel.text = ""
        contactDOBLabel.text = ""
        phoneNumberLabel.text = ""
        phoneNumberLabel2.text = ""
        phoneNumberLabel3.text = ""
        emailLabel.text = ""
        emailLabel2.text = ""
        emailLabel3.text = ""
        addressLabel.text = ""
        addressLabel2.text = ""
        addressLabel3.text = ""
        
    }
    
}

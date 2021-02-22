//
//  SearchHotelsTableViewCell.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/21/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import UIKit

class SearchHotelsTableViewCell: UITableViewCell {
    
    lazy var hotelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = .black
        label.numberOfLines = 0
        //label.backgroundColor = .orange
        return label
    }()
    
    lazy var starIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        //imageView.backgroundColor = .cyan
        return imageView
    }()
    
    lazy var starsLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location")
        //imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .systemPink
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Inside UITableViewCell subclass

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    public func setHotelInfo(name: String, stars: Int, address: String, distance: Double) {
        hotelNameLabel.text = name
        starsLabel.text = String(Double(stars))
        addressLabel.text = address
        distanceLabel.text = "\(String(distance)) meters away from center"
    }
    private func setupView() {
        //self.layer.borderWidth = 0.5
        //self.layer.borderColor = UIColor.systemGray3.cgColor
        //self.contentView.backgroundColor = .yellow
        self.layer.cornerRadius = 10
        //self.backgroundColor = .green
        self.selectionStyle = .none
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = true
        
        let viewElements = [hotelNameLabel, starIconImageView, starsLabel, addressLabel, locationIconImageView, distanceLabel]
        viewElements.forEach { (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
            addSubview(element)
        }
        NSLayoutConstraint.activate([
            hotelNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            hotelNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            hotelNameLabel.trailingAnchor.constraint(equalTo: starIconImageView.leadingAnchor, constant: -20),
            
            starIconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            starIconImageView.centerYAnchor.constraint(equalTo: hotelNameLabel.centerYAnchor),
            starIconImageView.heightAnchor.constraint(equalToConstant: 30),
            starIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            starsLabel.topAnchor.constraint(equalTo: starIconImageView.bottomAnchor, constant: 5),
            starsLabel.centerXAnchor.constraint(equalTo: starIconImageView.centerXAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: hotelNameLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: hotelNameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: hotelNameLabel.trailingAnchor),
            
            locationIconImageView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            locationIconImageView.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            locationIconImageView.heightAnchor.constraint(equalToConstant: 25),
            locationIconImageView.widthAnchor.constraint(equalToConstant: 25),
            
            distanceLabel.centerYAnchor.constraint(equalTo: locationIconImageView.centerYAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: locationIconImageView.trailingAnchor, constant: 10),
            distanceLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor)
        ])
    }

}

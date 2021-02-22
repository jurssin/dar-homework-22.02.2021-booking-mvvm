//
//  DetailedHotelViewController.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/22/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import UIKit

class DetailedHotelViewController: UIViewController {
    
    lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var hotelImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var hotelNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
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

    var hotelId: Int?
    var hotelName: String?
    let viewModel = DetailedHotelViewModel()
    var detailedHotel: DetailedHotel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.getDetailedHotels(id: hotelId!) { [weak self] (hotel) in
            guard let imageName = hotel?.image else { return }
            self?.setHotelImage(imageName: imageName)
            self?.hotelNameLabel.text = self?.hotelName
            guard let stars = hotel?.stars else { return }
            self?.starsLabel.text = String(stars)
            self?.addressLabel.text = hotel?.address
            self?.distanceLabel.text = "\((hotel?.distance) ?? 0.0) meters away from center"
        }
        
        // Do any additional setup after loading the view.
    }
    private func setHotelImage(imageName: String) {
        viewModel.getImage(id: imageName) { [weak self] (imageData) in
            if let image = UIImage(data: imageData) {
                self?.hotelImageView.image = image
            }
            else {
                self?.hotelImageView.image = UIImage(named: "no image")
            }
        }
        spinner.stopAnimating()
    }
    
}

extension DetailedHotelViewController {
    private func setupView() {
        spinner.startAnimating()
        title = hotelName
        view.backgroundColor = .secondarySystemBackground
        
        let viewElements = [hotelImageView, hotelNameLabel, starIconImageView, starsLabel, addressLabel, locationIconImageView, distanceLabel, spinner]
        viewElements.forEach { (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            hotelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            hotelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            hotelImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            hotelImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.36),
            
            hotelNameLabel.topAnchor.constraint(equalTo: hotelImageView.bottomAnchor, constant: 15),
            hotelNameLabel.leadingAnchor.constraint(equalTo: hotelImageView.leadingAnchor),
            hotelNameLabel.trailingAnchor.constraint(equalTo: starIconImageView.leadingAnchor, constant: -20),
            
            starIconImageView.centerYAnchor.constraint(equalTo: hotelNameLabel.centerYAnchor),
            starIconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
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
            distanceLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

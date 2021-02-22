//
//  DetailedHotelViewController.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/22/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import UIKit

class DetailedHotelViewController: UIViewController {
    
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
            self?.hotelNameLabel.text = hotel?.name
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
    }
    
}

extension DetailedHotelViewController {
    private func setupView() {
        title = hotelName
        view.backgroundColor = .secondarySystemBackground
        
        let viewElements = [hotelImageView, hotelNameLabel, starIconImageView]
        viewElements.forEach { (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            hotelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            hotelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            hotelImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            hotelImageView.heightAnchor.constraint(equalToConstant: 300),
            
            hotelNameLabel.topAnchor.constraint(equalTo: hotelImageView.bottomAnchor, constant: 15),
            hotelNameLabel.leadingAnchor.constraint(equalTo: hotelImageView.leadingAnchor),
            hotelNameLabel.trailingAnchor.constraint(equalTo: starIconImageView.leadingAnchor, constant: -20),
            
            starIconImageView.centerYAnchor.constraint(equalTo: hotelNameLabel.centerYAnchor),
            starIconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            starIconImageView.heightAnchor.constraint(equalToConstant: 30),
            starIconImageView.widthAnchor.constraint(equalToConstant: 30)
            

        ])
    }
}

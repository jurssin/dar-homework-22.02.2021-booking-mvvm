//
//  DetailedHotelViewController.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/22/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import UIKit
import MapKit

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
    
    lazy var availableRoomsLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .systemPink
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    
    var annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    var hotelId: Int?
    var hotelName: String?
    let viewModel = DetailedHotelViewModel()
    var detailedHotel: DetailedHotel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.getDetailedHotels(id: hotelId!) { [weak self] (hotel) in
            
            self?.annotation.coordinate = CLLocationCoordinate2D(latitude: hotel?.lat ?? 0.0, longitude: hotel?.lon ?? 0.0)
            self?.mapView.addAnnotation(self!.annotation)
            self?.region = .init(center: (self?.annotation.coordinate)!, latitudinalMeters: 500, longitudinalMeters: 500)
            self?.mapView.setRegion(self!.region, animated: true)
            self?.hotelNameLabel.text = self?.hotelName
            self?.addressLabel.text = hotel?.address
            self?.distanceLabel.text = "\((hotel?.distance) ?? 0.0) meters away from center"
            self?.availableRoomsLabel.text = "Rooms available: \(hotel?.suitesAvailability ?? "No available rooms")"
            guard let stars = hotel?.stars else {
                self?.spinner.stopAnimating()
                return
            }
            self?.starsLabel.text = String(stars)
            guard let imageName = hotel?.image else {
                self?.setHotelImage(imageName: "no image")
                self?.spinner.stopAnimating()
                return
            }
            self?.setHotelImage(imageName: imageName)
            self?.spinner.stopAnimating()

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
        navigationBarSetup()
        spinner.startAnimating()
        view.backgroundColor = .secondarySystemBackground
        
        let viewElements = [hotelImageView, hotelNameLabel, starIconImageView, starsLabel, addressLabel, locationIconImageView, distanceLabel, spinner, availableRoomsLabel, mapView]
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
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            availableRoomsLabel.topAnchor.constraint(equalTo: locationIconImageView.bottomAnchor, constant: 10),
            availableRoomsLabel.leadingAnchor.constraint(equalTo: locationIconImageView.leadingAnchor),
            availableRoomsLabel.trailingAnchor.constraint(equalTo: starIconImageView.leadingAnchor),
            
            mapView.topAnchor.constraint(equalTo: availableRoomsLabel.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: availableRoomsLabel.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: starIconImageView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
    private func navigationBarSetup() {
        title = hotelName
        var button: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(addToFavourites))

        viewModel.favHotels = UserDefaults.standard.stringArray(forKey: "Hotel") ?? []

        if viewModel.favHotels.contains(hotelName!) {
                    button = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(addToFavourites))
                }
                self.navigationController?.navigationBar.tintColor = .black
                self.navigationItem.rightBarButtonItem = button
                

    }
    @objc func addToFavourites() {
        guard let hotelTitle = title else { return }
        if !viewModel.favHotels.contains(hotelTitle) {
            viewModel.favHotels.append(hotelTitle)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            UserDefaults.standard.setValue(viewModel.favHotels, forKey: "Hotel")
        }
        else {
            guard let hotel = viewModel.favHotels.firstIndex(of: hotelTitle) else { return }
            viewModel.favHotels.remove(at: hotel)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            UserDefaults.standard.setValue(viewModel.favHotels, forKey: "Hotel")
        }
        print(viewModel.favHotels)
    }
}

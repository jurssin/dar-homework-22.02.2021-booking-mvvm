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
        imageView.backgroundColor = .green
        return imageView
    }()

    var hotelId: Int?
    var hotelName: String?
    let viewModel = DetailedHotelViewModel()
    var detailedHotel: DetailedHotel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getDetailedHotels(id: hotelId!) { [weak self] (hotel) in
            self?.title = hotel?.name
            guard let imageName = hotel?.image else { return }
            let url = URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(imageName)")!
            let imageData = try? Data(contentsOf: url)
            self?.hotelImageView.image = UIImage(data: imageData ?? Data())
            //print(hotel?.image)
        }
        // Do any additional setup after loading the view.
    }
    
}

extension DetailedHotelViewController {
    private func setupView() {
        //title = hotelName
        view.backgroundColor = .secondarySystemBackground
        
        let viewElements = [hotelImageView]
        viewElements.forEach { (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            hotelImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            hotelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            hotelImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            hotelImageView.heightAnchor.constraint(equalToConstant: 300)

        ])
    }
}

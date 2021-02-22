//
//  SearchHotelsViewController.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/21/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import UIKit
import Moya

class SearchHotelsViewController: UIViewController {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search hotels by address..."
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var hotelsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchHotelsTableViewCell.self, forCellReuseIdentifier: "HotelsCell")
        //tableView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        //tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.rowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    let viewModel = SearchHotelsViewModel()
    var hotelList = [Hotel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        hideKeyboardWhenTappedAround()
        viewModel.getHotels { [weak self] in
            self?.hotelList = self?.viewModel.hotels ?? []

            self?.hotelsTableView.reloadData()
            self?.spinner.stopAnimating()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        title = "Hotel Search"
        navBarSetup()
        let viewElements = [hotelsTableView, spinner, searchBar]
        viewElements.forEach { (element) in
            element.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(element)
        }
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            hotelsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            hotelsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hotelsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            hotelsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        spinner.startAnimating()

    }
    
    private func navBarSetup() {
        self.tabBarController?.tabBar.items![0].image = UIImage(systemName: "house.fill")
        self.tabBarController?.tabBar.items![1].image = UIImage(systemName: "heart.fill")
        self.tabBarController?.tabBar.items![1].title = "Favourite Hotels"
        self.tabBarController?.tabBar.tintColor = .black
        
        let barButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortList))
        barButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    @objc func sortList() {
        let alert = UIAlertController(title: "Sort", message: "Select sorting method", preferredStyle: .actionSheet)
        let distanceSort = UIAlertAction(title: "Distance", style: .default) { [weak self] (action) in
            self?.viewModel.sortByDistanceHotelList {
                self?.hotelsTableView.reloadData()
            }
        }
        let roomsSort = UIAlertAction(title: "Available rooms", style: .default) { [weak self] (action) in
            self?.viewModel.sortByRoomsHotelList {
                self?.hotelsTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(distanceSort)
        alert.addAction(roomsSort)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
extension SearchHotelsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        viewModel.hotels = hotelList
        hotelsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(by: searchText) {
            hotelsTableView.reloadData()
        }
        if searchText.isEmpty {
            viewModel.hotels = hotelList
            hotelsTableView.reloadData()
        }
    }
}

extension SearchHotelsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.hotels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailedHotelViewController()
        vc.hotelId = viewModel.hotels[indexPath.section].id
        vc.hotelName = viewModel.hotels[indexPath.section].name

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelsCell", for: indexPath) as! SearchHotelsTableViewCell
        let hotelInfo = viewModel.hotels[indexPath.section]
        cell.setHotelInfo(name: hotelInfo.name, stars: hotelInfo.stars, address: hotelInfo.address, distance: hotelInfo.distance)
        
        return cell
    }
    
    
}

//
//  DetailViewController.swift
//  iOSTask
//
//  Created by nineleaps on 23/03/22.
//

import UIKit
import CoreData

class RestaurantsListViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = nil
        table.dataSource = nil
        table.register(RestaurantsListTableViewCell.self, forCellReuseIdentifier: "restaurantsListTableCell")
       /// table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        //table.tableFooterView = UIView()
        return table
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController

    }()
    var busniessViewModel = BusinessViewModel()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurants"
        setRightBarButton()
        
        let connectivity = Reachability.shared
        connectivity.startMonitoring()
        connectivity.checkNetwork { (status) in
            if status == true {
                DispatchQueue.main.async {
                    self.setUpTableView()
                    self.setSeachBar()
                    if self.busniessViewModel.searchTerm.count != 0{
                        self.fetchBusiness()

                    } else {
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
                    }
                }
            } else {
                let businessCoreDataViewModel = BussinessCoreDataViewModel()
                businessCoreDataViewModel.retriveData { (businesses) in
                    DispatchQueue.main.async {
                        self.setUpTableView()
                        self.busniessViewModel.busniess = businesses
                        self.tableView.delegate = self
                        self.tableView.dataSource = self

                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        

    }
    
    //MARK: - SetUpUI
    private func setUpTableView() {
        self.view.addSubview(tableView)

        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func setSeachBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func setRightBarButton(){
        let filterButton  : UIBarButtonItem = UIBarButtonItem(title: "Filter", style: UIBarButtonItem.Style.plain, target: self, action: #selector(filterButtonPressed))
        self.navigationItem.rightBarButtonItem = filterButton

    }
    
    //MARK: -  Button Action
    @objc func filterButtonPressed() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let filterVC = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        filterVC.modalPresentationStyle = .fullScreen

        
        let navController = UINavigationController(rootViewController: filterVC)
        filterVC.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        filterVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))

        self.navigationController!.present(navController, animated: true, completion: nil)

       
        
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)

        self.activityIndicatorBegin()
        busniessViewModel.fetchBusinesses(latitiude: FilterViewModel.selectedLocation.latitude , longitude: FilterViewModel.selectedLocation.longitude ) { (business) in
            DispatchQueue.main.async {
                self.activityIndicatorEnd()
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Fetch Business

    private func fetchBusiness(){
        self.activityIndicatorBegin()
        let lat = self.busniessViewModel.userLocation.locationManager?.location?.coordinate.latitude
        let long = self.busniessViewModel.userLocation.locationManager?.location?.coordinate.longitude
        busniessViewModel.fetchBusinesses(latitiude: lat ?? 40.7128, longitude: long ?? 74.0060 ) { (business) in
            DispatchQueue.main.async {
                self.activityIndicatorEnd()
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
   

}

//MARK: - TableView Delagate & Datasource

extension RestaurantsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.busniessViewModel.busniess?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurantsListTableCell = tableView.dequeueReusableCell(withIdentifier: "restaurantsListTableCell", for: indexPath) as! RestaurantsListTableViewCell
        restaurantsListTableCell.lblName.text = self.busniessViewModel.busniess?[indexPath.row].name
        return restaurantsListTableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.detailViewModel.business = self.busniessViewModel.busniess?[indexPath.row]
        saveLocally(detailVM: detailVC.detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
//MARK: - UISearchBar &  UISearchResults Delagate

extension RestaurantsListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.busniessViewModel.searchTerm = searchBar.text ?? ""
        let lat = self.busniessViewModel.userLocation.locationManager?.location?.coordinate.latitude
        let long = self.busniessViewModel.userLocation.locationManager?.location?.coordinate.longitude
        self.activityIndicatorBegin()
        self.tableView.isHidden = true
        busniessViewModel.fetchBusinesses(latitiude: lat ?? 40.7128, longitude: long ?? 74.0060 ) { (business) in
            DispatchQueue.main.async {
                self.tableView.isHidden = false

                self.activityIndicatorEnd()
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        //your code here....
    }
}

//MARK: - Saving to CoreData

extension RestaurantsListViewController {
    func saveLocally(detailVM:DetailViewModel ) {
        let coreDataVM = BussinessCoreDataViewModel()
        coreDataVM.saveLocally(detailVM: detailVM)
    }
}

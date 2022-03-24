//
//  FilterViewController.swift
//  iOSTask
//
//  Created by nineleaps on 24/03/22.
//

import UIKit
import CoreLocation





class FilterViewController: UIViewController {

    var filterViewModel = FilterViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = nil
        table.dataSource = nil
        table.register(RestaurantsListTableViewCell.self, forCellReuseIdentifier: "restaurantsListTableCell")
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()


        // Do any additional setup after loading the view.
    }
    
    //MARK: - Setup UI
    private func setUpTableView() {
        self.view.addSubview(tableView)

        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

//MARK: - TableView Delagate & Datasource

extension FilterViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Catogories"
        } else {
            return "Locations"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.filterViewModel.searchCategories.count
        } else {
            return self.filterViewModel.locations.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let restaurantsListTableCell = tableView.dequeueReusableCell(withIdentifier: "restaurantsListTableCell", for: indexPath) as! RestaurantsListTableViewCell
        restaurantsListTableCell.accessoryType = .none
        if indexPath.section == 0 {
            if FilterViewModel.selectedCategory == self.filterViewModel.searchCategories[indexPath.row] {
                restaurantsListTableCell.accessoryType = .checkmark
            }
            restaurantsListTableCell.lblName.text = self.filterViewModel.searchCategories[indexPath.row]

        } else {
            let  componentArray = [String] (self.filterViewModel.locations.keys)
            let values = [CLLocationCoordinate2D] (self.filterViewModel.locations.values)
            
            if  FilterViewModel.selectedLocation.latitude == values[indexPath.row].latitude {
                restaurantsListTableCell.accessoryType = .checkmark

            }


            restaurantsListTableCell.lblName.text = componentArray[indexPath.row]
        }
        return restaurantsListTableCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantsListTableCell = tableView.dequeueReusableCell(withIdentifier: "restaurantsListTableCell", for: indexPath) as! RestaurantsListTableViewCell
        
        if indexPath.section == 0 {
            FilterViewModel.selectedCategory = self.filterViewModel.searchCategories[indexPath.row]
        } else {
            let values = [CLLocationCoordinate2D] (self.filterViewModel.locations.values)
            FilterViewModel.selectedLocation = values[indexPath.row]
        }
        restaurantsListTableCell.accessoryType = .checkmark
        self.tableView.reloadData()
        

    }
    
}

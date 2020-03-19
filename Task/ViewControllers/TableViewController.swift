//
//  TableViewController.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import UIKit


enum Type {
    case voivodeships, cities
}

class TableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var type: Type = .voivodeships
    private var voivodeships: [VoivodeshipModel]?
    private var cities: [CityModel]?

    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.beginRefreshing()
        fetchData()
    }
    
    //MARK: - Private functions
    
    private func fetchData() {
        
        switch type {
        case .voivodeships:
            NetworkingClient.instance.fetchVoivodeship {
                self.voivodeships = $0
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        case .cities:
            NetworkingClient.instance.fetchCities() {
                self.cities = $0
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - TableView dataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        switch type {
        case .voivodeships:
            if let voivodeships = voivodeships {
                return voivodeships.count
            }
        case .cities:
            if let cities = cities {
                return cities.count
            }
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        switch type {
        case .voivodeships:
            if let voivodeships = voivodeships {
                cell.textLabel?.text = voivodeships[indexPath.row].name
                cell.accessoryType = .disclosureIndicator
            }
        case .cities:
            if let cities = cities {
                cell.textLabel?.text = cities[indexPath.row].name
                cell.accessoryType = .disclosureIndicator
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch type {
        case .voivodeships:
            if let voivodeships = voivodeships {
                let citiesTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                citiesTableViewController.navigationItem.title = voivodeships[indexPath.row].name
                citiesTableViewController.type = .cities
                self.navigationController?.pushViewController(citiesTableViewController, animated: true)
            }
        case .cities:
            if let cities = cities {
                let pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
                pageViewController.navigationItem.title = cities[indexPath.row].name
                pageViewController.places = cities[indexPath.row].places
                self.navigationController?.pushViewController(pageViewController, animated: true)
                
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func refreshAction(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        fetchData()
    }
}

//
//  SearchResultTableViewController.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    var savedProjects = [Any]()
    var searchedproject = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in searchresult")
        tableView.tableFooterView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 60
    }
    
    func getData(completion: @escaping () -> Void) {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let randomNumber = Int.random(in: 1...20)
            print("Number: \(randomNumber)")
            self.savedProjects.removeAll()
            self.appendProjects(randomNumber)
            if randomNumber == 10 {
                timer.invalidate()
                completion()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedproject.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchedproject[indexPath.row] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedIndex!)
        guard let selectedValue =  cell?.textLabel?.text else { return }
        print("project: \(selectedValue)")
        
        guard let selectedVC = (mmDrawerContainer?.centerViewController as? TabBarController)?.selectedViewController as? UINavigationController else { return }
    }

}

// MARK: - SearchResultDelegate
extension SearchResultTableViewController: UISearchResultsUpdating,UISearchBarDelegate {
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.isLoading = true
        self.tableView.isHidden = true
        getData {
            self.tableView.isHidden = false
            searchBar.isLoading = false
        }
    }
    
    func appendProjects(_ value: Int) {
        let projectCreated = "Project: \(value)"
        savedProjects.append(projectCreated)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[cd] %@", searchController.searchBar.text!)
        searchedproject = (savedProjects as NSArray).filtered(using: searchPredicate)
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
       print("cancell searhc")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
 
}

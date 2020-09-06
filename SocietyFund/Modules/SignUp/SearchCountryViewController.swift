//
//  SearchCountryViewController.swift
//  SocietyFund
//
//  Created by sanish on 9/6/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

protocol CountryDelegate: class {
    func selectedCountry(country: CountryCode)
}

class SearchCountryViewController: UIViewController {
    
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var countryCodes = [CountryCode]()
    var selectedCountry: CountryCode?
    var delegate: CountryDelegate?
    var searchedCountry = [CountryCode]()
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        view.bringSubviewToFront(viewAlert)
        SignInInteractor().getDialCode { (countryCodes) in
            self.countryCodes = countryCodes
            self.searchedCountry = countryCodes
            tableView.reloadData()
        }
    }
    
}

//MARK: - SearchBarDelegate
extension SearchCountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Log.debug(msg: searchBar.text)
        self.searchedCountry.removeAll()
        if (searchBar.text!.isEmpty) {
            self.searchedCountry = self.countryCodes
        }else {
            for country in self.countryCodes {
                if ((country.name!.contains(searchBar.text!)) || (country.code!.contains(searchBar.text!))) {
                   self.searchedCountry.append(country)
               }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}

//MARK: - TableViewDelegate
extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CountryCell
        let country = searchedCountry[indexPath.row].name!
        let shortName = searchedCountry[indexPath.row].code!
        cell.lblCountry.text = """
                  \(country) (\(shortName))
                """
        cell.lblCode.text = searchedCountry[indexPath.row].dialCode
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.indexPathForSelectedRow
        selectedCountry = searchedCountry[selectedRow!.row]
        delegate?.selectedCountry(country: selectedCountry!)
        dismiss(animated: false, completion: nil)
    }
}

//MARK: - CountryCell
class CountryCell: UITableViewCell {
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
}

//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: Sandwich)
}

class SandwichViewController: UITableViewController, SandwichDataSource {

  
  
  private let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [Sandwich]()
  var filteredSandwiches = [Sandwich]()
  
  let defaults = UserDefaults.standard

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    loadSandwiches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchBar.selectedScopeButtonIndex = defaults.integer(forKey: "saucey")
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map {$0 .rawValue}
    searchController.searchBar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    do {
      sandwiches = try context.fetch(Sandwich.fetchRequest())

    } catch let error as NSError {
      print("Could not fetch. \(error)")
      
    }
  }
  
  func loadSandwiches() {
        guard let sandwichJSONURL = Bundle.main.url(forResource: "sandwiches",
                                                withExtension: "json") else {
                                                  return
    }
    
    let decoder = JSONDecoder()
    
    do {
      let sandwichData = try Data(contentsOf: sandwichJSONURL)
      let sandwich = try decoder.decode([SandwichData].self, from: sandwichData)
      sandwiches.append(contentsOf: try context.fetch(Sandwich.fetchRequest()))
      print(Sandwich())

    } catch let error {
      print(error)
      
    }
  }

  func saveSandwich(_ sandwich: Sandwich) {
    sandwiches.append(sandwich)
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    filteredSandwiches = sandwiches.filter { (sandwich: Sandwich) -> Bool in
      let doesSauceAmountMatch = sauceAmount == .any || sandwich.sauces?.sauceAmount == sauceAmount

      if isSearchBarEmpty {
        return doesSauceAmountMatch
      } else {
        return doesSauceAmountMatch && sandwich.name!.lowercased()
          .contains(searchText.lowercased())
      }
    }
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

//    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: Sandwich().imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauces?.sauceAmount.description

    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    defaults.set(sauceAmount?.sauceValue, forKey: "saucey")
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)

  }
  

}


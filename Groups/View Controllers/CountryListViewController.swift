//
//  CountryListViewController.swift
//  Groups
//
//  Created by John Brayton on 9/8/21.
//

import UIKit

class CountryListViewController: UITableViewController {

    let countries: [Country]
    
    init( countries: [Country] ) {
        self.countries = countries
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = String.localizedStringWithFormat("Countries")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.countries[indexPath.row]
        let childViewController = GroupListViewController(countryName: country.name, groups: country.groups)
        self.navigationController?.pushViewController(childViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}


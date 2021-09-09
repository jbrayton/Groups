//
//  GroupListViewController.swift
//  GroupListViewController
//
//  Created by John Brayton on 9/9/21.
//

import UIKit

class GroupListViewController: UITableViewController {

    let country: Country
    
    init( country: Country ) {
        self.country = country
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = self.country.name
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUserActivity()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.country.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.country.groups[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = self.country.groups[indexPath.row]
        let childViewController = GroupViewController(group: group, countryIdentifier: self.country.identifier)
        self.navigationController?.pushViewController(childViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    func setUserActivity() {
        NSUserActivity.setCurrent(withIdentifier: String(format: "countries/%@", self.country.identifier), title: self.country.name)
    }

}


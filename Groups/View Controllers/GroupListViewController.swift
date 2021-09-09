//
//  GroupListViewController.swift
//  GroupListViewController
//
//  Created by John Brayton on 9/9/21.
//

import UIKit

class GroupListViewController: UITableViewController {

    let countryName: String
    let groups: [Group]
    
    init( countryName: String, groups: [Group] ) {
        self.countryName = countryName
        self.groups = groups
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = self.countryName
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.groups[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group = self.groups[indexPath.row]
        let childViewController = GroupViewController(group: group)
        self.navigationController?.pushViewController(childViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}


//
//  GroupViewController.swift
//  GroupViewController
//
//  Created by John Brayton on 9/9/21.
//

import UIKit

class GroupViewController : UIViewController {
    
    let group: Group
    let countryIdentifier: String
    
    var meetingTextLabel: UILabel!

    init( group: Group, countryIdentifier: String ) {
        self.group = group
        self.countryIdentifier = countryIdentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.title = self.group.name
        
        self.view.backgroundColor = .white
        
        self.meetingTextLabel = UILabel()
        self.meetingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.meetingTextLabel.text = self.group.meetingText
        self.meetingTextLabel.textColor = .black
        self.meetingTextLabel.numberOfLines = 0
        self.view.addSubview(self.meetingTextLabel)
        
        self.view.addConstraints([
            self.meetingTextLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.meetingTextLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.meetingTextLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUserActivity()
    }
    
    func setUserActivity() {
        NSUserActivity.setCurrent(withIdentifier: ContentIdentifier.groupDetails(countryIdentifier: self.countryIdentifier, groupIdentifier: self.group.identifier).identifierString, title: self.group.name)
    }

}

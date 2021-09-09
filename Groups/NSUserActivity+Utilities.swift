//
//  Constants.swift
//  Constants
//
//  Created by John Brayton on 9/9/21.
//

import Foundation

var currentUserActivity: NSUserActivity?

extension NSUserActivity {
    
    static func setCurrent( withIdentifier identifier: String, title: String ) {
        let userActivity = NSUserActivity(activityType: "com.goldenhillsoftware.Groups.view")
        userActivity.title = title
        userActivity.isEligibleForHandoff = true
        userActivity.persistentIdentifier = identifier
        userActivity.becomeCurrent()
        currentUserActivity = userActivity
    }
    
}

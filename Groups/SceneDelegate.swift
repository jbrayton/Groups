//
//  SceneDelegate.swift
//  Groups
//
//  Created by John Brayton on 9/8/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let countryListViewController = CountryListViewController(countries: Country.all)
        let navigationController = UINavigationController(rootViewController: countryListViewController)
        
        /*
             If launching from an NSUserActivity that specifies a specific country and/or group, push that onto the navigation stack.
         */
        if let userActivity = connectionOptions.userActivities.first, let persistentIdentifier = userActivity.persistentIdentifier, let contentIdentifier = ContentIdentifier.parse(persistentIdentifier) {
            if let countryIdentifier = contentIdentifier.countryIdentifier, let country = Country.all.with(identifier: countryIdentifier) {
                navigationController.pushViewController(GroupListViewController(country: country), animated: false)
                if let groupIdentifier = contentIdentifier.countryIdentifier, let group = country.groups.with(identifier: groupIdentifier) {
                    navigationController.pushViewController(GroupViewController(group: group, countryIdentifier: country.identifier), animated: false)
                }
            }
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    /*
        Gets called if the app is already launched and the user wants to go to a specific user activity.
        This could be made much cleaner, but the general idea is that this code is responsible for
        accepting the NSUserActivity and bending the view hierarchy to its will.
     */
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let persistentIdentifier = userActivity.persistentIdentifier, let contentIdentifier = ContentIdentifier.parse(persistentIdentifier), let navigationController = self.window?.rootViewController as? UINavigationController else {
            return
        }
        
        switch contentIdentifier {
        case .countryList:
            while navigationController.children.count > 1 {
                navigationController.popViewController(animated: false)
            }
        case .groupListByCountry( let countryIdentifier ):
            while navigationController.children.count > 2 {
                navigationController.popViewController(animated: false)
            }
            if navigationController.children.count == 2 {
                if let topViewController = navigationController.topViewController as? GroupListViewController, topViewController.country.identifier == countryIdentifier {
                    return
                } else {
                    navigationController.popViewController(animated: false)
                }
            }
            if let countryIdentifier = contentIdentifier.countryIdentifier, let country = Country.all.with(identifier: countryIdentifier) {
                navigationController.pushViewController(GroupListViewController(country: country), animated: false)
            }
        case .groupDetails( let countryIdentifier, let groupIdentifier ):
            while navigationController.children.count > 3 {
                navigationController.popViewController(animated: false)
            }
            if navigationController.children.count == 3 {
                if let topViewController = navigationController.topViewController as? GroupViewController, topViewController.group.identifier == groupIdentifier {
                    return
                } else {
                    navigationController.popViewController(animated: false)
                }
            }
            var needCountry = true
            if navigationController.children.count == 2 {
                if let topViewController = navigationController.topViewController as? GroupListViewController, topViewController.country.identifier == countryIdentifier {
                    needCountry = false
                } else {
                    navigationController.popViewController(animated: false)
                }
            }
            
            if let countryIdentifier = contentIdentifier.countryIdentifier, let country = Country.all.with(identifier: countryIdentifier) {
                if needCountry {
                    navigationController.pushViewController(GroupListViewController(country: country), animated: false)
                }
                if let groupIdentifier = contentIdentifier.groupIdentifier, let group = country.groups.with(identifier: groupIdentifier) {
                    navigationController.pushViewController(GroupViewController(group: group, countryIdentifier: country.identifier), animated: false)
                }
            }
        }
    }

}


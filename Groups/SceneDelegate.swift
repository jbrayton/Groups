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
        if let userActivity = connectionOptions.userActivities.first, let components = userActivity.persistentIdentifier?.components(separatedBy: "/") {
            if components.count > 1, components[0] == "countries" {
                let countryIdentifier = components[1]
                for country in Country.all {
                    if country.identifier == countryIdentifier {
                        navigationController.pushViewController(GroupListViewController(country: country), animated: false)
                    }
                    if components.count == 4, components[2] == "groups" {
                        let groupIdentifier = components[3]
                        for group in country.groups {
                            if group.identifier == groupIdentifier {
                                navigationController.pushViewController(GroupViewController(group: group, countryIdentifier: country.identifier), animated: false)
                            }
                        }
                    }
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
        guard let components = userActivity.persistentIdentifier?.components(separatedBy: "/"), let navigationController = self.window?.rootViewController as? UINavigationController else {
            return
        }
        if components.count == 1, components[0] == "countries" {
            while navigationController.children.count > 1 {
                navigationController.popViewController(animated: false)
            }
        }
        if components.count == 2, components[0] == "countries" {
            let countryIdentifier = components[1]
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
            for country in Country.all {
                if country.identifier == countryIdentifier {
                    navigationController.pushViewController(GroupListViewController(country: country), animated: false)
                    return
                }
            }
        }
        if components.count == 4, components[0] == "countries", components[2] == "groups" {
            let countryIdentifier = components[1]
            let groupIdentifier = components[3]
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
            
            for country in Country.all {
                if country.identifier == countryIdentifier {
                    if needCountry {
                        navigationController.pushViewController(GroupListViewController(country: country), animated: false)
                    }
                    for group in country.groups {
                        if group.identifier == groupIdentifier {
                            navigationController.pushViewController(GroupViewController(group: group, countryIdentifier: country.identifier), animated: false)
                        }
                    }
                }
            }
            
        }
    }

}


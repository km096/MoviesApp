//
//  MainTabBar.swift
//  Task 4
//
//  Created by ME-MAC on 12/21/22.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupVCs()
    }
    
    func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = .systemGray
    }
    
    
    func setupVCs() {
        let vc1 = UIStoryboard(name: "Movies", bundle: nil) .instantiateViewController(withIdentifier: "MoviesNC") as! UINavigationController
        vc1.tabBarItem.customizeTabBar(title: "movies".localized, image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let vc2 = UIStoryboard(name: "People", bundle: nil) .instantiateViewController(withIdentifier: "PeopleNC") as! UINavigationController
        vc2.tabBarItem.customizeTabBar(title: "people".localized, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        self.setViewControllers([vc1, vc2], animated: false)
    }

}

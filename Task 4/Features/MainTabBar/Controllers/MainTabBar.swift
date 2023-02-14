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

        let moviesVC = self.instantiateVC(appStoryboard: .movies, vc: MoviesVC.self)
        moviesVC.tabBarItem.customizeTabBar(title: "movies".localized, image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let peopleVC = self.instantiateVC(appStoryboard: .people, vc: PeopleVC.self)
        peopleVC.tabBarItem.customizeTabBar(title: "people".localized, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let favoriteVC = self.instantiateVC(appStoryboard: .favorite, vc: FavoriteMoviesVC.self)
        favoriteVC.tabBarItem.customizeTabBar(title: "favorite".localized, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        self.setViewControllers([moviesVC, peopleVC, favoriteVC], animated: false)
    }

}




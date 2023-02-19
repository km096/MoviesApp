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
        configureTabBar()
    }
    
    func configureTabBar() {
        let moviesVC = self.instantiateVC(appStoryboard: .movies, vc: MoviesVC.self)
        moviesVC.configureTabBarItem("movies".localized, UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let peopleVC = self.instantiateVC(appStoryboard: .people, vc: PeopleVC.self)
        peopleVC.configureTabBarItem("people".localized, UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let favoriteVC = self.instantiateVC(appStoryboard: .favorite, vc: FavoriteMoviesVC.self)
        favoriteVC.configureTabBarItem("favorite".localized, UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        self.setViewControllers([moviesVC, peopleVC, favoriteVC], animated: false)
    }

}




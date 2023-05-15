//
//  MainTabBar.swift
//  Task 4
//
//  Created by ME-MAC on 12/21/22.
//

import UIKit
import CoreData

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBadge()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateBadge()
    }
    
    func updateBadge() {
        if let tabBarItems = self.tabBar.items {
            let tabItem = tabBarItems[2]
            tabItem.badgeValue = "\(getFavoriteMoviesCount())"
        }
    }
    
    func setTabBar() {
        let moviesVC = self.instantiateVC(appStoryboard: .movies, vc: MoviesVC.self)
        moviesVC.setTabBarItem("movies".localized, UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let peopleVC = self.instantiateVC(appStoryboard: .people, vc: PeopleVC.self)
        peopleVC.setTabBarItem("people".localized, UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let favoriteVC = self.instantiateVC(appStoryboard: .favorite, vc: FavoriteMoviesVC.self)
        favoriteVC.setTabBarItem("favorite".localized, UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        self.setViewControllers([moviesVC, peopleVC, favoriteVC], animated: false)
    }
    
    func getFavoriteMoviesCount() -> Int {
        let mangedcontext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        
        do {
            let count = try mangedcontext?.count(for: fetchRequest)
            return count!
        } catch {
            debugPrint("could not get count: \(error.localizedDescription)")
            return 0
        }
    }

}




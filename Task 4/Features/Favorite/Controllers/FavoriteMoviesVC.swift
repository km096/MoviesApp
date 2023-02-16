//
//  FavoriteMoviesVC.swift
//  Task 4
//
//  Created by ME-MAC on 2/14/23.
//

import UIKit
import CoreData

class FavoriteMoviesVC: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteMovie: [FavoriteMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.isHidden = false
        favoriteTableView.registerNib(cell: MoviesCell.self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreDataObjects()
    }
    
    func fetchCoreDataObjects() {
        self.fetchData { complete in
            if complete {
                if favoriteMovie.count > 0 {
                    favoriteTableView.isHidden = false
                } else {
                    favoriteTableView.isHidden = true
                }
            }
        }
        
    }
    
    func fetchData(completion: (_ complete: Bool)-> ()) {
        guard let mangedcontext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        
        do {
            favoriteMovie = try mangedcontext.fetch(fetchRequest)
            debugPrint("successfully fetched data")
            completion(true)
        } catch {
            debugPrint("could not fetch data: \(error.localizedDescription)")
            completion(
            false)
        }
        favoriteTableView.reloadData()
    }
    
    func removeMove(atIndexPath indexPath: IndexPath) {
        guard let mangedContext = appDelegate?.persistentContainer.viewContext else { return }
        mangedContext.delete(favoriteMovie[indexPath.row])
        
        do {
            try mangedContext.save()
            debugPrint("successfully removed movie")
        } catch {
            debugPrint("could not remove movie: \(error.localizedDescription)")
        }
    }
    

   

}

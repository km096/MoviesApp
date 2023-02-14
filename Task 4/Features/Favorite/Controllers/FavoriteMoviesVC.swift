//
//  FavoriteMoviesVC.swift
//  Task 4
//
//  Created by ME-MAC on 2/14/23.
//

import UIKit

class FavoriteMoviesVC: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.isHidden = false
        favoriteTableView.registerNib(cell: MoviesCell.self)
        // Do any additional setup after loading the view.
    }
    

   

}

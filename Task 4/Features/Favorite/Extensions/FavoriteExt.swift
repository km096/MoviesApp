//
//  FavoriteExt.swift
//  Task 4
//
//  Created by ME-MAC on 2/14/23.
//

import UIKit

extension FavoriteMoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell() as MoviesCell
        return cell
    }
}

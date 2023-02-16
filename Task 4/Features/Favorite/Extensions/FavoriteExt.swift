//
//  FavoriteExt.swift
//  Task 4
//
//  Created by ME-MAC on 2/14/23.
//

import UIKit
import Kingfisher

extension FavoriteMoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell() as MoviesCell
        let favMovie = favoriteMovie[indexPath.row]
        cell.lblTitle.text = favMovie.movieTitle
        cell.lblOverview.text = favMovie.movieOverview
        cell.lblReleaseDate.text = favMovie.movieReleaseDate
        cell.movieRate.value = favMovie.movieVoteAverage * 10
        cell.lblVoteAverage.text = String(describing: favMovie.movieVoteAverage)
        cell.imgPoster.kf.setImage(with: URL(string: Api.baseImageUrl + (favMovie.moviePosterPath ?? "")), options: [.cacheOriginalImage])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "REMOVE") { rowAction, indexPath in
            self.removeMove(atIndexPath: indexPath)
//            self.favoriteTableView.reloadRows(at: [indexPath], with: .automatic)
            self.favoriteTableView.reloadData()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return [deleteAction]
    }
}

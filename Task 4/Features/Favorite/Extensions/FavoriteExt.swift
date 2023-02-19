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
        cell.configureCell(movie: initMovie(atIndexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsVC")
                as? DetailsVC else {return}
        detailsVC.movie = initMovie(atIndexPath: indexPath)
        presestVC(detailsVC)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "REMOVE") { _, indexPath in
            self.removeMovie(atIndexPath: indexPath)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return [deleteAction]
    }
}

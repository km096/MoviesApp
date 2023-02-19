//
//  MoviesTableViewExt.swift
//  Task 4
//
//  Created by ME-MAC on 1/5/23.
//

import UIKit

extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? filteredMovies.count : currentMovies.movie.count
    }
    
    // Setup tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell() as MoviesCell        
        let movieToDispaly = isFiltered ? filteredMovies[indexPath.row] : currentMovies.movie[indexPath.row]
    
        cell.configureCell(movie: movieToDispaly)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsVC")
                as? DetailsVC else {return}
        detailsVC.movie = isFiltered ? filteredMovies[indexPath.row] : currentMovies.movie[indexPath.row]
        presestVC(detailsVC)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Add pagination
        switch moviesSegmentedControl.selectedSegmentIndex {
        case 0 :
            if indexPath.row == currentMovies.movie.count - 3 {
                fetchData(endPoint: EndPoint.popular)
            }
        case 1:
            if indexPath.row == currentMovies.movie.count - 3 {
                fetchData(endPoint: EndPoint.upcoming)
            }
        default:
            if indexPath.row == currentMovies.movie.count - 3 {
                fetchData(endPoint: EndPoint.nowPlaying)
            }
        }
        
        // Add animation to tableView
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    
}


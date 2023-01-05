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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTVC", for: indexPath) as? MoviesTVC {
            cell.btnGoToDetails.tag = indexPath.row
            cell.btnGoToDetails.addTarget(self, action: #selector(goToDetails), for: .touchUpInside)
            
            // If any filter applied load data from filteredMovies else load from currnetMovies
            let movieToDispaly = isFiltered ? filteredMovies[indexPath.row] : currentMovies.movie[indexPath.row]
        
            cell.setupCell (title: movieToDispaly.title, releaseDate: movieToDispaly.releaseDate, overview: movieToDispaly.overview, rate: (movieToDispaly.voteAverage ?? 0) * 10, voteAverage: movieToDispaly.voteAverage, imageUrl: Api.baseImageUrl+(movieToDispaly.posterPath ?? "" )
            )
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Add pagination
        if indexPath.row == currentMovies.movie.count - 3 {
            fetchData(endPoint: EndPoint.popular)
        }
        
        // Add animation to tableView
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    
}


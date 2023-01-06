//
//  MoviesFilterExt.swift
//  Task 4
//
//  Created by ME-MAC on 1/5/23.
//

import UIKit


extension MoviesVC: RateValueDelegate, UITextFieldDelegate {

    func rateValueDidChange(minValue: Float, maxValue: Float) {
        rate = (minValue, maxValue)
        filterByRate()
    }
        
    // Filter by movie rate
    func filterByRate() {
        filter { movie in
            Float(movie.voteAverage ?? 0) >= rate.0 && Float(movie.voteAverage ?? 0) <= rate.1 
        }
    }
    
    // Search tableView data through textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if string.count == 0 {
                isFiltered = false
            } else {
                filterByTitle(text+string)
            }
        }
        return true
    }
    
    // Filter by movie title
    func filterByTitle(_ text: String){
        filter { movie in
            movie.title?.lowercased().hasPrefix(text.lowercased()) ?? false
        }
    }
    
    //
    func filter(closure: (Movies) -> Bool) {
        let movie = currentMovies.movie.filter(closure)
        filteredMovies.removeAll()
        filteredMovies.append(contentsOf: movie)
        isFiltered = true
        tableView.reloadData()
    }
    
}

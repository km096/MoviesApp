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
        let movie = currentMovies.movie.filter({Float($0.voteAverage!) >= rate.0 && Float($0.voteAverage!) <= rate.1})
        filteredMovies.removeAll()
        filteredMovies.append(contentsOf: movie)
        isFiltered = true
        tableView.reloadData()
    }
    
    // search tableView data through textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if string.count == 0 {
                isFiltered = false
            } else {
                filterByTitle(text+string)
            }
        }
        tableView.reloadData()
        return true
    }
    
    // Filter by movie title
    func filterByTitle(_ text: String){
        filteredMovies.removeAll()
        let movie = currentMovies.movie.filter({
            $0.title!.lowercased().hasPrefix(text.lowercased()) })
        filteredMovies.append(contentsOf: movie)
        isFiltered = true
    }
}

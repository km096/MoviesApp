//
//  MovieExt.swift
//  Task 4
//
//  Created by ME-MAC on 2/20/23.
//

import Foundation
import CoreData

extension Movie {
    
    func toFavoriteMovie(_ mangedContext: NSManagedObjectContext) -> FavoriteMovie {
        let favoriteMovie = FavoriteMovie(context: mangedContext)
        favoriteMovie.movieTitle = title
        favoriteMovie.movieReleaseDate = releaseDate
        favoriteMovie.movieOverview = overview
        favoriteMovie.movieVoteAverage = (voteAverage)!
        favoriteMovie.movie_id = Int32((id)!)
        favoriteMovie.moviePosterPath = ((posterPath)!)

        return favoriteMovie
    }
}

extension FavoriteMoviesVC {
    
    func toMovie(atIndexPath indexPath: IndexPath) -> Movie {
        let favoriteMovie = favoriteMovie[indexPath.row]
        let movie = Movie(
            id: Int(favoriteMovie.movie_id),
            overview: favoriteMovie.movieOverview,
            posterPath: favoriteMovie.moviePosterPath,
            releaseDate: favoriteMovie.movieReleaseDate,
            title: favoriteMovie.movieTitle,
            voteAverage: favoriteMovie.movieVoteAverage
        )
        
        return movie
    }
}

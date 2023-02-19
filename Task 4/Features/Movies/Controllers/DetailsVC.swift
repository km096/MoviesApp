//
//  DetailsVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/20/22.
//

import UIKit
import Kingfisher
import Cosmos
import CoreData

class DetailsVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var addToFavoriteBtn: UIButton!
    
    var movie: Movies?
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMovieDetails()
        setRatingStars()
        imgPoster.addShadow(view: containerView, shadowOpacity: 0.7, shadowRadius: 15, cornerRadius: 13)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkFavorite()
    }
    
    func setFavoriteImage () {
        if isFavorite {
            addToFavoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            addToFavoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    func configureMovieDetails() {
        let imageUrl = URL(string: Api.baseImageUrl+(movie?.posterPath ?? ""))
        lblTitle.text = movie?.title
        lblOverview.text = movie?.overview
        imgPoster.kf.setImage(with: imageUrl, options: [.cacheOriginalImage])
    }
    
    func setRatingStars(){
        ratingStars.rating = (movie?.voteAverage ?? 0) / 2
        ratingStars.settings.fillMode = .precise
    }
    
    //Check if movie is in favorite list
    func checkFavorite() {
        guard let mangedcontext = appDelegate?.persistentContainer.viewContext else { return }

        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        fetchRequest.predicate = NSPredicate(format: "movie_id == %i", (movie?.id!)!)

        do {
            let results = try mangedcontext.fetch(fetchRequest)
            if results.count == 0 {
                isFavorite = false
            } else {
                isFavorite = true
            }
            self.setFavoriteImage()
        } catch {
            debugPrint("could not fetch data: \(error.localizedDescription)")
        }
    }
    
    // Save the movie in favorite list
    func saveFavoriteMovieData() {
        guard let mangedContext = appDelegate?.persistentContainer.viewContext else { return }
        let favoriteMovie = FavoriteMovie(context: mangedContext)
        favoriteMovie.movieTitle = movie?.title
        favoriteMovie.movieReleaseDate = movie?.releaseDate
        favoriteMovie.movieOverview = movie?.overview
        favoriteMovie.movieVoteAverage = (movie?.voteAverage)!
        favoriteMovie.movie_id = Int32((movie?.id)!)
        favoriteMovie.moviePosterPath = ((movie?.posterPath)!)
        
        do {
            try mangedContext.save()
            isFavorite = true
            setFavoriteImage()
            print("successfully saved data")
        } catch {
            debugPrint("could not save data: \(error.localizedDescription)")
        }
        
    }
    
    // Remove the movie from favorite list
    func removeFavoriteMovie() {
        guard let mangedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        fetchRequest.predicate = NSPredicate(format: "movie_id == %i", (movie?.id!)!)

        do {
            let results = try mangedContext.fetch(fetchRequest)
            for result in results {
                mangedContext.delete(result)
            }
            isFavorite = false
            setFavoriteImage()
            debugPrint("successfully removed movie")
        } catch {
            debugPrint("could not remove movie: \(error.localizedDescription)")
        }
    }
    
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        let textToShare = [lblTitle.text, lblOverview.text]
        let imageToShare = [imgPoster.image]
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, imageToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismissVC()
    }
    
    @IBAction func addToFavoriteBtnTapped(_ sender: UIButton) {
        if isFavorite {
            self.removeFavoriteMovie()
        } else {
            self.saveFavoriteMovieData()
        }
    }

}

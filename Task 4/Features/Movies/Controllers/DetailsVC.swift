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
    var favorite: [FavoriteMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        backView.layer.cornerRadius = 5
//        backView.alpha = 0.8
        
        configureMovieDetails()
        setupRatingStars()
        imgPoster.addShadow(view: containerView, shadowOpacity: 0.7, shadowRadius: 15, cornerRadius: 13)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkFavorite ()
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
    
    func setupRatingStars(){
        ratingStars.rating = (movie?.voteAverage ?? 0) / 2
        ratingStars.settings.fillMode = .precise
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
            self.removeMovie()
        } else {
            self.saveFavoriteMovieData()

        }
    }
    
    func checkFavorite() {
        guard let mangedcontext = appDelegate?.persistentContainer.viewContext else { return }

        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        fetchRequest.predicate = NSPredicate(format: "movie_id == %i", (movie?.id!)!)

        do {
            favorite = try mangedcontext.fetch(fetchRequest)
            if favorite.count == 0 {
                isFavorite = false

            } else {
                isFavorite = true
            }
            self.setFavoriteImage()
        } catch {
            debugPrint("could not fetch data: \(error.localizedDescription)")
        }
    }
    
    
    func saveFavoriteMovieData() {
        guard let mangedContext = appDelegate?.persistentContainer.viewContext else { return }
        let favoriteMovie = FavoriteMovie(context: mangedContext)
        favoriteMovie.movieTitle = movie?.title
        favoriteMovie.movieReleaseDate = movie?.releaseDate
        favoriteMovie.movieOverview = movie?.overview
        favoriteMovie.movieVoteAverage = movie?.voteAverage ?? 0
        favoriteMovie.movie_id = Int32(movie?.id ?? 0)
        favoriteMovie.moviePosterPath = Api.baseUrl + (movie?.posterPath ?? "")
        
        do {
            try mangedContext.save()
            isFavorite = true
            setFavoriteImage()
            print("successfully saved data")
        } catch {
            debugPrint("could not save data: \(error.localizedDescription)")
        }
        
    }
    
    func removeMovie() {
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
    
    
}

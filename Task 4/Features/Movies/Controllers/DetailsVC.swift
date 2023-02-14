//
//  DetailsVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/20/22.
//

import UIKit
import Kingfisher
import Cosmos

class DetailsVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var backView: UIView!
//    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var addToFavoriteBtn: UIButton!
    
    var movie: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        frontView.backgroundColor = .clear
        backView.layer.cornerRadius = 5
        backView.alpha = 0.8
        
        setupMovieDetails()
        setupRatingStars()
        imgPoster.addShadow (containerView: containerView, color: UIColor.black.cgColor,
                             shadowOpacity: 0.7, shadowRadius: 15, cornerRadius: 13)
    }
    
    func setupMovieDetails() {
        let imageUrl = URL(string: Api.baseImageUrl+(movie?.posterPath ?? ""))

        lblTitle.text = movie?.title
        lblOverview.text = movie?.overview
        imgPoster.kf.setImage(with: imageUrl, options: [.cacheOriginalImage])
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
    
    @IBAction func addToFavoriteBtnTapped(_ sender: Any) {
    }
    func setupRatingStars(){
        ratingStars.rating = (movie?.voteAverage ?? 0) / 2
        ratingStars.settings.fillMode = .precise
    }
    
    
    
}

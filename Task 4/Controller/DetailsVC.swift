//
//  DetailsVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/20/22.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var btnDetalis: UIButton!
    var movie: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frontView.backgroundColor = .clear
        backView.layer.cornerRadius = 5
        backView.alpha = 0.5
        btnDetalis.layer.cornerRadius = 5
        
        setupMovieDetails()
        imgPoster.addShadow (
            containerView: containerView, color: UIColor.black.cgColor,
            shadowOpacity: 0.7, shadowRadius: 10, cornerRadius: 10
        )
        btnDetalis.setTitle("details".localized, for: .normal)

        
    }
    
    func setupMovieDetails() {
        let imageUrl = URL(string: Api.baseImageUrl+(movie?.posterPath ?? ""))

        lblTitle.text = movie?.title
        lblOverview.text = movie?.overview
        imgPoster.kf.setImage(with: imageUrl, options: [.cacheOriginalImage])
        
        
    }

    
}

//
//  MoviesTVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit
import Kingfisher
import UICircularProgressRing

class MoviesCell: UITableViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var movieRate: UICircularProgressRing!
    @IBOutlet weak var btnGoToDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgPoster.roundCorner(cornerRadius: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateView(movie: Movies) {
        lblTitle.text = movie.title
        lblReleaseDate.text = movie.releaseDate
        lblOverview.text = movie.overview
        movieRate.value = (movie.voteAverage ?? 0) * 10
        lblVoteAverage.text = String(describing: movie.voteAverage ?? 0)
        imgPoster.kf.setImage(with: URL(string: Api.baseImageUrl+(movie.posterPath ?? "")),
            options: [.cacheOriginalImage])
    }

    
}

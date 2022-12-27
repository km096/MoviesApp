//
//  MoviesTVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit
import Kingfisher
import UICircularProgressRing

class MoviesTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var movieRate: UICircularProgressRing!
    
    @IBOutlet weak var btnGoToDetails: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradientView.addGradient()
        backView.backgroundColor = .clear
        imgPoster.roundCorner(cornerRadius: 15)
//        btnGoToDetails.changeDirection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(title: String?, releaseDate: String?, overview: String?, rate: Double?,
                   voteAverage: Double?, imageUrl: URL?) {
        lblTitle.text = title ?? ""
        lblReleaseDate.text = releaseDate ?? ""
        lblOverview.text = overview ?? ""
        movieRate.value = rate ?? 0
        lblVoteAverage.text = String(describing: (voteAverage ?? 0))
        imgPoster.kf.setImage(with: imageUrl, options: [.cacheOriginalImage])
        
    }

    
}

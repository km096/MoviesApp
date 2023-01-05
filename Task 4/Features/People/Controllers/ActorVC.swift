//
//  PersonVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/25/22.
//

import UIKit
import Kingfisher

class ActorVC: UIViewController {
    
    @IBOutlet weak var imgActor: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblKnownFor: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var actor: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        setupInfo()
        collectionView.layer.cornerRadius = 15
        imgActor.addShadow(containerView: containerView, color: UIColor.black.cgColor,
            shadowOpacity: 0.5, shadowRadius: 5, cornerRadius: 15)
        
    }
    
    func setupInfo () {
        lblName.text = actor?.name
        lblGender.text = "\(actor?.gender ?? 0)".localized
        lblKnownFor.text = actor?.knownForDepartment
        imgActor.kf.setImage(with: URL(string: Api.baseImageUrl+(actor?.profilePath ?? "")),
            options: [.cacheOriginalImage] )
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}


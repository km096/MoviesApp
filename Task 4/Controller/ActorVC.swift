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
        collectionView.layer.cornerRadius = 15
        setupInfo()
        imgActor.addShadow(containerView: containerView, color: UIColor.black.cgColor, shadowOpacity: 0.5, shadowRadius: 5, cornerRadius: 15)
        
    }
    
    func setupInfo () {
        lblName.text = actor?.name
        lblGender.text = "\(actor?.gender ?? 0)".localized
        lblKnownFor.text = actor?.knownForDepartment
        imgActor.kf.setImage(with: URL(string: Api.baseImageUrl+(actor?.profilePath ?? "")), options: [.cacheOriginalImage] )
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}

extension ActorVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = actor?.knownFor?.count else {return 0}
        return count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "knownForCell", for: indexPath) as? knownForCVC {
            let actorInfo = self.actor?.knownFor?[indexPath.item]
            cell.imgMoviePoster.kf.setImage(with: URL(string: Api.baseImageUrl+(actorInfo?.posterPath ?? "")), options: [.cacheOriginalImage])
            cell.imgMoviePoster.roundCorner(cornerRadius: 15)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 2.5, height: collectionView.frame.height)

    }
}

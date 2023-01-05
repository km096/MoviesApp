//
//  ActorCollectionViewEXT.swift
//  Task 4
//
//  Created by ME-MAC on 1/5/23.
//

import UIKit

// collectionView for actor movies
extension ActorVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = actor?.knownFor?.count else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "knownForCell", for: indexPath) as? knownForCVC {
            
            let actorInfo = self.actor?.knownFor?[indexPath.row]
            cell.imgMoviePoster.kf.setImage(with: URL(string: Api.baseImageUrl+(actorInfo?.posterPath ?? "")), options: [.cacheOriginalImage])
            cell.imgMoviePoster.roundCorner(cornerRadius: 15)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // Set distance betwwen cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 2.5, height: collectionView.frame.height)

    }
}

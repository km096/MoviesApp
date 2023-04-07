//
//  PeopleCollectionViewExt.swift
//  Task 4
//
//  Created by ME-MAC on 1/5/23.
//

import UIKit

//collectionView for actors
extension PeopleVC: UICollectionViewDelegate, UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCV", for: indexPath) as? PeopleCV {
            
            let person = person[indexPath.row]
            cell.lblName.text = person.name
            cell.imgPersonPhoto.kf.setImage(with: URL(string: Api.baseImageUrl+(person.profilePath ?? "")), options: [.cacheOriginalImage] )
            cell.imgPersonPhoto.addShadow(cell.contentView, 0.7, 10, 10)
            
            // To recognize which cell is tapped
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
            cell.containerView.addGestureRecognizer(tap)
            cell.containerView.tag = indexPath.row
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // Add pagination to collectioView
        if indexPath.row == person.count - 3 {
            getActorsData()
        }
    }
    
    // Set distance between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemSpacing: CGFloat = 15
        let itemInOneLine: CGFloat = 2
        
        let width = collectionView.frame.width - itemSpacing * (itemInOneLine - 1 )
        
        layout.minimumLineSpacing = itemSpacing
        
        return CGSize(width: width / itemInOneLine, height: (width / itemInOneLine) * 1.5)
    }
}


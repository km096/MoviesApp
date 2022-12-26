//
//  DiscoverVC.swift
//  Task 4
//
//  Created by ME-MAC on 12/21/22.
//

import UIKit
import Kingfisher


class PeopleVC: UIViewController {
    


    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageNumber: Int = 0
    var person = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        fetchData(endPoint: EndPoint.person)
        
    }
    
    func fetchData(endPoint: String) {
        
        let currentLang = Locale.current.language.languageCode!.identifier

        let page: [String: Any] = ["language": currentLang, "page": pageNumber+1]
        ApiManager.sharedInstance.fetchApiData(url: Api.baseUrl+EndPoint.person, parameters: Api.parameters.merging(page, uniquingKeysWith: { (first, _) in first }),
            responseModel: People.self) { response in

            switch response {

            case .success(let personResponse):
                guard let personResponse = personResponse?.results else {return}

                self.pageNumber += 1
                self.person.append(contentsOf: personResponse)
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @objc func tapHandle(_ sender: UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ActorVC")
                        as? ActorVC else {return}
        let index = IndexPath(item: sender.view!.tag, section: 0)
        vc.actor = person[index.item]
        print("index: \(index.item)")
        present(vc, animated: true)
    }
    
    

}

extension PeopleVC: UICollectionViewDelegate, UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCV", for: indexPath) as? PeopleCV {
            let person = person[indexPath.item]
            cell.lblName.text = person.name
            cell.imgPersonPhoto.kf.setImage(with: URL(string: Api.baseImageUrl+(person.profilePath ?? "")), options: [.cacheOriginalImage] )
            cell.imgPersonPhoto.addShadow(containerView: cell.contentView, color: UIColor.black.cgColor, shadowOpacity: 0.7, shadowRadius: 10, cornerRadius: 10)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
            cell.containerView.addGestureRecognizer(tap)
            cell.containerView.tag = indexPath.item
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        print("item: \(indexPath.item)")

        if indexPath.row == person.count - 3 {
            
//            fetchData(endPoint: EndPoint.person)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemSpacing: CGFloat = 15
        let itemInOneLine: CGFloat = 2
        
        let width = collectionView.frame.width - itemSpacing * (itemInOneLine - 1 )
        
        layout.minimumLineSpacing = itemSpacing
        
        return CGSize(width: width / itemInOneLine, height: (width / itemInOneLine) * 1.5)
    }
}

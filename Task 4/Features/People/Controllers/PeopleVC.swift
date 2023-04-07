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

        getActorsData()
        
    }
    
    func getActorsData() {
        let api: ActorsAPIProtocol = MoviesAPI()
        api.getActors(target: .getActors, pageNum: ["page": pageNumber+1]) { result in
            switch result {
                
            case .success(let response):
                guard let response = response?.results else { return }
                self.pageNumber += 1
                self.person.append(contentsOf: response)
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    //Go to selected actor detail page
    @objc func tapHandle(_ sender: UITapGestureRecognizer) {
        guard let actorVC = storyboard?.instantiateViewController(withIdentifier: "ActorVC") as? ActorVC
        else {return}
        let indexPath = IndexPath(row: sender.view!.tag, section: 0)
        actorVC.actor = person[indexPath.row]
        presestVC(actorVC)
    }
    

}


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
        ApiManager.sharedInstance.fetchApiData(url: Api.baseUrl+EndPoint.person, parameters: Api.baseParameters.merging(page, uniquingKeysWith: { (first, _) in first }),
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
    
    //Go to selected actor detail page
    @objc func tapHandle(_ sender: UITapGestureRecognizer) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ActorVC")
                        as? ActorVC else {return}
        let index = IndexPath(row: sender.view!.tag, section: 0)
        vc.actor = person[index.row]
        present(vc, animated: true)
    }
    

}


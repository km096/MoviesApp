//
//  ViewController.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit
import Alamofire
import Kingfisher
import BLTNBoard

class MoviesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var btnChangeLang: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    
    var currentMovies = MovieList()
    var popularMovies = MovieList()
    var upcomingMovies = MovieList()
    var nowPlayingMovies = MovieList()
    
    var filteredMovies = [Movies]()
    var isFiltered = false
    
    var rate: (Float, Float) = (0, 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        txtSearchField.delegate = self

        // Popular movies is first segment
        fetchData(endPoint: EndPoint.popular)
        
        segControl.addTitle(titles: ["popular".localized, "upcoming".localized, "nowPlaying".localized])
        btnChangeLang.setTitle("lang".localized, for: .normal)
        
        self.title = "movies".localized
        tableView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtSearchField.text = ""
        isFiltered = false
        tableView.reloadData()
    }
    
    func fetchData(endPoint: String){
        
        let currentLang = Locale.current.language.languageCode!.identifier
        let parameters: [String: Any] = ["language": currentLang, "page": currentMovies.pageNumber+1]

        ApiManager.sharedInstance.fetchApiData(url: Api.baseUrl+endPoint, parameters: Api.baseParameters.merging(parameters, uniquingKeysWith: {(first, _) in first}), responseModel: Response.self) { response in
            switch response {
            case .success(let moviesResponse):
                guard let movies = moviesResponse?.results else {return}

                // Increment page num and append fetched movies list to the propper segment movie list
                if endPoint == EndPoint.popular {
                    self.popularMovies.pageNumber += 1
                    self.popularMovies.movie.append(contentsOf: movies)
                } else if endPoint == EndPoint.upcoming {
                    self.upcomingMovies.pageNumber += 1
                    self.upcomingMovies.movie.append(contentsOf: movies)
                } else if endPoint == EndPoint.nowPlaying {
                    self.nowPlayingMovies.pageNumber += 1
                    self.nowPlayingMovies.movie.append(contentsOf: movies)
                }
                
                // Increment page num and append fetched movies list to the current selected segment movie list
                self.currentMovies.movie.append(contentsOf: movies)
                self.currentMovies.pageNumber += 1
                
                // Reload table to appear the new fetched movies
                self.tableView.reloadData()
                
                // Apply search text on the new fetched movies
                if !self.txtSearchField.text!.isEmpty {
                    self.filterByTitle(self.txtSearchField.text ?? "")
                }
                
                // Aply filter by rate on the new fetched movies if the user set a rate range not from 0 to 10
                if(self.rate.0 != 0 || self.rate.1 != 10){
                    self.filterByRate()
                }

            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // Navigate to detailsVC
    @objc func goToDetails (sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailsVC")
                as? DetailsVC else {return}
        if isFiltered {
            destinationVC.movie = filteredMovies[indexpath.row]
        } else {
            destinationVC.movie = currentMovies.movie[indexpath.row]
        }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func btnChangeLanguageTapped (_ sender: UIButton) {
        LocalizationManager.sharedInstance.switchLanguage(viewController: self)
    }
    
    // Load selected movie list
    func getSegmentMovies (movieList: MovieList, endPoint: String) {
        self.currentMovies.movie = movieList.movie
        self.currentMovies.pageNumber = movieList.pageNumber
        
        if movieList.pageNumber == 0 {
            fetchData(endPoint: endPoint)
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getSegmentMovies(movieList: popularMovies, endPoint: EndPoint.popular)
        case 1:
            getSegmentMovies(movieList: upcomingMovies, endPoint: EndPoint.upcoming)
        case 2:
            getSegmentMovies(movieList: nowPlayingMovies, endPoint: EndPoint.nowPlaying)
        default:
            print("error")
        }
        tableView.reloadData()
    }
    
    // Show bottom sheet with rate range slider
    @IBAction func btnFilterTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RangeSlider", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RS") as? RangeSlider
        else {return}
        vc.delegate = self
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                return context.maximumDetentValue * 0.3
            })]
        }
        self.present(vc, animated: true)
    }
    
    // To dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


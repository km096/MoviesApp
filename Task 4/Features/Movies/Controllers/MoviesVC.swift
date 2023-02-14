//
//  ViewController.swift
//  Task 4
//
//  Created by ME-MAC on 12/19/22.
//

import UIKit
import Alamofire
import Kingfisher
import MOLH

class MoviesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var moviesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var filterBtn: UIButton!
    
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
        tableView.isHidden = false
        tableView.layer.cornerRadius = 20
        tableView.registerNib(cell: MoviesCell.self)
        
        txtSearchField.delegate = self

        // Popular movies is first segment
        fetchData(endPoint: EndPoint.popular)
        
        moviesSegmentedControl.addTitle(titles: ["popular".localized, "upcoming".localized, "nowPlaying".localized])
    }
    
    func fetchData(endPoint: String) {
        let parameters: [String: Any] = ["language": LocalizationManager.sharedInstance.getCurrentLang(), "page": currentMovies.pageNumber+1]

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
                self.tableView.reloadData()
                
                // Apply search text on the new fetched movies
                if !self.txtSearchField.text!.isEmpty {
                    self.filterByTitle(self.txtSearchField.text ?? "")
                }
                
                // Apply filter by rate on the new fetched movies if the user set a rate range not from 0 to 10
                if(self.rate.0 != 0 || self.rate.1 != 10){
                    self.filterByRate()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Load selected movie list
    func segmentMovieList (movieList: MovieList, endPoint: String) {
        self.currentMovies.movie = movieList.movie
        self.currentMovies.pageNumber = movieList.pageNumber
        
        if movieList.pageNumber == 0 {
            fetchData(endPoint: endPoint)
        } else {
            tableView.reloadData()
        }
    }
    
    // Navigate to detailsVC
    @objc func goToDetails (sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        guard let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsVC")
                as? DetailsVC else {return}
        detailsVC.movie = isFiltered ? filteredMovies[indexpath.row] : currentMovies.movie[indexpath.row]
        print("btn tapped")
        presestVC(detailsVC)
    }
    
    @IBAction func changeLangBtnTapped (_ sender: UIButton) {
        LocalizationManager.sharedInstance.switchLanguage(viewController: self)
    }
        
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentMovieList(movieList: popularMovies, endPoint: EndPoint.popular)
        case 1:
            segmentMovieList(movieList: upcomingMovies, endPoint: EndPoint.upcoming)
        case 2:
            segmentMovieList(movieList: nowPlayingMovies, endPoint: EndPoint.nowPlaying)
        default:
            print("error")
        }
    }
    
    // Show bottom sheet with rate range slider
    @IBAction func filterBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RangeSlider", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RangeSlider")
                as? RangeSlider else {return}
        vc.delegate = self
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                return context.maximumDetentValue * 0.3 })]
        }
        self.present(vc, animated: true)
    }
    
}


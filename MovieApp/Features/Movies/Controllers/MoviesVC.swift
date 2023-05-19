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
import CoreData



let appDelegate = UIApplication.shared.delegate as? AppDelegate

class MoviesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var moviesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var filterBtn: UIButton!
    
    var currentMovies = MovieList()
    var popularMovies = MovieList()
    var upcomingMovies = MovieList()
    var nowPlayingMovies = MovieList()
    
    var filteredMovies = [Movie]()
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
        
        moviesSegmentedControl.addTitle(titles: ["popular".localized, "upcoming".localized, "nowPlaying".localized])
        
      getMoviesAPI()
    }
    
    func getMoviesAPI() {
        let api: MoviesAPIProtocol = MoviesAPI()
        api.getMovies(target: setEndPoint(), pageNum: ["page": currentMovies.pageNumber+1]) { result in
            switch result {
            case .success(let response):
                guard let movies = response?.results else { return }
                switch self.moviesSegmentedControl.selectedSegmentIndex {
                case 0:
                    self.updateMovieList(movie: &self.popularMovies, movies: movies)
                case 1:
                    self.updateMovieList(movie: &self.upcomingMovies, movies: movies)
                case 2:
                    self.updateMovieList(movie: &self.nowPlayingMovies, movies: movies)

                default:
                    self.updateMovieList(movie: &self.popularMovies, movies: movies)
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
                print(error.localizedDescription)
            }
        }
    }
    
    func updateMovieList(movie: inout MovieList, movies: [Movie]) {
        movie.pageNumber += 1
        movie.movie.append(contentsOf: movies)
        
    }
    
    func setEndPoint() -> Networking {
        switch moviesSegmentedControl.selectedSegmentIndex {
        case 0 :
            return .getPopularMovies
        case 1:
            return .getUpcomingMovies
        case 2:
            return .getNowPlayingMovies
        default:
            return .getPopularMovies
        }
    }
    
    // Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Load selected movie list
    func loadMovieList (movieList: MovieList) {
        self.currentMovies.movie = movieList.movie
        self.currentMovies.pageNumber = movieList.pageNumber
        
        if movieList.pageNumber == 0 {
            getMoviesAPI()
        } else {
            tableView.reloadData()
        }
    }
    
    @IBAction func changeLangBtnTapped (_ sender: Any) {
        LocalizationManager.sharedInstance.switchLanguage(viewController: self)
    }
        
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadMovieList(movieList: popularMovies)
        case 1:
            loadMovieList(movieList: upcomingMovies)
        case 2:
            loadMovieList(movieList: nowPlayingMovies)
        default:
            print("error")
        }
        print(sender.selectedSegmentIndex)
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


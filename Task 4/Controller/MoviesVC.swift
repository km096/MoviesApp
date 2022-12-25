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
    @IBOutlet weak var lblMovie2List: UILabel!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    var currentMovies = SegmentState()
    var popularMovies = SegmentState()
    var upcomingMovies = SegmentState()
    var nowPlayingMovies = SegmentState()
    
    var filteredMovies = [Movies]()
    var isFiltered = false
    
    var selectedSegTitle: String! {
        return segControl.titleForSegment(at: segControl.selectedSegmentIndex)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        txtSearchField.delegate = self
        
        fetchData(endPoint: EndPoint.popular)
        changeLblTitle(string: "popular".localized)
        segControl.addTitle(titles: ["popular".localized, "upcoming".localized, "nowPlaying".localized])
        self.navigationItem.customNavBar(btntitle: "lang".localized, title: "movies")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtSearchField.text = ""
        isFiltered = false
        tableView.reloadData()
    }
    
    
    func changeLblTitle(string: String){
        lblMovie2List.text = string
    }
    
    func filterText(_ text: String) {
        filteredMovies.removeAll()
        for movie in currentMovies.movie {
            if movie.title!.lowercased().starts(with: text.lowercased()) {
                filteredMovies.append(movie)
            }
        }
        isFiltered = true
    }
    
    func fetchData(endPoint: String){
        let currentLang = Locale.current.language.languageCode!.identifier

        let otherParameters: [String: Any] = ["language": currentLang, "page": currentMovies.pageNumber+1]

        ApiManager.sharedInstance.fetchApiData(url: Api.baseUrl+endPoint, parameters: Api.parameters.merging(otherParameters, uniquingKeysWith: {(first, _) in first}), responseModel: Response.self) { response in
            switch response {
            case .success(let moviesResponse):
                guard let movies = moviesResponse?.results else {return}

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
                self.currentMovies.movie.append(contentsOf: movies)
                self.currentMovies.pageNumber += 1
                self.tableView.reloadData()
                if !self.txtSearchField.text!.isEmpty {
                    self.filterText(self.txtSearchField.text ?? "")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    @objc func goToDetails (sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailsVC")
                as? DetailsVC else {return}
        if isFiltered {
            destinationVC.movie = filteredMovies[indexpath.row]
        } else {
            destinationVC.movie = currentMovies.movie[indexpath.row]
        }
        destinationVC.title = "movies".localized
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func getSegmentMovies (movieState: SegmentState, endPoint: String) {
        self.currentMovies.movie = movieState.movie
        self.currentMovies.pageNumber = movieState.pageNumber
        
        if movieState.pageNumber == 0 {
            fetchData(endPoint: endPoint)
        }
    }
    
    @IBAction func segChanged(_ sender: UISegmentedControl) {
        changeLblTitle(string: selectedSegTitle)
        switch sender.selectedSegmentIndex {
        case 0:
            getSegmentMovies(movieState: popularMovies, endPoint: EndPoint.popular)
        case 1:
            getSegmentMovies(movieState: upcomingMovies, endPoint: EndPoint.upcoming)
        case 2:
            getSegmentMovies(movieState: nowPlayingMovies, endPoint: EndPoint.nowPlaying)
        default:
            print("error")
        }
        tableView.reloadData()
    }
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? filteredMovies.count : currentMovies.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTVC", for: indexPath) as? MoviesTVC {
            cell.btnGoToDetails.tag = indexPath.row
            cell.btnGoToDetails.addTarget(self, action: #selector(goToDetails), for: .touchUpInside)
            
            if isFiltered {
                let filtered = filteredMovies[indexPath.row]
                cell.setupCell (
                    title: filtered.title, releaseDate: filtered.releaseDate, overview: filtered.overview,
                    rate: (filtered.voteAverage ?? 0) * 10, voteAverage: filtered.voteAverage,
                    imageUrl: URL(string: Api.baseImageUrl+(filtered.posterPath ?? ""))
                )
            } else {
                let movies = currentMovies.movie[indexPath.row]
                cell.setupCell (
                    title: movies.title, releaseDate: movies.releaseDate, overview: movies.overview,
                    rate: (movies.voteAverage ?? 0) * 10, voteAverage: movies.voteAverage,
                    imageUrl: URL(string: Api.baseImageUrl+(movies.posterPath ?? ""))
                )
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == currentMovies.movie.count - 3 {
            fetchData(endPoint: EndPoint.popular)
        }
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if string.count == 0 {
                isFiltered = false
            } else {
                filterText(text+string)
            }
        }
        tableView.reloadData()
        return true
    }
}

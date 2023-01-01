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
    
    var currentMovies = SegmentMovieList()
    var popularMovies = SegmentMovieList()
    var upcomingMovies = SegmentMovieList()
    var nowPlayingMovies = SegmentMovieList()
    
    var filteredMovies = [Movies]()
    var isFiltered = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        txtSearchField.delegate = self

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
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func btnChangeLanguage (_ sender: UIButton) {
        LocalizationManager.sharedInstance.switchLanguage(viewController: self)
    }
    func getSegmentMovies (movieList: SegmentMovieList, endPoint: String) {
        self.currentMovies.movie = movieList.movie
        self.currentMovies.pageNumber = movieList.pageNumber
        
        if movieList.pageNumber == 0 {
            fetchData(endPoint: endPoint)
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
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
    
    @IBAction func didTapFilter(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RangeSlider", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RS") as? RangeSlider
        else {return}
        vc.delegate = self
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(vc, animated: true)
    }
    
    func filterText(_ text: String){
        filteredMovies.removeAll()
        let movie = currentMovies.movie.filter({
            return $0.title!.lowercased().hasPrefix(text.lowercased()) })
        filteredMovies.append(contentsOf: movie)
        isFiltered = true
    }
    
}

extension MoviesVC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, RateValueDelegate {
    
    func rateValueDidChange(minValue: Float, maxValue: Float) {
        print("min: \(minValue), max: \(maxValue)")
        let m = currentMovies.movie.filter({return Float($0.voteAverage!) >= minValue && Float($0.voteAverage!) <= maxValue})
        filteredMovies.removeAll()
        filteredMovies.append(contentsOf: m)
        isFiltered = true
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
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

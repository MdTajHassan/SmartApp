//
//  ApiCallViewModel.swift
//  SmartApp
//
//  Created by taj hassan on 10/03/22.
//
import Alamofire

class ApiCallViewModel {
    
    static let sharedInstance = ApiCallViewModel()
    var resultArray: [Result] = []
    var filteredResultsArray: [Result] = []
    
    init() { }
    
    var refreshCLV: (() -> Void)? = nil
    
    func getMovieData() {
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        AF.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (responseData) in
            guard let jsonData = responseData.data else { return }
            
            do {
                let movieData = try JSONDecoder().decode(MovieModel.self, from: jsonData)
                self.resultArray = movieData.results
                self.filteredResultsArray = self.resultArray
                self.refreshCLV?()
            }
            catch {
                print("getDataList Unexpected error: \(error.localizedDescription).")
            }
        }
    }
}

//
//  ViewController.swift
//  SmartApp
//
//  Created by taj hassan on 10/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    let modelViewObj = ApiCallViewModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieCollectionView.register(UINib(nibName: "UnPopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UnPopularCollectionViewCell")
        self.movieCollectionView.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularCollectionViewCell")
        
        //calling API
        modelViewObj.getMovieData()
        
        //reloading CollectionView
        modelViewObj.refreshCLV = { [weak self] in
            self?.movieCollectionView.reloadData()
        }
    }
    //For searching text
    @IBAction func onClickSearchText(_ sender: UITextField) {
        if let text = sender.text, text.count > 0 {
            self.modelViewObj.filteredResultsArray = self.modelViewObj.resultArray.filter({ $0.title.lowercased().contains(text.lowercased()) })
        } else {
            self.modelViewObj.filteredResultsArray = self.modelViewObj.resultArray
        }
        self.movieCollectionView.reloadData()
    }
}


// MARK: - CollectionView Delegate
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelViewObj.filteredResultsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellUnpopular = collectionView.dequeueReusableCell(withReuseIdentifier: "UnPopularCollectionViewCell", for: indexPath) as! UnPopularCollectionViewCell
        cellUnpopular.delegate = self
        let cellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
        cellPopular.delegate = self
        let resultData = modelViewObj.filteredResultsArray[indexPath.row]
        if resultData.voteAverage < 7 {
            cellUnpopular.cellPreparationForUnpopularMovie(data: resultData)
            return cellUnpopular
        } else {
            cellPopular.cellPreparationForPopularMovie(data: resultData)
            return cellPopular
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        VC.posterPath = modelViewObj.filteredResultsArray[indexPath.row].posterPath
        navigationController?.pushViewController(VC, animated: true)
    }
}

// MARK: - Cell Delete Delegate
extension ViewController:DeleteUnPopularCellDelegate,DeletePopularCellDelegate {
    func deleteUnPopular(cell: UnPopularCollectionViewCell) {
        if let indexPath = movieCollectionView.indexPath(for: cell) {
            modelViewObj.filteredResultsArray.remove(at: indexPath.item)
            movieCollectionView.deleteItems(at: [indexPath])
        }
    }
    
    func deletePopular(cell: PopularCollectionViewCell) {
        if let indexPath = movieCollectionView.indexPath(for: cell) {
            modelViewObj.filteredResultsArray.remove(at: indexPath.item)
            movieCollectionView.deleteItems(at: [indexPath])
        }
    }
}

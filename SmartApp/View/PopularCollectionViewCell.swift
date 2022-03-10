//
//  PopularCollectionViewCell.swift
//  SmartApp
//
//  Created by taj hassan on 10/03/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePopular: UIImageView!
    @IBOutlet weak var BtnDeletePop: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellPreparationForPopularMovie(data:Result) {
        let imageUrl = "https://image.tmdb.org/t/p/w342" + data.posterPath
        guard let url = URL(string: imageUrl) else {return}
        imagePopular.downloadImage(url: url)
    }

}

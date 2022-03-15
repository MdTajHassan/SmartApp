//
//  UnPopularCollectionViewCell.swift
//  SmartApp
//
//  Created by taj hassan on 10/03/22.
//

import UIKit

protocol DeleteUnPopularCellDelegate {
func deleteUnPopular(cell:UnPopularCollectionViewCell)
}

class UnPopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageUnpopular: UIImageView!
    @IBOutlet weak var lblUnpopularTitle: UILabel!
    @IBOutlet weak var lblUnpopularOverview: UILabel!
    @IBOutlet weak var BtnDelete: UIButton!
    
    var delegate: DeleteUnPopularCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellPreparationForUnpopularMovie(data:Result) {
        let imageUrl = "https://image.tmdb.org/t/p/w342" + data.posterPath
        guard let url = URL(string: imageUrl) else {return}
        lblUnpopularTitle.text = data.title
        lblUnpopularOverview.text = data.overview
        imageUnpopular.downloadImage(url: url)
    }
    @IBAction func onClickDeleteUnpopular(_ sender: Any) {
        delegate?.deleteUnPopular(cell: self)
    }
}

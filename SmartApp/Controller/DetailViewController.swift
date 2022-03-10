//
//  DetailViewController.swift
//  SmartApp
//
//  Created by taj hassan on 10/03/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var DetailImageView: UIImageView!
    var posterPath:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageUrl = "https://image.tmdb.org/t/p/w342" + posterPath
        guard let url = URL(string: imageUrl) else {return}
        DetailImageView.downloadImage(url: url)
    }
}

//
//  DownloadImage.swift
//  SmartApp
//
//  Created by taj hassan on 10/03/22.
//

import UIKit

extension UIImageView {
    
    func downloadImage(url:URL) {
        var task:URLSessionDataTask!
        let imageCache = NSCache<AnyObject,AnyObject>()
        image = nil
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data, let image = UIImage(data: data) else {
                print("not able to load image from url: \(url)")
                return
            }
            imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}


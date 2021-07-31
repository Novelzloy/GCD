//
//  SecondViewController.swift
//  GCD
//
//  Created by Роман on 31.07.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicater: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage {
        get {
                return imageView.image!
        }
        set {
            activityIndicater.startAnimating()
            activityIndicater.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    
    fileprivate func fetchImage() {
        
        imageURL = URL(string: "https://tsdbklimovo.ru/wp-content/uploads/2020/06/ookean2.jpg")
        activityIndicater.isHidden = false
        activityIndicater.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)!
            }
            
        }
        
    }
}

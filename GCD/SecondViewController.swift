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
        delay(3) {
            self.loginAlert()
        }
        
    }
    
    fileprivate func delay (_ delay: Int, clouser: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            clouser( )
        }
    }
    
    fileprivate func loginAlert() {
        let alert = UIAlertController(title: "Зарегистрованны?", message: " Введите ваш логин и пароль ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let canceAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(canceAction)
        
        alert.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        
        alert.addTextField { (userpassTF) in
            userpassTF.placeholder = "Введите пароль"
            userpassTF.isSecureTextEntry = true
        }
        
        self.present(alert, animated: true, completion: nil)
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

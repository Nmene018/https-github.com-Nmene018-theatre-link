//
//  HomeViewController.swift
//  TheatreLink
//
//  Created by Umar Khalid on 11/30/20.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    let genreImages: [UIImage] = []
    
    var genres = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(GenreCollectionViewCell.nib(), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        else {
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.genres = dataDictionary["genres"] as! [[String:Any]]
                self.collectionView.reloadData()
           }
        }
        task.resume()
    }
    
    //4. From tap, I need to go to next screen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Item pressed")
        
        /***/
        
//        let genre = genres[indexPath.item]
//        let genreID = genre["id"] as! Int
//        print("Image was tapped")
//
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
//        controller.genreID = genreID
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        
        let genre = genres[indexPath.item]
        let genreID = genre["id"] as! Int
        
        cell.imageView.image = imageForGenreID(id: genreID)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func imageForGenreID(id : Int) -> UIImage? {
    
        let imagesById = [
            28:UIImage(named: "action_image"),
            12:UIImage(named: "adventure_image"),
            16:UIImage(named: "animation_image"),
            35:UIImage(named: "comedy_image"),
            80:UIImage(named: "crime_image"),
            //99:"name":"Documentary"
            18 : UIImage(named: "drama_image"),
            10751 : UIImage(named: "family_image"),
            14:UIImage(named: "fantasy_image"),
            36:UIImage(named: "history_image"),
            27:UIImage(named: "horror_image"),
            10402:UIImage(named: "musical_image"),
            9648:UIImage(named: "mystery_image"),
            10749:UIImage(named: "romance_image"),
            878:UIImage(named: "scifi_image"),
            //10770:"name":"TV Movie"
            53:UIImage(named: "thriller_image"),
            10752:UIImage(named: "war_image"),
            37:UIImage(named: "western_image")
        ]
        
        return imagesById[id] ?? nil
        
    }

}

/*DELETE BELOW IMAGES FROM ASSETS**/
//UIImage(named: "biography_image")!,
//UIImage(named: "detective_image")!,
//sport_image

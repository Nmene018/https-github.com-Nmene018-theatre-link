//
//  SwipingViewController.swift
//  TheatreLink
//
//  Created by Natalie Meneses on 12/2/20.
//
import Parse
import AlamofireImage
import UIKit

class SwipingViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    var movies = [[String: Any]]()
    var genreID : Int!
    
    var currentMovieIndex = 0
    var currentCard : CardView?
    var posterView : UIImageView?
    var nextCard: CardView?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newCard = CardView()
        newCard.frame.size = CGSize(width:view.bounds.width * 0.8, height:view.bounds.height * 0.5)
        newCard.center = view.center
        newCard.delegate = self
        view.addSubview(newCard)
        currentCard = newCard
      
        
        let api = "https://api.themoviedb.org/3/discover/movie"
      
        let endpoint = "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genreID!)"
        let url = URL(string: api + endpoint)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
         
            print(dataDictionary)
            self.movies = dataDictionary["results"] as! [[String:Any]]
            guard let firstMovie = self.movies.first else {
                return
            }
            let posterPath = firstMovie["poster_path"] as! String
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"){
                self.currentCard?.posterView.af.setImage(withURL: imageURL)
           }
            let newMovie = self.movies[self.currentMovieIndex]
            let title =  newMovie["title"] as! String
            let synopsis = newMovie["overview"] as! String
            self.titleLabel.text = title
            self.synopsisLabel.text = synopsis
           }
        }
        task.resume()
       
    }
  
    
    @IBAction func genresBarButton(_ sender: Any) {
    }
    
    
    func didSwipeCardOffScreen(didLike: Bool, animated: Bool){
        let swipe = PFObject(className: "SwipeDirection")
        let currentMovie = movies[currentMovieIndex]
        let movieID = currentMovie["id"] as! Int
    
        
        swipe["User"] = PFUser.current()!
        swipe["MovieID"] = movieID
        
        if didLike
        {
            swipe["Swipe"] = "right"
        }
        else{
            swipe["Swipe"] = "left"
        }
        
        swipe.saveInBackground{ (success, error) in
            if success{
                print("saved!")
            } else {
                print("error!")
            }
        }
        
        currentMovieIndex += 1
        var imageURL: URL?
        if currentMovieIndex < movies.count{
            let newMovie = movies[currentMovieIndex]
            let posterPath = newMovie["poster_path"] as! String
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"){
                imageURL = url
            }
        }
        
        if animated{
            UIView.animate(withDuration: 0.5) {
             if didLike{
                self.currentCard?.center.x = self.view.bounds.maxX + (self.currentCard?.bounds.width ?? 0)
             }
             else{
                self.currentCard?.center.x = self.view.bounds.minX - (self.currentCard?.bounds.width ?? 0)
             }
            } completion: { (_) in
               self.currentCard?.center = self.view.center
               guard let url = imageURL else {
                    print("Out of Movies!")
                self.currentCard?.posterView.image = nil
                    return
                }
               self.currentCard?.posterView.af.setImage(withURL: url)
                let newMovie = self.movies[self.currentMovieIndex]
                let title =  newMovie["title"] as! String
                let synopsis = newMovie["overview"] as! String
                self.titleLabel.text = title
                self.synopsisLabel.text = synopsis
            }
        }
        else{
            self.currentCard?.center = self.view.center
            guard let url = imageURL else {
                print("Out of Movies!")
                currentCard?.posterView.image = nil
                titleLabel.text = "Out of Movies"
                synopsisLabel.text = nil
                return
            }
            self.currentCard?.posterView.af.setImage(withURL: url)
            let newMovie = self.movies[self.currentMovieIndex]
            let title =  newMovie["title"] as! String
            let synopsis = newMovie["overview"] as! String
            self.titleLabel.text = title
            self.synopsisLabel.text = synopsis
        }
        
    }
    
    func createAndAddCard(){
        let cardView = CardView()
        view.addSubview(cardView)
    }

    @IBAction func likeButtonTapped(_ sender: Any) {
        didSwipeCardOffScreen(didLike: true, animated: true)
    }
    
    @IBAction func dislikeButtonTapped(_ sender: Any) {
        didSwipeCardOffScreen(didLike: false, animated: true)
    }
}


extension SwipingViewController: CardViewDelegate {
    func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
       
        if sender.state == UIGestureRecognizer.State.ended
        {
          
            if card.center.x < self.view.center.x - 40
            {
                self.didSwipeCardOffScreen(didLike: false, animated: false)
            }
            else if card.center.x > self.view.center.x + 40
            {
                self.didSwipeCardOffScreen(didLike: true, animated: false)
            }
            else
            {
                card.center = self.view.center
            }
            UIView.animate(withDuration: 0.2, animations:{self.currentCard?.center = self.view.center})
        }
    }

}



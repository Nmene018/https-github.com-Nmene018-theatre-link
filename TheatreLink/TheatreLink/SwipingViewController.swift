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
    
    var movies = [[String: Any]]()
    var genreID = 28
    
    var currentMovieIndex = 0
    var currentCard : CardView?
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
        let endpoint = "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genreID)"
        let url = URL(string: api + endpoint)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            //self.movies = dataDictionary[""] as! [[String: Any]]
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            print(dataDictionary)
           // self.movies = dataDictionary["belongs_to_collection"] as! [[String:Any]]
            self.movies = dataDictionary["results"] as! [[String:Any]]
            guard let firstMovie = self.movies.first else {
                return
            }
            let posterPath = firstMovie["poster_path"] as! String
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"){
                self.currentCard?.posterView.af_setImage(withURL: imageURL)
            }
       //     if let movieID = URL(string: <#T##String#>)
            
           }
            
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    func didSwipeCardOffScreen(didLike: Bool){
        //handles moving front card to back
        //sends swipe to Parse
        //  view.removeFromSuperview()
       
        let swipe = PFObject(className: "SwipeDirection")
      //let movieIDTable = PFObject(className: "MovieID")
      //  let movieID = movie["id"] as! String
        
      //  let title = movie ["title"] as! String
      //  let synopsis = movie["overview"] as! String
    
      //  cell.titleLabel.text=title
    // cell.synopsisLabel.text=synopsis
        
        swipe["User"]=PFUser.current()!
        
        swipe.saveInBackground{ (success, error) in
        if success{
             print("saved!")
        } else {
            print("error!")
        }
        }
        if didLike{
            swipe["Swipe"] = "right"
        }
       // else{
       //    swipe["Swipe"] = "left"
       // }
       // currentCard?.center = self.view.center
        currentMovieIndex += 1
        let newMovie = movies[currentMovieIndex]
        guard currentMovieIndex < movies.count else {
            print("Out of Movies!")
            return
        }
        let posterPath = newMovie["poster_path"] as! String
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"){
            self.currentCard?.posterView.af_setImage(withURL: imageURL)
        }
    //    addBackgroundCardIfNeeded()
        
    }
    func createAndAddCard(){
        let cardView = CardView()
        view.addSubview(cardView)
    }
    
    func addBackgroundCardIfNeeded(){
        // check if more movies available
        //   if available add new card
        //set image on new card
        
    }
   /*
    @IBAction func panOtherCards(_ sender: UIPanGestureRecognizer) {
        let otherCard = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = otherCard.center.x - view.center.x
        
        otherCard.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xFromCenter>0{
            
        }else{
            
        }
        
        
        if sender.state == UIGestureRecognizer.State.ended
        {
            //moves off to left of screen
           
            if otherCard.center.x<75{
                UIView.animate(withDuration: 0.3, animations: {
                    otherCard.center = CGPoint(x: otherCard.center.x - 200, y: otherCard.center.y+75)
                    otherCard.alpha = 1
                    
                } )
                return
            }else if otherCard.center.x>(view.frame.width - 75){
                //move off to right side of screen
                UIView.animate(withDuration: 0.3, animations: {
                              otherCard.center = CGPoint(x: otherCard.center.x + 200, y: otherCard.center.y+75)
                    otherCard.alpha=1
                   
                    
                })
                return
            }
        UIView.animate(withDuration: 0.2, animations:{ otherCard.center = self.view.center})
        }
 
    } */
}


extension SwipingViewController: CardViewDelegate {
    func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
       
        if sender.state == UIGestureRecognizer.State.ended
        {
            //moves off to left of screen
          
            if card.center.x<40
            {
                self.didSwipeCardOffScreen(didLike: true)
            }
            else if card.center.x>self.view.frame.width - 40
            {
                self.didSwipeCardOffScreen(didLike: false)
            }
            
            
            
            
            
          /*  if card.center.x<75{
                UIView.animate(withDuration: 0.3, animations: {
                   // card.center = CGPoint(x: card.center.x - 200, y: card.center.y+75)
                //card.alpha = 1
                    
                    if card.center.x<40
                    {
                        self.didSwipeCardOffScreen(didLike: true)
                    }
                    
                } )
               

            }else if card.center.x>(view.frame.width - 75){
                //move off to right side of screen
                UIView.animate(withDuration: 0.3, animations: {
                    //card.center = CGPoint(x: card.center.x + 200, y: card.center.y+75)
                    //card.alpha = 1
                  
                    if card.center.x>self.view.frame.width - 40
                    {
                        self.didSwipeCardOffScreen(didLike: false)
                    }
                    
                })
            }
 */
            UIView.animate(withDuration: 0.2, animations:{self.currentCard?.center = self.view.center})
        }
    }

}



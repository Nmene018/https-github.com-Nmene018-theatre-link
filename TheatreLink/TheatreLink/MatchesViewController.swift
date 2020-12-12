//
//  MatchesViewController.swift
//  TheatreLink
//
//  Created by Kauther Zeini on 12/7/20.
//

import UIKit
import Parse
import AlamofireImage

struct Match {
    let username: String
    let movieID: Int
    var movie = [String:Any]()
}


class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var movieMatches = [Match]()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMatches()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getMatches()
    }
    
    
    func getMovieDetails(movieID: Int, completion: @escaping ([String:Any]) -> Void ){
        
        // https://api.themoviedb.org/3/movie/577922?api_key=<<api_key>>&language=en-US
        
        let api = "https://api.themoviedb.org/3/movie/"
        
        let endpoint = "\(movieID)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let url = URL(string: api + endpoint)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                completion(dataDictionary)
                
            }
        }
        task.resume()
        
    }
    
    func getMatches(){
        
        var matches = [Match]()
        let currentUserRightSwipesQuery = PFQuery(className: "SwipeDirection")
        currentUserRightSwipesQuery.whereKey("User", equalTo: PFUser.current()!)
        currentUserRightSwipesQuery.whereKey("Swipe", equalTo:"right")
        currentUserRightSwipesQuery.findObjectsInBackground { (userLikedMovieIDs: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let userLikedMovieIDs = userLikedMovieIDs {
                let otherUsersRightSwipesQuery = PFQuery(className: "SwipeDirection")
                otherUsersRightSwipesQuery.whereKey("User", notEqualTo: PFUser.current()!)
                otherUsersRightSwipesQuery.whereKey("Swipe", equalTo:"right")
                otherUsersRightSwipesQuery.includeKey("User")
                otherUsersRightSwipesQuery.findObjectsInBackground { (otherLikedMovieIDs: [PFObject]?, error: Error?) in
                    for userLikedMovieID in userLikedMovieIDs {
                        let movieIDobj1 = userLikedMovieID["MovieID"] as! Int
                        for otherLikedMovieID in otherLikedMovieIDs! {
                            let movieIDobj2 = otherLikedMovieID["MovieID"] as! Int
                            if (movieIDobj1 == movieIDobj2){
                                guard let username = (otherLikedMovieID["User"] as! PFUser).username else {
                                    continue
                                }
                                let match = Match(username: username, movieID: movieIDobj2)
                              //  let matchingMovieIds = matches.map {
                                //    $0.movieID
                                //}
                               // if UserDefaults.standard.object(forKey: "\(movieIDobj2)") == nil
                              //  {
                                    matches.append(match)
                               // }
                            }
                        }
                    }
                    var finalMatches = [Match]()
                    
                    let group = DispatchGroup()
                    
                    for match in matches {
                        group.enter()
                        DispatchQueue.global(qos: .default).async {
                            self.getMovieDetails(movieID: match.movieID, completion: { (movieObject) in
                                let finalMatch = Match(username: match.username, movieID: match.movieID, movie: movieObject)
                                finalMatches.append(finalMatch)
                                group.leave()
                            })
                        }
                        
                    }
                    
                    group.notify(queue: .main) {
                        self.movieMatches = finalMatches.sorted{
                            $0.movieID < $1.movieID
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesCell") as! MatchesCell
        let match = movieMatches[indexPath.row]
        cell.usernameLabel?.text = match.username
        cell.movieNameLabel?.text = match.movie["original_title"] as! String
        
        return cell
    }
    
    
    
}

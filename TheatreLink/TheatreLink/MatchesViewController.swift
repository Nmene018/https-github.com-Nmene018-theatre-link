//
//  MatchesViewController.swift
//  TheatreLink
//
//  Created by Kauther Zeini on 12/7/20.
//

import UIKit
import Parse
import AlamofireImage

class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var matches = [[String:Any]]() {
        didSet {
            tableView.reloadData() //whenever matches is set, reloads data and table view updates
        }
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        1. list of all the movies you've swight right on
        To do this: query SwipeDirection table for all that have user == yourUserId and swipe == right
       
        let currentUserRightSwipesQuery = PFQuery(className: "SwipeDirection")
        currentUserRightSwipesQuery.whereKey("User", equalTo: PFUser.current()!)
        currentUserRightSwipesQuery.whereKey("Swipe", equalTo:"right")
        currentUserRightSwipesQuery.findObjectsInBackground { (objects : [PFObject]?, error:Error?) in
          if let error = error {
            print(error.localizedDescription)
          } else {
            print("\(objects?.count) objects found" )
            
          }
        }
         */
        
        /*
        2. find all swipe rights that aren't yours
        to do this: query SwipeDirection table for all where user != yourUserId and swipe == right
       
        let otherUsersRightSwipesQuery = PFQuery(className: "SwipeDirection")
        otherUsersRightSwipesQuery.whereKey("User", notEqualTo: PFUser.current()!)
        otherUsersRightSwipesQuery.whereKey("Swipe", equalTo:"right")
        otherUsersRightSwipesQuery.findObjectsInBackground { (objects : [PFObject]?, error:Error?) in
          if let error = error {
            print(error.localizedDescription)
          } else {
            print("\(objects?.count) objects found" )
            
          }
        }
         */
        
        var matchingMovieIds = [Int]()
        /*
        1. list of all the movies you've swight right on
        To do this: query SwipeDirection table for all that have user == yourUserId and swipe == right
        */
        let currentUserRightSwipesQuery = PFQuery(className: "SwipeDirection")
        currentUserRightSwipesQuery.whereKey("User", equalTo: PFUser.current()!)
        currentUserRightSwipesQuery.whereKey("Swipe", equalTo:"right")
        currentUserRightSwipesQuery.findObjectsInBackground { (userLikedMovieIDs: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let userLikedMovieIDs = userLikedMovieIDs {
                /*
                2. find all swipe rights that aren't yours
                to do this: query SwipeDirection table for all where user != yourUserId and swipe == right
                */
                let otherUsersRightSwipesQuery = PFQuery(className: "SwipeDirection")
                otherUsersRightSwipesQuery.whereKey("User", notEqualTo: PFUser.current()!)
                otherUsersRightSwipesQuery.whereKey("Swipe", equalTo:"right")
                otherUsersRightSwipesQuery.findObjectsInBackground { (otherLikedMovieIDs: [PFObject]?, error: Error?) in
                    /*
                    3. compare the two results for matching movie ids
                    Add each match to a new list --nested for loop- outside list 1, inside list 2
                    */
                     for userLikedMovieID in userLikedMovieIDs {
                          // get movie id from object1 -- MovieID column in Parse
                        let movieIDobj1 = userLikedMovieID["MovieID"] as! Int
                        
                          for otherLikedMovieID in otherLikedMovieIDs! {
                             // if movie id from object2 matches movie id from object 1, then append it to matchingMovieIds
                            let movieIDobj2 = otherLikedMovieID["MovieID"] as! Int
                            
                            if ( movieIDobj1 == movieIDobj2){
                                matchingMovieIds.append(movieIDobj2)
                            }
                          }
                     }
                }
            }
        }
            
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesCell") as! MatchesCell
        
        //let match = matches[indexPath.row]
        
        //cell.usernameLabel?.text
        //cell.movieNameLabel?.text=
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

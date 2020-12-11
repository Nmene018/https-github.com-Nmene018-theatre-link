//
//  ProfileViewController.swift
//  TheatreLink
//
//  Created by Natalie Meneses on 12/10/20.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var changeProfile = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Profile")
        query.includeKey("description")
        query.limit = 1
        query.findObjectsInBackground { (results, error) in
            if (results != nil)
            {
                self.changeProfile = results!
                self.tableView.reloadData()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return changeProfile.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
        let profile = changeProfile[indexPath.row]
        let user = PFUser.current()!
        cell.usernameLabel.text = user.username
        cell.descriptionLabel.text=profile["description"] as! String
   //     let imageFile = profile["image"] as! PFFileObject
    //    let urlString = imageFile.url!
     //   let url = URL(string: urlString)!
        
     //   cell.photoView.af_setImage(withURL: url)
        return cell
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        guard let windowScence = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScence.delegate as? SceneDelegate
        else{
            return
        }
        
        delegate.window?.rootViewController = loginViewController
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

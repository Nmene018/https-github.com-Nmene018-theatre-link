# TheatreLink
This is a mobile iOS app that will be utilizing the Movie Databases API to allow one to match their user account to an assortment of movies. This way the target audience of the app can connect with other users who wish to watch the same movie, either in person or online. 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This is an app that showcases the current movies playing organized by their genres to allow users to find matches on what to watch with other users.

### App Evaluation
- **Category:** Social/Entertainment 
- **Mobile:** As of right now, this app will primarily be used and desgined for iOS mobile phones. 
- **Story:** Analyzes what genres of movies a user is interested in and matches them with others users who have the same movie interests. It allows the user to reach out to their matches if they choose to.
- **Market:** This app can be used by anyone, but the target audience are those from ages 13-25. The possible implementation of a kids vs. adults movie selections could make the app more safe and age-friendly. 
- **Habit:** This app can be used whenever the user wants, depending on if they want to watch a movie/s with some company.
- **Scope:** First we want to match people based on what types of movies they are interested in. This could possibly evolve into users actually watching the movies with their matches, while possibly implementing the choice of streaming vs. in theater. This has potential use with the AMC Theater application.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User has to be able to create an account and log back in with all their previous information (favorites, matches) saved.
- [x] User must see the home screen that organizes all the movies by genre
- [ ] User has to be able to click on a movie genre and swipe yes or no on all the movies within the specified genre
- [ ] User must be able to see all the matches they have matched with other users for when it comes to any of the movies they swipped right to
- [ ] Profile page for each user
- [ ] User must be able to see all the movies that swiped right to on their profile page

**Optional Nice-to-have Stories**
* Streaming vs. In Theater Choice of Available Movies
* Adults vs Kids 
* Chat Feature


### 2. Screen Archetypes

* Launch Screen: 
  * Logo and Name 
* Login Screen: 
  * Allows for creation and login of accounts
* Home Screen: 
  * Current Movies Organized By Genre
* Swiping Screen: 
  * After clicking on a genre within the Home Screen, this screen will allow a user to swipe yes/no to all the movie options within that specified genre. The screen will provide the title of the movie and the movie poster.
* Profile Screen: 
  * Your profile information along with a list of all the movies the user has favorited.
* Matches Screen: 
  * This screen will show a list of all matches a user has with other people for any movies that they have favorited/swipped right to.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Tab
* Profile Tab
* Matches Tab

**Flow Navigation** (Screen to Screen)

* Launch Screen
* Login Screen
   * Home Screen
     * Swiping Screen
* Matches Screen
* Profile Screen

## Wireframes
<img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/launchScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/loginScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/homeScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/swippingScreen.png" width=100>  <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/matchesScreen.png" width=100>  <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/profileScreen.png" width=100>


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]

### Models
 | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | username      | Pointer to User    | Login screen username |
   | password      | Pointer to password| Login screen password |
   | profileName   | String             | Name of user.         |
   | profileImage  | file.              | Image that user posts |
   | commentsCount | Number             | number of comments that has been posted to an image |
   | swipe         | Boolean            | Movie approval/disapproval  |

### Networking
Login Screen
Home Feed Screen
(Read/GET) Create Genres Screen
- (Read/GET) Query all posts where user is author
```swift
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-U")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            self.movies = dataDictionary["results"] as! [[String:Any]]
            print(dataDictionary)
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
 
           }
        }
```
(Create/POST) Create a new object
Profile Screen
(Read/GET) Query logged in user object
(Update/PUT) Update user profile image
Swiping Screen 
(Read/GET) Create Swiping Screen 
(Create/POST) Create a new object 
Matches Screen 

Network Requests for The Movie Database API:

- [OPTIONAL: List endpoints if using existing API such as Yelp]
Base URL: https://developers.themoviedb.org/3/genres/get-movie-list
HTTP Verb | Endpoint | Description
   ----------|-------------------|------------
    `GET`    | /genre/movie/list | Get all movie genres
    `GET`    | /movie/{movie_id} | Get all movies


## Video Walkthrough Unit 10

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/HRIs26BANe.gif' width='' alt='Video Walkthrough Unit 10' />

## Video Walkthrough Unit 11

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/VGafz7y6bF.gif' width='' alt='Video Walkthrough Unit 11' />




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

* User has to be able to create an account and log back in with all their previous information (favorites, matches) saved.
* User has to be able to click on a movie genre and swipe yes or no on all the movies within the specified genre
* User must be able to see all the movies that swipped right to in their favorites
* User must be able to see all the profiles of the users that they have matched with for each of the movies they have in their favorites
* Profile page for each user 

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
  * Your profile information 
* Favorites Screen: 
  * Lists the movies that the user has swiped yes to  
* Matches Screen: 
  * After clicking on a movie on the Favorites Screen, this screen will show a list of all the profiles of the people you have matched with for the specified movie.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Tab
* Profile Tab
* Favorites Tab

**Flow Navigation** (Screen to Screen)

* Launch Screen
* Login Screen
   * Home Screen
     * Swiping Screen
* Favorites Screen
   * Matches Screen
* Profile Screen

## Wireframes
<img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/launchScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/loginScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/homeScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/swippingScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/favoritesScreen.png" width=100>   <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/matchesScreen.png" width=100>  <img src="https://github.com/https-github-com-TheatreLink/TheatreLink/blob/main/wireframes/profileScreen.png" width=100>






### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]

### Models
[Add table of models]

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]

- [OPTIONAL: List endpoints if using existing API such as Yelp]

# Movie        [![wakatime](https://wakatime.com/badge/github/siuzanna/Movie.svg)](https://wakatime.com/badge/github/siuzanna/Movie)

App shows you collections of TV streaming and other movies. Movie app written in Swift & UIKit using the [Custom API](https://www.mocky.io/v3/3feccf06-6bc1-480d-97af-bbc05d785f86) created on the Mocky website. App built using the MVVM architecture and 100% programmatic UI (No Storyboard).

### Screen Shots
![Group1X](https://user-images.githubusercontent.com/64474454/146820234-84c70414-719a-4471-9513-8cc813a14bbe.png)
---

### Table of Contents

- [Description](#description)
- [Dependencies](#dependencies)
- [Resources](#resources)
- [How To Use](#how-to-use)
- [Author Info](#author-info)

---

## Description

- [X] App shows you collections of TV streaming and other movies. 
- [X] Layout created using a UICollectionviewCompositionalLayout.
- [X] Project was completed using 100% programmatic UI (No Storyboard).
- [X] App built using the MVVM architecture.
- [X] This app includes descriptions for each movie as well as trailers and the movie’s rating.
- [X] Movie also contains movies that are from paid apps such as Netflix.
- [X] User can view movie details by tapping on a cell.
- [x] All images are cached uising SDWebImage cocoapod.
- [X] Movie details page contain backdrop and poster image, overview, duration and other relevant information.
- [X] User can view trailer of a particular movie in the youtube app or a web browser.
- [X] It also features the best movies that refresh weekly so you can choose and watch the latest movies that have the best ratings.

### Todo

- [ ] Refresh API data - trailer ulr, description, comments, rating for each movie.

## Dependencies
|#|Library|Description|
|-|-|-|
|1|[SwiftLint](https://github.com/realm/SwiftLint)|A tool to enforce Swift style and conventions. SwiftLint enforces the style guide rules that are generally accepted by the Swift community.|
|2|[SwiftGen](https://github.com/SwiftGen/SwiftGen)|SwiftGen is a tool to automatically generate Swift code for resources of your projects (like images, localised strings, etc), to make them type-safe to use.|
|3|[SDWebImage](https://github.com/SDWebImage/SDWebImage)|This library provides an async image downloader with cache support.|
|4|[SnapKit](https://github.com/SnapKit/SnapKit)|SnapKit is a DSL allows building constraints with minimal amounts of code while ensuring they are easy to read and understand.|
  
#### Frameworks

- UIKit
- WebKit 
  
## Resources
 
- Design - [Figma design](https://www.figma.com/community/file/988093088740037911/VOD-Platform-App) created by [Mehri Fekri](https://www.figma.com/community/file/988093088740037911/VOD-Platform-App)
- API - [Link to Mocky](https://www.mocky.io/v3/3feccf06-6bc1-480d-97af-bbc05d785f86)

## How To Use

- Clone the project and run it on Xcode 12 or above.
- Open a terminal window, and $ cd into your project directory.
- Run $ pod install.
- Open the Movie.xcworkspace.

[Back To The Top](#Movie)

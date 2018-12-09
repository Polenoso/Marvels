# Marvels
Project example displaying data from Marvel API

## Architecture
### Clean Swift
Usage of Clean Swift ([`Clean Swift`](https://clean-swift.com/)) as main architecture for this project.
Written in [`Swift 4.2`](https://developer.apple.com/swift/).

The project is structured as:

-Infrastructure

-Interface

where,

`Infrastructure` :  Contains all the core of the project.
* Managers
* AppConfig
* Models
* Network + API
* Tools

`Interface` : Contains the presentation busniess of the project.
* Scenes
* Components

### Deployment Target

- iOS 12.0+

## Frameworks
* [Alamofire](https://github.com/Alamofire/Alamofire) - The network library.

Alamofire is a supported framework with MIT license used to manage network requests easier. It gives features like:
- [x] Chainable Request / Response Methods
- [x] URL / JSON / plist Parameter Encoding
- [x] Upload File / Data / Stream / MultipartFormData
- [x] Network Reachability

It also helps to do asynchronous tasks on network requests, leaving the main queue free for UI threads.


* [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift) - The encoding library

CryptoSwift is a supported framework with Copyright license used to manage the encrypting process for requests.

- [x] Crypto related functions and helpers for Swift implemented in Swift


* [KingFisher](https://github.com/onevcat/Kingfisher) - The image library
- [x] Asynchronous image downloading and caching.
- [x] `URLSession`-based networking. Basic image processors and filters supplied.
- [x] Multiple-layer cache for both memory and disk.

Kingfisher is a supported framework with MIT license used to mange the image caching and presenting.


## Installation
### Carthage
To run the project Carthage is needed.

[How to install carthage](https://github.com/Carthage/Carthage#user-content-installing-carthage) 

After installing carthage, open a new terminal session, navigate to project folder under marvels directory.

run ``` carthage bootstrap --platform iOS ```

- Carthage is a dependency manager for external frameworks. The advantages of using Carthage instead of CocoaPods or embedded frameworks is that with Carthage you can just use a reference to your frameworks and avoid to have large files in the repository. It is completely compatible and supported.

## A Quick View
<p align="center">
<img src="https://github.com/polenoso/Marvels/blob/master/SeriesScreen.png" width="350"/>
<img src="https://github.com/polenoso/Marvels/blob/master/SeriesDetailScreen.png" width="350"/>
</p>

## Testing

- Unit testing for scenes `interactors` and `presenters` 
- Unit testing for `workers`

### TODO:

- Add UITests

## Authors & Contributors

**Aitor Pagan** - *Initial work*

[Contributors](https://github.com/polenoso/Marvels/graphs/contributors) who participated.

## License
This project is licensed under the MIT License

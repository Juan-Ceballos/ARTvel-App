# ARTvel-App

![Artvel-Logo](ARTvel-App/SupportingFiles/Assets.xcassets/ARTvelLogo.imageset/ARTvelLogo.png)

## Overview

ARTvel is a dual experience app for the purpose of discovery. The first type of discovery is for art pieces from Rijksmuseum. The second allows users to discover events happening all over the country available through Ticketmaster. 

       
### Login  

![Login](ARTvel-App/SupportingFiles/Assets.xcassets/Login.imageset/Login.png) 

## Features

### Search
Rijksmuseum: Search for art pieces by artist name.

Ticketmaster: Search for events based on address.

Rijksmuseum Experience | Ticketmaster Experience
---------------------- | -----------------------
![RijksExperience](ARTvel-App/SupportingFiles/Assets.xcassets/RijksExperience.imageset/RijksExperience.png) | ![TMExperience](ARTvel-App/SupportingFiles/Assets.xcassets/TMExperience.imageset/TMExperience.png)

### Details and Favorite

Rijksmuseum Experience | Ticketmaster Experience
---------------------- | -----------------------
![RijksDetailFavorite](ARTvel-App/SupportingFiles/Assets.xcassets/RijksDetailFavorite.imageset/RijksDetailFavorite.png) | ![TMDetailFavorite](ARTvel-App/SupportingFiles/Assets.xcassets/TMDetailFavorite.imageset/TMDetailFavorite.png)

### Browse Favorites

![Favorites](ARTvel-App/SupportingFiles/Assets.xcassets/Favorites.imageset/Favorites.png)

## Code Block

```swift
case .rijks:
    configureDataSourceFavoriteRijks()
    fetchFavoriteArtItems()
    favListener = Firestore.firestore().collection(DatabaseService.favoriteCollectionRijks).whereField("userID", isEqualTo: user.uid).addSnapshotListener({ (snapshot, error) in
        if let error = error {
            print(error)
        } else if let snapshot = snapshot {
            let favorites = snapshot.documents.map {ArtObject($0.data(), $0.data())}
            self.updateFavoriteSnapshotRijks(favoriteArtItems: favorites)
        }
    })
```

## Installation

### Prerequisites

* A developer account from Rijksmuseum for an API Key

* A developer account from Ticketmaster for a consumer key and consumer secret

* Clone this repo to your local machine using https://github.com/Juan-Ceballos/ARTvel-App.git

### Clone

## Built With

## Collaborators

[Juan Ceballos](https://github.com/Juan-Ceballos)

[![Juan](https://avatars1.githubusercontent.com/u/55723135?s=250&u=cce4396e360011123eebd2f52323aa6248023ef0&v=4)](https://github.com/Juan-Ceballos)

//
//  MovieViewState.swift
//  MovieApp
//
//  Created by Mohammad Azam on 8/21/21.
//

import Foundation
import CoreData

struct MovieViewState {
    
    var id: NSManagedObjectID?
    var title: String = ""
    var director: String = ""
    var releaseDate: Date = Date()
    var rating: Int?
    
}

extension MovieViewState {
    
    static func fromMovieViewModel(vm: MovieViewModel) -> MovieViewState {
        var movieVS = MovieViewState()
        movieVS.id = vm.id
        movieVS.title = vm.title
        movieVS.director = vm.director
        movieVS.releaseDate = vm.releaseDate?.asDate() ?? Date()
        movieVS.rating = vm.rating
        return movieVS
    }
    
}


//
//  AddMovieViewModel.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/26/21.
//

import Foundation
import CoreData

enum MovieError: Error {
    case movieNotFound
}

class AddUpdateMovieViewModel: ObservableObject {
    
    var title: String = ""
    var director: String = ""
    @Published var rating: Int? = nil
    var releaseDate: Date = Date()
    
    func save(_ vs: MovieViewState) {
        
        let manager = CoreDataManager.shared
        let movie = Movie(context: manager.persistentContainer.viewContext)
        movie.title = vs.title
        movie.director = vs.director
        movie.rating = Double(vs.rating ?? 0)
        movie.releaseDate = vs.releaseDate
        
        manager.save()
    }
    
    func update(_ vs: MovieViewState) throws {
        
        guard let movieId = vs.id else {
            throw MovieError.movieNotFound
        }
        
        let manager = CoreDataManager.shared
        guard let movie = CoreDataManager.shared.getMovieById(id: movieId) else {
            throw MovieError.movieNotFound
        }
        
        movie.title = vs.title
        movie.director = vs.director
        movie.rating = Double(vs.rating ?? 0)
        movie.releaseDate = vs.releaseDate
        
        manager.save()
    }
    
    func getMovieById(movieId: NSManagedObjectID) throws -> MovieViewModel {
        guard let movie = CoreDataManager.shared.getMovieById(id: movieId) else {
            throw MovieError.movieNotFound
        }
        
        let movieVM = MovieViewModel(movie: movie)
        return movieVM
    }
    
}

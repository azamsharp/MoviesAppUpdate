//
//  AddMovieScreen.swift
//  MovieApp
//
//  Created by Mohammad Azam on 2/24/21.
//

import SwiftUI
import CoreData

struct AddUpdateMovieScreen: View {
    
    @StateObject private var addMovieVM = AddUpdateMovieViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var movieVS = MovieViewState()
    
    var movieId: NSManagedObjectID?
    
    private func saveOrUpdate() {
        
        do {
            
            if movieId != nil {
                try addMovieVM.update(movieVS)
                // fire the notification
                NotificationCenter.default.post(Notification(name: .movieUpdatedNotification))
            } else {
                addMovieVM.save(movieVS)
            }
            
        } catch {
            print(error)
        }
       
    }
    
    var body: some View {
        Form {
            TextField("Enter name", text: $movieVS.title)
            TextField("Enter director", text: $movieVS.director)
            HStack {
                Text("Rating")
                Spacer()
                RatingView(rating: $movieVS.rating)
            }
            DatePicker("Release Date", selection: $movieVS.releaseDate)
            
            HStack {
                Spacer()
                Button("Save") {
                    saveOrUpdate()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            
        }
        .onAppear(perform: {
            // if the movieId is not nil then fetch the movie information
            if let movieId = movieId {
                // fetch the movie
                
                do {
                    let movieVM = try addMovieVM.getMovieById(movieId: movieId)
                    movieVS = MovieViewState.fromMovieViewModel(vm: movieVM)
                    
                } catch {
                    print(error)
                }
                
            }
        })
        .navigationTitle("Add Movie")
        .embedInNavigationView()
    }
}

struct AddMovieScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateMovieScreen()
    }
}

//
//  ContentView.swift
//  iMoviesAPIDemo
//
//  Created by Eyüp on 2023-10-04.
//

import SwiftUI
import iMoviesAPI

struct ContentView: View {

    @State var movies: [Movie] = []

    var body: some View {
        VStack {
            List{
                ForEach(movies, id: \.id) { movie in
                    Text(movie.title ?? "")
                }
            }
        }
        .onAppear {
            fetchMovies()
        }
    }

    func fetchMovies() {
        let networking = Networking()
        let endpoint = MovieEndpoint.upcoming
        Task {
            do {
                let response: UpcomingReponseModel = try await networking.request(endpoint)
                if let results = response.results {
                    self.movies = results
                }

            } catch {
                print("An error occurred: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  iMoviesAPIDemo
//
//  Created by Eyüp on 2023-10-04.
//

import SwiftUI
import Combine
import iMoviesAPI

enum FetchDemoType {
    case asyncAwait, combine
}

struct ContentView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            List{
                ForEach(viewModel.movies, id: \.id) { movie in
                    Text(movie.title ?? "")
                }
            }

            Button("Fetch Movies - Async-Await") {
                viewModel.type = .asyncAwait
                viewModel.fetchMoviesAsyncAwait()
            }

            Button("Fetch Movies - Combine") {
                viewModel.type = .combine
                viewModel.fetchMoviesCombine()
            }
        }
    }

}


@MainActor
final class ViewModel: ObservableObject {

    var cancellables = Set<AnyCancellable>()

    @Published var asyncAwaitMovies: [Movie] = []
    @Published var combineMovies: [Movie]? = []
    @Published var type: FetchDemoType = .asyncAwait

    var movies: [Movie] {
        switch type {
        case .asyncAwait: asyncAwaitMovies
        case .combine: combineMovies ?? []
        }
    }

    let networking = Networking()
    let endpoint = MovieEndpoint.upcoming

    func fetchMoviesAsyncAwait() {
        Task {
            do {
                let response: UpcomingReponseModel = try await networking.request(endpoint)
                if let results = response.results {
                    self.asyncAwaitMovies = results
                }

            } catch {
                print("An error occurred: \(error)")
            }
        }
    }

    func fetchMoviesCombine() {
        networking.request(endpoint, for: UpcomingReponseModel.self)
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] movies in
                self?.combineMovies = movies ?? []
            }
            .store(in: &cancellables)

        // MARK: Different syntax, same thing
        // networking.request(endpoint, for: UpcomingReponseModel.self)
        //      .map(\.results)
        //      .receive(on: DispatchQueue.main)
        //      .replaceError(with: [])
        //      .assign(to: &$combineMovies)
    }
}

#Preview {
    ContentView()
}

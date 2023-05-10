//
//  ContentView.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import SwiftUI

struct PlanetListView: View {
    @ObservedObject var viewModel: PlanetListViewModel
    
    init() {
        self.viewModel = PlanetListViewModel()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.planetList) {
                    planet in
                    VStack {
                        ListCellComponent(planetName: planet.name ?? "", waterAmount: planet.surface_water ?? "")
                    }
                }
            }
            .refreshable {
                Task {
                    try await viewModel.getPlanetListFromAPI()
                    print("Refreshing List")
                }
            }
            .navigationTitle(viewModel.getTitle())
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                Task {
                    try await viewModel.getPlanetListFromAPI()
                }
            }
            
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}

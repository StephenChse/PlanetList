//
//  PlanetListViewModel.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    
    private var nwHandler: NetworkHandler
    @Published var planetList: [PlanetEntity] = []
    @Published var title: String = ""
    @Published private var isLoadingList: Bool = true
    
    init (nwHandler: NetworkHandler = NetworkHandler()) {
        self.nwHandler = nwHandler
        DataManager.shared.load { _ in }
    }
    
    func getPlanetListFromAPI() async throws {
        //TODO: Would be good to have a better loadings state for user
        DispatchQueue.main.async {
            self.isLoadingList = true
        }
        do {
            let data = try await nwHandler.getCall(url: API.planetList.url)
            let jsonObjects = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let results = jsonObjects?["results"] as? [[String: Any]] {
                DataManager.shared.createOrUpdateManagedObjects(using: results, mappedTo: "PlanetEntity")
            }

            DispatchQueue.main.async { [unowned self] in
                self.getPlanetListFromLocal()
                self.isLoadingList = false
            }
            
        } catch {
            //TODO: Inclusion of an error state for user clarity (though this is dependent)
            print("Error getting list of planets: ", error)
        }
    }
    
    func getPlanetListFromLocal() {
        self.planetList = DataManager.shared.fetchAllData(of: "PlanetEntity") as! [PlanetEntity]
    }
    
    func getTitle() -> String {
        switch isLoadingList {
        case true:
            return "Loading Planets..."
        case false:
            return "Planet List"
        }
    }
}

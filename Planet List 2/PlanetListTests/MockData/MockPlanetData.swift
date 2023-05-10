//
//  MockPlanetData.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import Foundation
import CoreData

class MockPlanetData {
    func getPlanetDataFromFile() -> Data {
        return dataFromJSON(withName: "MockPlanetData")!
    }
    
    func getPlanetList() -> [PlanetEntity]? {
        do {
            var planetList = [PlanetEntity]()
            let jsonObjects = try JSONSerialization.jsonObject(with: MockPlanetData().getPlanetDataFromFile(), options: []) as? [String: Any]
            if let results = jsonObjects?["results"] as? [[String: Any]] {
                results.forEach { result in
                    guard let managedObject = DataManager.shared.createManagedObject(for: PlanetEntity.entityName) else { return }
                    DataManager.shared.updateManagedObject(managedObject, usingJSON: result)
                    planetList.append(managedObject as! PlanetEntity)
                }
            }
            return planetList
        } catch {
            return nil
        }
    }
}

func dataFromJSON(withName name: String) -> Data? {
    guard let fileURL = Bundle(for: PlanetListTests.self).url(forResource: name, withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: fileURL)
}


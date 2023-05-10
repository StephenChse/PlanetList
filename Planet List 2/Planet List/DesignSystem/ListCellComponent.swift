//
//  PlanetCustomCellComponent.swift
//  JPMC MCoE
//
//  Created by Stephen Chase on 09/05/2023.
//

import SwiftUI

struct ListCellComponent: View {
    //TODO: Update design, include image potentially

    var planetName: String
    var waterAmount: String
    
    var body: some View {
        HStack {
            Text(planetName)
            Text(waterAmount)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
        
    }
}

struct ListCellComponent_Previews: PreviewProvider {
    static var previews: some View {
        ListCellComponent(planetName: "Earth", waterAmount: "2")
    }
}


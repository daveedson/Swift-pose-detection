
//
//  Created by DavidOnoh on 10/25/25.
//


import Foundation


/// This our simple model class that  represents a coordinate point with x, y values and a timestamp.
struct CoordinatePoint: Identifiable, Equatable {
    let id = UUID()
    let x: Double
    let y: Double
    let timestamp: Date

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
        self.timestamp = Date()
    }
}

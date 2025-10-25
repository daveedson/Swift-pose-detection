//
//  Created by DavidOnoh on 10/25/25.
//

import Foundation

class PoseDataService {
    static let shared = PoseDataService()

    private init() {}

    // This function generates a random coordinate point within the range of 0 to 1 for both x and y axis.
    func generateRandomCoordinatePoint() -> CoordinatePoint {
        let randomX = Double.random(in: 0...1)
        let randomY = Double.random(in: 0...1)
        return CoordinatePoint(x: randomX, y: randomY)
    }
}

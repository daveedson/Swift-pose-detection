
//
//  Created by DavidOnoh on 10/25/25.
//


import Foundation
import Combine

class PoseDataViewModel: ObservableObject {
    @Published var coordinatePoints: [CoordinatePoint] = []
    @Published var isDataFlowActive: Bool = false
    @Published var showNewDataIndicator: Bool = false

    private var timer: Timer?
    private let dataService = PoseDataService.shared
    private let maxPoints = 10

    
    //this function starts the data flow by scheduling a timer that adds new coordinate points at regular intervals.
    func startDataFlow() {
        guard !isDataFlowActive else { return }
        isDataFlowActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.addNewCoordinatePoint()
        }
    }

    func stopDataFlow() {
        isDataFlowActive = false
        timer?.invalidate()
        timer = nil
    }

    
    
    private func addNewCoordinatePoint() {
        let newPoint = dataService.generateRandomCoordinatePoint()

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.coordinatePoints.append(newPoint)

            if self.coordinatePoints.count > self.maxPoints {
                self.coordinatePoints.removeFirst()
            }

            self.showVisualIndicator()
        }
    }

    
    
    private func showVisualIndicator() {
        showNewDataIndicator = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.showNewDataIndicator = false
        }
    }

    deinit {
        stopDataFlow()
    }
}

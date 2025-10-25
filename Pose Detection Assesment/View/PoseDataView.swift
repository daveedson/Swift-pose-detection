

//  Created by DavidOnoh on 10/25/25.
//
import SwiftUI

struct PoseDataView: View {
    @StateObject private var viewModel = PoseDataViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                headerSection
                coordinatePointsList
                Spacer()
                controlButton
            }
            .padding()
            .navigationTitle("My Pose Detection")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Real-time Coordinate Points")
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                if viewModel.showNewDataIndicator {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .scaleEffect(viewModel.showNewDataIndicator ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.showNewDataIndicator)
                }
            }

          
        }
    }

    private var coordinatePointsList: some View {
        VStack(spacing: 0) {
            if viewModel.coordinatePoints.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "location.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No coordinate points Available")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Click Start button \n to see the data flow in real-time")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color(.systemGray6).opacity(0.3))
                .cornerRadius(12)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.coordinatePoints.reversed()) { point in
                            CoordinatePointRow(point: point)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .top).combined(with: .opacity),
                                    removal: .move(edge: .bottom).combined(with: .opacity)
                                ))
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                }
                .frame(maxHeight: 500)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6).opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                        )
                )
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.coordinatePoints.count)
    }

    private var controlButton: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                if viewModel.isDataFlowActive {
                    viewModel.stopDataFlow()
                } else {
                    viewModel.startDataFlow()
                }
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: viewModel.isDataFlowActive ? "stop.fill" : "play.fill")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(viewModel.isDataFlowActive ? "Stop" : "Start")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: viewModel.isDataFlowActive ?
                        [Color.red, Color.orange, Color.yellow] :
                        [Color.green, Color.yellow, Color.purple]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .shadow(color: Color.purple.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .scaleEffect(viewModel.isDataFlowActive ? 1.0 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: viewModel.isDataFlowActive)
    }
}


#Preview {
    PoseDataView()
}

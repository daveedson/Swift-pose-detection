# Pose Detection Assessment

This is my implementation of the real-time pose detection data visualization challenge. I decided to use a clean MVVM architecture approach that keeps things organized and scalable for future extensions.

## What This App Does

The app simulates real-time pose detection by generating random coordinate points every 500ms. Users can start/stop the data flow with a gradient button, and it displays the most recent 10 points in a scrollable list. There's also a visual indicator that shows when new data arrives.

## My Approach & Key Decisions

I made several important choices while building this:

1. **MVVM Architecture**: Chose this pattern because it separates concerns nicely and makes the code more testable
2. **Random Coordinates**: Since we're simulating pose data, I generate random x,y values between 0-1 (normalized coordinates)
3. **10 Point Limit**: The app automatically removes older points to keep the UI responsive
4. **Timer Implementation**: Used `Timer.scheduledTimer` for consistent 500ms intervals
5. **SwiftUI for UI**: Leveraged SwiftUI's declarative syntax for building the interface quickly and cleanly
6. **Dark & light Mode**: The UI adapts to system appearance for better user experience

## Project Structure

Here's how I organized the codebase:

```
├── Model/
│   └── CoordinatePoint.swift          # Data model for coordinates
├── View/
│   └── PoseDataView.swift             # Main UI components
├── ViewModel/
│   └── PoseDataViewModel.swift        # Business logic & state managment
├── Service/
│   └── PoseDataService.swift          # Data generation service
└── ContentView.swift                  # App entry point
```

## How the Layers Communicate

The communication flow works like this:

**Service → ViewModel**: PoseDataService generates random coordinates when the ViewModel's timer fires. This keeps data generation logic seperate from business logic.

**ViewModel → View**: PoseDataViewModel is an ObservableObject with @Published properties. The View observes these changes using @StateObject for automatic UI updates.

**View → ViewModel**: When users tap the start/stop button, the View calls startDataFlow() or stopDataFlow() methods. The ViewModel handles all timer managment and state updates.


## Technical Highlights

- **Memory Management**: Proper timer cleanup in deinit and weak self references
- **Performance**: Used LazyVStack instead of List for better animation control
- **UI Polish**: Custom gradients, shadows, and transition animations
- **Code Organization**: Each component has a single responsibility
- **Error Handling**: Graceful handling of timer states and edge cases

The MVVM pattern makes it easy to extend later, and the service layer means we could easily swap out random generation for real pose detection data from a camera or sensor.

# FuelConsumptionCalculator_SwiftUI
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/metraakladap/FuelConsumptionCalculator_SwiftUI)

FuelConsumptionCalculator is a simple and elegant iOS application built with SwiftUI that helps users calculate trip expenses based on fuel consumption. It provides a clean interface to input trip details and instantly see the total cost, fuel required, and the cost per person.

## Features

-   **Real-time Calculation**: Results are updated instantly as you input data.
-   **Trip Cost Analysis**: Calculate the total cost of a trip based on distance, average fuel consumption, and fuel price.
-   **Expense Splitting**: Easily determine the cost per person for ride-sharing.
-   **Fuel Estimation**: Get an accurate estimate of the total fuel needed for your journey.
-   **Modern UI**: A clean, intuitive, and responsive interface built entirely with SwiftUI.
-   **Dark Mode Support**: The user interface adapts beautifully to both light and dark system themes.

## Architecture

The application is built using modern iOS development practices and follows the MVVM (Model-View-ViewModel) architectural pattern.

-   **View**: Composed of SwiftUI views (`CalculatorScreen`, `CalculatorInputItem`, `CalculatorOutputItem`) that are responsible for the UI. The main screen uses a `TabView` to present different sections of the app.
-   **ViewModel**: The `MainViewModel` contains the business logic for the calculations and manages the state of the calculator using `@Published` properties from the Combine framework.
-   **State Management**: The UI is reactively updated based on changes in the `MainViewModel`'s state (`CalculatorState`).
-   **Project Structure**: The code is organized into logical groups:
    -   `screens`: Contains the primary views of the application.
    -   `viewmodel`: Houses the view models that drive the UI logic.

## How to Get Started

### Prerequisites
- macOS with Xcode installed.
- Swift 5.0 or later.

### Installation & Running

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/metraakladap/FuelConsumptionCalculator_SwiftUI.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd FuelConsumptionCalculator_SwiftUI
    ```
3.  **Open the project in Xcode:**
    ```bash
    open FuelConsumptionCalculator_SwiftUI.xcodeproj
    ```
4.  **Build and run the application:**
    -  Select a simulator or connect a physical iOS device.
    -  Press the "Run" button (▶) in Xcode or use the `Cmd+R` shortcut.

## How to Use

1.  Launch the application.
2.  On the calculator screen, enter the following details:
    -   **Distance (km)**: The total distance of your trip.
    -   **Average Fuel Consumption (L/100km)**: Your vehicle's average fuel usage.
    -   **Fuel Price (per L)**: The current cost of fuel per liter.
    -   **Number of People**: The number of people sharing the cost (defaults to 1).
3.  The app will automatically calculate and display:
    -   **Total Fuel Needed**
    -   **Total Cost**
    -   **Cost Per Person**

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

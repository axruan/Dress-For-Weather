//
// WeatherViewModel.swift
//
///This is the view model for the entire project.  It provides the following services to the views:
///
///1. search text for a location
///    sample usage: WeatherViewModel.sample.textSearch(area: "xxx")
///
///2. retrieve 5 day forecast based on the coordinate of a location
///     sample usage: WeatherViewModel.sample.getFiveDayWeatherFromCoordinate(coordinate:  )
///
///3. provide outfit suggestion based on weather condition for a location
///     sample useage: WeatherViewModel.sample.getDressCodeFromCoordinate(coordinate: )
///
/// This view model also controls when to show alert in case search location does not generate any result or service failure is encountered.
///
/// It depends on various network manager to actually retrieve data from APIs.
/// The view model is the bridge between views and network managers; it digests raw data retrieved from backend APIs, and then manipulates the data to present it to views.
///
import Foundation
import Combine
import MapKit

class WeatherViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var fiveDayReport = FiveDayForecast.sample()
    @Published var geoCode = "EMPTY"
    private let emptyGeoCode = "EMPTY"
    @Published var textSearchResult = LocationSearchElement.sample()
    @Published var geoPostionResult = GeopositionResponse.sample()
    
    @Published var region: MKCoordinateRegion
    @Published var coordinates = []
    @Published var locations: [Location] = []
    
    //dress code dictionary for both genders
    @Published var dressCode = [Gender:[Outfit]]()
        
    //same for all days
    @Published var selectedGender: Gender = .female
    @Published var selectedGenderImage : String = Gender.male.rawValue
    @Published var showingSearchAlert = false
    @Published var showingOutfitAlert = false
    @Published var showingWeatherAlert = false
    @Published var isLoading = true
    
    private let delta = 0.5
    
    static let shared = WeatherViewModel()
    
    ///provide default data at app startup time
    private init() {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.655251, longitude: -71.139671), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        
        self.dressCode[.female] = Array(1...5).map { _ in Outfit.sampleFemale()}
        self.dressCode[.male] = Array(1...5).map { _ in Outfit.sampleMale()}
        
        if selectedGender == .female {
            selectedGenderImage = Gender.male.rawValue
        } else {
            selectedGenderImage =  Gender.female.rawValue
        }
    }
    
    //MARK: gender operations
    ///Called when user switches gender in outfit view, at end of this function it forces the view to refresh
    func switchGender() {
        switch selectedGender {
        case .female:
            selectedGenderImage = Gender.female.rawValue
            selectedGender = .male
        case .male:
            selectedGenderImage = Gender.male.rawValue
            selectedGender = .female
        }
        self.objectWillChange.send()
    }
    
    
    //MARK: Location operations
    ///Called when user wants to add a new pin locaiton on the map
    func addLocation() {
        print("locations count before= \(locations.count)")
        locations.append(Location(name: "New Location", coordinate: CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)))
        print("location is added: \(region.center.latitude),\(region.center.longitude)")
        print("locations count after= \(locations.count)")
    }
    
    ///Called when user deletes a pin location on the map
    func removeLocation(loc: Location) {
        print("locations count before= \(locations.count)")
        print("location is to be removed:\(loc.coordinate.latitude), \(loc.coordinate.longitude)")
        if let index = locations.firstIndex(of: loc) {
            locations.remove(at: index)
        }
        
        print("locations count after= \(locations.count)")
    }
    
    //MARK: AccuWeather API services
    private func getFiveDayForecastData(geoCode: String, completion: @escaping (_ fiveDayReport: FiveDayForecast) -> Void) {
        guard geoCode.isNumber else {
            return
        }
                
        let query:[String:String] = ["details": "true"]
        AccuWeatherManager.shared.getData(endpoint: "\(AccuWeatherManager.shared.fiveDayForecastURL)\(geoCode)",
                                          query: query,
                                          type: FiveDayForecast.self)
        .sink { completion in
            switch completion {
            case .failure(let err):
                print("GetFiveDayForecastDate Error is \(err.localizedDescription)")
                self.isLoading = true
                self.showingOutfitAlert = true
                self.showingWeatherAlert = true
            case .finished:
                print("getFiveDayForecastData Finished")
                self.isLoading = false
            }
        }
    receiveValue: { [weak self] response in
        self?.fiveDayReport = response
        completion(self?.fiveDayReport ?? FiveDayForecast.sample())
    }
    .store(in: &self.cancellables)
    }
    
    private func getGeoCode(zipCode: String, completion: @escaping () -> Void) {
        guard zipCode.isNumber else {
            return
        }
        
        let query:[String:String] = ["q": zipCode]
        AccuWeatherManager.shared.getData(endpoint: AccuWeatherManager.shared.fiveDayForecastURL,
                                          query: query, type: [ZipCodeElement].self)
        .sink { completion in
            switch completion {
            case .failure(let err):
                print("getGeoCode Error is \(err.localizedDescription)")
            case .finished:
                print("getGeoCode Finished")
            }
        }
    receiveValue: { [weak self] response in
        self?.geoCode = response[0].parentCity!.key
        completion()
    }
    .store(in: &self.cancellables)
    }
    
    private func getGeoPosition(coordinate: CLLocationCoordinate2D, completion: @escaping (_ geoCode: String) -> Void) {
        
        let coordinateString = "\(coordinate.latitude),\(coordinate.longitude)"//.urlEncoded
        let query:[String:String] = ["q": coordinateString]
        
        AccuWeatherManager.shared.getData(endpoint: AccuWeatherManager.shared.geoPositionURL,
                                          query: query, type: GeopositionResponse.self)
        .sink { completion in
            switch completion {
            case .failure(let err):
                print("getGeoPosition Error is \(err.localizedDescription)")
                self.showingOutfitAlert = true
                self.showingWeatherAlert = true
            case .finished:
                print("getGeoPosition Finished")
            }
        }
    receiveValue: { [weak self] response in
        self?.geoCode = response.key
        self?.geoPostionResult = response
        completion(self?.geoCode ?? "" )
    }
    .store(in: &self.cancellables)
    }
    
    
    
    public func textSearch(area: String) {
        let query:[String:String] = ["q": area]
        AccuWeatherManager.shared.getData(endpoint: AccuWeatherManager.shared.textSearchURL,
                                          query: query, type: LocationSearch.self)
        .sink { completion in
            switch completion {
            case .failure(let err):
                print("textSearch Error is \(err.localizedDescription)")
                self.showingSearchAlert = true
            case .finished:
                print("textSearch Finished")
            }
        }
    receiveValue: { [weak self] response in
        if response.count > 0 {
            let textSearchResult = response[0]
            let lat = textSearchResult.geoPosition.latitude
            let lon = textSearchResult.geoPosition.longitude
            
            self?.coordinates = [lat, lon]
            self?.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: self!.delta, longitudeDelta: self!.delta))
            
        } else {
            self?.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.655251, longitude: -71.139671), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
            self?.showingSearchAlert = true
        }
    }
    .store(in: &self.cancellables)
    }
    
    
    //MARK: DressCode API services
    private func getDressCode(forecast: DailyForecast, gender: Gender) -> Outfit {
        let selectedCodeForOneGender: Outfit
        let dressCodeForBothGenders = DressCodeManager.shared.getDressCodeForWeather(forecast: forecast)
        
        switch gender {
        case .female:
            selectedCodeForOneGender = dressCodeForBothGenders[.female] ?? Outfit.sampleFemale()
            // selectedGenderImage = Gender.male.rawValue
        case .male:
            selectedCodeForOneGender = dressCodeForBothGenders[.male] ?? Outfit.sampleMale()
            // selectedGenderImage = Gender.female.rawValue
        }
        
        return selectedCodeForOneGender
    }
    
    private func getDressCode(fiveDayforecast: FiveDayForecast){
        
        dressCode.removeAll()
        
        var dressCodeForFemale = [Outfit]()
        var dressCodeForMale = [Outfit]()
        for index in 0...(fiveDayforecast.dailyForecasts.count-1) {
            dressCodeForFemale.append( getDressCode(forecast: fiveDayforecast.dailyForecasts[index], gender: .female))
            dressCodeForMale.append( getDressCode(forecast: fiveDayforecast.dailyForecasts[index], gender: .male))
        }
        
        dressCode[.female] = dressCodeForFemale
        dressCode[.male] = dressCodeForMale
    }
    
    
    //MARK: combined services used by Views
    func getDressCodeFromCoordinate(coordinate:CLLocationCoordinate2D)  {
        isLoading = true
        getGeoPosition(coordinate: coordinate) { geoCode in
            self.getFiveDayForecastData(geoCode: geoCode) { fiveDayReport in
                self.getDressCode(fiveDayforecast: fiveDayReport)
            }
        }
    }
    
    func getFiveDayWeatherFromCoordinate(coordinate:CLLocationCoordinate2D)  {
        isLoading = true
        getGeoPosition(coordinate: coordinate) { geoCode in
            self.getFiveDayForecastData(geoCode: geoCode) {fiveDayReport in
                //do nothing
            }
        }
    }
    
}

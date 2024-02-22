//
//AccuWeatherManager.swift
//
///
/// This class is responsible to get data from  AccuWeather APIs at https://developer.accuweather.com/apis
/// It uses a genetic type T to represent the return object type for different services.
///
/// Each API service shares one single common parameter: the API key. Other than that, different API services requires different set of query items.
///
/// This class uses pass in query items and endpoints to talk to APIs, then returns raw object types back.  
///
/// It uses Combine to handle async calls. Referenced from this article: https://tolgatanerstories.medium.com/creating-generic-networking-with-combine-in-swift-385a38417c92
///
///

import Foundation
import Combine
import MapKit

class AccuWeatherManager{
    
    static let shared = AccuWeatherManager()
    
    private init() {
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    //endpoints for Accuweather APIs
    internal let fiveDayForecastURL = "https://dataservice.accuweather.com/forecasts/v1/daily/5day/"
    internal let postCodeURL = "https://dataservice.accuweather.com/locations/v1/postalcodes/search"
    internal let textSearchURL = "https://dataservice.accuweather.com/locations/v1/US/search"
    internal let geoPositionURL = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search"
    private let apiKeyString = "j4rLEjQzkksGVi7UsWoEaf46W8Zc72wG"
    
    
    //sample query string: q=Andover,MA
    /// Get data from API
    /// - In parameter: `endpoint`is String type; it is the absolute url to the API
    ///             `query`: a dictionary for key:value pairs, converted to query string, appended to the endpoint
    ///             `type`:  return type of the data returned from API
    /// - Return: Future gives a promise closure that we can call when an asynchronous operation is completed,
    /// and Combine will then automatically map the Result that we give the closure into proper publisher events.
    func getData<T: Decodable>(endpoint: String, query: [String:String], type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in

            guard let self = self,
                  var urlComponents = URLComponents(string: endpoint) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            urlComponents.queryItems=[URLQueryItem(name:"apikey",value:self.apiKeyString)]
            for (key, value)  in query {
                let item = URLQueryItem(name: key, value:value)
                urlComponents.queryItems?.append(item)
            }
           
            guard let url = urlComponents.url else {
                return promise(.failure(NetworkError.invalidURL))
            }

            //decode date to correct format
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            print(url)
            
            URLSession.shared.dataTaskPublisher(for: url)
            //URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    data.printJSON()
                    return data
                }
                .decode(type: T.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)

        }
    }

}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

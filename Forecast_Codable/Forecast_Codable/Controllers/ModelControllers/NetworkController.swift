//
//  NetworkController.swift
//  Forecast_Codable
//
//  Created by Colton Brenneman on 6/20/23.
//

import Foundation

struct NetworkController {
    
    // MARK: - Properties
    private static let baseURLString = "https://api.weatherbit.io/v2.0/forecast/daily"
    
    
    // MARK: - Functions
    static func fetchDays(completion: @escaping(TopLevelDictionary?) -> Void) {
        guard let baseURL = URL(string: baseURLString) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: "key", value: "66b860501a054c83b086019d99e0f316")
        let cityQuery = URLQueryItem(name: "city", value: "Saint George")
        let unitsQuery = URLQueryItem(name: "units", value: "I")
        
        urlComponents?.queryItems = [apiQuery, cityQuery, unitsQuery]
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error {
                print("AH SHIT DUDE THERE WAS AN ERROR FETCHING THE DATA", error.localizedDescription)
                completion(nil) ; return
            } //End of error
            guard let data = data else { completion(nil) ; return }
            
            do {
                let toplevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(toplevelDictionary)
            } catch {
                print("AH DAMN THERE'S AN ERROR IN THE DO-TRY-CATCH", error.localizedDescription)
            }
        }.resume() //End of dataTask
    } //End of fetchDays
} //End of struct

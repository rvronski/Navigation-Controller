//
//  NetworkManager.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 11.12.2022.
//

import Foundation

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {
        guard let url = URL(string: configuration.rawValue) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            let headerFields = (response as? HTTPURLResponse)?.allHeaderFields
            print("🍏 Statys Code = \(String(describing: statusCode))")
            print("🍎 Header Fields = \(String(describing: headerFields))")
            if statusCode != 200 {
                print("Status Code = \(String(describing: statusCode))")
                return
            }
            guard let data else {
                print("data = nil")
                return
            }
            print("🍓 Data = \(data)")
        }
        
        task.resume()
    }
}

enum AppConfiguration: String {
    case one = "https://swapi.dev/api/people/8"
    case two = "https://swapi.dev/api/starships/3"
    case three = "https://swapi.dev/api/planets/5"
    
}


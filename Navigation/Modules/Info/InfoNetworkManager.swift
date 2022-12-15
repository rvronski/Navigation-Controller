//
//  InfoNetworkManager.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 13.12.2022.
//

import Foundation

struct Planet: Decodable {
    var orbital_period: String
}

struct Resident: Decodable {
    var residents: [String]
}

struct NamesResidents: Decodable {
    var name: String
}

class InfoNetworkManager {
    
    static func loadText(completion: ((_ textTitle: [String]?) -> Void)?) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/" ) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            let headerFields = (response as? HTTPURLResponse)?.allHeaderFields
            print("🍏 Statys Code = \(String(describing: statusCode))")
            print("🍎 Header Fields = \(String(describing: headerFields))")
            if statusCode != 200 {
                print("Status Code = \(String(describing: statusCode))")
                completion?(nil)
                return
            }
            guard let data else {
                print("data = nil")
                completion?(nil)
                return
            }
            do {
                guard let answer = try JSONSerialization.jsonObject(with: data) as? [[String : Any]] else {
                    print("error parsing JSON - answer")
                    completion?(nil)
                    return
                }
                var returnArray = [String]()
                for item in answer {
                    if let titleText = item["title"] as? String {
                        returnArray.append(titleText)
                    }
                }
                completion?(returnArray)
            } catch {
                completion?(nil)
                print(error)
            }
            
        }
        
        task.resume()
    }
    
   static func loadOrbitalPeriod(completion: ((_ orbital_period: String?) -> Void)?) {
        guard let url = URL(string: "https://swapi.dev/api/planets/1" ) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            let headerFields = (response as? HTTPURLResponse)?.allHeaderFields
            print("🍏 Statys Code = \(String(describing: statusCode))")
            print("🍎 Header Fields = \(String(describing: headerFields))")
            if statusCode != 200 {
                print("Status Code = \(String(describing: statusCode))")
                completion?(nil)
                return
            }
            guard let data else {
                print("data = nil")
                completion?(nil)
                return
            }
            do {
               let period = try JSONDecoder().decode(Planet.self, from: data)
                let orbital_Period = period.orbital_period
                completion?(orbital_Period)
            } catch {
                completion?(nil)
                print(error)
            }
            
        }
        
        task.resume()
    }

   

    //let serialQueue = DispatchQueue(label: "com.NavigationApp.serial")
    //let concurrentQueue = DispatchQueue(label: "com.NavigationApp.concurrent", attributes: [.concurrent])

   static func loadResidents(completion: ((_ name: String?) -> Void)?) {
        guard let url = URL(string: "https://swapi.dev/api/planets/1" ) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if statusCode != 200 {
                print("Status Code = \(String(describing: statusCode))")
                completion?(nil)
                return
            }
            guard let data else {
                print("data = nil")
                completion?(nil)
                return
            }
            do {
                let resident = try JSONDecoder().decode(Resident.self, from: data)
                let residentArray = resident.residents
                for name in residentArray {
                    guard let url = URL(string: name ) else { return }
                    let session = URLSession(configuration: .default)
                    let task = session.dataTask(with: url) { data, response, error in
                        if let error {
                            print(error.localizedDescription)
                            completion?(nil)
                            return
                        }
                        let statusCode = (response as? HTTPURLResponse)?.statusCode
                        if statusCode != 200 {
                            print("Status Code = \(String(describing: statusCode))")
                            completion?(nil)
                            return
                        }
                        guard let data else {
                            print("data = nil")
                            completion?(nil)
                            return
                        }
                        do {
                            let names = try JSONDecoder().decode(NamesResidents.self, from: data)
                            let residentsNames = names.name
                            completion?(residentsNames)
                            
                        } catch {
                            completion?(nil)
                            print(error)
                        }
                    }
                    task.resume()
                }
            } catch {
                completion?(nil)
                print(error)
            }
        }
        task.resume()
    }
    
    
}



//func loadName(array: [String]) -> [String]? {
//    var namesArray = [Any]()
//    let group = DispatchGroup()
//    group.enter()
//    DispatchQueue.global().async {
//        for value in array {
//            guard let url = URL(string: value ) else { return }
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if let error {
//                    print(error.localizedDescription)
//                    //                completion?(nil)
//                    return
//                }
//                let statusCode = (response as? HTTPURLResponse)?.statusCode
//                if statusCode != 200 {
//                    print("Status Code = \(String(describing: statusCode))")
//                    //                completion?(nil)
//                    return
//                }
//                guard let data else {
//                    print("data = nil")
//                    //                completion?(nil)
//                    return
//                }
//                do {
//                    let names = try JSONDecoder().decode(NamesResidents.self, from: data)
//                    let name = names.name
//                    namesArray.append(name)
//
//                } catch {
//                    //                completion?(nil)
//                    print(error)
//                }
//            }
//            task.resume()
//        }
//        group.leave()
//    }
//
//        return namesArray as! [String]?
//}
//
//
    
 




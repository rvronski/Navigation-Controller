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


struct InfoNetworkManager {
    
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
                
//                guard let result = answer["result"] as? [[String : Any]] else {
//                    print("error parsing JSON - result")
//                    return
//                }
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
    
    
    
    
}

func loadOrbitalPeriod(completion: ((_ orbital_period: String?) -> Void)?) {
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

struct Resident: Decodable {
    var residents: [String]
}

struct NamesResidents: Decodable {
    var name: String
}

func loadName(completion: ((_ name: [String]?) -> Void)?) {
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
            var namesResidents = [String]()
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
                            namesResidents.append(residentsNames) 
                            print("🍉🍉 \(residentsNames)")
                        } catch {
                            completion?(nil)
                            print(error)
                        }
                    }
                    task.resume()
                }
            let delay = DispatchTime.now() + .seconds(3)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                print(namesResidents.isEmpty)
                completion?(namesResidents)
            }
            
        } catch {
            completion?(nil)
            print(error)
        }
        
    }
    task.resume()
}
   



/*
 Создайте модель данных планеты на базе JSON, соответствующую протоколу Decodable
 Запустите URLSessionDataTask
 С помощью JSONDecoder инициализируйте вашу модель данных
 В дополнительно созданной UITableView на InfoViewController отобразите имена всех жителей планеты Татуин
 Для этого вам потребуется отключить SSL с помощью ключа в Info.plist: Dictionary: App Transport Security Settings ключ: Allow Arbitrary Loads, значение: YES
 После чего создайте модель данных для JSON по адресу жителя планеты с 1 полем - name
 Запустите для каждого URL жителя Татуина URLSessionDataTask
 Инициализируйте модели данных жителей и сохраните их, к примеру, в Array
 .reloadData()

 */
//for name in residentsArray {
//    guard let url = URL(string: name as! String ) else { return }
//    let session = URLSession(configuration: .default)
//    let task = session.dataTask(with: url) { data, response, error in
//        if let error {
//            print(error.localizedDescription)
//            completion?(nil)
//            return
//        }
//        let statusCode = (response as? HTTPURLResponse)?.statusCode
//        let headerFields = (response as? HTTPURLResponse)?.allHeaderFields
//        print("🍏 Statys Code = \(String(describing: statusCode))")
//        if statusCode != 200 {
//            print("Status Code = \(String(describing: statusCode))")
//            completion?(nil)
//            return
//        }
//        guard let data else {
//            print("data = nil")
//            completion?(nil)
//            return
//        }
//        do {
//            let names = try JSONDecoder().decode(NamesResidents.self, from: data)
//        }
//
//
//completion?(orbital_Period)

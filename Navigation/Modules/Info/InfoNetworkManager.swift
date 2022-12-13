//
//  InfoNetworkManager.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 13.12.2022.
//

import Foundation

struct InfoNetworkManager {
    
    static func request(completion: ((_ textTitle: [String]?) -> Void)?) {
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

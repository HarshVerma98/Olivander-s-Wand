//
//  Spells.swift
//  The_Olivander's Wand
//
//  Created by Harsh Verma on 19/05/20.
//  Copyright © 2020 Harsh Verma. All rights reserved.
//

import Foundation
class Spells {
    
    private struct Returned: Codable {
        
        var results: [SpellData] = []
        
    }
    
    var spellArray: [SpellData] = []
    var url = "https://potterspells.herokuapp.com/api/v1/spells"
    
    func getData(completed: @escaping ()->()) {
        let urlString = url
        print("Accessing URL\(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: Cant create a URL from\(urlString)")
            completed()
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print(returned)
                self.spellArray = returned.results
            } catch {
                print("JSON Error:-\(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}

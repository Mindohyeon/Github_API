//
//  MainViewModel.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import Foundation
import Alamofire


class MainViewModel : ObservableObject {
    
    @Published var api : Contact? = nil
    @Published var inputId : String = ""
    
    
    func fetch(of name: String) async {
        
        // MARK: - Alamofire
        print("iii")
        let url = "https://api.github.com/users/\(name)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
        //        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            print(response)
            
            switch response.result {
                
            case .success(_):
                do {
                    
                    let json = try JSONDecoder().decode(Contact.self, from: response.data ?? .init())
                    print("contact = \(json)")
                    
                    self.api = json
                } catch(let error) {
                    print("error = \(error)")
                }
            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
}

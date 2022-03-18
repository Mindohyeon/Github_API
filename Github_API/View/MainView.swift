//
//  MainView.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import SwiftUI
import Alamofire

struct MainView: View {
    
    var api: [API] = []
    
    var imageUrl: String = ""
    @State var inputId: String = ""

    
    var body: some View {
        VStack {
            Button {
                fetch(of: inputId)
                print(inputId)
            } label: {
                Image(imageUrl)
                    .resizable()
                    .frame(width: 100, height: 100)
                
            }
            
            TextField("id", text: $inputId)
                .frame(maxWidth: 200, maxHeight: 30)
            
                .onSubmit {
                    print(inputId)
                    
                }
            
            
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    func fetch(of name: String) {
        
        let url = "https://api.github.com/users/\(name)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                print(json)
                
            }

    
    }
}

//
//  MainView.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import SwiftUI
import Alamofire
import Combine


struct MainView: View {
    
    @State var api: [Contact] = []
    
    var imageUrl: String = ""
    @State var inputId: String = ""
    @State var email : String = ""
    
    
    var body: some View {
        VStack {
            HStack {
                
                TextField("id", text: $inputId)
                    .frame(maxWidth: 200, maxHeight: 30)
                
                //enter 쳤을 때
                    .onSubmit {
                        print(inputId)
                        
                    }
                
                Image(systemName: "paperplane")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        fetch(of: inputId)
                        print(inputId)
                    }
            }
            
            
            
            AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/81687906?v=4")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
            }
            
            Text(email)
                .font(.title2)
        }
    }
    
    func fetch(of name: String) {
        
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

                    let json = try JSONDecoder().decode(API.self, from: response.data ?? .init())

                    self.api = json.contact
                } catch(let error) {
                    print("error = \(error)")
                }
            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

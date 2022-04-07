//
//  MainView.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var inputId: String = ""
    
    
    var body: some View {
        ZStack {
            Color.orange
                .scaledToFit()
            
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
                            
                            Task {
                                
                                await viewModel.fetch(of: inputId)
                                print(inputId)
                            }
                        }
                }
                
                AsyncImage(url: URL(string: viewModel.api?.avatar_url ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                }
                
                HStack(spacing: 50) {
                    VStack {
                        Text("following")
                        
                        Text(String(viewModel.api?.following ?? 0))
                    }
                    
                    VStack {
                        Text("followers")
                        
                        Text(String(viewModel.api?.followers ?? 0))
                    }
                    
                    
                }
            }
        }
    }
    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

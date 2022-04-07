//
//  MainView.swift
//  Github_API
//
//  Created by 민도현 on 2022/03/18.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Color.orange
                .scaledToFit()
            
            VStack {
                HStack {
                    
                    TextField("id", text: $viewModel.inputId)
                        .frame(maxWidth: 200, maxHeight: 30)
                    
                    //enter 쳤을 때
                        .onSubmit {
                            print(viewModel.inputId)
                        }
                    
                    Image(systemName: "paperplane")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            Task {
                                
                                await viewModel.fetch()
                                print(viewModel.inputId)
                                
                            }
                        }
                }
                
                if let url = viewModel.api?.avatarUrl {
                    AsyncImage(url: URL(string: url)) { image in
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
                    
                } else {
                    Text("없음")
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
                .padding()
                
                if let url = viewModel.api?.htmlUrl {
                    Link(destination: URL(string: url)!) {
                        Text("깃허브로 이동하기!")
                            .font(.system(size: 15))
                    }
                } else {
                    Text("사용자의 깃허브 링크가 없어요.")
                        .font(.system(size: 15))
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

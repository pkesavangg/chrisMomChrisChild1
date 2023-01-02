//
//  DashboardView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var authentication = AuthenticationService()
    @EnvironmentObject var gameService : GameService
    @Binding var isDashboardView : Bool
    var body: some View {
        
        NavigationView {
            VStack{
                Text("") .navigationTitle("Home").navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button {
                            Task{
                                isDashboardView = false
                                authentication.logOut()
                            }
                        } label: {
                            Image(systemName:  "rectangle.portrait.and.arrow.right")
                        }
                    }
                
                
                TabView {
              
                    MainScreen().tabItem {
                        Label("PlayerList", systemImage: "person.crop.circle.fill")
                    }.onAppear{
                        self.gameService.getUserDetails()
                        self.gameService.getPlayersList()
                    }
                    
                    SendingDareView().tabItem {
                        Label("SendDare", systemImage: "paperplane.circle.fill")
                    }.onAppear{
                        self.gameService.getMomChildNamesList()
                        self.gameService.getDareMessage()
                    }
                    
                    DareMessageDetailView().tabItem {
                        Label("Dare Details", systemImage: "list.star")
                    }.onAppear{
                        self.gameService.getMomChildNamesList()
                        self.gameService.getDareMessage()
                    }
                    
                    }
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(isDashboardView: .constant(false))
    }
}

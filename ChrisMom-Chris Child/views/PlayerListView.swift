//
//  PlayerListView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 28/12/22.
//

import SwiftUI

struct PlayerListView: View {
    
    @EnvironmentObject var gameService : GameService
    var body: some View {
        VStack{
            List {
                Section(header: Text("Players List")){
                    ForEach(self.gameService.playerDetails, id: \.self) { item in
                    Text(item.playerName)
                }
                }
                
                if(self.gameService.isAdmin()){
                    Section(footer:
                               VStack(alignment: .center) {
                                   Spacer()
                        HStack{
                            Spacer()
                            Button("Start The Game") {
                                self.gameService.generateMomAndChild()
                            }.disabled(!isValid())
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            
                            Button("Reset the game") {
                                self.gameService.resetTheGame()
                            }.disabled(!isValid())
                            
                            
                            Spacer()
                        }
                           }) {
                               EmptyView()
                           }
                }
                
                
             } .listStyle(GroupedListStyle())
        }
        
    }
    
    private func isValid() -> Bool {
        if(self.gameService.playerDetails.count > 2 && self.gameService.isAdmin()){
            return true
        }else{
            return false
        }
    }
    
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}

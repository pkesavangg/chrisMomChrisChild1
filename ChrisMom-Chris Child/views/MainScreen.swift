//
//  MainScreen.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 28/12/22.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var gameService : GameService
    var body: some View {
        VStack{
            if(self.gameService.isCurrentUserIsPlayer()){
                PlayerListView()
            }else{
                VStack{
                    VStack(alignment: .leading ){
                        HStack{
                            Text("UserName")
                            Spacer()
                            Text(self.gameService.getCurrentUserName())
                        }
                        HStack{
                            Text("UserMailId")
                            Spacer()
                            Text(self.gameService.getCurrentUserMailId())
                        }
                        
                    }
                    Spacer()
                    Text("Click the button below to join the Game")
                    Button("Join") {
                        self.gameService.addThePlayer()
                    }
                    Spacer()
                }
            }
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

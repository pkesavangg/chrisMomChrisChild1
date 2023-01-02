//
//  SendingDareView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 28/12/22.
//

import SwiftUI

struct SendingDareView: View {
    @EnvironmentObject var gameService : GameService
    @State var dareMessage = ""
    var body: some View {
        VStack{
            List {
                ForEach(self.gameService.momChildNameFromDB, id: \.self) { item in
                    if(item.momName == self.gameService.getCurrentUserName()){
                        SendingDareViewCell(dareDetails: item)
                    }
                }
            }.listStyle(GroupedListStyle())
        }
    }
}
struct SendingDareView_Previews: PreviewProvider {
    static var previews: some View {
        SendingDareView()
    }
}

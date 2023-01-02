//
//  DareMessageDetailView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 28/12/22.
//

import SwiftUI

struct DareMessageDetailView: View {
    @EnvironmentObject var gameService : GameService
    var isSelected = false
    var body: some View {
        VStack{
            List {
                ForEach(self.gameService.dareMessageDetails, id: \.self) { item in
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            Text("Child Name: ")  +  Text(item.childName).foregroundColor(.blue)
                            Spacer()
                        }
                         
                        Spacer()
                        HStack{
                            HStack(alignment: .top){
                                Text("Task for her/him: ").foregroundColor(.blue).padding(.trailing)
                            }
                           
                            Text(item.dareMessage)
                            
                        }
                        Spacer()
//                        HStack{
//                            HStack(alignment: .top){
//                                Text("Dare Completion Status").foregroundColor(.blue).padding(.trailing)
//                            }
//                            if(item.isCompledted == "Completed"){
//                                Text(Image(systemName:  "checkmark.circle.fill" )).foregroundColor(Color("check-mark-color")) + Text("   Completed SucessFully")
//                            }else{
//                                Text(Image(systemName:  "checkmark.circle" )) + Text("   Not Completed Yet")
//                            }
//                            
//                           
//                        }
                        
                       
                    }
                }
            }
        }
    }
    
    
}

struct DareMessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DareMessageDetailView()
    }
}

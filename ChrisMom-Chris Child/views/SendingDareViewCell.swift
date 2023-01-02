//
//  SendingDareViewCell.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 30/12/22.
//

import SwiftUI

struct SendingDareViewCell: View {
    @EnvironmentObject var gameService : GameService
   // @State var isCompleted = ""
    
    
    
    let dareDetails :  MomChildNamesModelDB
    @State var dareMessage = ""
    @State var dareCompletionStatus = false
    init(dareDetails: MomChildNamesModelDB) {
        self.dareDetails = dareDetails
        
    }
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                VStack{
                    Text("Your Name").foregroundColor(.blue)
                    Text(dareDetails.momName)
                }
                Spacer()
                VStack{
                    Text("Your ChildName").foregroundColor(.blue)
                    Text(dareDetails.childName)
                }
            }
            
            
            VStack{
                
                TextField("Enter your dare details for your child", text: $dareMessage, axis: .vertical)
                    .lineLimit(15, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                VStack(alignment: .center) {
                    Spacer()
  //                  PickerView()
                    if(self.gameService.isDareAlreadyAssigned()){
                        Button("Replace the Existing Dare for your child") {
                            self.gameService.updateDareMessage(updatedDareMessage: self.dareMessage)
                        }.disabled(self.dareMessage.isEmpty)
                    }
                    else{

                        Button("Send Dare") {
                            self.gameService.sendDareDetails(dareMessage: self.dareMessage)
                        }.disabled(self.dareMessage.isEmpty)

                    }
                    
                    Spacer()
//                    if(self.gameService.isDareAlreadyAssigned()){
//                        VStack{
//                            Picker(selection: $isCompleted, label: Text("Select the dare completion status of your child")) {
//                                           Text("Completed").tag("Completed")
//                                           Text("Not Completed").tag("Not Completed")
//                                       }.pickerStyle(MenuPickerStyle())
//                                  
//                            Button("Update Completion Status") {
//                                self.gameService.updateDareCompletionStatus(dareCompletionStatus: self.isCompleted)
//                            }
//                        }
//                    }
                }
            }
            
        }
    }
}


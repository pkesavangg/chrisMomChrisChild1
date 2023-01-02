//
//  PickerView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 01/01/23.
//

import SwiftUI

struct PickerView: View {
    
    @State var selected = ""
    
   
    
    var body: some View {
        VStack{
            Picker(selection: $selected, label: Text("Select the dare completion status of your child")) {
                           Text("Completed").tag("Completed")
                           Text("Not Completed").tag("Not Completed")
                       }.pickerStyle(MenuPickerStyle())
                  
        }
    }
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//    }
//}

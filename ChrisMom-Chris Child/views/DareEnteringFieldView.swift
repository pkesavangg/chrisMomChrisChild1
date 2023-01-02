//
//  DareEnteringFieldView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 27/12/22.
//

import SwiftUI

struct DareEnteringFieldView: View {
    @State var dareText = ""
    var body: some View {
        
        VStack{
            TextField("Enter your Dare", text: $dareText, axis: .vertical)

                       .textFieldStyle(.roundedBorder)
                       .lineLimit(5, reservesSpace: true)
                       .padding()
        }
        
        
    }
}

struct DareEnteringFieldView_Previews: PreviewProvider {
    static var previews: some View {
        DareEnteringFieldView()
    }
}

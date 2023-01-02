//
//  GameService.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 28/12/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class GameService : ObservableObject {
    
    let dataBase = Firestore.firestore()
    let userDefaults = UserDefaults.standard
    var emptyArray  = [String]()
    @Published var usersDetails = [UserDetails]()
    @Published var playerDetails = [PlayerDetailsModel]()
    @Published var momChildNames = [MomChildNamesModel]()
    @Published var dareMessageDetails = [DareMessageModel]()
    @Published var momChildNameFromDB = [MomChildNamesModelDB]()
    
    func getCurrentUserName() -> String{
        return  UserDefaults.standard.string(forKey: "userName") ?? ""
    }
    
    func getCurrentUserMailId() -> String{
        if let currentUserId = Auth.auth().currentUser?.email{
            return currentUserId
        }
        return ""
    }
    
    func isCurrentUserIsPlayer() -> Bool {
        return playerDetails.contains(where: {$0.playerName == getCurrentUserName()})
    }
    
    func isAdmin() -> Bool {
        return self.getCurrentUserMailId() == "karthick@gmail.com" ? true : false
    }
    
    func generateMomAndChild() {
        self.momChildNames = []
        
        var boolValue = true
        
        if( self.playerDetails.count < 2){
            return
        }
        
        for player in self.playerDetails {
            boolValue = true
            while(boolValue == true){
                print(self.playerDetails)
                let randomNumber = Int.random(in: 0 ... self.playerDetails.count - 1)
                if( !momChildNames.contains(where: {$0.childName == playerDetails[randomNumber].playerName})  && playerDetails[randomNumber].playerName != player.playerName){
                    let value = MomChildNamesModel(momName: player.playerName, childName: playerDetails[randomNumber].playerName)
                    momChildNames.append(value)
                    boolValue = false
                }
            }
        }
        print(momChildNames)
        self.sendMomChildListToDB()
    }
    
    
    func getChildName() -> String{
        var childName = ""
        for item in momChildNameFromDB {
            if(item.momName == getCurrentUserName()){
                childName = item.childName
            }
        }
        return childName
    }
    
    func sendUserDetails(userId: String, userName : String){
        
        let newDocument = dataBase.collection("MemberDetails").document()
        
        newDocument.setData(["MemberMailId": userId,
                             "MemberName": userName,
                             "dateField": Date.timeIntervalSinceReferenceDate, "documentId" : newDocument.documentID]) { (error) in
            if let e = error {
                print("There was and issue, \(e)")
                print("There was and issue")
            }else{
                DispatchQueue.main.async {
                    
                }
                print("SuccessFully send the players list")
            }
        }
    }
    
    
    func getUserDetails(){
        dataBase.collection("MemberDetails")
            .order(by: "dateField")
            .addSnapshotListener{ (querySnapshot , error ) in
                
                if let e = error {
                    print("There was an issue retrieving data from firestore \(e)")
                }else{
                    if let snapShotDocuments =  querySnapshot?.documents {
                        self.usersDetails = []
                        
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let userId = data["MemberMailId"] as? String , let userName = data["MemberName"] as? String,
                               let documentId = data["documentId"] as? String
                            {
                                if ( userId == self.getCurrentUserMailId()){
                                    self.userDefaults.set(userName, forKey: "userName")
                                }
                                self.usersDetails.append(UserDetails(userMailId: userId, userName: userName, documentId: documentId))
                                
                            }
                        }
                        DispatchQueue.main.async {
                            print(self.usersDetails)
                        }
                        
                    }
                }
            }
    }
    
    
    func addThePlayer() {
        
        let newDocument = dataBase.collection("PlayerDetails").document()
        newDocument.setData(["PlayerMailId": self.getCurrentUserMailId(),
                             "PlayerName": self.getCurrentUserName(),
                             "dateField": Date.timeIntervalSinceReferenceDate,
                             "documentId" : newDocument.documentID]) { (error) in
            if let e = error {
                print("There was and issue, \(e)")
                print("There was and issue")
            }else{
                DispatchQueue.main.async {
                    
                }
                print("SuccessFully send the players list")
            }
        }
        
    }
    
    
    func getPlayersList(){
        dataBase.collection("PlayerDetails")
            .order(by: "dateField")
            .addSnapshotListener{ (querySnapshot , error ) in
                
                if let e = error {
                    print("There was an issue retrieving data from firestore \(e)")
                }else{
                    if let snapShotDocuments =  querySnapshot?.documents {
                        self.playerDetails = []
                        
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let userId = data["PlayerMailId"] as? String , let userName = data["PlayerName"] as? String,
                               let documentId = data["documentId"] as? String
                            {
                                self.playerDetails.append(PlayerDetailsModel(playerName: userName, playerMailId: userId, documentId: documentId))
                            }
                        }
                        DispatchQueue.main.async {
                            
                        }
                        
                    }
                }
            }
    }
    
    func sendMomChildListToDB(){
        
        for names in momChildNames {
            
            let newDocument = dataBase.collection("MomChildList").document()
            newDocument.setData(["MomName": names.momName, "ChildName": names.childName,
                                 "dateField": Date.timeIntervalSinceReferenceDate,
                                 "documentId": newDocument.documentID]) { (error) in
                if let e = error {
                    print("There was and issue, \(e)")
                    print("There was and issue")
                }else{
                    DispatchQueue.main.async {
                        
                    }
                    print("SuccessFully send the players list")
                }
            }
            
        }
    }
    
    func getMomChildNamesList(){
        
        
        dataBase.collection("MomChildList")
            .order(by: "dateField")
            .addSnapshotListener{ (querySnapshot , error ) in
                
                if let e = error {
                    print("There was an issue retrieving data from firestore \(e)")
                }else{
                    if let snapShotDocuments =  querySnapshot?.documents {
                        self.momChildNameFromDB = []
                        
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let momName = data["MomName"] as? String , let childName = data["ChildName"] as? String
                                , let documentId = data["documentId"] as? String
                            {
                                self.momChildNameFromDB.append(MomChildNamesModelDB(momName: momName, childName: childName, documentId: documentId))
                            }
                        }
                        DispatchQueue.main.async {
                            
                        }
                        
                    }
                }
            }
    }
    
    
    func sendDareDetails(dareMessage: String){
        
        let newDocument = dataBase.collection("DareMessageDetails").document()
        newDocument.setData(["dareMessage": dareMessage, "childName": getChildName(),
                             "dateField": Date.timeIntervalSinceReferenceDate,
                             "dareCompletionStatus" : "Not Completed",
                             
                             "documentId": newDocument.documentID]) { (error) in
            if let e = error {
                print("There was and issue, \(e)")
                print("There was and issue")
            }else{
                DispatchQueue.main.async {
                    
                }
                print("SuccessFully send the players list")
            }
        }
        
    }
    
    
    func isDareAlreadyAssigned()-> Bool{
        
        return  dareMessageDetails.contains(where: {$0.childName == getChildName()})
        
    }
    
    
    
    func getDocumentIdofDareDetails() -> [String]{
        var documentId = ""
        var dareMessage = ""
        for item in self.dareMessageDetails{
            if(item.childName == getChildName()){
                documentId = item.documentId
                dareMessage = item.dareMessage
            }
        }
        return [documentId, dareMessage]
    }
    
    func updateDareMessage(updatedDareMessage: String){
        
        dataBase.collection("DareMessageDetails").document(getDocumentIdofDareDetails()[0])
            .setData(["dareMessage": updatedDareMessage, "childName": getChildName(),
                      "dateField": Date.timeIntervalSinceReferenceDate,
                     ], merge: true) { (error) in
                if let e = error {
                    print("There was and issue, \(e)")
                    print("There was and issue")
                }else{
                    DispatchQueue.main.async {
                        
                    }
                    print("SuccessFully send the players list")
                }
            }
    }
    
    
    func getDareMessage(){
        dataBase.collection("DareMessageDetails")
            .order(by: "dateField")
            .addSnapshotListener{ (querySnapshot , error ) in
                
                if let e = error {
                    print("There was an issue retrieving data from firestore \(e)")
                }else{
                    if let snapShotDocuments =  querySnapshot?.documents {
                        self.dareMessageDetails = []
                        
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let dareMessage = data["dareMessage"] as? String , let childName = data["childName"] as? String
                                , let documentId = data["documentId"] as? String, let dareCompletionStatus = data["dareCompletionStatus"] as? String
                            {
                                
                                self.dareMessageDetails.append(DareMessageModel(childName: childName, dareMessage: dareMessage, documentId: documentId))
                            }
                        }
                        DispatchQueue.main.async {
                            
                        }
                        
                    }
                }
            }
    }
    
  
    
    func resetTheGame(){
        print("resetTheGame")
        for item in self.dareMessageDetails{
            dataBase.collection("DareMessageDetails").document(item.documentId).delete()
        }
        for item in self.momChildNameFromDB{
            dataBase.collection("MomChildList").document(item.documentId).delete()
        }
        for item in self.playerDetails{
            dataBase.collection("PlayerDetails").document(item.documentId).delete()
        }
        self.dareMessageDetails = []
        self.momChildNameFromDB = []
        self.playerDetails = []
        
        
    }
    
   
    
}


//
//  Member.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

//import Foundation
//// MARK: - Member Model
//import SwiftUI
//import PhotosUI
//import Observation
//
//struct Member: Identifiable {
//    let id = UUID()
//    var name: String
//    var age: String
//    var gender: String
//    var phone: String
//    var address: String
//    var profileImage: UIImage?
//    var membershipPlan: String = "Premium"
//    var membershipMonths: String = "1"
//    var startDate: Date = Date()
//    var endDate: Date = Date().addingTimeInterval(2592000)
//    var paymentMethod: String = "Cash"
//    var amountPaid: String = ""
//    var emergencyContact: String = ""
//    var emergencyPhone: String = ""
//    var bloodGroup: String = "O+"
//    var notes: String = ""
//    var totalAmount: Double = 0
//    var amountDue: Double = 0
//    var paymentStatus: String = "Pending"
//}
//
//// MARK: - Members View Model
//@Observable
//class MembersViewModel {
//    var members: [Member] = []
//    
//    func addMember(_ member: Member) {
//        members.append(member)
//    }
//    
//    func removeMember(at indices: IndexSet) {
//        members.remove(atOffsets: indices)
//    }
//}
import Foundation
import SwiftUI
import PhotosUI
import Observation

struct Member: Identifiable {
    let id = UUID()
    var name: String
    var age: String
    var gender: String
    var phone: String
    var address: String
    var profileImage: UIImage?
    var membershipPlan: String = "Premium"
    var membershipMonths: String = "1"
    var startDate: Date = Date()
    var endDate: Date = Date().addingTimeInterval(2592000)
    var paymentMethod: String = "Cash"
    var amountPaid: String = ""
    var emergencyContact: String = ""
    var emergencyPhone: String = ""
    var bloodGroup: String = "O+"
    var notes: String = ""
    var totalAmount: Double = 0
    var amountDue: Double = 0
    var paymentStatus: String = "Pending"
}

@Observable
class MembersViewModel {
    var members: [Member] = []
    
    func addMember(_ member: Member) {
        members.append(member)
    }
    
    func removeMember(at indices: IndexSet) {
        members.remove(atOffsets: indices)
    }
}

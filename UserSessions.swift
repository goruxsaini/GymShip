//
//  UserSessions.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

import Foundation
import SwiftUI

struct UserSession {
    @AppStorage("GymShip.savedEmail") static var savedEmail: String = ""
    @AppStorage("GymShip.savedPassword") static var savedPassword: String = ""
    @AppStorage("GymShip.savedUsername") static var savedUsername: String = ""
    @AppStorage("GymShip.savedMobile") static var savedMobile: String = ""
    @AppStorage("GymShip.isLoggedIn") static var isLoggedIn: Bool = false
}

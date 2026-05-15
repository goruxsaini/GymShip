//
//  SettingView.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

//
//  SettingsView.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

import SwiftUI

struct SettingsView: View {

    // Persist gym info
    @AppStorage("GymShip.gymName") private var gymName: String = ""
    @AppStorage("GymShip.gymAddress") private var gymAddress: String = ""
    @AppStorage("GymShip.ownerName") private var ownerName: String = ""
    @AppStorage("GymShip.contactNumber") private var contactNumber: String = ""

    // Persist login state
    @AppStorage("GymShip.isLoggedIn") private var isLoggedIn: Bool = false

    @State private var notificationsEnabled: Bool = true
    @State private var autoRenewAlerts: Bool = true
    @State private var selectedCurrency: String = "INR"

    let currencies = ["INR", "USD", "EUR", "GBP"]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    // MARK: - GYM INFO SECTION
                    VStack(spacing: 16) {
                        SectionHeader(title: "Gym Information", icon: "building.2.fill")

                        FormTextField(
                            label: "Gym Name",
                            placeholder: "Enter gym name",
                            text: $gymName,
                            icon: "building.2"
                        )

                        FormTextField(
                            label: "Gym Address",
                            placeholder: "Enter address",
                            text: $gymAddress,
                            icon: "location.fill"
                        )

                        FormTextField(
                            label: "Owner Name",
                            placeholder: "Enter owner's name",
                            text: $ownerName,
                            icon: "person.fill"
                        )

                        FormTextField(
                            label: "Contact Number",
                            placeholder: "Enter phone number",
                            text: $contactNumber,
                            icon: "phone.fill",
                            keyboardType: .numberPad
                        )
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)



                    // MARK: - APP SETTINGS
                    VStack(spacing: 16) {
                        SectionHeader(title: "App Preferences", icon: "gearshape.fill")

                        Toggle(isOn: $notificationsEnabled) {
                            Label("Enable Notifications", systemImage: "bell.fill")
                                .foregroundStyle(.black)
                        }
                        .tint(.main)

                        Toggle(isOn: $autoRenewAlerts) {
                            Label("Renewal Alerts", systemImage: "exclamationmark.bubble.fill")
                                .foregroundStyle(.black)
                        }
                        .tint(.main)

                        FormTextField(
                            label: "Currency",
                            placeholder: "Select",
                            text: $selectedCurrency,
                            icon: "indianrupeesign",
                            isDropdown: true,
                            items: currencies
                        )
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)



                    // MARK: - LOGOUT BUTTON
                    VStack(spacing: 16) {
                        SectionHeader(title: "Account", icon: "person.crop.circle.badge.xmark")

                        Button {
                            isLoggedIn = false   // Works now
                        } label: {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                Text("Logout")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .foregroundStyle(.red)
                            .padding(16)
                            .background(Color.red.opacity(0.08))
                            .cornerRadius(12)
                        }
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)



                    // MARK: - RESET ALL DATA
                    VStack(spacing: 16) {
                        SectionHeader(title: "Danger Zone", icon: "exclamationmark.triangle.fill")

                        Button(role: .destructive) {
                            resetAppData()
                        } label: {
                            HStack {
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                Text("Reset All App Data")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .foregroundStyle(.red)
                            .padding(16)
                            .background(Color.red.opacity(0.08))
                            .cornerRadius(12)
                        }
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)

                }
                .padding(16)
            }
            .navigationTitle(gymName.isEmpty ? "Settings" : gymName)
            .navigationBarTitleDisplayMode(.automatic)
        }
    }


    // MARK: - Reset Function
    private func resetAppData() {
        gymName = ""
        gymAddress = ""
        ownerName = ""
        contactNumber = ""
    }
}

#Preview {
    SettingsView()
}

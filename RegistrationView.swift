//
//  RegistrationView.swift
//  GymShip
//
//  Created by Goru Saini on 08/10/25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var mobile = ""
    @Environment(\.presentationMode) var presentationMode

    @State private var showAlert = false
    @State private var alertMessage = ""

    @AppStorage("GymShip.savedEmail") private var savedEmail = ""
    @AppStorage("GymShip.savedPassword") private var savedPassword = ""
    @AppStorage("GymShip.savedUsername") private var savedUsername = ""
    @AppStorage("GymShip.savedMobile") private var savedMobile = ""
    // DO NOT auto-login here

    var body: some View {
        VStack{
            Spacer()

            Text("Create your account")
                .font(.title)
                .fontWeight(.semibold)

            Image("ThemePicture")
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
                .frame(width: 200)

            VStack{
                TextField("Enter the email", text: $email)
                    .modifier(TextFieldViewModifier())

                TextField("Enter the mobile number", text: $mobile)
                    .modifier(TextFieldViewModifier())

                TextField("Enter the username", text: $username)
                    .modifier(TextFieldViewModifier())

                SecureField("Enter the password", text: $password)
                    .modifier(TextFieldViewModifier())
            }

            Button {
                validateRegistration()
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 352, height: 44)
                    .background(Color.main)
                    .cornerRadius(8)
            }
            .padding(.vertical)

            Spacer()
            Divider()

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign In").fontWeight(.semibold)
                }
                .font(.footnote)
                .foregroundStyle(.black)
                .padding(.top)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    // MARK: - Registration Validation
    private func validateRegistration() {
        guard email.contains("@"), email.contains(".") else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }

        guard password.count >= 6 else {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            return
        }

        guard !username.isEmpty else {
            alertMessage = "Username cannot be empty."
            showAlert = true
            return
        }

        guard mobile.count >= 10 else {
            alertMessage = "Please enter a valid mobile number."
            showAlert = true
            return
        }

        // Save user credentials
        savedEmail = email
        savedPassword = password
        savedUsername = username
        savedMobile = mobile

        // GO BACK TO LOGIN SCREEN
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    RegistrationView()
}

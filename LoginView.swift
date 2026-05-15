//
//  LoginView.swift
//  GymShip
//
//  Created by Goru Saini on 08/10/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    @AppStorage("GymShip.savedEmail") private var savedEmail = ""
    @AppStorage("GymShip.savedPassword") private var savedPassword = ""
    @AppStorage("GymShip.isLoggedIn") private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Image("ThemePicture")
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .frame(width: 200)

                VStack {
                    TextField("Enter your email", text: $email)
                        .modifier(TextFieldViewModifier())

                    SecureField("Enter your password", text: $password)
                        .modifier(TextFieldViewModifier())
                }

                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                Button {
                    validateLogin()
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 44)
                        .background(Color.main)
                        .cornerRadius(8)
                }

                Spacer()
                Divider()

                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up").fontWeight(.semibold)
                    }
                }
                .foregroundStyle(.black)
                .font(.footnote)
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

    // MARK: - Login Validation
    private func validateLogin() {
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

        guard email == savedEmail && password == savedPassword else {
            alertMessage = "Email or password is incorrect."
            showAlert = true
            return
        }

        isLoggedIn = true
    }
}

#Preview {
    LoginView()
}

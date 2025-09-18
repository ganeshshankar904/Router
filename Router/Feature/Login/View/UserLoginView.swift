//
//  UserLoginView.swift
//  Router
//
//  Created by ganesh shankar on 14/09/25.
//

import SwiftUI

struct UserLoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 32) {
                    // Header
                    VStack(spacing: 16) {
                        Text("Login")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 40)
                        
                        Text("Add your details to login")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    
                    // Input fields
                    VStack(spacing: 20) {
                        // Email field
                        TextField("Your Email", text: $email)
                            .font(.system(size: 16))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal, 32)
                        
                        // Password field
                        SecureField("Password", text: $password)
                            .font(.system(size: 16))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal, 32)
                    }
                    
                    // Login button
                    Button(action: {
                        // Login action
                    }) {
                        Text("Login")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 1.0, green: 0.4, blue: 0.2),
                                        Color(red: 1.0, green: 0.5, blue: 0.3)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                    }
                    .padding(.horizontal, 32)
                    
                    // Forgot password
                    Button(action: {
                        // Forgot password action
                    }) {
                        Text("Forgot your password?")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 8)
                    
                    // Divider text
                    Text("or Login With")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.top, 32)
                    
                    // Social login buttons
                    VStack(spacing: 16) {
                        // Facebook login
                        Button(action: {
                            // Facebook login action
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "f.cursive")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                
                                Text("Login with Facebook")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.23, green: 0.52, blue: 0.89),
                                        Color(red: 0.31, green: 0.58, blue: 0.91)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                        }
                        .padding(.horizontal, 32)
                        
                        // Google login
                        Button(action: {
                            // Google login action
                        }) {
                            HStack(spacing: 12) {
                                Text("G+")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Login with Google")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.87, green: 0.28, blue: 0.22),
                                        Color(red: 0.91, green: 0.35, blue: 0.28)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                        }
                        .padding(.horizontal, 32)
                    }
                    
                    Spacer(minLength: 60)
                    
                    // Sign up link
                    HStack {
                        Text("Don't have an Account?")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Sign up action
                        }) {
                            Text("Sign Up")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // Bottom indicator
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.black)
                        .frame(width: 134, height: 5)
                        .padding(.bottom, 20)
                }
            }
        }
        .background(Color.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        UserLoginView()
    }
}

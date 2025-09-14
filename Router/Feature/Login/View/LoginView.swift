//
//  LoginView.swift
//  Router
//
//  Created by ganesh shankar on 13/09/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(Router.self) var router
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient - top half with rounded bottom
                VStack(spacing: 0) {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1.0, green: 0.4, blue: 0.2),
                            Color(red: 1.0, green: 0.5, blue: 0.3),
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: geometry.size.height / 2)
                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])

                    Color.clear
                        .frame(height: geometry.size.height / 2)
                }
                .ignoresSafeArea()
                .shadow(radius: 10)

                // Background circles for decoration
                                VStack {
                                    HStack {
                                        Circle()
                                            .fill(Color.white.opacity(0.1))
                                            .frame(width: 200, height: 180)
                                            .offset(x: -60, y: -80)
                                        Spacer()
                                        Circle()
                                            .fill(Color.white.opacity(0.15))
                                            .frame(width: 180, height: 180)
                                            .offset(x: 40, y: -100)
                                    }
                                    HStack {
                                        Circle()
                                            .fill(Color.white.opacity(0.1))
                                            .frame(width: 280, height: 180)
                                            .offset(x: -90, y: 20)
                                        Spacer()
                                        Circle()
                                            .fill(Color.white.opacity(0.15))
                                            .frame(width: 80, height: 80)
                                            .offset(x: -40, y: -80)
                                    }
                                    HStack{
                                        Circle()
                                            .fill(Color.white.opacity(0.1))
                                            .frame(width: 120, height: 120)
                                            .offset(x: -100, y: -320)
                                    }
                                    Spacer()
                                    
                                }

                VStack(spacing: 0) {
                    Spacer()

                    // White card container
                    VStack(spacing: 0) {
                        // Monkey logo
                        VStack(spacing: 16) {
                            ZStack {
                                Image("Monkey")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())  // makes it circular
                                    .overlay(
                                        Circle().stroke(
                                            Color.white,
                                            lineWidth: 10
                                        )  // optional border
                                    )
                                    .shadow(radius: 10)  // optional shadow
                                //                                }
                            }
                            .offset(y: -40)
                        }

                        // White content area
                        VStack(spacing: 24) {
                            VStack(spacing: 8) {
                                HStack(spacing: 4) {
                                    Text("Meal")
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.orange)
                                    Text("Monkey")
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.black)
                                }

                                Text("FOOD DELIVERY")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                    .tracking(2)
                            }

                            Text(
                                "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
                            )
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .lineSpacing(4)

                            VStack(spacing: 16) {
                                // Login button
                                Button(action: {
                                    // Login action
                                    router.navigate(to: .userLogin)
                                }) {
                                    Text("Login")
                                        .font(
                                            .system(size: 18, weight: .semibold)
                                        )
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(
                                                        red: 1.0,
                                                        green: 0.4,
                                                        blue: 0.2
                                                    ),
                                                    Color(
                                                        red: 1.0,
                                                        green: 0.5,
                                                        blue: 0.3
                                                    ),
                                                ]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(28)
                                }
                                .padding(.horizontal, 32)

                                // Create account button
                                Button(action: {
                                    // Create account action
                                }) {
                                    Text("Create an Account")
                                        .font(
                                            .system(size: 18, weight: .semibold)
                                        )
                                        .foregroundColor(.orange)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(Color.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 28)
                                                .stroke(
                                                    Color.orange,
                                                    lineWidth: 2
                                                )
                                        )
                                }
                                .padding(.horizontal, 32)
                            }

                            // Bottom indicator
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.black)
                                .frame(width: 134, height: 5)
                                .padding(.top, 16)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 3)
                        .background(Color.white)
                        .cornerRadius(24, corners: [.topLeft, .topRight])
                    }
                }
            }
        }
    }
}

// Extension to apply corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    LoginView()
        .environment(Router())
}

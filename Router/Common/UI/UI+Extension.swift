//
//  UI+Extension.swift
//  Router
//
//  Created by ganesh shankar on 14/09/25.
//
import SwiftUI

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
extension LinearGradient {
    static let primaryOrange = LinearGradient(
        gradient: Gradient(colors: [
            Color("PrimaryOrangeStart"),
            Color("PrimaryOrangeEnd")
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
}

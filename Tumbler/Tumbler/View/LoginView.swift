//
//  LoginView.swift
//  Tumbler
//
//  Created by Carol Liu on 11/8/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            //TODO: Font size seems a bit off
            Text("Tumbler -> . Trip Planner")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding()
                .accessibilityIdentifier("text-title")
            Text("Keep on tripping over your plans")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .accessibilityIdentifier("text-description")
            Spacer()
            Button(action: {}) {
                HStack {
                    Image(systemName: "apple.logo")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Sign in with Apple")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(width: 300, height: 35)
            }
            .buttonStyle(.borderedProminent)
            .tint(.black)
            .accessibilityIdentifier("button-signInApple")
            Spacer()
        }
        //TODO: Center the image
        .background(Image("loginPhoto")
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(width: 570, height: 890)
            .clipped()
            .brightness(-0.2)
            .accessibilityIdentifier("image-background")
        )
    }
}

#Preview {
    LoginView()
}

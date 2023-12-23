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
                .accessibilityIdentifier("title-text")
            Text("Keep on tripping over your plans")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .accessibilityIdentifier("description-text")
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
            .accessibilityIdentifier("sign-in-apple-button")
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
            .accessibilityIdentifier("background-image")
        )
    }
}

#Preview {
    LoginView()
}

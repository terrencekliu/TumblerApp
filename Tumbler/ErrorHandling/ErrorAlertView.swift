//
//  ErrorAlertView.swift
//  Tumbler
//
//  Created by Terrence Liu on 3/5/24.
//

import SwiftUI

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(
            isPresented: .constant(localizedAlertError != nil),
            error: localizedAlertError
        ) { _ in
            Button(buttonTitle) { error.wrappedValue = nil }
        } message: { error in Text(error.recoverySuggestion ?? "") }
    }
}

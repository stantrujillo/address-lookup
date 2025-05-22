//
//  TextField.swift
//  address-lookup
//
//  Created by Stan Trujillo on 22/05/2025.
//

import SwiftUI
import Combine

// Source: https://stackoverflow.com/questions/66164898/swiftui-combine-debounce-textfield

class TextFieldObserver : ObservableObject {
    @Published var debouncedText = ""
    @Published var searchText = ""

    private var subscriptions = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] txt in
                self?.debouncedText = txt
            } )
            .store(in: &subscriptions)
    }
}

struct TextFieldWithDebounce : View {
    @Binding var debouncedText : String
    @StateObject private var textObserver = TextFieldObserver()

    var body: some View {

        VStack {
            TextField("Search for address", text: $textObserver.searchText)
                .frame(height: 30)
                .padding(.leading, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .padding(.horizontal, 20)
        }.onReceive(textObserver.$debouncedText) { (txt) in
            debouncedText = txt
        }
    }
}

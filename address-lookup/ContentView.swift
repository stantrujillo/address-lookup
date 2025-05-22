//
//  ContentView.swift
//  address-lookup
//
//  Created by Stan Trujillo on 22/05/2025.
//

import SwiftUI
import Combine
import CoreLocation

struct ContentView: View {

    private let geocoder = CLGeocoder()
    @State var searchText = ""
    @State var results = ""

    var body: some View {
        VStack(alignment: .leading) {
            TextFieldWithDebounce(debouncedText: $searchText.onChange({ searchPhrase in
                if searchPhrase.count > 2 {
                    forwardGeocoding(address: searchPhrase)
                }
            }))

            Text(results).padding()

            Spacer()
        }
        .padding()
    }

    func forwardGeocoding(address: String) {

        geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in

            if let error {
                results = "Error:\n\(error.localizedDescription))"
                return
            }

            guard let placemarks else {
                results = "No results"
                return
            }

            var rows: [String] = []
            placemarks.forEach {
                if  let coordinate = $0.location?.coordinate {

                    let lat = coordinate.latitude.rounded(toPlaces: 3)
                    let long = coordinate.longitude.rounded(toPlaces: 3)
                    let location = "[\(lat),\(long)]"

                    let rowData = [$0.name, $0.administrativeArea, $0.postalCode, $0.country, location].compactMap {$0}

                    rows.append(rowData.joined(separator: ", "))
                }
            }
            results = rows.joined(separator: "\n")
        })
    }
}

#Preview {
    ContentView()
}

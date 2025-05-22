### `address-lookup`

Simple SwiftUI app that uses CLGeocoder.geocodeAddressString to perform "forward geocoding."

Given a string, geocodeAddressString responds with a list of CLPlacemark objects, which includes, among other things, the latitude and longitude of the address.

(In practice this method almost never returns more than one CLPlacemark per request.)

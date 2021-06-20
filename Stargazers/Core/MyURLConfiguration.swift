import Foundation

struct MyURLConfiguration {
    let service: MyURLService
    let baseUrl: String

    init(service: MyURLService,
         baseUrl: String) {
        self.service = service
        self.baseUrl = baseUrl
    }
}

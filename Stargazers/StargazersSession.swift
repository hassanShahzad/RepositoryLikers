import Foundation

enum StargazersSession {
    static var configuration = MyURLConfiguration(service: MyURLService(),
                                                 baseUrl: MyConstants.URL.base)
    static var wireframe = Wireframe(configuration: configuration)
}

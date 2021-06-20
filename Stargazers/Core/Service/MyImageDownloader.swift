import Foundation
import UIKit

protocol MyImageProtocol {
    func downloadImage(from link: String?,
                       completion: @escaping (_ image: UIImage?) -> Void)
}

struct MyImageDownloader {
    private let service: MyURLService
    private let cache: MyCacheable

    init(service: MyURLService,
         cache: MyCacheable = DefaultCache()) {
        self.service = service
        self.cache = cache
    }

    func makeRequest(with url: URL,
                     completion: @escaping (_ image: UIImage?) -> Void) {
        (cache.object(for: url.absoluteString) as? UIImage)
            .fold(some: { cached(image: $0, completion: completion) },
                  none: { perform(url: url, completion: completion) })
    }
}

private extension MyImageDownloader {
    func cached(image: UIImage,
                completion: @escaping (_ image: UIImage?) -> Void) {
        completion(image)
    }

    func perform(url: URL,
                 completion: @escaping (_ image: UIImage?) -> Void) {
        service.performTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == MyConstants.URL.statusCodeOk,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            cache.set(obj: image, for: url.absoluteString)
            completion(image)
        }
    }
}

extension MyImageDownloader: MyImageProtocol {
    func downloadImage(from link: String?,
                       completion: @escaping (_ image: UIImage?) -> Void) {
        guard let imageUrl = link?.url else {
            completion(nil)
            return
        }

        makeRequest(with: imageUrl,
                    completion: completion)
    }
}

private extension String {
    var url: URL? {
        return [self]
            .compactMap({ URL(string: $0) })
            .first ?? nil
    }
}

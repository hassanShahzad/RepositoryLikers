import XCTest
@testable import Stargazers

class MyCacheServiceTests: XCTestCase {
    func testSetObjectForKey_triggeringExpiration_shoudlReturnNil() {
        let cache = MyCacheService(expiration: 0)
        let item = MCacheableItem(value: Data())
        cache.set(obj: item, for: "key")
        XCTAssertNil(cache.object(for: "key"))
    }
    
    func testSetObjectForKey_noTriggeringExpiration_shoudlReturnValue() {
        let cache = MyCacheService(expiration: 10)
        let item = MCacheableItem(value: Data())
        cache.set(obj: item, for: "key")
        XCTAssertNotNil(cache.object(for: "key"))
    }
    
    func testGetObject_forNotSetKey_shoudlReturnNil() {
        let cache = MyCacheService(expiration: 0)
        XCTAssertNil(cache.object(for: "key"))
    }
    
    func testValidDateShouldReturnTrue() {
        XCTAssertTrue(Date().isValid(TimeInterval(10)))
    }
    
    func testValidDateShouldReturnFalse() {
        XCTAssertFalse(Date().isValid(TimeInterval(0)))
    }
}



import XCTest
@testable import QTickets
class RegistrationTests: XCTestCase {
    
    var sut: URLSession!
    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }


    // Asynchronous test: success fast, failure slow
    func testValidHTTPStatusCode200() {
      // given
      let url =
        URL(string:  "\(APIURL.REG_URL)firstname=\("Hitendra")&lastname=&prefix=&phone=\("9876543234")&mailid=\("hitendraios07@gmail.com")&pwd=\("Server@123")&confirmpwd=\("Server@123")&fid=&nationality=&dob=&gender=&source=4&token=")
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }
    
    func testCompletes() {
      // given
      let url =
        URL(string: "\(APIURL.REG_URL)firstname=\("Hitendra")&lastname=&prefix=&phone=\("9876543234")&mailid=\("hitendraios07@gmail.com")&pwd=\("Server@123")&confirmpwd=\("Server@123")&fid=&nationality=&dob=&gender=&source=4&token=")
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }

    func test_RegisterResults_ParsesData() {
     
      let url =
        URL(string: "\(APIURL.REG_URL)firstname=\("Hitendra")&lastname=&prefix=&phone=\("9876543234")&mailid=\("hitendraios07@gmail.com")&pwd=\("Server@123")&confirmpwd=\("Server@123")&fid=&nationality=&dob=&gender=&source=4&token=")
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        if let error = error {
            print(error.localizedDescription)
        } else if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 {
           XCTAssertNotNil(response)
        }
        promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
       
        
    }


}

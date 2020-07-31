/

import XCTest
@testable import QTickets
class QTicketsTests: XCTestCase {
    
    func testLoginScreen(){
        let loginInctance = LoginVC()
        loginInctance.loginViewModel.APICall(url:  "\(APIURL.LOGIN_URL)username=\("hitendraios07@gmail.com")&password=\("Server@123")&source=4&token=") { (responseData) in
            XCTAssertNotNil(responseData)
        }
    }
    
    func testSignUpScreen(){
        let registerInstance = RegistrationVC()
        registerInstance.registrationViewModel.APICall(url: "\(APIURL.BASE_URL + APIURL.REG_URL)firstname=\( "Hitendra")&lastname=&prefix=&phone=\("78787878")&mailid=\("hitendraios07@gmail.com")&pwd=\("Server@123")&confirmpwd=\("Server@123")&fid=&nationality=&dob=&gender=&source=4&token=") { (responseData) in
             XCTAssertNotNil(responseData)
        }
    }
    
    func testHomeCountryListScreen(){
        let homeInstance = HomeVC()
        // Country List api
        homeInstance.homeCountryListModels.APICall(url: "\("http://94.237.48.114/api/Common/CountryList")") { (responseData) in
             XCTAssertNotNil(responseData)
        }
    }
    
    
    
    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}

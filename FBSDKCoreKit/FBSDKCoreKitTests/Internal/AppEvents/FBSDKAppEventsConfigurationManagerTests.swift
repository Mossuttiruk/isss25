// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class FBSDKAppEventsConfigurationManagerTests: XCTestCase {

  let store = UserDefaultsSpy()
  let settings = TestSettings()
  let requestFactory = TestGraphRequestFactory()
  let connectionFactory = TestGraphRequestConnectionFactory()

  override class func setUp() {
    super.setUp()

    AppEventsConfigurationManager.reset()
  }

  override func setUp() {
    super.setUp()

    AppEventsConfigurationManager.configure(
      store: store,
      settings: settings,
      graphRequestFactory: requestFactory,
      graphRequestConnectionFactory: connectionFactory
    )
  }

  override func tearDown() {
    super.tearDown()

    AppEventsConfigurationManager.reset()
  }

  // MARK: - Dependencies

  func testDefaultDependencies() {
    AppEventsConfigurationManager.reset()

    XCTAssertNil(
      AppEventsConfigurationManager.shared.store,
      "Should not have a data store by default"
    )
    XCTAssertNil(
      AppEventsConfigurationManager.shared.settings,
      "Should not have a settings by default"
    )
    XCTAssertNil(
      AppEventsConfigurationManager.shared.requestFactory,
      "Should not have a graph request factory by default"
    )
    XCTAssertNil(
      AppEventsConfigurationManager.shared.connectionFactory,
      "Should not have a graph request connection factory by default"
    )
  }

  func testConfiguringWithDependencies() {
    XCTAssertTrue(
      AppEventsConfigurationManager.shared.store === store,
      "Should be able to configure with a persistent data store"
    )
    XCTAssertEqual(
      AppEventsConfigurationManager.shared.settings as? TestSettings,
      settings,
      "Should be able to configure with custom settings"
    )
    XCTAssertEqual(
      AppEventsConfigurationManager.shared.requestFactory as? TestGraphRequestFactory,
      requestFactory,
      "Should be able to configure with a custom graph request provider"
    )
    XCTAssertEqual(
      AppEventsConfigurationManager.shared.connectionFactory as? TestGraphRequestConnectionFactory,
      connectionFactory,
      "Should be able to configure with a custom graph request connection provider"
    )
  }

  // MARK: - Parsing

  func testParsingResponses() {
    for _ in 0..<100 {
      AppEventsConfigurationManager._processResponse(RawAppEventsConfigurationResponseFixtures.random, error: nil)
    }
  }
}

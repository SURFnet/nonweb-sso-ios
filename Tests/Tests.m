//
//  Tests.m
//  Tests
//
//  Created by Johan Kool on 3/11/15.
//  Copyright © 2015 Surfnet. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SSOService.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    UIViewController *aViewController = [[UIViewController alloc] init];

    UIViewController *authorizationViewController = [SSOService authorizationViewControllerForConsumerId:@"consumer id" endpoint:@"endpoint" completionHandler:^(NSString *token, NSError *error) {
        if (token) {
            // Success
        } else if (error) {
            // Failure
        }
    }];
    [aViewController presentViewController:authorizationViewController animated:YES completion:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

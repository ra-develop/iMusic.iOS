//
//  ArtistTests.m
//  iMusicTests
//
//  Created by RA on 15/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Artist.h"

@interface ArtistTests : XCTestCase

@end

@implementation ArtistTests {
    NSUInteger artistID;
    NSString *artistName;
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    artistID = 100;
    artistName = @"Metallica";
}

//- (void)tearDown {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//}
//
//- (void)testExample {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//}
//
//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testInitWithIDName {

    
    Artist *artist = [[Artist alloc] initWithID:artistID name:artistName];
    
    XCTAssertEqual(artist.artistID, artistID);
    XCTAssertEqualObjects(artist.artistName, artistName);
}

-(void)testArtistConvienceInitialiser {
    Artist *artist = [[Artist alloc] initWithID:artistID name:artistName];
    XCTAssertEqual(artist.artistID, artistID);
    XCTAssertEqualObjects(artist.artistName, artistName);
}

-(void)testAdoptNSCoding {
    Artist *artist = [[Artist alloc] initWithID:artistID name:artistName];
    XCTAssertTrue([artist conformsToProtocol:@protocol(NSCoding)], @"Arist does not adopt NSCoding");
}

@end

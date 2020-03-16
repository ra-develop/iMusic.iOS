//
//  AlbumIntTest.m
//  iMusicTests
//
//  Created by RA on 16/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Album.h"

@interface AlbumIntTest : XCTestCase

@end

@implementation AlbumIntTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iMusic" ofType:@"data"];
    NSURL *sourceURL = [NSURL fileURLWithPath:path];
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *destinationURL = [[urls lastObject] URLByAppendingPathComponent:@"iMusic.data"];
    [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:nil];
    [[NSFileManager defaultManager] copyItemAtURL:sourceURL toURL:destinationURL error:nil];
}

-(void)testFindAll {
    NSArray *albums = [Album findAllAlbums];
    NSUInteger expectedCount = 12;
    XCTAssertEqual([albums count], expectedCount);
}

-(void)testSaveAlbum {
    NSUInteger originalAlbumCount = [[Album findAllAlbums] count];
    
    Artist *theBeatles = [Artist artistWithID:1000 name:@"The Beatles"];
    
    Album *abbeyRoad = [[Album alloc] init];
    
    abbeyRoad.albumID = 2000;
    abbeyRoad.albumName = @"Abbey Road";
    abbeyRoad.artist = theBeatles;
    
    [abbeyRoad saveAlbum];
    NSArray *albums = [Album findAllAlbums];
    NSArray *albumNames = [albums valueForKeyPath:@"albumName"];
    XCTAssertTrue([albumNames containsObject:@"Abbey Road"]);
    XCTAssertEqual([albums count], originalAlbumCount + 1);
}

-(void)testDeleteAlbum {
    NSArray *albums = [Album findAllAlbums];
    NSUInteger origAlbumCount =[albums count];
    
    Album *album = [albums objectAtIndex:0];
    NSNumber *deleteAlbumID = [NSNumber numberWithUnsignedInteger:album.albumID];
    
    [album deleteAlbum];
    
    albums = [Album findAllAlbums];
    XCTAssertEqual([albums count], origAlbumCount - 1);
    NSArray *albumIDs = [albums valueForKeyPath:@"albumID"];
    XCTAssertFalse([albumIDs containsObject:deleteAlbumID]);
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

@end

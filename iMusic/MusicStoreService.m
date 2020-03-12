//
//  MisicStoreService.m
//  iMusic
//
//  Created by RA on 12/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import "MusicStoreService.h"
#import "Artist.h"
#import "Album.h"
#import "NSString+Additions.h"
#import "HTTPGetRequest.h"

#define ARTIST_ENDPOINT_FORMAT @"http://itunes.apple.com/search?term=%@&media=music&entity=musicArtist&attribute=artistTerm&limit=20"

//@interface MusicStoreService ()
//@property (nonatomic,strong) NSURLConnection *connection;
//@property (nonatomic,strong) NSMutableData *responseData;
//@property (nonatomic,strong) ServiceCompletionBlock completionBlock;
//@end

@implementation MusicStoreService

//@synthesize connection = _connection;
//@synthesize responseData = _responseDate;
//@synthesize completionBlock = _completionBlock;

- (void)findArtistByArtistName:(NSString *)artistName completionBlock:(ServiceCompletionBlock)completionBlock{

//    self.completionBlock = completionBlock;
//
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ARTIST_ENDPOINT_FORMAT, [artistName urlEncodedString]]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    self.responseData = [[NSMutableData alloc] init];
//    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ARTIST_ENDPOINT_FORMAT, [artistName urlEncodedString]]];
    
    SuccessBlock successBlock = ^(NSData *response) {

        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        // Data parsed correctly
        if (jsonDict) {
            NSMutableArray *artists = [NSMutableArray array];
            for (id artistDict in [jsonDict objectForKey:@"results"]) {
                NSInteger artistID = [[artistDict objectForKey:@"aritstId"] integerValue];
                NSString *artistName = [artistDict objectForKey:@"artistName"];
                [artists addObject:[Artist artistWithID:artistID name:artistName]];
            }
            completionBlock(artists, nil);
        } else {
            completionBlock(nil, error);
        }
    };
    
    FailureBlock failureBlock = ^(NSError *error) {
        completionBlock(nil, error);
    };
    
    HTTPGetRequest *request = [[HTTPGetRequest alloc] initWithURL:url successBlock:successBlock failureBlock:failureBlock];
    [request startRequest];
}

//- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response {
//    [self.responseData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
//    [self.responseData appendData:data];
//}
//
//-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
//    self.responseData = nil;
//    self.connection = nil;
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
////    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
////    NSLog(@"Response: %@", responseString);
//    NSError *error;
//    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
//    if (jsonDict) {
//        NSMutableArray *artists = [NSMutableArray array];
//        for (id artistDict in [jsonDict objectForKey:@"results"]) {
//            NSInteger artistID = [[artistDict objectForKey:@"artistID"] integerValue];
//            NSString *artistName = [artistDict objectForKey:@"artistName"];
//            [artists addObject:[Artist artistWithID:artistID name:artistName]];
//        }
//        self.completionBlock(artists, nil);
//    } else {
//        self.completionBlock(nil, error);
//    }
//}

- (void)loadAlbumsForArtist:(Artist *)artist completionBlock:(ServiceCompletionBlock)completionBlock{
    
}

- (void)fetchArtworkForAlbum:(Album *)album completionBlock:(ServiceCompletionBlock)completionBlock{
    
}

@end

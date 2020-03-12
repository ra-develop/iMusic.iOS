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

#define ARTIST_ENDPOINT_FORMAT @"http://itunes.apple.com/search?term=%@&media=music&entity=musicArtist&attribute=artistTerm&limit=20"

@interface MusicStoreService ()
@property (nonatomic,strong) NSURLConnection *connection;
@property (nonatomic,strong) NSMutableData *responseData;
@property (nonatomic,strong) ServiceCompletionBlock completionBlock;
@end

@implementation MusicStoreService

@synthesize connection = _connection;
@synthesize responseData = _responseDate;
@synthesize completionBlock = _completionBlock;

- (void)findArtistByArtistName:(NSString *)artistName completionBlock:(ServiceCompletionBlock)completionBlock{
    
    self.completionBlock = completionBlock;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ARTIST_ENDPOINT_FORMAT, [artistName urlEncodedString]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.responseData = [[NSMutableData alloc] init];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(nonnull NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(nonnull NSData *)data {
    [self.responseData appendData:data];
}

-(void)connection:(NSURLConnection *)theConnection didFailWithError:(nonnull NSError *)error {
    self.responseData = nil;
    self.connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
//    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"Response: %@", responseString);
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&error];
    if (jsonDict) {
        NSMutableArray *artists = [NSMutableArray array];
        for (id artistDict in [jsonDict objectForKey:@"results"]) {
            NSInteger artistID = [[artistDict objectForKey:@"artistID"] integerValue];
            NSString *artistName = [artistDict objectForKey:@"artistName"];
            [artists addObject:[Artist artistWithID:artistID name:artistName]];
        }
        self.completionBlock(artists, nil);
    } else {
        self.completionBlock(nil, error);
    }
}

- (void)loadAlbumsForArtist:(Artist *)artist completionBlock:(ServiceCompletionBlock)completionBlock{
    
}

- (void)fetchArtworkForAlbum:(Album *)album completionBlock:(ServiceCompletionBlock)completionBlock{
    
}

@end

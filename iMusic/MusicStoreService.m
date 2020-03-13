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
#import "NSDictionary+DateAdditions.h"

#define ARTIST_ENDPOINT_FORMAT @"http://itunes.apple.com/search?term=%@&media=music&entity=musicArtist&attribute=artistTerm&limit=20"
#define ALBUM_URL_FORMAT @"https://itunes.apple.com/lookup?entity=album&id=%lu"


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
                NSInteger artistID = [[artistDict objectForKey:@"artistId"] integerValue];
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
    

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ALBUM_URL_FORMAT, (unsigned long)artist.artistID]];
    
    SuccessBlock successBlock = ^(NSData *responseData) {

        //        NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        
        NSError *error;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        if (jsonDict) {
            NSMutableArray *albums =[NSMutableArray array];
            for (NSDictionary *albumDict in [jsonDict objectForKey:@"results"]) {
                if ([[albumDict objectForKey:@"wrapperType"] isEqualToString:@"collection"]) {
                    Album *album = [[Album alloc] init];
                    album.albumID = [[albumDict objectForKey:@"collectionId"] integerValue];
                    album.albumName = [albumDict objectForKey:@"collectionName"];
                    album.imageURLString =[albumDict objectForKey:@"artworkUrl100"];
                    album.price = [albumDict objectForKey:@"collectionPrice"];
                    album.iTunesURLString = [albumDict objectForKey:@"collectionViewUrl"];
                    album.genre = [albumDict objectForKey:@"primaryGenreName"];
                    album.releaseDate = [albumDict dateForKey:@"releaseDate"];
                    album.artist = artist;
                    [albums addObject:album];
                }
            }
            completionBlock(albums, nil);
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

- (void)fetchArtworkForAlbum:(Album *)album completionBlock:(ServiceCompletionBlock)completionBlock{
    NSURL *url = [NSURL URLWithString:album.imageURLString];
    
    SuccessBlock successBlock = ^(NSData *responseData){
        completionBlock([UIImage imageWithData:responseData], nil);
    };
    
    HTTPGetRequest *request = [[HTTPGetRequest alloc] initWithURL:url successBlock:successBlock failureBlock:NULL];
    [request startRequest];
}

@end

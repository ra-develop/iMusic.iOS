//
//  MisicStoreService.h
//  iMusic
//
//  Created by RA on 12/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Artist;
@class Album;

typedef void(^ServiceCompletionBlock)(id result, NSError *error);

@interface MusicStoreService : NSObject

- (void)findArtistByArtistName:(NSString *)artistName completionBlock:(ServiceCompletionBlock)completionBlock;

- (void)loadAlbumsForArtist:(Artist *)artist completionBlock:(ServiceCompletionBlock)completionBlock;

- (void)fetchArtworkForAlbum:(Album *)album completionBlock:(ServiceCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END

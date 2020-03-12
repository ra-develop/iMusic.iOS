//
//  HTTPGetRequest.h
//  iMusic
//
//  Created by RA on 12/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(NSData *response);
typedef void(^FailureBlock)(NSError *error);

@interface HTTPGetRequest : NSObject

- (id)initWithURL:(NSURL *)requestURL successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
- (void)startRequest;

@end

NS_ASSUME_NONNULL_END

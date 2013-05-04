//
//  NSTrendApi.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"

@protocol NSTrendApiDelegate <NSObject>
- (void)apiDidReturnError:(NSString*)error;
- (void)apiDidReturnResult:(NSDictionary*)json;
@end

@interface NSTrendApi : NSURLConnection

@property (nonatomic, unsafe_unretained) id<NSTrendApiDelegate> delegate;

+ (NSString *)bodyFromRequestParams:(NSRequestParams*)params;
- (void)call:(NSString *)api params:(NSRequestParams*)params;
- (void)didReturnData:(NSData*)data;
- (void)didReturnConnectionErrorWithStatusCode:(NSInteger)statusCode;


@end

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
@optional
- (void)apiDidReturnError:(NSString*)error;
- (void)apiDidReturnError:(NSString*)error WithIdentifier:(NSInteger)identifier;
- (void)apiDidReturnResult:(NSDictionary*)json;
- (void)apiDidReturnResult:(NSDictionary *)json WithIdentifier:(NSInteger)identifier;
@end

@interface NSTrendApi : NSURLConnection

@property (nonatomic, weak) id<NSTrendApiDelegate> delegate;
@property (nonatomic, assign) NSInteger identifier;

+ (NSString *)bodyFromRequestParams:(NSRequestParams*)params;
- (void)call:(NSString *)api params:(NSRequestParams*)params;
- (void)didReturnData:(NSData*)data;
- (void)didReturnConnectionErrorWithStatusCode:(NSInteger)statusCode;


@end

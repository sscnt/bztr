//
//  NSTrendApi.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"

@interface NSTrendApi : NSURLConnection

+ (void)call:(NSString *)api params:(NSRequestParams *)params addTarget:(id)target selector:(SEL)selector;

@end

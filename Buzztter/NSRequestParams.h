//
//  NSRequestParams.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRequestParams : NSObject

@property (nonatomic, assign) NSInteger min_rt;
@property (nonatomic, strong) NSString* user_id_string;
@property (nonatomic, strong) NSString* user_token;
@property (nonatomic, strong) NSString* user_token_secret;
@property (nonatomic, assign) NSInteger max_rt;
@property (nonatomic, assign) NSInteger min_fav;
@property (nonatomic, assign) NSInteger max_fav;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString* receipt;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* pin;

@end

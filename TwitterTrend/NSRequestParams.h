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
@property (nonatomic, assign) NSInteger max_rt;
@property (nonatomic, assign) NSInteger min_fav;
@property (nonatomic, assign) NSInteger max_fav;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString* api;

@end

//
//  NSFilterUsersFullData.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/20.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFilterUsersFullData : NSObject

@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* screen_name;

@end

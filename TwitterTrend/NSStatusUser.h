//
//  NSStatusUser.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStatusUser : NSDictionary

- (id)initWithJsonObject:(NSDictionary*)json;

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* screen_name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* profile_image_url;

@end

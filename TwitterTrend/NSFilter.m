//
//  NSFilter.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSFilter.h"

static NSFilter* _sharedFileter = nil;

@implementation NSFilter

+ (NSFilter*)sharedFilter
{
    @synchronized(self) {
        if (_sharedFileter == nil) {
            (void) [[self alloc] init];
        }
    }
    return _sharedFileter;
}


+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_sharedFileter == nil) {
            _sharedFileter = [super allocWithZone:zone];
            return _sharedFileter;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (BOOL)isDisplayable:(NSStatus *)status
{
    _status = status;
    if([self ifConatainNGWord] || [self ifNGUser]){
        
    }
}

- (BOOL)ifConatainNGWord
{
    
}
- (BOOL)ifNGUser
{
    
}

@end

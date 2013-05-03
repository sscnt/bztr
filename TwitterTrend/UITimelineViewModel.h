//
//  UIViewModel.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"

@interface UITimelineViewModel : NSObject
{
    NSArray* _statusesArray;
}

- (void)callApi:(NSString*)api params:(NSRequestParams*)params;
- (NSArray*)statusesOnPage:(NSInteger)page;

@end

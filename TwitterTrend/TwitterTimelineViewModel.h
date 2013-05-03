//
//  UIViewModel.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"
#import "NSTrendApi.h"
#import "NSStatus.h"

@protocol TwitterTimelineViewModelDelegate <NSObject>
- (void)didCallApi;
@end

@interface TwitterTimelineViewModel : NSObject
{
    NSMutableArray* _statusesArray;
}

- (void)callApi:(NSString*)api params:(NSRequestParams*)params;
- (void)didCallApi:(NSDictionary*)json;
- (NSMutableArray*)statusesOnPage:(NSInteger)page;

@end

//
//  TwitterTimelineViewUsersModel.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"
#import "NSTrendApi.h"

@protocol TwitterTimelineViewDeveloperModelDelegate <NSObject>
- (void)didFinishDeveloperBlockingWithMessage:(NSString*)message;
- (void)didReturnError:(NSString*)error;
@end

@interface TwitterTimelineViewDeveloperModel : NSObject <NSTrendApiDelegate>
{
    NSTrendApi* _api;
}

@property (nonatomic, weak) id<TwitterTimelineViewDeveloperModelDelegate> delegate;

- (void)developerBlockWithParams:(NSRequestParams*)params;

@end

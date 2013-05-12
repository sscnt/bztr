//
//  NSTrendApi.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSTrendApi.h"

@implementation NSTrendApi

+ (NSString *)bodyFromRequestParams:(NSRequestParams *)params
{
    NSString *bodyString = @"";
    
    //// Page
    if(params.page != -1){
        bodyString = [NSString stringWithFormat:@"%@=%d&%@",@"page",params.page,bodyString];
    }
    //// Fav
    if(params.min_fav != -1){
        bodyString = [NSString stringWithFormat:@"%@=%d&%@",@"min_fav",params.min_fav,bodyString];
    }
    if(params.max_fav != -1){
        bodyString = [NSString stringWithFormat:@"%@=%d&%@",@"max_fav",params.max_fav,bodyString];
    }
    //// RT
    if(params.min_rt != -1){
        bodyString = [NSString stringWithFormat:@"%@=%d&%@",@"min_rt",params.min_rt,bodyString];
    }
    if(params.max_rt != -1){
        bodyString = [NSString stringWithFormat:@"%@=%d&%@",@"max_rt",params.max_rt,bodyString];
    }
    
    //// Target User ID
    if(![params.user_id_string isEqualToString:@"0"]){
        bodyString = [NSString stringWithFormat:@"%@=%@&%@",@"target_user_id",params.user_id_string,bodyString];
    }
    
    //// Tokens
    if(![params.user_token_secret isEqualToString:@""]){
        bodyString = [NSString stringWithFormat:@"%@=%@&%@",@"user_token_secret",params.user_token_secret,bodyString];
    }
    if(![params.user_token isEqualToString:@""]){
        bodyString = [NSString stringWithFormat:@"%@=%@&%@",@"user_token",params.user_token,bodyString];
    }

    
    return bodyString;
}

- (void)call:(NSString *)api params:(NSRequestParams *)params
{
    //// General Declarations
    NSString* body = [NSTrendApi bodyFromRequestParams:params];
    NSString* url_string = [NSString stringWithFormat:@"http://trend.ssctech.jp/api/%@", api];
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    __weak NSTrendApi* _self = self;
    //// Send Request    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connection_error)
    {
        int statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if(connection_error || statusCode != 200){
            [_self didReturnConnectionErrorWithStatusCode:statusCode];
        } else {
            [_self didReturnData:data];
        }
    }];

}

- (void)didReturnConnectionErrorWithStatusCode:(NSInteger)statusCode
{
    NSString* message = @"";
    switch (statusCode) {
        case 0:
            message = @"インターネットに接続されていることを確認してください。";
            break;
        case 404:
            message = @"サーバーが見つかりません。App Storeで修正済みの最新バージョンがリリースされている可能性があります。";
            break;
        default:
            message = @"サーバーに接続できません。障害が発生している可能性があります。";
            break;
    }
    dlog(@"An error occured:%@", message);
    if(self.identifier){
        [self.delegate apiDidReturnError:message WithIdentifier:self.identifier];
        return;
    }
    [self.delegate apiDidReturnError:message];
}

- (void)didReturnData:(NSData *)data
{
    //// General Declarations
    id json = nil;
    NSString* message = @"予期せぬエラーです。";
    NSError *conversion_error = nil;
    
    //// Conversion
    json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&conversion_error];
    if(conversion_error){
        dlog(@"Conversion Error: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        message = @"データが壊れています。サーバーで障害が発生している可能性があります。";
    } else {
        if([json objectForKey:@"errors"] != nil){
            id errors = [json objectForKey:@"errors"];
            //if([[[errors class] description] rangeOfString:@"NSArray"].location != NSNotFound){
            if([errors isKindOfClass:[NSArray class]]){
                if(!errors || [errors count] > 0){
                    //// Error
                    dlog(@"An error occured:%@", [errors objectAtIndex:0]);
                    message = [errors objectAtIndex:0];
                } else {
                    //// Success
                    if(self.identifier){
                        [self.delegate apiDidReturnResult:json WithIdentifier:self.identifier];
                        return;
                    }
                    [self.delegate apiDidReturnResult:json];
                    return;
                }
            }else{
                //// Unexpected Error
                dlog(@"Unexpected Error:errors not array.");
                message = @"予期せぬエラーです。サーバーで障害が発生している可能性があります。";
            }
        } else {
            //// Unexpected Error
            dlog(@"Unexpected Error:errors not foound.");
            message = @"予期せぬエラーです。サーバーで障害が発生している可能性があります。";
        }
    }
    if(self.identifier){
        [self.delegate apiDidReturnError:message WithIdentifier:self.identifier];
        return;
    }
    [self.delegate apiDidReturnError:message];
}

- (void)dealloc
{
    self.delegate = nil;
}

@end

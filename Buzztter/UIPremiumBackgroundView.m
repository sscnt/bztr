//
//  UIPremiumBackgroundView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/31.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIPremiumBackgroundView.h"

@implementation UIPremiumBackgroundView

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 500.0f);
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _margin = 20.0f;
        _bottom = 0.0f;

        self.backgroundColor = [UIColor colorWithWhite:210.0f/255.0f alpha:1.0f];
        self.layer.masksToBounds = YES;
        
        UIPremiumDropShadowView* shadow = [[UIPremiumDropShadowView alloc] initWithFrame:CGRectMake(0.0f, -8.0f, self.bounds.size.width, 10.0f)];
        [self addSubview:shadow];
        
        //// Label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:16.0f];
        label.text = @"プレミアム機能の紹介・使い方";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        [label sizeToFit];
        [self appendView:label margin:16.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        label.text = @"・フィルタリング";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        [label sizeToFit];
        [self appendView:label margin:10.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-regular" size:14.0f];
        label.text = @"RT数・お気に入り登録数の上限・下限を指定できます。\n例）500RT以上のツイートのみ表示する\n右上のボタンから「ページ設定」画面へ移動し設定してください。";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self appendView:label margin:0.0f];
        
        UIPremiumSeparator* sep = [[UIPremiumSeparator alloc] init];
        [self appendView:sep margin:15.0f];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        label.text = @"・ページ閲覧制限の解除";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        [label sizeToFit];
        [self appendView:label margin:10.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-regular" size:14.0f];
        label.text = @"スタンダード会員は30ページ以降の閲覧ができませんが、プレミアム会員ならすべてのページを閲覧可能です。";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self appendView:label margin:0.0f];
        sep = [[UIPremiumSeparator alloc] init];
        [self appendView:sep margin:15.0f];

        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        label.text = @"・NGワード";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        [label sizeToFit];
        [self appendView:label margin:10.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-regular" size:14.0f];
        label.text = @"特定の単語を含むツイートを非表示にします。\n「メニュー」→「設定」ページで追加・削除できます。";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self appendView:label margin:0.0f];
        sep = [[UIPremiumSeparator alloc] init];
        [self appendView:sep margin:15.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        label.text = @"・ユーザー非表示";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        [label sizeToFit];
        [self appendView:label margin:10.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-regular" size:14.0f];
        label.text = @"特定のユーザーのツイートを非表示にします。ツイートのユーザー名をタップすると非表示にできます。\n「メニュー」→「設定」ページで解除できます。";
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [self appendView:label margin:0.0f];
        sep = [[UIPremiumSeparator alloc] init];
        [self appendView:sep margin:15.0f];
        
    }
    return self;
}

//// Adding View
- (void)appendView:(UIView *)view
{
    [self appendView:view margin:_margin];
}

- (void)appendView:(UIView *)view margin:(NSInteger)margin
{
    [view setY:(_bottom + margin)];
    [self addSubview:view];
    CGFloat bottom = view.frame.origin.y + view.frame.size.height;
    if(bottom > _bottom){
        _bottom = bottom;
    }
    [self setHeight:_bottom];
}

- (void)prependView:(UIView *)view
{
    [self prependView:view margin:_margin];
}

- (void)prependView:(UIView *)view margin:(NSInteger)margin
{
    
}

- (void)removeAllSubviews
{
    for(UIView* view in [self subviews]){
        if([view isKindOfClass:[UIImageView class]]){
            
        } else {
            [view removeFromSuperview];
        }
    }
    _bottom = 0.0f;
}

- (void)sizeToFit
{
    _bottom = 0.0f;
    for(UIView* view in [self subviews]){
        _bottom = MAX(view.bottom, _bottom);
    }
}



@end

//
//  UISettingsTableView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/25.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISettingsTableView.h"

@implementation UISettingsTableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bottomY = 0.0f;
    }
    return self;
}

- (void)setDelegate:(id<UISettingsTableViewDelegate>)delegate
{
    _delegate = delegate;
    NSInteger numCell = [self.delegate numberOfRowsInTableView:self];
    for(NSInteger i = 0;i < numCell;i++){
        UISettingsTableViewCell* cell = [self.delegate tableView:self cellForRowAtIndex:i];
        [self append:cell];
    }
    [self setHeight:_bottomY];
    [self setDropShadow];
}

- (void)append:(UIView *)view
{
    [view setY:_bottomY];
    [self addSubview:view];
    CGFloat bottomY = view.frame.origin.y + view.frame.size.height;
    if(bottomY > _bottomY){
        _bottomY = bottomY;
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _bottomY)];
    }
}

- (void)setDropShadow
{
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    [rectanglePath closePath];
    
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowPath = rectanglePath.CGPath;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end

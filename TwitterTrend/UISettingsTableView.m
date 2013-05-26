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
        _cells = [NSMutableArray array];
        _container = [[UISettingsTableViewContainer alloc] initWithFrame:self.bounds];
        [self addSubview:_container];
    }
    return self;
}

- (void)setDelegate:(id<UISettingsTableViewDelegate>)delegate
{
    _bottomY = 0.0f;
    for(UIView* view in [_container subviews]){
        [view removeFromSuperview];
    }
    _delegate = delegate;
    NSInteger numCell = [self.delegate numberOfRowsInTableView:self];
    for(NSInteger i = 0;i < numCell;i++){
        UISettingsTableViewCell* cell = [self.delegate tableView:self cellForRowAtIndex:i];
        cell.index = i;
        cell.delegate = self;
        [_cells insertObject:cell atIndex:i];
        [self append:cell];
    }
    [self setHeight:_bottomY];
    [self setDropShadow];
}

- (void)cell:(UISettingsTableViewCell *)cell highlighted:(BOOL)highlighted
{
    [self.delegate tableView:self didCellTapAtIndex:cell.index];
}

- (void)append:(UIView *)view
{
    [view setY:_bottomY];
    [_container addSubview:view];
    CGFloat bottomY = view.frame.origin.y + view.frame.size.height;
    if(bottomY > _bottomY){
        _bottomY = bottomY;
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _bottomY)];
        [_container setFrame:self.bounds];
    }
}

- (void)removeRowAtIndex:(NSInteger)index
{
    if(_cells == nil){
        return;
    }
    UISettingsTableViewCell* cell = [_cells objectAtIndex:index];
    if(cell){
        [cell removeFromSuperview];
        cell = nil;
        [self plugCells];
    }
}

- (void)plugCells
{
    CGFloat bottomY = 0.0f;
    for(UIView* view in [_container subviews]){
        if([view isKindOfClass:[UISettingsTableViewCell class]]){
            if(view.frame.origin.y != bottomY){
                [view setY:bottomY];
            }
            bottomY = view.bottom;
        }
    }
    [self setHeight:bottomY];
    [_container setFrame:self.bounds];
    [self setDropShadow];
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

- (void)dealloc
{
    [_cells removeAllObjects];
    _cells = nil;
}


@end

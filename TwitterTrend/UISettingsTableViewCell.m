//
//  UISettingsTableVIewCell.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/25.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISettingsTableViewCell.h"

@implementation UISettingsTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.editing = NO;
        self.position = CellPositionMiddle;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    if(_textLabel == nil){
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16];
        [self addSubview:_textLabel];
    }
    _textLabel.text = text;
    [_textLabel sizeToFit];
    [_textLabel adjustsFontSizeToFitWidth];
    [_textLabel setY:5];
    [_textLabel setX:10];
}

- (void)setDetailText:(NSString *)detailText
{
    if(_textLabel){
        _detailTextLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _detailTextLabel.backgroundColor = [UIColor clearColor];
        _detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        _detailTextLabel.textColor = [UIColor colorWithWhite:140.0f/255.0f alpha:1.0f];
        [self addSubview:_detailTextLabel];
    }
    _detailTextLabel.text = detailText;
    [_detailTextLabel sizeToFit];
    [_detailTextLabel adjustsFontSizeToFitWidth];
    [_detailTextLabel setX:10];
    [_detailTextLabel setY:24];
}

- (void)drawRect:(CGRect)rect
{
    UIRectCorner _corner;
    UIBezierPath* path;
    if(_position == CellPositionTop){
        _corner = UIRectCornerTopLeft | UIRectCornerTopRight;
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:_corner cornerRadii:CGSizeMake(4.0f, 4.0f)];        
    } else if (_position == CellPositionBottom){
        _corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:_corner cornerRadii:CGSizeMake(4.0f, 4.0f)];
    } else {
        path = [UIBezierPath bezierPathWithRect:rect];
    }

    [[UIColor whiteColor] setFill];    
    [path fill];
    
    if(_position != CellPositionBottom){
        UIBezierPath* bottomStrokePath = [UIBezierPath bezierPath];
        [bottomStrokePath moveToPoint:CGPointMake(0.0f, rect.size.height)];
        [bottomStrokePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height )];
        [bottomStrokePath closePath];
        [[UIColor colorWithWhite:0.0f alpha:0.1f] setStroke];
        [bottomStrokePath stroke];
    }
}

@end

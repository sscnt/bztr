//
//  UISideMenuButton.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/06.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISideMenuButton.h"

@implementation UISideMenuButton

- (id)initWithTitle:(NSString *)titie
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, 44.0f);
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, frame.size.width, frame.size.height)];
        titleLabel.text = titie;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        titleLabel.textColor = [UIColor colorWithWhite:210.0f/255.0f alpha:1.0f];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* topStrokePath = [UIBezierPath bezierPath];
    [topStrokePath moveToPoint:CGPointMake(0.0f, 0.0f)];
    [topStrokePath addLineToPoint:CGPointMake(rect.size.width, 0.0f)];
    [topStrokePath closePath];
    [[UIColor colorWithWhite:1.0f alpha:0.1f] setStroke];
    [topStrokePath stroke];
    
    UIBezierPath* bottomStrokePath = [UIBezierPath bezierPath];
    [bottomStrokePath moveToPoint:CGPointMake(0.0f, rect.size.height - 1.0f)];
    [bottomStrokePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 1.0f)];
    [bottomStrokePath closePath];
    [[UIColor colorWithWhite:0.0f alpha:0.2f] setStroke];
    [bottomStrokePath stroke];
    
    if(self.selected){
        dlog(@"DrawRect");
        UIBezierPath* bgPath = [UIBezierPath bezierPathWithRect:rect];
        [[UIColor colorWithWhite:32.0f/255.0f alpha:1.0f] setFill];
        [bgPath fill];
        
        UIBezierPath* topStrokePath = [UIBezierPath bezierPath];
        [topStrokePath moveToPoint:CGPointMake(0.0f, 1.0f)];
        [topStrokePath addLineToPoint:CGPointMake(rect.size.width, 1.0f)];
        [topStrokePath closePath];
        [[UIColor colorWithWhite:0.0f alpha:0.5f] setStroke];
        [topStrokePath stroke];
        
        UIBezierPath* labelPath = [UIBezierPath bezierPathWithRect:CGRectMake(0.0f, 0.0f, 5.0f, rect.size.height)];
        [[UIColor colorWithRed:174.0f/255.0f green:66.0f/255.0f blue:63.0f/255.0f alpha:1.0f] setFill];
        [labelPath fill];
    }
}


@end

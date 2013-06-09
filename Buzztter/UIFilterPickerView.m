//
//  UIFilterPickerView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/27.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterPickerView.h"

@implementation UIFilterPickerView


- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, (PickerWidth + 4.0f) * 3 + 4.0f, PickerHeight);
    return [self initWithFrame:frame];
}


- (id)initWithFrame:(CGRect)frame
{
    dlog(@"%f", frame.size.width);
    dlog(@"%f", frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        self.layer.masksToBounds =  YES;
        
        _scrollViewHundredPlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewHundredPlace.tag = ScrollViewIdHundredPlace;
        _scrollViewOnePlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewOnePlace.tag = ScrollViewIdOnePlace;
        _scrollViewTenPlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewTenPlace.tag = ScrollViewIdTenPlace;
        
        _wrapperHundredPlace = [[UIFilterPickerWrapperView alloc] init];
        _wrapperOnePlace = [[UIFilterPickerWrapperView alloc] init];
        _wrapperTenPlace = [[UIFilterPickerWrapperView alloc] init];
        
        [_wrapperHundredPlace setX:4];
        _wrapperHundredPlace.scrollView = _scrollViewHundredPlace;
        [self addSubview:_wrapperHundredPlace];
        [_wrapperTenPlace setX:PickerWidth + 8];
        _wrapperTenPlace.scrollView = _scrollViewTenPlace;
        [self addSubview:_wrapperTenPlace];
        [_wrapperOnePlace setX:PickerWidth * 2 + 12];
        _wrapperOnePlace.scrollView = _scrollViewOnePlace;
        [self addSubview:_wrapperOnePlace];
        
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spinner.png"]];
        imageView.frame = frame;
        imageView.userInteractionEnabled = NO;
        [self addSubview:imageView];
        
        
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)page
{

}

- (NSInteger)currentPageNumber
{
    int value;
    int numPage = 0;
    value = _scrollViewOnePlace.contentOffset.y / _scrollViewOnePlace.frame.size.height;
    numPage += value;
    value = _scrollViewTenPlace.contentOffset.y / _scrollViewTenPlace.frame.size.height;
    numPage += value * 10;
    value = _scrollViewHundredPlace.contentOffset.y / _scrollViewHundredPlace.frame.size.height;
    numPage += value * 100;
    return numPage;
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int value = 0;
    value = scrollView.contentOffset.y / scrollView.frame.size.height;
    if(scrollView.tag == ScrollViewIdHundredPlace){
        
        return;
    }
    
    if(scrollView.tag == ScrollViewIdTenPlace){
        return;
    }
    
    if(scrollView.tag == ScrollViewIdOnePlace){
        return;
    }
    
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.0f];
    [[UIColor blackColor] setFill];
    [path fill];
}


@end

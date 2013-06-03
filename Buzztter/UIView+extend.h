//
//  UIView+extend.h
//  Practice1
//
//  Created by SSC on 2013/02/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>


/*
 * UIViewのカテゴリ
 */

@interface UIView (extend)
- (CGFloat)bottom;
- (CGFloat)right;
- (void)setShadow;
- (void)setX:(NSInteger)x;
- (void)setY:(NSInteger)y;
- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;
- (void)setWidth:(NSInteger)width;
- (void)setHeight:(NSInteger)height;
- (void)setOrigin:(CGPoint)point;
- (void)setSize:(CGSize)size;
@end

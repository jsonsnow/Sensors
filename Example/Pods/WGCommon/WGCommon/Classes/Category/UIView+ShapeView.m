//
//  UIView+ShapeView.m
//  WeAblum
//
//  Created by chen liang on 2020/3/9.
//  Copyright © 2020 WeAblum. All rights reserved.
//

#import "UIView+ShapeView.h"

@implementation UIView (ShapeView)

- (void)configTraingleView {
    [self traignleViewWithType:3];
}

- (void)topTraingleView {
    [self traignleViewWithType:0];
}

- (void)leftTraingleView {
    [self traignleViewWithType:1];
}

- (void)bottomTraingleView {
    [self traignleViewWithType:2];
}

- (void)rightTraingleView {
    [self traignleViewWithType:3];
}

/// 设置当前view的mask为三角形
/// @param type 三角形定点的坐标，0：上方，1:左边，2：低边，3：右边
- (void)traignleViewWithType:(NSInteger)type {
    CGPoint leftPoint;
    CGPoint rightPoint;
    CGPoint centerPoint;
    if (type == 0) {
        centerPoint = CGPointMake(self.bounds.size.width/2, 0);
        leftPoint = CGPointMake(0, self.bounds.size.height);
        rightPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    } else if (type == 1) {
        centerPoint = CGPointMake(0, self.bounds.size.height/2);
        leftPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height);
        rightPoint = CGPointMake(self.bounds.size.width, 0);
    } else if (type == 2) {
        centerPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        leftPoint = CGPointMake(0, 0);
        rightPoint = CGPointMake(self.bounds.size.width, 0);
    } else {
        centerPoint = CGPointMake(self.bounds.size.width, self.bounds.size.height/2);
        leftPoint = CGPointMake(0, 0);
        rightPoint = CGPointMake(0, self.bounds.size.height);
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    //layer.fillColor = UIColor.blackColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: centerPoint];
    [path addLineToPoint:leftPoint];
    [path addLineToPoint:rightPoint];
    [path addLineToPoint:centerPoint];
    layer.lineWidth = 1;
    layer.strokeColor = UIColor.redColor.CGColor;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

@end

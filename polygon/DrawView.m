//
//  DrawView.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "DrawView.h"
#import "NSArray+getPoints.h"

@interface DrawView ()

@property (nonatomic, strong, readonly) CAShapeLayer *layer;

@end

@implementation DrawView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.lineJoin = kCALineJoinRound;
    self.layer.lineWidth = 2;
    self.layer.fillColor = nil;
    self.layer.strokeColor = [UIColor blackColor].CGColor;
}

- (void)updateWithPoints:(NSArray *)points {
    switch (points.count) {
        case 0:
            [self updateWithNoPoints];
            break;
        case 1:
            [self updateWithOnePoint:points.rawPoints[0]];
            break;
        default:
            [self updateWithManyPoints:points];
            break;
    }
}

- (void)updateWithNoPoints {
    self.layer.path = nil;
}

- (void)updateWithOnePoint:(CGPoint)point {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    [path addLineToPoint:(CGPoint){point.x + 0.01, point.y}];
    [path closePath];
    self.layer.path = path.CGPath;
}

- (void)updateWithManyPoints:(NSArray *)points {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddLines(path, NULL, points.rawPoints, points.count);
    CGPathCloseSubpath(path);
    self.layer.path = path;
    CGPathRelease(path);
}

@end

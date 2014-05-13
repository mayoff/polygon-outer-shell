//
//  DrawView.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (UIBezierPath *)pathWithOnePoint:(CGPoint)point {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    [path addLineToPoint:(CGPoint){point.x + 0.01, point.y}];
    [path closePath];
    return path;
}

- (UIBezierPath *)pathWithTwoPoints:(CGPoint const *)points {
    return [self pathWithManyPoints:points count:2];
}

- (UIBezierPath *)pathWithManyPoints:(CGPoint const *)points count:(NSUInteger)count {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:points[0]];
    for (NSUInteger i = 1; i < count; ++i) {
        [path addLineToPoint:points[i]];
    }
    [path closePath];
    return path;
}

@end

//
//  UnionView.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "UnionView.h"
#include "clipper.hpp"

using namespace ClipperLib;

@implementation UnionView

- (UIBezierPath *)pathWithOnePoint:(CGPoint)point {
    return nil;
}

- (UIBezierPath *)pathWithTwoPoints:(CGPoint const *)points {
    return nil;
}

static CGPoint cgPointWithIntPoint(IntPoint const &intPoint) {
    return CGPointMake(intPoint.X, intPoint.Y);
}

- (UIBezierPath *)pathWithManyPoints:(CGPoint const *)points count:(NSUInteger)count {

    Path subject;
    for (NSUInteger i = 0; i < count; ++i) {
        subject << IntPoint(points[i].x, points[i].y);
    }

    Clipper clipper;
    clipper.AddPath(subject, ptSubject, true);
    Paths solutions;
    clipper.Execute(ctUnion, solutions, pftNonZero, pftNonZero);

    UIBezierPath *path = [UIBezierPath bezierPath];
    for (size_t i = 0; i < solutions.size(); ++i) {
        Path& solution = solutions[i];
        if (solution.size() > 0) {
            [path moveToPoint:cgPointWithIntPoint(solution[0])];
            for (size_t j = 1; j < solution.size(); ++j) {
                [path addLineToPoint:cgPointWithIntPoint(solution[j])];
            }
            [path closePath];
        }
    }

    return path;
}

@end

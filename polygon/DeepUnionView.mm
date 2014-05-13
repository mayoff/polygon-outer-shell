//
//  DeepUnionView.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "DeepUnionView.h"
#include "clipper.hpp"

using namespace ClipperLib;

@implementation DeepUnionView

- (UIBezierPath *)pathWithOnePoint:(CGPoint)point {
    return nil;
}

- (UIBezierPath *)pathWithTwoPoints:(CGPoint const *)points {
    return nil;
}

static CGPoint cgPointWithIntPoint(IntPoint const &intPoint) {
    return CGPointMake(intPoint.X, intPoint.Y);
}

static void reverse(Path &path) {
    size_t l = path.size();
    size_t half = l / 2;
    for (size_t i = 0; i < half; ++i) {
        std::swap(path[i], path[l - i - 1]);
    }
}

- (UIBezierPath *)pathWithManyPoints:(CGPoint const *)points count:(NSUInteger)count {

    Path subject;
    for (NSUInteger i = 0; i < count; ++i) {
        subject << IntPoint(points[i].x, points[i].y);
    }

    Clipper clipper;
    clipper.AddPath(subject, ptSubject, true);
    Paths intermediateSolutions;
    clipper.Execute(ctUnion, intermediateSolutions, pftNonZero, pftNonZero);

    clipper.Clear();
    for (size_t i = 0; i < intermediateSolutions.size(); ++i) {
        if (Orientation(intermediateSolutions[i])) {
            reverse(intermediateSolutions[i]);
        }
    }
    clipper.AddPaths(intermediateSolutions, ptSubject, true);
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

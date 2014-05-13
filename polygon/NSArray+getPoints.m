//
//  NSArray+getPoints.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "NSArray+getPoints.h"

@implementation NSArray (getPoints)

- (CGPoint *)rawPoints {
    NSMutableData *data = [NSMutableData dataWithLength:self.count * sizeof(CGPoint)];
    CGPoint *rawPoints = data.mutableBytes;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger i, BOOL *stop) {
        NSValue *value = obj;
        rawPoints[i] = [value CGPointValue];
    }];
    CFRetain((__bridge CFMutableDataRef)data);
    CFAutorelease((__bridge CFMutableDataRef)data);
    return rawPoints;
}

@end

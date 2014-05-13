//
//  NSArray+getPoints.h
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (getPoints)

/** Return a pointer valid until the autorelease pool is drained. */
- (CGPoint *)rawPoints;

@end

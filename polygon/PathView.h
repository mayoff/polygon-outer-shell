//
//  PathView.h
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathView : UIView

- (void)updateWithPoints:(CGPoint const *)points count:(NSUInteger)count;

@end

@interface PathView (SubclassResponsibility)

- (UIBezierPath *)pathWithOnePoint:(CGPoint)point;
- (UIBezierPath *)pathWithTwoPoints:(CGPoint const *)points;
- (UIBezierPath *)pathWithManyPoints:(CGPoint const *)points count:(NSUInteger)count;

@end
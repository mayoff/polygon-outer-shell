//
//  PathView.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "PathView.h"

@interface PathView ()

@property (nonatomic, strong, readonly) CAShapeLayer *layer;

@end

@implementation PathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    [self initLayer];
}

- (void)initLayer {
    self.layer.lineJoin = kCALineJoinRound;
    self.layer.lineWidth = 2;
    self.layer.fillColor = nil;
    self.layer.strokeColor = [UIColor blackColor].CGColor;
}

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)updateWithPoints:(CGPoint const *)points count:(NSUInteger)count {
    UIBezierPath *path;
    switch (count) {
        case 0:
            path = nil;
            break;
        case 1:
            path = [self pathWithOnePoint:points[0]];
            break;
        case 2:
            path = [self pathWithTwoPoints:points];
            break;
        default:
            path = [self pathWithManyPoints:points count:count];
            break;
    }
    self.layer.path = path.CGPath;
}

@end

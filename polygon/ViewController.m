//
//  ViewController.m
//  polygon
//
//  Created by Rob Mayoff on 5/13/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "NSArray+getPoints.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet DrawView *drawView;
@property (strong, nonatomic) IBOutlet PathView *middleView;
@property (strong, nonatomic) IBOutlet PathView *bottomView;
@property (nonatomic, strong, readonly) NSMutableArray *points;

@end

@implementation ViewController {
    NSMutableArray *_points;
}

- (NSMutableArray *)points {
    if (_points == nil) {
        _points = [NSMutableArray array];
    }
    return _points;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self removeAllPoints];
    }
    [super motionEnded:motion withEvent:event];
}

- (IBAction)drawViewDidReceiveTap:(UITapGestureRecognizer *)tapper {
    CGPoint point = [tapper locationInView:self.drawView];
    [self addPoint:point];
}

- (void)addPoint:(CGPoint)point {
    [self.points addObject:[NSValue valueWithCGPoint:point]];
    [self updateViews];
}

- (void)removeAllPoints {
    [self.points removeAllObjects];
    [self updateViews];
}

- (void)updateViews {
    CGPoint const *points = self.points.rawPoints;
    NSUInteger count = self.points.count;
    [self.drawView updateWithPoints:points count:count];
    [self.middleView updateWithPoints:points count:count];
    [self.bottomView updateWithPoints:points count:count];
}

@end

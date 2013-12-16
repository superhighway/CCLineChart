#import <QuartzCore/QuartzCore.h>
#import "CC2DLineChartView.h"

@interface CC2DLineChartView ()
@property (strong, nonatomic) CAShapeLayer *lineShapeLayer;
@property (strong, nonatomic) CAShapeLayer *fillShapeLayer;
@end

@implementation CC2DLineChartView

- (void)reloadData {
    [self reloadDataAnimated:NO];
}

- (void)reloadDataAnimated:(BOOL)animated {
    if (self.fillShapeLayer) {
        self.lineShapeLayer.path = nil;
        [self.lineShapeLayer didChangeValueForKey:@"path"];
        self.fillShapeLayer.path = nil;
        [self.fillShapeLayer didChangeValueForKey:@"path"];
    } else {
        self.lineShapeLayer = [CAShapeLayer layer];
        self.lineShapeLayer.lineWidth = 2;
        self.lineShapeLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
        self.lineShapeLayer.fillColor = [UIColor clearColor].CGColor;
        self.lineShapeLayer.frame = self.layer.bounds;
        [self.layer addSublayer:self.lineShapeLayer];

        self.fillShapeLayer = [CAShapeLayer layer];
        self.fillShapeLayer.strokeColor = [UIColor clearColor].CGColor;
        self.fillShapeLayer.fillColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        self.fillShapeLayer.frame = self.layer.bounds;
        [self.layer addSublayer:self.fillShapeLayer];
    }

    NSArray *points = [self.dataSource pointsForLineChartView:self];
    if (!points || points.count == 0) return;

    CGFloat w = CGRectGetWidth(self.frame), h = CGRectGetHeight(self.frame);
    CC2DLineChartAxisMeta *xMeta = [self.dataSource lineChartView:self metadataForAxis:CC2DLineChartAxisX];
    CC2DLineChartAxisMeta *yMeta = [self.dataSource lineChartView:self metadataForAxis:CC2DLineChartAxisY];


    CGMutablePathRef path = CGPathCreateMutable();
    NSArray *point = points[0];
    CGFloat xFactor = w/(xMeta.valueIncrement*(xMeta.maxValue - xMeta.minValue)),
            yFactor = h/(yMeta.valueIncrement*(yMeta.maxValue - yMeta.minValue)),
            x = ([point[0] doubleValue] - xMeta.minValue)*xFactor,
            y = h - ([point[1] doubleValue] - yMeta.minValue)*yFactor,
            firstX = x;

    CGPathMoveToPoint(path, nil, x, y);
    for (int i = 1; i < points.count; i++) {
        point = points[i];
        x = ([point[0] doubleValue] - xMeta.minValue)*xFactor;
        y = h - ([point[1] doubleValue] - yMeta.minValue)*yFactor;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathRef copyPath = CGPathCreateCopy(path);
    self.lineShapeLayer.path = copyPath;
    CGFloat midY = h - yMeta.midValue*yFactor;
    CGPathAddLineToPoint(path, nil, x, midY);
    CGPathAddLineToPoint(path, nil, firstX, midY);
    CGPathCloseSubpath(path);
    self.fillShapeLayer.path = path;

    if (animated) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.3;
        pathAnimation.fromValue = @0;
        pathAnimation.toValue = @1;
        [self.lineShapeLayer addAnimation:pathAnimation forKey:pathAnimation.keyPath];

        CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
        fillColorAnimation.duration = 0.5;
        fillColorAnimation.fromValue = (id)[UIColor clearColor].CGColor;
        fillColorAnimation.toValue = (id)self.fillShapeLayer.backgroundColor;
        [self.fillShapeLayer addAnimation:fillColorAnimation forKey:@"fillColor"];
    }

    CGPathRelease(path);
    CGPathRelease(copyPath);
    [self.lineShapeLayer didChangeValueForKey:@"path"];
    [self.fillShapeLayer didChangeValueForKey:@"path"];
}

@end


@implementation CC2DLineChartAxisMeta
@end

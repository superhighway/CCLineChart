@class CC2DLineChartView;
@class CC2DLineChartAxisMeta;

typedef NS_ENUM(NSInteger, CC2DLineChartAxis) {
    CC2DLineChartAxisX,
    CC2DLineChartAxisY
};


@protocol CC2DLineChartViewDataSource <NSObject>
- (CC2DLineChartAxisMeta *)lineChartView:(CC2DLineChartView *)lineChartView metadataForAxis:(CC2DLineChartAxis)axis;

// @[@[@(1.1), @(1.2)], @[@(1.4), @(1.8)]]
- (NSArray *)pointsForLineChartView:(CC2DLineChartView *)lineChartView;
@end



@interface CC2DLineChartView : UIView
@property (weak, nonatomic) IBOutlet id<CC2DLineChartViewDataSource> dataSource;
@property (strong, nonatomic, readonly) CAShapeLayer *lineShapeLayer;
@property (strong, nonatomic, readonly) CAShapeLayer *fillShapeLayer;

- (void)reloadData;
- (void)reloadDataAnimated:(BOOL)animated;
@end



@interface CC2DLineChartAxisMeta : NSObject
@property (strong, nonatomic) NSAttributedString *attributedTitle;

@property (nonatomic) CGFloat valueIncrement;
@property (nonatomic) CGFloat minValue;
@property (strong, nonatomic) NSNumberFormatter *minValueFormatter;
@property (nonatomic) CGFloat midValue;
@property (strong, nonatomic) NSNumberFormatter *midValueFormatter;
@property (nonatomic) CGFloat maxValue;
@property (strong, nonatomic) NSNumberFormatter *maxValueFormatter;
@end

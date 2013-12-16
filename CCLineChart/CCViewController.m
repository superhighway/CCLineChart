#import "CC2DLineChartView.h"
#import "CCViewController.h"

@interface CCViewController () <CC2DLineChartViewDataSource>
@property (weak, nonatomic) IBOutlet CC2DLineChartView *lineChartView;
@end

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lineChartView reloadDataAnimated:YES];
}

#pragma mark - CC2DLineChartViewDataSource

- (CC2DLineChartAxisMeta *)lineChartView:(CC2DLineChartView *)lineChartView metadataForAxis:(CC2DLineChartAxis)axis {
    switch (axis) {
        case CC2DLineChartAxisX: {
            CC2DLineChartAxisMeta *meta = [[CC2DLineChartAxisMeta alloc] init];
            meta.valueIncrement = 2;
            meta.maxValue = 8;
            meta.midValue = 0;
            meta.minValue = -2;
            return meta;
        }
        case CC2DLineChartAxisY: {
            CC2DLineChartAxisMeta *meta = [[CC2DLineChartAxisMeta alloc] init];
            meta.valueIncrement = 1;
            meta.maxValue = 6;
            meta.midValue = 0;
            meta.minValue = -1;
            return meta;
        }
        default:
            return nil;
    }
}

- (NSArray *)pointsForLineChartView:(CC2DLineChartView *)lineChartView {
    return @[@[@0, @1], @[@1, @1], @[@2, @4], @[@6, @1], @[@(6.3), @(1.2)], @[@(7), @(1.2)]];
}

@end

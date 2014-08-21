//
//  SBTHomeViewController.m
//  ScreenshotBugTest
//
//  Created by Johann Fradj on 02/06/2014.
//  Copyright (c) 2014 Fradj. All rights reserved.
//

#import "SBTHomeViewController.h"
#import "SBTScreenshotViewController.h"


@interface SBTHomeViewController () <SBTScreenshotViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *oldWayImageView;
@property (nonatomic, weak) IBOutlet UIImageView *currentWayImageView;
@property (nonatomic, weak) IBOutlet UILabel *oldWayLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentWayLabel;

@end



@implementation SBTHomeViewController


- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.navigationItem.title = @"Home";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Screenshot TEST"
                                                                                  style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(next)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.oldWayImageView.layer.borderWidth = 1.0;
    self.currentWayImageView.layer.borderWidth = 1.0;
    
    self.oldWayImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.currentWayImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.oldWayLabel.preferredMaxLayoutWidth = 320.0;
    self.currentWayLabel.preferredMaxLayoutWidth = 320.0;
}


#pragma mark - NavBar callback

- (void)next
{
    SBTScreenshotViewController *vc = [[SBTScreenshotViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - SBTScreenshotViewControllerDelegate

- (void)screenshotViewController:(SBTScreenshotViewController *)screenshotViewController
         didTakeOldWayScreenshot:(UIImage *)oldWayScreenshot
         didTakeCurrentWayScreenshot:(UIImage *)currentWayScreenshot
{
    self.oldWayImageView.image = oldWayScreenshot;
    self.currentWayImageView.image = currentWayScreenshot;
    
    self.oldWayLabel.text = @"renderInContext: (from CALayer)\n\n- The selected state of the segmented control isn't visible\n\n- The DatePicker isn't well rendered\n\n- The Toolbar can be acceptable (just no blur) or can be totally black";
    
    self.currentWayLabel.text = @"drawViewHierarchyInRect:afterScreenUpdates:\n\nWORKS PERFECTLY on iPad mini (1st gen) and simulator\n\n /!\\ DO NOT WORK on others iPads (seems to be the retina ones)";
}


@end

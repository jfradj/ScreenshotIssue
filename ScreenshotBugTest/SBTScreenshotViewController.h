//
//  SBTScreenshotViewController.h
//  ScreenshotBugTest
//
//  Created by Johann Fradj on 02/06/2014.
//  Copyright (c) 2014 Fradj. All rights reserved.
//

@protocol SBTScreenshotViewControllerDelegate;


@interface SBTScreenshotViewController : UIViewController

@property (nonatomic, weak) id<SBTScreenshotViewControllerDelegate> delegate;

@end


@protocol SBTScreenshotViewControllerDelegate <NSObject>

- (void)screenshotViewController:(SBTScreenshotViewController *)screenshotViewController
         didTakeOldWayScreenshot:(UIImage *)oldWayScreenshot
         didTakeCurrentWayScreenshot:(UIImage *)currentWayScreenshot;

@end
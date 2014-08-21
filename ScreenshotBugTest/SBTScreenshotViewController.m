//
//  SBTScreenshotViewController.m
//  ScreenshotBugTest
//
//  Created by Johann Fradj on 02/06/2014.
//  Copyright (c) 2014 Fradj. All rights reserved.
//

#import "SBTScreenshotViewController.h"





// ***********************************
// ***  ZOOM ENABLING / DISABLING  ***
// ***********************************

#define ZOOM_ENABLED 0





@interface SBTScreenshotViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIView *workspace;
@property (nonatomic, assign) CGRect canvasRect;

@end


@implementation SBTScreenshotViewController


- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SHOW ME THE ISSUE"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(done)];
        
        _canvasRect = CGRectMake(600, 800, 320, 480);
    }
    return self;
}

- (void)done
{
    
    // *************************************************************************************
    // ***  OLD WAY  ***
    // *****************
    
    UIGraphicsBeginImageContextWithOptions(self.canvasRect.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, -self.canvasRect.origin.x, -self.canvasRect.origin.y);
    [self.workspace.layer renderInContext:context];
    
    UIImage *oldWayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // *************************************************************************************
    
    
    
    // *************************************************************************************
    // ***  NEW WAY  ***
    // *****************
    
    UIGraphicsBeginImageContextWithOptions(self.canvasRect.size, YES, 0.0);
    context = UIGraphicsGetCurrentContext();
    
    CGRect r = CGRectMake(-self.canvasRect.origin.x, -self.canvasRect.origin.y, self.workspace.bounds.size.width, self.workspace.bounds.size.height);
    BOOL result = [self.workspace drawViewHierarchyInRect:r afterScreenUpdates:YES];
    
    UIImage *currentWayImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // *************************************************************************************
    
    
    
    
    if (!result) {
        [[[UIAlertView alloc] initWithTitle:@"Snapshot is missing image data"
                                    message:@"drawViewHierarchyInRect:afterScreenUpdates:\nFAILED"
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];
    }
    
    [self.delegate screenshotViewController:self didTakeOldWayScreenshot:oldWayImage didTakeCurrentWayScreenshot:currentWayImage];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(2000, 3000);
    
#if ZOOM_ENABLED
    self.scrollView.minimumZoomScale = 2.0;
    self.scrollView.maximumZoomScale = 0.3;
#else
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 1.0;
#endif
    
    self.workspace = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    [self.scrollView addSubview:self.workspace];
    
    
    UIView *canvas = [[UIView alloc] initWithFrame:self.canvasRect];
    canvas.backgroundColor = [UIColor whiteColor];
    canvas.layer.borderWidth = 1.0;
    [self.workspace addSubview:canvas];
    
    UIView *shape = [[UIView alloc] initWithFrame:CGRectMake(self.canvasRect.origin.x + 100.0,
                                                             self.canvasRect.origin.y + 120,
                                                             self.canvasRect.size.width - 200.0,
                                                             self.canvasRect.size.height - 400)];
    shape.backgroundColor = [UIColor redColor];
    [self.workspace addSubview:shape];
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"One", @"Two", @"Three"]];
    sc.frame = CGRectMake(self.canvasRect.origin.x + 10.0,
                          self.canvasRect.origin.y + 10.0,
                          self.canvasRect.size.width - 20.0,
                          29.0);
    sc.selectedSegmentIndex = 1;
    [self.workspace addSubview:sc];
    
    UIDatePicker *dp = [[UIDatePicker alloc] initWithFrame:CGRectMake(self.canvasRect.origin.x,
                                                                      self.canvasRect.origin.y + self.canvasRect.size.height - 216.0,
                                                                      self.canvasRect.size.width,
                                                                      216.0)];
    [self.workspace addSubview:dp];
    
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(self.canvasRect.origin.x,
                                                                self.canvasRect.origin.y + self.canvasRect.size.height - 340.0,
                                                                self.canvasRect.size.width,
                                                                44.0)];
    [self.workspace addSubview:tb];
}



#if ZOOM_ENABLED

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.workspace;
}

#endif

@end

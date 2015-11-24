//
//  ComposePopViewController.m
//  Logger
//
//  Created by iamchiwon on 2015. 11. 16..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import "ComposePopViewController.h"
#import "MainListViewController.h"

@interface ComposePopViewController ()
@property (weak, nonatomic) IBOutlet UIView* popupView;

@end

@implementation ComposePopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.alpha = 0;
    self.popupView.layer.cornerRadius = 5;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        UIButton* cameraButton = [self.popupView viewWithTag:2];
        cameraButton.enabled = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.alpha = 1;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDismiss:(id)sender
{
    [self hidePopupAndSendEvent:-1];
}

- (IBAction)onItemSelected:(UIButton*)sender
{
    NSInteger tag = sender.tag;
    [self hidePopupAndSendEvent:tag];
}

- (void)hidePopupAndSendEvent:(const NSInteger)tag
{
    [UIView animateWithDuration:0.3
        animations:^{
            self.view.alpha = 0;
        }
        completion:^(BOOL finished) {

            ((MainListViewController*)self.parentViewController).composeButton.enabled = YES;

            [self.view removeFromSuperview];
            [self removeFromParentViewController];

            if (tag >= 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PopupItemSelected" object:@(tag)];
            }
        }];
}

@end

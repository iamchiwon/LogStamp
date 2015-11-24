//
//  MainListViewController.m
//  Logger
//
//  Created by iamchiwon on 2015. 11. 16..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import "MainListViewController.h"
#import "ListItemTableViewCell.h"
#import "ComposePopViewController.h"
#import "ListItem.h"

@interface MainListViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property NSMutableArray* listItems;
@end

@implementation MainListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.listItems = [[NSMutableArray alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddItem:) name:@"PopupItemSelected" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onExport:(id)sender
{
}

- (IBAction)onCompose:(id)sender
{
    ComposePopViewController* compose = [self.storyboard instantiateViewControllerWithIdentifier:@"ComposePopViewController"];

    UIView* subView = compose.view;
    [self.view addSubview:subView];
    [self addChildViewController:compose];
    [compose didMoveToParentViewController:self];

    self.composeButton.enabled = NO;
}

- (void)onAddItem:(NSNotification*)noti
{
    NSInteger type = [noti.object integerValue];
    switch (type) {
    case 0: //TEXT
        [self addTextItem];
        break;
    case 1: //PHOTO
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController* cameraController = [[UIImagePickerController alloc] init];
            cameraController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            cameraController.allowsEditing = NO;
            cameraController.mediaTypes
                = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];

            cameraController.delegate = self;

            [self presentViewController:cameraController animated:YES completion:nil];
        }
    } break;
    case 2: //CAMERA
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController* cameraController = [[UIImagePickerController alloc] init];
            cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
            cameraController.allowsEditing = NO;
            cameraController.mediaTypes
                = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];

            cameraController.delegate = self;

            [self presentViewController:cameraController animated:YES completion:nil];
        }
    } break;
    case 3: //LOCATION
        break;
    case 4: //DRAWING
        break;
    case 5: //STAMP
        [self addStamp];
        break;
    }
}

- (void)addTextItem
{
    ListItem* item = [ListItem new];
    item.type = ITEM_TYPE_TEXT;
    item.text = @"Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World";
    [self.listItems addObject:item];

    NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:(self.listItems.count - 1)inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)addStamp
{
    ListItem* item = [ListItem new];
    item.type = ITEM_TYPE_TEXT;
    item.image = [UIImage imageNamed:@"good_stamp"];
    [self.listItems addObject:item];

    NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:(self.listItems.count - 1)inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image editingInfo:(nullable NSDictionary<NSString*, id>*)editingInfo
{
    ListItem* item = [ListItem new];
    item.type = ITEM_TYPE_IMAGE;
    item.image = image;
    [self.listItems addObject:item];

    NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:(self.listItems.count - 1)inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationRight];

    [picker dismissViewControllerAnimated:YES
                               completion:^{
                               }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listItems.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    ListItemTableViewCell* cell = (ListItemTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ListItemTableViewCell"];

    NSInteger index = indexPath.row;
    ListItem* item = self.listItems[index];

    cell.textLogLabel.text = item.text;
    cell.imageLogView.image = item.image;
    cell.timeStampLabel.text = [item.timeStamp description];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

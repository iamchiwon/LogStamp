//
//  ListItemTableViewCell.h
//  Logger
//
//  Created by iamchiwon on 2015. 11. 16..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView* imageLogView;
@property (weak, nonatomic) IBOutlet UILabel* textLogLabel;
@property (weak, nonatomic) IBOutlet UILabel* timeStampLabel;

@end

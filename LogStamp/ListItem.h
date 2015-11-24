//
//  ListItem.h
//  LogStamp
//
//  Created by iamchiwon on 2015. 11. 16..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

#define ITEM_TYPE_IMAGE 0
#define ITEM_TYPE_TEXT 1
#define ITEM_TYPE_LOCATION 2

@interface ListItem : NSObject
@property NSInteger type;
@property UIImage* image;
@property NSString* text;
@property CLLocation* location;
@property NSDate* timeStamp;
@end

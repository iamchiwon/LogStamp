//
//  ListItem.m
//  LogStamp
//
//  Created by iamchiwon on 2015. 11. 16..
//  Copyright © 2015년 iamchiwon. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.image = nil;
        self.text = @"";
        self.timeStamp = [NSDate date];
    }
    return self;
}

@end

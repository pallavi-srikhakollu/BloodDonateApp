//
//  HistoryListViewController.h
//  DonateLife
//
//  Created by webonise on 07/09/15.
//  Copyright (c) 2015 webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddHistoryViewController.h"
//extern NSMutableArray *arrayOfLocations;
//extern NSMutableArray *arrayOfDates;
@interface HistoryListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *arrayOfLocation;
@property NSMutableArray *arrayOfDates;
@end

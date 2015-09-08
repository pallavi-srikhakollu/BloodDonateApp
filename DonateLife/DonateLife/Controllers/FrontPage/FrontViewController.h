//
//  FrontViewController.h
//  DonateLife
//
//  Created by webonise on 03/09/15.
//  Copyright (c) 2015 webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationPageViewController.h"
#import "DonorsDisplayViewController.h"


@interface FrontViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewBloodList;
@property DonorsDisplayViewController *donorsDisplayViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintHeightForTable;
@end

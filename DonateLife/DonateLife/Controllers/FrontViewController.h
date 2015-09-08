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
@property NSMutableDictionary * dictonaryForDonar;
@property NSDictionary *dictonaryForInfo;
@property NSMutableArray *arrayOfDonars;
@property UITableView *tableViewForSettings;
@property  CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITableView *tableViewBloodList;
@property DonorsDisplayViewController *donorsDisplayViewController;

@end

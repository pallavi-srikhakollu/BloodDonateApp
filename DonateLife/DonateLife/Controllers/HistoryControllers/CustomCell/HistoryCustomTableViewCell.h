//
//  HistoryCustomTableViewCell.h
//  DonateLife
//
//  Created by webonise on 08/09/15.
//  Copyright (c) 2015 webonise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBHelper.h"
@interface HistoryCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForCetificate;
@property (weak, nonatomic) IBOutlet UILabel *labelForLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonForDelete;
@property (weak, nonatomic) IBOutlet UILabel *labelForDate;
@property DBHelper *databaseHelper;
@end

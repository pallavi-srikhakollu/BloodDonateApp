//
//  CustomTableViewCell.h
//  DonateLife
//
//  Created by webonise on 05/09/15.
//  Copyright (c) 2015 webonise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelForName;
@property (weak, nonatomic) IBOutlet UILabel *labelForDistance;
@property (weak, nonatomic) IBOutlet UIButton *buttonForContact;

@end

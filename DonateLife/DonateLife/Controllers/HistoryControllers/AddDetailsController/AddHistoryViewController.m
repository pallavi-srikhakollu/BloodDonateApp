//
//  AddHistoryViewController.m
//  DonateLife
//
//  Created by webonise on 09/09/15.
//  Copyright (c) 2015 webonise. All rights reserved.
//

#import "AddHistoryViewController.h"

@interface AddHistoryViewController ()
{
 IBOutlet UITextField *textFieldLocation;
}
@end

@implementation AddHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self intializeBarButton];
   // _datePicker.datePickerMode = UIDatePickerModeDate;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)intializeBarButton{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(buttonActionAddDetails)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    

}


- (void)buttonActionAddDetails {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/YY"];
    NSString *str = [dateFormatter stringFromDate:[_datePicker date]];
    NSLog(@"%@",str);
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
//    HistoryListViewController *historyListViewController = [storyboard instantiateViewControllerWithIdentifier:@"HistoryListViewController"];
//    [arrayOfLocations addObject : textFieldLocation];
//    [arrayOfDates addObject:str];
//    [arrayOfLocations addObject:textFieldLocation.text];
//    [arrayOfDates addObject:str];
    [self.navigationController popViewControllerAnimated:YES];
}



@end



#import "FrontViewController.h"


@interface FrontViewController ()
{

CLLocation *userLocation;
}

@property NSArray* settingList;
@property NSArray *bloodTypes;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintHeightForTable;

@end

@implementation FrontViewController

@synthesize locationManager;
@synthesize settingList;
@synthesize bloodTypes;
@synthesize layoutConstraintHeightForTable;
@synthesize tableViewBloodList;
@synthesize tableViewForSettings;
@synthesize dictonaryForDonar;
@synthesize dictonaryForInfo;
- (void)viewDidLoad {
  
    [super viewDidLoad];
       NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBarHidden = false;

    if(![[[defaults dictionaryRepresentation] allKeys] containsObject:@"user"])
    {
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RegistrationPageViewController *registration = [storyboard instantiateViewControllerWithIdentifier:@"RegistrationPageViewController"];
        NSLog(@"%@",self.navigationController);
        [self.navigationController pushViewController:registration animated:NO];

    }
    
       layoutConstraintHeightForTable.constant = 0;
    settingList = [[NSArray alloc]initWithObjects:@"Edit Profile",@"Privacy", nil];
    bloodTypes =[[NSArray alloc] initWithObjects:@"A+",@"A-",@"B+",@"B-",@"AB+",@"AB-",@"O+",@"O-", nil];
    [self gettingCurrentLocation];
    NSLog(@"%f",userLocation.coordinate.latitude);
    locationManager.pausesLocationUpdatesAutomatically = YES;    
    _arrayOfDonars = [[NSMutableArray alloc]init];
    dictonaryForInfo = @{@"data":@[
                                 @{
                                     @"id":@1234,
                                     @"name":@"Sandeep Rathore",
                                     @"phone":@"+918149325524",
                                     @"email":@"sandeep.rathore@weboniselab.com",
                                     @"lat":@19.017615,
                                     @"lng":@72.856164
                                     },
                                 @{
                                     @"id":@3243,
                                     @"name":@"Chirag",
                                     @"phone":@"+918149325524",
                                     @"email":@"chirag@weboniselab.com",
                                     @"lat":@28.538048,
                                     @"lng":@73.786755
                                     },
                                 @{
                                     @"id":@3424,
                                     @"name":@"Hardik Trivedi",
                                     @"phone":@"+918149325524",
                                     @"email":@"hardik.trivedi@weboniselab.com",
                                     @"lat":@18.517214,
                                     @"lng":@73.780489
                                     },
                                 ],
                         @"error": @{
                                 @"errorCode":@400,
                                 @"message":@""
                                 },
                         @"status": @{
                                 @"statusCode":@200,
                                 @"message":@"Success"
                                 }
                         };
    [self parseData];
    
    [self convertToJson];
    
    
    

}




-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = false;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark :- parsing json
-(void)parseData{
    NSLog(@"%@",[dictonaryForInfo valueForKeyPath:@"error.errorCode" ] );
    if([[dictonaryForInfo valueForKeyPath:@"status.statusCode" ] isEqualToValue: @200] )
    {
        NSMutableDictionary *donar;
        for(donar in [dictonaryForInfo valueForKey:@"data"])
        {
            Donor *donarInfo = [[Donor alloc]init];
            
            donarInfo.name = [donar valueForKey:@"name"];
            
            donarInfo.email = [donar valueForKey:@"email"];
            donarInfo.phoneNo = [donar valueForKey:@"phone"];
            donarInfo.lattitude = [[donar valueForKey:@"lat"] integerValue];
            donarInfo.longitude  = [[ donar valueForKey:@"lng"] integerValue];
            [_arrayOfDonars addObject:donarInfo];
        }
        
    }
}



- (IBAction)buttonHistoryAction:(id)sender {
}
- (IBAction)buttonSearchBloodAction:(id)sender {
    layoutConstraintHeightForTable.constant = 200;
    [tableViewBloodList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [tableViewBloodList reloadData];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tableViewForSettings removeFromSuperview];
    //[self.bloodTypePicker removeFromSuperview];
}
- (IBAction)barButtonSettingAction:(id)sender {
    
    
    if(![self.tableViewForSettings isDescendantOfView:self.view]) {
        tableViewForSettings=[[UITableView alloc]init];
        tableViewForSettings.frame = CGRectMake(35,30,120,80);
        
        tableViewForSettings.dataSource= self;
        tableViewForSettings.delegate=self;
        [tableViewForSettings registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [tableViewForSettings reloadData];
        
        [self.view addSubview:self.tableViewForSettings];
    }
    else {
        [self.tableViewForSettings removeFromSuperview];
    }
    
    
}
#pragma mark - current location

-(void)gettingCurrentLocation{

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
  
    [locationManager requestWhenInUseAuthorization];
    
    
    [locationManager startUpdatingLocation];


}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
        userLocation = [locations lastObject];
    
        NSLog(@"%f",userLocation.coordinate.latitude);
        NSLog(@"%f",userLocation.coordinate.latitude);
[locationManager stopUpdatingLocation];
    
    }


#pragma mark - setting's Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == tableViewForSettings){
        return settingList.count;
    }
    else{
        return bloodTypes.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tableViewForSettings){
        UITableViewCell *cell = [[UITableViewCell alloc]init] ;
        cell.textLabel.text = [settingList objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:77.0/255.0f green:104.0/255.0f blue:159.0/255.0f alpha:1.0];  ;
        
        return cell;
    }
    else{
        UITableViewCell *cell = [[UITableViewCell alloc]init] ;
        cell.textLabel.text = [bloodTypes objectAtIndex:indexPath.row];
        
        return cell;
        
        
    }
}

#pragma mark - Selecting row on table view

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(tableView == tableViewBloodList){
            self.navigationController.navigationBarHidden = false;
        layoutConstraintHeightForTable.constant = 0;
        _donorsDisplayViewController = [storyboard instantiateViewControllerWithIdentifier:@"DonorsDisplayViewController"];
        NSLog(@"%@",userLocation);
        _donorsDisplayViewController.donorsArray = _arrayOfDonars;
        _donorsDisplayViewController.userLocation = userLocation;
      [self.navigationController  pushViewController:_donorsDisplayViewController animated:YES];
        
    }
    else if(tableView == tableViewForSettings){
        switch (indexPath.row) {
            case 0:{
                [self.tableViewForSettings removeFromSuperview];
                RegistrationPageViewController *registration = [storyboard instantiateViewControllerWithIdentifier:@"RegistrationPageViewController"];
                NSLog(@"%@",self.navigationController);
                registration.registerOrUpdate = YES;
                [self.navigationController pushViewController:registration animated:YES];
            }
                
                break;
            case 1:{
                
                NSLog(@"ON setings screen");
                break;
            }
            default:
                break;
        }
    }
}




-(void)convertToJson {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictonaryForInfo
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSLog(@"%@",jsonData);
    NSString* aStr;
    aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",aStr);
    
}

@end




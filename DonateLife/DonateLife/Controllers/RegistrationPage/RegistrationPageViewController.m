

#import "RegistrationPageViewController.h"
#define FRONTVIEWCONTROLLER @"FrontViewController"
#import "FrontViewController.h"
@interface RegistrationPageViewController ()
{
    NSInteger selectedRowAtPicker;
    NSString *privacy;
    NSUserDefaults *defaults;
  IBOutlet UIButton *buttonForRegisterAndUpdate;
     IBOutlet UITextField *textFieldName;
  IBOutlet UIPickerView *pickerViewBloodTypes;
     IBOutlet UITextField *textFieldMobileNo;
   IBOutlet UITextField *textFieldEmailId;
    NSMutableDictionary * dictonaryToPost;
    CLLocationManager *locationManager;
  //  CLLocation *userLocation;


}
@end

@implementation RegistrationPageViewController

//@synthesize bloodTypes ;
@synthesize userLocation;

- (void)viewDidLoad {
     [super viewDidLoad];
    defaults =  [NSUserDefaults standardUserDefaults];
      self.navigationController.navigationBarHidden = true;
    textFieldName.delegate = self;
    textFieldMobileNo.delegate =self;
    textFieldEmailId.delegate = self;
   
    if(_registerOrUpdate == YES)
    {
        [self updateScreen];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark : Custom functions


-(NSString *)trimWhiteSpaces:(NSString *)inputString{
    
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return inputString;
}
    
-(void)alertMessageDisplay:(NSString *)title withMessage:(NSString *)message{
UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
  [alertView show];
}

-(void)updateScreen{

    self.navigationController.navigationBarHidden = false;
    [buttonForRegisterAndUpdate setTitle:@"UPDATE" forState:UIControlStateNormal];
    
    textFieldName.text = [[defaults dictionaryRepresentation] valueForKey:NAME];
    textFieldMobileNo.text = [[defaults dictionaryRepresentation] valueForKey:PHONENO];
    textFieldEmailId.text = [[defaults dictionaryRepresentation] valueForKey:EMAIL];
    [pickerViewBloodTypes selectRow:[BLOODTYPES indexOfObject:[[defaults dictionaryRepresentation] valueForKey:BLOODTYPE]]inComponent:0 animated:YES];
    privacy =   [[defaults dictionaryRepresentation] valueForKey:PRIVACY];
    if([privacy isEqualToString:ON])
        [_switchForPrivacy setOn:YES];
    else
        [_switchForPrivacy setOn:NO];
    [self gettingCurrentLocation];
    [self DicitonaryFormation];
    [self convertToJson:dictonaryToPost];
}
    






#pragma mark : ButtonActions


- (IBAction)buttonActionRegister:(id)sender {
    if([[self trimWhiteSpaces:(textFieldName.text)] isEqualToString:@""]) {
    
        [self alertMessageDisplay:titleForEmpty withMessage:@"Name cannot be empty"];
    
    }
    else if([[self trimWhiteSpaces:(textFieldMobileNo.text)] isEqualToString:@""]) {
        
        [self alertMessageDisplay:titleForEmpty withMessage:@"Mobile number cannot be empty"];
        
    }
    else if([[self trimWhiteSpaces:(textFieldEmailId.text)] isEqualToString:@""]) {
    
        [self alertMessageDisplay:titleForEmpty withMessage:@"Email ID cannot be empty"];
        
    }
    else{
    
    
    NSLog(@"%d",_switchForPrivacy.on);
  
        if(_switchForPrivacy.on == 1){
            privacy = ON;
        }
        else{
        
            privacy = OFF;

        }
        
    [defaults setObject:textFieldName.text forKey:NAME];
    [defaults setObject:textFieldMobileNo.text forKey:PHONENO];
    [defaults setObject:textFieldEmailId.text forKey:EMAIL];
    [defaults setObject:[BLOODTYPES objectAtIndex:selectedRowAtPicker] forKey:BLOODTYPE];
    [defaults setObject:privacy forKey:PRIVACY];
    [defaults setObject:REGISTERED forKey:@"user"];
    [defaults synchronize];
    
    NSLog(@"Data saved");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FrontViewController *front = [storyboard instantiateViewControllerWithIdentifier:FRONTVIEWCONTROLLER];
        NSLog(@"%@",self.navigationController);
        [self.navigationController pushViewController:front animated:YES];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return BLOODTYPES.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [BLOODTYPES objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedRowAtPicker = row;
    NSLog(@"%@",[BLOODTYPES objectAtIndex:row]);
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



#pragma mark : API Handling

-(void)convertToJson:(NSDictionary *)dicitonaryToConvert {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicitonaryToConvert
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSLog(@"%@",jsonData);
    NSString* aStr;
    aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",aStr);
    
}
-(void) DicitonaryFormation{
    NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
    dictonaryToPost = [[NSMutableDictionary alloc]init];
    [user setObject:textFieldName.text forKey:NAME];
    [user setObject:textFieldMobileNo.text forKey:PHONENO];
    [user setObject:textFieldEmailId.text forKey:EMAIL];
    [user setObject:[BLOODTYPES objectAtIndex:selectedRowAtPicker] forKey:BLOODTYPE];
    
    [dictonaryToPost setObject:[[NSNumber numberWithFloat:userLocation.coordinate.latitude] stringValue]  forKey:@"lat"];
    
    [dictonaryToPost setObject:[[NSNumber numberWithFloat:userLocation.coordinate.longitude] stringValue]  forKey:@"lng"];
    [dictonaryToPost setObject:user forKey:@"user"];
    
   
}




@end

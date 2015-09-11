

#import "RegistrationPageViewController.h"
#define FRONTVIEWCONTROLLER @"FrontViewController"
#import "FrontViewController.h"
#define UPDATE @"UPDATE"
#define MESSAGEFOREMPTYNAMEFEILD @"Name cannot be empty"
#define MESSAGEFOREMPTYPHONEFEILD @"Input a valid Mobile No "
#define MESSAGEFOREMPTYEMAILIDFEILD @"Input a valid Email ID "


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
    float keyboardHeight;
  //  CLLocation *userLocation;


}
@end

@implementation RegistrationPageViewController

@synthesize userLocation;

- (void)viewDidLoad {
     [super viewDidLoad];
    defaults =  [NSUserDefaults standardUserDefaults];
    [self setViewWithCustomSetting];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
}


#pragma mark:View settings

-(void)setViewWithCustomSetting{
    self.navigationController.navigationBarHidden = true;
    
    [self gettingCurrentLocation];
    
    if(_registerOrUpdate == YES)
    {
        [self updateScreen];
    }
    [self setkeyBoardNotification];

}

#pragma mark:KeyBoard notification
-(void)setkeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark: TextFeildDelegate
-(void)setTextFieldDelegates{
    textFieldName.delegate = self;
    textFieldMobileNo.delegate =self;
    textFieldEmailId.delegate = self;
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
   
    [buttonForRegisterAndUpdate setTitle:UPDATE forState:UIControlStateNormal];
    
    textFieldName.text = [[defaults dictionaryRepresentation] valueForKey:NAME];
    textFieldMobileNo.text = [[defaults dictionaryRepresentation] valueForKey:PHONENO];
    textFieldEmailId.text = [[defaults dictionaryRepresentation] valueForKey:EMAIL];
    [pickerViewBloodTypes selectRow:[BLOODTYPES indexOfObject:[[defaults dictionaryRepresentation] valueForKey:BLOODTYPE]]inComponent:0 animated:YES];
    
    privacy =   [[defaults dictionaryRepresentation] valueForKey:PRIVACY];
    if([privacy isEqualToString:ON])
        [_switchForPrivacy setOn:YES];
    else
        [_switchForPrivacy setOn:NO];
    
    [self DicitonaryFormation];
    [self convertToJson:dictonaryToPost];
}
    






#pragma mark : ButtonActions


- (IBAction)buttonActionRegister:(id)sender {
    if([[self trimWhiteSpaces:(textFieldName.text)] isEqualToString:EMPTYSTRING]) {
    
        [self alertMessageDisplay:titleForEmpty withMessage:MESSAGEFOREMPTYNAMEFEILD];
    
    }
    else if([[self trimWhiteSpaces:(textFieldMobileNo.text)] isEqualToString:EMPTYSTRING] || (textFieldMobileNo.text.length <10) || (textFieldMobileNo.text.length >10) ) {
        
        [self alertMessageDisplay:titleForEmpty withMessage:MESSAGEFOREMPTYPHONEFEILD];
        
    }
    else if([[self trimWhiteSpaces:(textFieldEmailId.text)] isEqualToString:EMPTYSTRING] || ([self validateEmailWithString:(textFieldEmailId.text)] == 0)) {
    
        [self alertMessageDisplay:titleForEmpty withMessage:MESSAGEFOREMPTYEMAILIDFEILD];
        
    }
    else{
    
    
   // NSLog(@"%d",_switchForPrivacy.on);
  
        if(_switchForPrivacy.on == 1){
            privacy = ON;
        }
        else{
        
            privacy = OFF;

        }
        
        if([CLLocationManager locationServicesEnabled] &&
           [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied &&(userLocation.coordinate.latitude != 0.000000)) {
            [self savingDataIntoUserDefaults ];
            [self DicitonaryFormation];
            [self convertToJson:dictonaryToPost];
        }
        else if (userLocation.coordinate.latitude == 0.0){
            [self alertMessageDisplay:ERRORFORLOCATION withMessage:ALERTMESSAGEFORLOCATIONERROR];
            
        }
        else {
            //NSLog(@"disllowed gps");
            [self alertMessageDisplay:ERRORFORLOCATION withMessage:ALERTMESSAGEFORLOCATIONERROR];

        }
        
        
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
        FrontViewController *front = [storyboard instantiateViewControllerWithIdentifier:FRONTVIEWCONTROLLER];
      
        [self.navigationController pushViewController:front animated:NO];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark : saving data into user defaults

-(void)savingDataIntoUserDefaults{
    [self gettingCurrentLocation];
    
    [defaults setObject:textFieldName.text forKey:NAME];
    [defaults setObject:textFieldMobileNo.text forKey:PHONENO];
    [defaults setObject:textFieldEmailId.text forKey:EMAIL];
    [defaults setObject:[BLOODTYPES objectAtIndex:selectedRowAtPicker] forKey:BLOODTYPE];
    [defaults setObject:privacy forKey:PRIVACY];
    [defaults setObject:REGISTERED forKey:USER];
    [defaults synchronize];
    


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
    //NSLog(@"%@",jsonData);
    NSString* aStr;
    aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",aStr);
    
}
-(void) DicitonaryFormation{
    NSMutableDictionary *user = [[NSMutableDictionary alloc]init];
    dictonaryToPost = [[NSMutableDictionary alloc]init];
    [user setObject:textFieldName.text forKey:NAME];
    [user setObject:textFieldMobileNo.text forKey:PHONENO];
    [user setObject:textFieldEmailId.text forKey:EMAIL];
    [user setObject:[BLOODTYPES objectAtIndex:selectedRowAtPicker] forKey:BLOODTYPE];
    NSLog(@"%f",userLocation.coordinate.latitude);
    [dictonaryToPost setObject:[[NSNumber numberWithFloat:userLocation.coordinate.latitude] stringValue]  forKey:LATTITUDE];
    
    [dictonaryToPost setObject:[[NSNumber numberWithFloat:userLocation.coordinate.longitude] stringValue]  forKey:LONGITUDE];
    [dictonaryToPost setObject:user forKey:USER];
    
   
}

#pragma mark : email validation
- (BOOL)validateEmailWithString:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSLog(@"%hhd",[emailTest evaluateWithObject:checkString]);
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark : Keyboard functions

-(void)keyboardWasShown:(NSNotification *)notification{
   
    NSDictionary *keyboardInfo = [notification userInfo];
    CGSize keyboardSize = [[keyboardInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
     keyboardHeight = keyboardSize.height;
    _layoutConstarintScrollViewBottom .constant = _layoutConstarintScrollViewBottom.constant + keyboardHeight;

}


-(void)keyboardWillHide:(NSNotification *)notification{
    _layoutConstarintScrollViewBottom .constant = _layoutConstarintScrollViewBottom.constant - keyboardHeight;

}
@end

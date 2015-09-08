

#import "RegistrationPageViewController.h"
//#define titleForEmpty @"Empty Field"
#import "FrontViewController.h"
@interface RegistrationPageViewController ()
{
    NSInteger selectedRowAtPicker;
    NSString *privacy;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonForRegisterAndUpdate;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewBloodTypes;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMobileNo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmailId;

@end

@implementation RegistrationPageViewController

@synthesize bloodTypes ;


- (void)viewDidLoad {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.navigationController.navigationBarHidden = false;
    bloodTypes =[[NSArray alloc] initWithObjects:@"A+",@"A-",@"B+",@"B-",@"AB+",@"AB-",@"O+", nil];
    
    [super viewDidLoad];
    if(_registerOrUpdate == YES)
    {
        self.navigationController.navigationBarHidden = false;
        [_buttonForRegisterAndUpdate setTitle:@"UPDATE" forState:UIControlStateNormal];
      
        _textFieldName.text = [[defaults dictionaryRepresentation] valueForKey:@"name"];
        _textFieldMobileNo.text = [[defaults dictionaryRepresentation] valueForKey:@"mobileNo"];
        _textFieldEmailId.text = [[defaults dictionaryRepresentation] valueForKey:@"email"];
        [_pickerViewBloodTypes selectRow:[bloodTypes indexOfObject:[[defaults dictionaryRepresentation] valueForKey:@"bloodType"]]inComponent:0 animated:YES];
     privacy =   [[defaults dictionaryRepresentation] valueForKey:@"privacy"];
        if([privacy isEqualToString:@"on"])
[_switchForPrivacy setOn:YES];
        else
         [_switchForPrivacy setOn:NO];
    }


}

-(NSString *)trimWhiteSpaces:(NSString *)inputString{
    
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return inputString;
}
-(void)alertMessageDisplay:(NSString *)title withMessage:(NSString *)message{
UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
  [alertView show];
}

- (IBAction)buttonActionRegister:(id)sender {
    if([[self trimWhiteSpaces:(_textFieldName.text)] isEqualToString:@""]) {
    
        [self alertMessageDisplay:titleForEmpty withMessage:@"Name cannot be empty"];
    
    }
    else if([[self trimWhiteSpaces:(_textFieldMobileNo.text)] isEqualToString:@""]) {
        
        [self alertMessageDisplay:titleForEmpty withMessage:@"Mobile number cannot be empty"];
        
    }
    else if([[self trimWhiteSpaces:(_textFieldEmailId.text)] isEqualToString:@""]) {
        
        [self alertMessageDisplay:titleForEmpty withMessage:@"Email ID cannot be empty"];
        
    }
    else{
    
    
    NSLog(@"%d",_switchForPrivacy.on);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if(_switchForPrivacy.on == 1){
            privacy = @"on";
        }
        else{
        
            privacy = @"off";

        }
        
    [defaults setObject:_textFieldName.text forKey:@"name"];
    [defaults setObject:_textFieldMobileNo.text forKey:@"mobileNo"];
    [defaults setObject:_textFieldEmailId.text forKey:@"email"];
    [defaults setObject:[bloodTypes objectAtIndex:selectedRowAtPicker] forKey:@"bloodType"];
    [defaults setObject:privacy forKey:@"privacy"];
    [defaults setObject:@"Registered"forKey:@"user"];
    [defaults synchronize];
    
    NSLog(@"Data saved");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FrontViewController *front = [storyboard instantiateViewControllerWithIdentifier:@"FrontViewController"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return bloodTypes.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [bloodTypes objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedRowAtPicker = row;
    NSLog(@"%@",[bloodTypes objectAtIndex:row]);
}


@end

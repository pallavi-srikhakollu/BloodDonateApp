

#import "AddHistoryViewController.h"
#define NOIMAGE @"No Image"
#define DATEFORMAT @"dd/MM/yy"
@interface AddHistoryViewController ()
{
    IBOutlet UITextField *textFieldLocation;
    NSArray *fetchedListFromDatabase;
    NSMutableDictionary *dictionaryToInsert;
    UIImagePickerController *imagePicker;
    NSMutableString *imageName;
    NSString *date;
    UIBarButtonItem *addButton;
    
}
@end

@implementation AddHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self intializeBarButton];
    _datePicker.maximumDate = [NSDate date];
    textFieldLocation.delegate = self;
    
//DBHelper *databaseHelper = [[DBHelper alloc]init];
    
    if(_isUpadte){
        [addButton setTitle:@"update"];

        textFieldLocation.text = _historyInfo.location;
             NSLog(@"%@",_historyInfo.date);
          NSLog(@"%@",_historyInfo.certificateImage);
        NSDateFormatter *format         =   [[NSDateFormatter alloc] init];
        [format setDateFormat:@"dd/MM/yy"];
        NSLog(@"%@",_historyInfo.date);
        NSDate      *tmp   =   [format dateFromString:_historyInfo.date];
       
        [_datePicker setDate:tmp animated:YES];
        [_buttonForImage setImage:[ self fetchImagesFromDbWithFileName:_historyInfo.certificateImage] forState:UIControlStateNormal];
 
        _idTobeInsertedAt =[ _historyInfo.idNo intValue];
        
          }
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)intializeBarButton{
     addButton = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(buttonActionAddDetails)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
}
#pragma mark : Database
-(void)setDatabase{
    
    
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}




#pragma mark : Add details Action
- (void)buttonActionAddDetails {
    if([[self trimWhiteSpaces:(textFieldLocation.text)] isEqualToString:EMPTYSTRING])
    {
        [self alertMessageDisplay:titleForEmpty withMessage:@"PleaseEnterLocation"];
        
    }
    else{
        
        [self dateFormatter];
        DBHelper *databaseHelper = [[DBHelper alloc]init];
        databaseHelper.dbName = @"HistoryInfo";
        databaseHelper.context = [self managedObjectContext];
        
        if(_isUpadte){
            _idTobeInsertedAt = [_historyInfo.idNo intValue];
           imageName = _historyInfo.certificateImage;
            [self dicitonaryTosave];
            NSLog(@"%@",imageName);
            NSLog(@ "%@",[NSString stringWithFormat:@"%@ = '%@'",IDNO,[NSString stringWithFormat: @"%@", _historyInfo.idNo]]);
                    NSPredicate *predicate =[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = '%@'",IDNO,[NSString stringWithFormat: @"%@", _historyInfo.idNo]]];
                    [databaseHelper updateWithPredicate:predicate withUpdatedKey:dictionaryToInsert];
            
        }
        else{
            _idTobeInsertedAt ++;
        [self dicitonaryTosave];
        [databaseHelper insertIntoTable:dictionaryToInsert];
        
        }
        //[self dicitonaryTosave];
        [self saveImageToPhoneWithImageName:imageName];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)dicitonaryTosave{
   // _idTobeInsertedAt ++;
    
    dictionaryToInsert = [[NSMutableDictionary alloc]init];
    NSLog(@"%@",textFieldLocation.text);
    [dictionaryToInsert setObject:textFieldLocation.text forKey:LOCATION];
    
   
    [dictionaryToInsert setObject:[self dateFormatter] forKey:DATE];
    [dictionaryToInsert setObject:[NSString stringWithFormat:@"%d", _idTobeInsertedAt] forKey:IDNO];
    [dictionaryToInsert setObject:imageName forKey:CERTIFICATE];
    
    
}
-(NSString *)dateFormatter{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATEFORMAT];
    date = [dateFormatter stringFromDate:[_datePicker date]];
    NSString *dateString = [dateFormatter stringFromDate:[_datePicker date]];
    NSLog(@"%@",dateString);
    return dateString;
}

-(NSString *)trimWhiteSpaces:(NSString *)inputString{
    
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return inputString;
}

-(void)alertMessageDisplay:(NSString *)title withMessage:(NSString *)message{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)buttonActionAddPhoto:(id)sender {
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self alertActionIntializer];
    //[self presentViewController:picker animated:YES completion:NULL];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [_buttonForImage setImage:chosenImage forState:UIControlStateNormal];
    [_buttonForImage setTitle:@"" forState:UIControlStateNormal];
    
    NSLog(@"textfeild %@",textFieldLocation.text);
   
    imageName = [[NSMutableString alloc]init];
    [imageName appendString:textFieldLocation.text];
    NSLog(@"%@",imageName);
     [self dateFormatter];
    [imageName appendString: [NSString stringWithFormat: @"%d", _idTobeInsertedAt]];
    [imageName appendString:@".JPG"];
    
    NSLog(@"Image name %@",imageName);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)saveImageToPhoneWithImageName:(NSString*)withImageName{
    NSData *imageBuffer = UIImagePNGRepresentation([_buttonForImage imageForState:UIControlStateNormal]);
                                   
    NSLog(@"NS DATA%@",imageBuffer);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = [paths objectAtIndex:0];
    
    NSString *filepath = [documentpath stringByAppendingPathComponent:imageName];
    NSLog(@"File path%@",filepath);
    
    [imageBuffer writeToFile:filepath atomically:YES];
    
}
#pragma mark: AlertAction

-(void)alertActionIntializer{

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"PhotoLibrary" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;[self presentViewController:imagePicker animated:YES completion:NULL];
    }];
    UIAlertAction* optional = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //picker.sourceType = UIImagePickerControllerSourceTypeCamera;[self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Input alert!!" message:@"Select image from "
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:defaultAction];
    [alert addAction:optional];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark:- fetch images
-(UIImage *)fetchImagesFromDbWithFileName : (NSString *)filename{
    UIImage *image;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = [path objectAtIndex:0];
    NSString *fileToRetreivePath = [documentpath stringByAppendingPathComponent:filename];
    //NSLog(@"%@",fileToRetreivePath);
    NSData *imageData = [NSData dataWithContentsOfFile:fileToRetreivePath];
    image = [UIImage imageWithData:imageData];
    return image;
}
@end

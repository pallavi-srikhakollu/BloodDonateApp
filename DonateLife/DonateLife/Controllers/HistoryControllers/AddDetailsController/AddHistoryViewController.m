

#import "AddHistoryViewController.h"
#define NOIMAGE @"No Image"
#define DATEFORMAT @"dd/MM/YY"
@interface AddHistoryViewController ()
{
 IBOutlet UITextField *textFieldLocation;
    NSArray *fetchedListFromDatabase;
    NSMutableDictionary *dictionaryToInsert;
   
}
@end

@implementation AddHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self intializeBarButton];
    _datePicker.maximumDate = [NSDate date];
   
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
    [self dateFormatter];
    DBHelper *databaseHelper = [[DBHelper alloc]init];
    databaseHelper.dbName = @"HistoryInfo";
    databaseHelper.context = [self managedObjectContext];
    [self dicitonaryTosave];
    [databaseHelper insertIntoTable:dictionaryToInsert];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dicitonaryTosave{
    _idTobeInsertedAt ++;
    
    dictionaryToInsert = [[NSMutableDictionary alloc]init];
    [dictionaryToInsert setObject:textFieldLocation.text forKey:LOCATION];
    [dictionaryToInsert setObject:[self dateFormatter] forKey:DATE];
    [dictionaryToInsert setObject:[NSString stringWithFormat:@"%d", _idTobeInsertedAt] forKey:IDNO];
    [dictionaryToInsert setObject:NOIMAGE forKey:CERTIFICATE];


}
-(NSString*)dateFormatter{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATEFORMAT];
    NSString *str = [dateFormatter stringFromDate:[_datePicker date]];
    NSLog(@"%@",str);
    return str;
}



@end

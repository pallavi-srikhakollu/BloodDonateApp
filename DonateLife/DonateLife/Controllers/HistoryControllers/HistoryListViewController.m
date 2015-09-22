

#import "HistoryListViewController.h"
#define ADDETAILSVIEWCONTROLLER @"AddHistoryViewController"
#define BARBUTTONTITLE @"Add"

@interface HistoryListViewController ()
{
    
    DBHelper *databaseHelper;
    NSArray * fetchedObjectsFromDatabase;
    UIStoryboard *storyboard;
    AddHistoryViewController *addHistoryViewController;
}

@end

@implementation HistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = false;
    [self databaseSetter];
    
    [self intializeBarButton];
    [_tableViewForHistory registerNib:[UINib nibWithNibName:@"HistoryCustomTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
addHistoryViewController    = [storyboard instantiateViewControllerWithIdentifier:ADDETAILSVIEWCONTROLLER];


    
}

-(void)viewWillAppear:(BOOL)animated{
    fetchedObjectsFromDatabase =[databaseHelper fetchAll];
    [_tableViewForHistory reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark: Database

-(void)databaseSetter{
    databaseHelper = [[DBHelper alloc]init];
    databaseHelper.dbName = @"HistoryInfo";
    NSLog(@"%@",databaseHelper.dbName);
    databaseHelper.context =[self managedObjectContext];
    
    
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


#pragma mark: barButton

-(void)intializeBarButton{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:BARBUTTONTITLE style:UIBarButtonItemStylePlain target:self action:@selector(buttonActionAddDetails)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
}


- (void)buttonActionAddDetails {
//        AddHistoryViewController *addHistoryViewController = [storyboard instantiateViewControllerWithIdentifier:ADDETAILSVIEWCONTROLLER];
    
    
    addHistoryViewController.idTobeInsertedAt = [[[fetchedObjectsFromDatabase lastObject ]valueForKey:IDNO ]intValue];
    [self.navigationController pushViewController:addHistoryViewController animated:YES];
}




#pragma mark : Table view functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return fetchedObjectsFromDatabase.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCustomTableViewCell *cell;
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    NSLog(@"%@", [[fetchedObjectsFromDatabase objectAtIndex:indexPath.row ]valueForKey:LOCATION ]);
    cell.labelForLocation.text = [[fetchedObjectsFromDatabase objectAtIndex:indexPath.row ]valueForKey:LOCATION ];
    cell.labelForDate.text = [NSString stringWithFormat: @"Date: %@",  [[fetchedObjectsFromDatabase objectAtIndex:indexPath.row]valueForKey:DATE]];
    cell.imageViewForCetificate.layer.cornerRadius = cell.imageViewForCetificate.frame.size.height /2;
    cell.buttonForDelete.tag = [[[fetchedObjectsFromDatabase objectAtIndex:indexPath.row] valueForKey:IDNO] integerValue];
    NSString *imageName = [[fetchedObjectsFromDatabase objectAtIndex:indexPath.row]valueForKey:@"certificateImage"];
    
       if([imageName isEqual:NOIMAGE] || [imageName isEqual:EMPTYSTRING]){
    
    }
    else{
        cell.imageViewForCetificate.backgroundColor = [UIColor clearColor];
         cell.imageViewForCetificate.image = [self fetchImagesFromDbWithFileName:imageName];
    }
   
    cell.tag = [[[fetchedObjectsFromDatabase objectAtIndex:indexPath.row] valueForKey:IDNO] integerValue];
   // NSLog(@"date of every cell",)
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [_tableViewForHistory cellForRowAtIndexPath:indexPath];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = '%@'",IDNO,[NSString stringWithFormat: @"%ld", (long)cell.tag]]];
    NSArray *WithID = [databaseHelper fetch:predicate];

    addHistoryViewController.historyInfo = [self parseIntoModel:WithID];
    NSLog(@"locvation from history view%@", addHistoryViewController.historyInfo.date);
    addHistoryViewController.isUpadte = YES;
       [self.navigationController pushViewController:addHistoryViewController animated:YES];

    NSLog(@"%@",WithID);
    
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

# pragma mark : Parsing into model

-(HistoryInfo * )parseIntoModel:(NSArray *)arrayWithValues{

    HistoryInfo *historyInfo = [[HistoryInfo alloc]init];
    historyInfo.location =[[arrayWithValues firstObject]valueForKey:LOCATION];
    historyInfo.idNo = [[arrayWithValues firstObject]valueForKey:IDNO];
    historyInfo . certificateImage =  [[arrayWithValues firstObject]valueForKey:CERTIFICATE];
    historyInfo.date =    [[arrayWithValues firstObject]valueForKey:DATE];
    //historyInfo.date =  [[arrayWithValues firstObject]valueForKey:DATE];
  //  addHistoryViewController.historyInfo  = historyInfo;
    NSLog(@"%@ in parse model",historyInfo.date);
    return historyInfo;
}

@end

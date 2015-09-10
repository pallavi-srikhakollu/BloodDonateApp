

#import "HistoryListViewController.h"
#define ADDETAILSVIEWCONTROLLER @"AddHistoryViewController"
#define BARBUTTONTITLE @"Add"

@interface HistoryListViewController ()
{

 DBHelper *databaseHelper;
    NSArray * fetchedObjectsFromDatabase;
}

@end

@implementation HistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = false;
    [self databaseSetter];
    
     [self intializeBarButton];

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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
    AddHistoryViewController *addHistoryViewController = [storyboard instantiateViewControllerWithIdentifier:ADDETAILSVIEWCONTROLLER];
   

    addHistoryViewController.idTobeInsertedAt = [fetchedObjectsFromDatabase count];
    [self.navigationController pushViewController:addHistoryViewController animated:YES];
}




#pragma mark : Table view functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fetchedObjectsFromDatabase.count;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [[fetchedObjectsFromDatabase objectAtIndex:indexPath.row ]valueForKey:@"location" ];
   cell.detailTextLabel.text = [NSString stringWithFormat: @"Date: %@",  [[fetchedObjectsFromDatabase objectAtIndex:indexPath.row]valueForKey:@"date"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


   
}




@end

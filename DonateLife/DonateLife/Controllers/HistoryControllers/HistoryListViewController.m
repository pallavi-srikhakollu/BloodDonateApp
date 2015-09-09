

#import "HistoryListViewController.h"

@interface HistoryListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableViewForHistory;

@end

@implementation HistoryListViewController
//@synthesize arrayOfLocation;
//@synthesize arrayOfDates;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = false;
     [self intializeBarButton];
//    arrayOfDates = [[NSMutableArray alloc]init];
//    arrayOfLocations = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{

    [_tableViewForHistory reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    // Dispose of any resources that can be recreated.
}

#pragma mark: barButton 

-(void)intializeBarButton{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(buttonActionAddDetails)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
}


- (void)buttonActionAddDetails {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
    AddHistoryViewController *addHistoryViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddHistoryViewController"];
    [self.navigationController pushViewController:addHistoryViewController animated:YES];
}




#pragma mark : Table view functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
//  return arrayOfLocations.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
   // NSString * location = [arrayOfLocation objectAtIndex:indexPath.row];
    cell.textLabel.text = @"hii";
//    cell.textLabel.text = [NSString stringWithFormat: @"Location: %@",  [arrayOfLocations objectAtIndex:indexPath.row]];
//    cell.detailTextLabel.text = [NSString stringWithFormat: @"Date: %@",  [arrayOfDates objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
    AddHistoryViewController *addHistoryViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddHistoryViewController"];
    [self .navigationController pushViewController:addHistoryViewController animated:YES];


}




@end

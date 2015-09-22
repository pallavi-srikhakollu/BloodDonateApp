

#import <UIKit/UIKit.h>
#import "AddHistoryViewController.h"
#import "DBHelper.h"
#import "CustomCell/HistoryCustomTableViewCell.h"
#import "HistoryInfo.h"
@interface HistoryListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *arrayOfLocation;
@property NSMutableArray *arrayOfDates;
@property (weak, nonatomic) IBOutlet UITableView *tableViewForHistory;

@end

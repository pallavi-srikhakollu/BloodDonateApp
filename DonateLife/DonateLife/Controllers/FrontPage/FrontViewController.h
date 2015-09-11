

#import <UIKit/UIKit.h>
#import "RegistrationPageViewController.h"
#import "DonorsDisplayViewController.h"
#import "HistoryListViewController.h"

@interface FrontViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
//@property (strong, nonatomic) IBOutlet UIView *overlayView;

@property (weak, nonatomic) IBOutlet UITableView *tableViewBloodList;
@property DonorsDisplayViewController *donorsDisplayViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintHeightForTable;
@end

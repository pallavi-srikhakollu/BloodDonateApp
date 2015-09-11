
#import <UIKit/UIKit.h>
#import "HistoryListViewController.h"
#import "DBHelper.h"

@interface AddHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property  int idTobeInsertedAt;
 
@end

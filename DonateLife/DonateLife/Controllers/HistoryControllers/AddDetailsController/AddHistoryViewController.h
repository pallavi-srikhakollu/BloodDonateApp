
#import <UIKit/UIKit.h>
#import "HistoryListViewController.h"
#import "DBHelper.h"

@interface AddHistoryViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property  int idTobeInsertedAt;
 
@end

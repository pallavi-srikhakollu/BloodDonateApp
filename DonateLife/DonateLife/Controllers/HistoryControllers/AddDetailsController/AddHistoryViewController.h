
#import <UIKit/UIKit.h>
#import "HistoryListViewController.h"
#import "DBHelper.h"
#include "HistoryInfo.h"

@interface AddHistoryViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property  int idTobeInsertedAt;
@property (weak, nonatomic) IBOutlet UIButton *buttonForImage;
@property HistoryInfo *historyInfo;
@property BOOL isUpadte;
@end

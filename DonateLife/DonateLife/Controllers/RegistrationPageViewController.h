
#import <UIKit/UIKit.h>

@interface RegistrationPageViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property NSArray* bloodTypes;
@property (weak, nonatomic) IBOutlet UISwitch *switchForPrivacy;
@property BOOL registerOrUpdate;
-(NSString *)trimWhiteSpaces:(NSString *)inputString;
@end

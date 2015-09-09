
#import <UIKit/UIKit.h>

@interface RegistrationPageViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *switchForPrivacy;
@property BOOL registerOrUpdate;
@property CLLocation *userLocation;
-(NSString *)trimWhiteSpaces:(NSString *)inputString;
@end

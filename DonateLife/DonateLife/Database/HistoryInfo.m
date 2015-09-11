
#import "HistoryInfo.h"
#import "DatabaseHelper/DBHelper.h"
@implementation HistoryInfo
-(instancetype)init{
    
    self.location = @"";
    self.idNo = @"-1";
    self.date = @"";
    self.certificateImage = @"";

    return self;
}

@end

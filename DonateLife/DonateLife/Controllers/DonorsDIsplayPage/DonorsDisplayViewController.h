

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ListView.h"
#import "MapView.h"
#import "CustomTableViewCell.h"

@interface DonorsDisplayViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property  CLLocation *userLocation;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;
//@property ListView * listView;
//@property MapView * mapView;
@property NSMutableArray * donorsArray;
@end

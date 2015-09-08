

#import "DonorsDisplayViewController.h"

#define LISTVIEW @"ListView"
#define MAPVIEW @"MapView"

@interface DonorsDisplayViewController ()
{
    ListView * listView;
    MapView * mapView;

}
@end

@implementation DonorsDisplayViewController
@synthesize segmentedController;
@synthesize donorsArray;
@synthesize userLocation;
//@synthesize listView;
@synthesize viewContainer;
//@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    
    NSLog(@"navigation controller %@",self.navigationController);
    self.segmentedController.selectedSegmentIndex = 0;
    
    listView = [[[NSBundle mainBundle] loadNibNamed:LISTVIEW owner:self options:nil] lastObject];
    mapView = [[[NSBundle mainBundle] loadNibNamed:MAPVIEW owner:self options:nil] lastObject];
    //CellIdentifier = @"cell";
    listView.tableListForDonors.dataSource = self;
    listView.tableListForDonors.delegate =self;
    
     [listView.tableListForDonors registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self.viewContainer addSubview:listView];

    [self mapSettings];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark :MAP settings

-(void)mapSettings{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:userLocation.coordinate.latitude
                                                            longitude:userLocation.coordinate.longitude
                                                                 zoom:11];
    mapView.mapView.myLocationEnabled = YES;
    mapView.mapView.mapType = kGMSTypeNormal;
    
    mapView.mapView.settings.compassButton = YES;
    
    mapView.mapView.settings.myLocationButton = YES;
    
    mapView.mapView.delegate = self;
    mapView.mapView.camera = camera;

}

-(void)mapMarker:(CLLocation*)location withName:(NSString *)title withPhoneNo:(NSString*)phoneNo{
GMSMarker *marker = [GMSMarker markerWithPosition:location.coordinate];
    
    marker.map = mapView.mapView;
    marker.title =  title;
    marker .snippet = phoneNo;
    marker.infoWindowAnchor = CGPointMake(0.5, 0.5);

}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Input alert!!"
                                                                   message:@"Select image from "
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"DO you want to call " style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {NSLog(@"Hello");}];
    
    [alert addAction:defaultAction];
[self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark : Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return donorsArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell;
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    Donor *donor = [[Donor alloc]init];
    donor = [donorsArray objectAtIndex:indexPath.row];
    cell.labelForName.text = donor.name;
   
     [cell.buttonForContact setTitle:donor.phoneNo forState:UIControlStateNormal];
    CLLocation *donorLocation = [[CLLocation alloc] initWithLatitude:donor.lattitude longitude:donor.longitude];
 
   
    CLLocationDistance distance = [userLocation distanceFromLocation:donorLocation]/1000;
    //NSLog(@"%f",distance);
    cell.labelForDistance.text = [[NSNumber numberWithFloat:distance] stringValue];
    [self mapMarker:donorLocation withName:donor.name withPhoneNo:donor.phoneNo];
  //[self mapMarker():donorLocation];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma mark  : alert

-(void)alertMessageDisplay:(NSString *)title withMessage:(NSString *)message{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alertView show];
}



#pragma mark :Segmented controller


- (IBAction)segmentControllerValuechanged:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0){
        if([mapView isDescendantOfView:viewContainer])
            mapView.hidden = YES;
      
      listView.translatesAutoresizingMaskIntoConstraints = false;
       listView.hidden = NO;
        [self.viewContainer addSubview:listView];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:listView
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:listView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:listView
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:listView
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        
    }
    
    else {
         if([listView isDescendantOfView:viewContainer])
             listView.hidden = YES;
        
        mapView.translatesAutoresizingMaskIntoConstraints = false;
        mapView.hidden = NO;
         NSLog(@"navigation controller %@",self.navigationController);
        [self.viewContainer addSubview:mapView];
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:mapView
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:mapView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:mapView
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:0.0]];
        
        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:mapView
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:viewContainer
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:0.0]];

        [self mapMarker:userLocation withName:@"YourLocation" withPhoneNo:@"Your PhoneNo"];
    }
    
}


@end




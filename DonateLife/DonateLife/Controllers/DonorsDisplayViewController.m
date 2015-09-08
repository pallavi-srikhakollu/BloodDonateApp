

#import "DonorsDisplayViewController.h"



@interface DonorsDisplayViewController ()
{
 NSString *CellIdentifier;
}
@end

@implementation DonorsDisplayViewController
@synthesize segmentedController;
@synthesize donorsArray;
@synthesize userLocation;
@synthesize listView;
@synthesize viewContainer;
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    NSLog(@"%@",self.navigationController);
    self.segmentedController.selectedSegmentIndex = 0;
    
    listView = [[[NSBundle mainBundle] loadNibNamed:@"ListView" owner:self options:nil] lastObject];
    mapView = [[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil] lastObject];
    CellIdentifier = @"cell";
    listView.tableListForDonors.dataSource = self;
    listView.tableListForDonors.delegate =self;
    
     [listView.tableListForDonors registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    [self.viewContainer addSubview:self.listView];

    [self mapSettings];
    
}
-(void)mapSettings{
    //CLLocationCoordinate2D position = CLLocationCoordinate2DMake(18.562622, 73.808723);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:userLocation.coordinate.latitude
                                                            longitude:userLocation.coordinate.longitude
                                                                 zoom:10];
    mapView.mapView.myLocationEnabled = YES;
    mapView.mapView.mapType = kGMSTypeNormal;
    
    mapView.mapView.settings.compassButton = YES;
    
    mapView.mapView.settings.myLocationButton = YES;
    
    mapView.mapView.delegate = self;
    mapView.mapView.camera = camera;

}
-(void)mapMarker:(CLLocation*)location{
    NSLog(@"%@",location);
    GMSMarker *marker = [GMSMarker markerWithPosition:location.coordinate];
    NSLog(@"hhh");
    NSLog(@"%f",location.coordinate.latitude);
    marker.map = self.mapView.mapView;
    marker.title = @"pune";
    marker .snippet = @"Population: hello";
    marker.infoWindowAnchor = CGPointMake(0.5, 0.5);

}




-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return donorsArray.count;
    // return 10;
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
  [self mapMarker:donorLocation];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"hello");
}

- (IBAction)segmentControllerValuechanged:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0){
        if([self.mapView isDescendantOfView:viewContainer])
            [self.mapView removeFromSuperview];
       // [self.listView translatesAutoresizingMaskIntoConstraints:false];
        self.listView.translatesAutoresizingMaskIntoConstraints = false;
        [self.viewContainer addSubview:self.listView];
        
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
         if([self.listView isDescendantOfView:viewContainer])
             [self.listView removeFromSuperview];
         //[self.mapView translatesAutoresizingMaskIntoConstraints:false];
        self.mapView.translatesAutoresizingMaskIntoConstraints = false;
        [self.viewContainer addSubview:self.mapView];
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
//        [self.viewContainer addConstraint:[NSLayoutConstraint constraintWithItem:mapView
//                                                                       attribute:NSLayoutAttributeHeight
//                                                                       relatedBy:NSLayoutRelationEqual
//                                                                          toItem:viewContainer
//                                                                       attribute:NSLayoutAttributeHeight
//                                                                      multiplier:0.5
//                                                                        constant:200]];
       // self.mapView.layoutConstraintMapView.constant = self.view.frame.size.height-500;
        [self mapMarker:userLocation];
    }
    
}


@end




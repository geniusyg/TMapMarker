//
//  ViewController.m
//  TMapMarker
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#import "DetailViewController.h"

@interface ViewController () <TMapViewDelegate>
@property (strong,nonatomic) TMapView *mapView;

@end

@implementation ViewController

- (void)onClick:(TMapPoint *)TMP {
	NSLog(@"Tapped Point %@", TMP);
}

- (void)onLongClick:(TMapPoint *)TMP {
	NSLog(@"Long Clicked %@", TMP);
}

- (void)onCalloutRightbuttonClick:(TMapMarkerItem *)markerItem {
	NSLog(@"Marker ID : %@", [markerItem getID]);
	if([@"T-ACEDEMY" isEqualToString:[markerItem getID]]) {
		DetailViewController * detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
		detailVC.urlStr = @"https://oic.skplanet.com";
		
		[self presentViewController:detailVC animated:YES completion:nil];
	}
}

- (void)onCustomObjectClick:(TMapObject *)obj {
	if ([obj isKindOfClass:[TMapMarkerItem class]]) {
		TMapMarkerItem *marker = (TMapMarkerItem *)obj;
		NSLog(@"Marker Clicked %@", [marker getID]);
	}
}

- (IBAction)addOverlay:(id)sender {
	CLLocationCoordinate2D coord[5] = {
		CLLocationCoordinate2DMake(37.460143, 126.914062),
		CLLocationCoordinate2DMake(37.469136, 126.981869),
		CLLocationCoordinate2DMake(37.437930, 126.989937),
		CLLocationCoordinate2DMake(37.413255, 126.959038),
		CLLocationCoordinate2DMake(37.426752, 126.913548),
	};
	
	TMapPolygon *polygon = [[TMapPolygon alloc] init];
	[polygon setLineColor:[UIColor redColor]];
	[polygon setPolygonAlpha:0];
	[polygon setLineWidth:8.0];
	
	for(int i = 0 ; i < 5 ; i++) {
		[polygon addPolygonPoint:[TMapPoint mapPointWithCoordinate:coord[i]]];
	}
	
	[_mapView addTMapPolygonID:@"관악산" Polygon:polygon];
}
- (IBAction)addMarker:(id)sender {
	
	NSString *itemID = @"T-ACEDEMY";
	
	TMapPoint *point = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
	TMapMarkerItem *marker = [[TMapMarkerItem alloc] initWithTMapPoint:point];
	[marker setIcon:[UIImage imageNamed:@"point.png"]];
					 
	[marker setCanShowCallout:YES];
	[marker setCalloutTitle:@"티 아카데미"];
	[marker setCalloutRightButtonImage:[UIImage imageNamed:@"right.png"]];
	
	[_mapView addTMapMarkerItemID:itemID Marker:marker];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	CGRect rect = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
	
	_mapView = [[TMapView alloc] initWithFrame:rect];
	[_mapView setSKPMapApiKey:@"86a2bcf5-5df8-3727-a7b2-55957bfda634"];
	
	_mapView.delegate = self;
	
	[self.view addSubview:_mapView];
	
}
- (IBAction)moveToSeoul:(id)sender {
	TMapPoint  *centerPoint = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
	[_mapView setCenterPoint:centerPoint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

































//
//  MKMapView+ZoomLevel.h
//  CurrentAddress
//
//  Created by Efim Polevoi on 25/02/2016.
//
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

-(void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

-(double)getZoomLevel;

@end

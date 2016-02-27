//
//  NearbyPlaces.m
//  CurrentAddress
//
//  Created by Efim Polevoi on 26/02/2016.
//
//

#import "NearbyPlaces.h"

@interface NearbyPlaces ()
@property (nonatomic,strong) NSMutableArray* places;
@end

@implementation NearbyPlaces

-(id)init
{
    self = [super init];
    if (self) {
        _places = [NSMutableArray arrayWithObjects:@"Benalmadena", @"Fuengirola", @"Torremolinos", nil];
    }

    return self;
}

@end

#import "Location.h"

@interface Location()

@property (strong, nonatomic) NSArray *temperature;
@property (strong, nonatomic) NSArray *precipitation;


@end

@implementation Location

- (id)initWithName:(NSString *)name temperature:(NSArray *)temperature precipitiation:(NSArray *)precipitation
{
    self = [super init];
    
    if (self) {
        
        self.name = name;
        self.temperature = temperature;
        self.precipitation = precipitation;
    }
    
    return self;
}



- (NSString *)temperatureForDay:(NSInteger)day
{
    return (self.temperature[day]) ? self.temperature[day] : @"";
}

- (NSString *)precipitationForDay:(NSInteger)day
{
    return (self.precipitation[day]) ? self.precipitation[day] : @"";
}
- (NSString *)getName{
    return(self.name);
}


@end

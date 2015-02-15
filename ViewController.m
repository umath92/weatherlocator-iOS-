#import "ViewController.h"
#import "CSVParser.h"
#import "location.h"
@interface ViewController ()
@property (strong) NSArray *array;
@property (weak, nonatomic) IBOutlet UILabel *numberOfEntriesLabel;

@end
NSMutableArray *locArray;
@implementation ViewController

int day;
int month;
NSString *loc;
NSArray *testArray;
@synthesize array=_array;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*
     Adjust background image to correct size and fit to screen.
     */
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"inputData" ofType:@"csv"];
    
    
    
    [CSVParser parseCSVIntoArrayOfArraysFromFile:file
                    withSeparatedCharacterString:@""
                            quoteCharacterString:nil
                                       withBlock:^(NSArray *array, NSError *error) {
                                           self.array = array;
                                           
                                           
                                           NSArray *table = _array;
                                           
                                           locArray=[[NSMutableArray alloc] init];
                                           for (NSArray *column in table) {
                                               
                                               NSArray *correctColumn = [(NSString *)column[0] componentsSeparatedByString:@","];
                                               NSString *name = correctColumn[0];
                                               NSMutableArray *temperatures = [[NSMutableArray alloc] init];
                                               NSMutableArray *precipitations = [[NSMutableArray alloc] init];
                                               for(int i=1; i<correctColumn.count-1; i++)
                                               {
                                                   [temperatures addObject:[NSString stringWithFormat:correctColumn[i]]];
                                                   [precipitations addObject:[NSString stringWithFormat:correctColumn[i+1]]];
                                                   i=i+1;
                                                   
                                               }
                                               
                                               Location *location = [[Location alloc] initWithName:name temperature:temperatures precipitiation:precipitations];
                                               
                                               [locArray addObject:location];
                                           }
                                           
                                           
                                       }];
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg2.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    int numDays=(month-1)*30+day;
    NSString *prec1;
    bool status=false;
    NSString *temp1;
    for(int i=0; i<locArray.count; i++)
        {


            if([loc isEqualToString:([locArray[i] getName])]){
               // NSLog(@"MSG5: %@",[locArray[i] getName]);
                status=true;
                prec1=[locArray[i] precipitationForDay:(numDays)];
                temp1=[locArray[i] temperatureForDay:(numDays)];
                
            }
            
            
        }
    if(status){
        
   
    NSString *monthString = [[NSString alloc] initWithFormat:@"%d", month];
    NSString *dayString = [[NSString alloc] initWithFormat:@"%d", day];


    NSString *nextPage= [NSString stringWithFormat:@"%@/%@/%@/%@/%@", loc, dayString, monthString ,prec1,temp1];

    
    secondViewController *svc=[segue destinationViewController];
    svc.labelText=nextPage;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Invalid Input" message: nil delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
 
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static bool isValidDate(int testDate){
    
    NSLog(@"MSG: %u",day);
    
    if(day>31 || day<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Invalid Day Input" message: nil delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        return false;
    }
    return true;
}


static bool isValidMonth(int testMont){
    
    
    if(month>12 || month<1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Invalid Month Input" message: nil delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
        return false;
    }
    return true;
}





@synthesize myTextField=_myTextField;
- (IBAction)myTextField:(id)sender {
    
    NSString *dayText=_myTextField.text;
    day=[dayText intValue];//converting string to int
    if(!isValidDate(day)){
        _myTextField.text=nil;
    }
    
}
@synthesize inputMonth=_myInputMonth;
- (IBAction)inputMonth:(id)sender {
    
    NSString *monthText=_myInputMonth.text;
    month=[monthText intValue];//convert string to int.
    if(!isValidMonth(month)){
        _myInputMonth.text=nil;//Releasing inputField
    }
    
}
@synthesize inputLocation=_myInputLocation;
- (IBAction)inputLocation:(id)sender {
    
    loc=_myInputLocation.text;

    
}
@end

#import "secondViewController.h"

@interface secondViewController ()

@end

NSInteger prec;
NSInteger temp=10;

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *info=[_labelText componentsSeparatedByString:@"/"];
    prec=[info[3] integerValue];
    temp=[info[4] integerValue];
    temp=(temp-32)/2;
    if(temp>15){
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"sun.png"] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    else if(temp<=0){
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"snow.png"] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    else if(prec>=6){
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"rain.png"] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    _labelSceneTwo.text=_labelText;
     NSLog(@"MSG5: %@",isValidPrec());


    
    NSString *combDate= [NSString stringWithFormat:@"%@/%@", info[2],info[1]];
    _locLabel.text=info[0];
    _percLabel.text=info[3];
    _tempLabel.text=info[4];
    _dateLab.text=combDate;
    
    
}

static NSString* isValidTemp(){
    
    
    if(temp>35)
    {
        return @"You'll boil out!";
    }
    if(temp<=35 && temp>30){
        return @"Too hot and sunny";
    }
    if(temp>20 && temp<=30){
        return @"The sun won't bother you!";
    }
    if(temp>10 && temp<=20){
        return @"Better take a jacket!!";
    }
    if(temp>0 && temp<=10){
        return @"Going out is not such a good idea, its freezing!";
    }
    return @"A thick snowy jacket is what you need!";
    
    
}

static NSString* isValidPrec(){
    
    
    if(prec>=7 && prec<11)
    {
        return @"Better take your raincoats!";
    }
    if(prec<3){
        return @"The sky is your umbrella!!";
    }
    if(prec>=3 && prec<5 ){
        return @"A jacket will do!!";
    }
    return @"Take your umbrella!!";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

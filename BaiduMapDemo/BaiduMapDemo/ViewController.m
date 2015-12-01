//
//  ViewController.m
//  BaiduMapDemo
//
//  Created by Alex on 15/11/30.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "BaiduMapViewController.h"

@interface ViewController ()<ChooseAddressDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)chooseAddress:(id)sender {
    [self performSegueWithIdentifier:@"ShowBaiduMap" sender:nil];
}

- (IBAction)showBaiduMapAnnotationView:(id)sender {
    [self performSegueWithIdentifier:@"showBaiduMapAnnotationView" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowBaiduMap"]) {
        
        BaiduMapViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}


#pragma mark -
#pragma mark - RPChooseAddressControllerDelegate
- (void)chooseAddressController:(BaiduMapViewController *)aVC didGetLocation:(CLLocationCoordinate2D)aLocation andAddress:(NSString *)anAddress
{
    [_addressBtn setTitle:anAddress forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

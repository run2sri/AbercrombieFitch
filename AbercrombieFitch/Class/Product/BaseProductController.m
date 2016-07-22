//
//  BaseProductController.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "BaseProductController.h"
#import "JSONWebservice.h"
#import "AFUtils.h"
#import "ProductCardCellTableViewCell.h"
#import "ProductCard.h"
#import "AppDelegate.h"
#import "ProducrCardDelegate.h"
#import "AFWebViewController.h"

#pragma mark - @class : BaseProductController

@class ProductCard;

@interface BaseProductController () <ProducrCardDelegate>
@property (nonatomic, strong) NSArray *productCardRecords;
@property (nonatomic, strong) ProductCard *productCard;

@end

@implementation BaseProductController

#pragma mark - Viewcontroller Delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadProductData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper

- (void) loadProductData {
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if (app.productCardRecords) {
        self.productCardRecords = app.productCardRecords;
        dispatch_async(dispatch_get_main_queue() , ^{
            [self.tableView reloadData];
        });
    } else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadProductData) name:AFProductDataLoaded object:nil];
        });
    }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
}



#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productCardRecords count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCardCellTableViewCell * cell = nil;
    if ([self.productCardRecords count] > 0) {
        cell = (ProductCardCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:ProductCardCellIdentifier];
        cell.delegate = self;
        ProductCard *product = (ProductCard *)self.productCardRecords[indexPath.row];
        [cell configureCellAtIndexPath:indexPath withProduct:product];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCard *product = (ProductCard *)self.productCardRecords[indexPath.row];
    return [product heightForTableViewCell];
}

#pragma mark - Productcard delegate

- (void) loadURL:(NSString *) url {
    UIStoryboard *main = [AFUtils getMainStoryBoardWithName:AFMainStoryboardName];
    AFWebViewController *vc = (AFWebViewController *)[main instantiateViewControllerWithIdentifier:AFWebStoryIdentifier];
    vc.webURL = url;
    [self.navigationController pushViewController:vc animated:YES];
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

//
//  AbercrombieFitchTests.m
//  AbercrombieFitchTests
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseProductController.h"
#import "ProductHomeViewController.h"
#import "AFUtils.h"

@interface AbercrombieFitchTests : XCTestCase
@property (nonatomic, strong) ProductHomeViewController *productVc;
@end

@implementation AbercrombieFitchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.productVc = (ProductHomeViewController*) [storyboard instantiateViewControllerWithIdentifier:ProductCardCellIdentifier];
//    [self.productVc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - View loading tests

-(void)viewThatViewLoads
{
    XCTAssertNotNil(self.productVc.view, @"View not initiated properly");
}

- (void)parentViewHasTableViewSubview
{
    NSArray *subviews = self.productVc.view.subviews;
    XCTAssertTrue([subviews containsObject:self.productVc.tableView], @"View does not have a table subview");
}

-(void)tableviewThatTableViewLoads
{
    XCTAssertNotNil(self.productVc.tableView, @"TableView not initiated");
}

#pragma mark - product tableview

- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.productVc conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.productVc.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.productVc conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.productVc.tableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = 10;
    XCTAssertTrue([self.productVc tableView:self.productVc.tableView numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[self.productVc tableView:self.productVc.tableView numberOfRowsInSection:0], (long)expectedRows);
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.productVc tableView:self.productVc.tableView cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.section,(long)indexPath.row];
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}

@end

//
//  AlbumDetailsViewController.h
//  iMusic
//
//  Created by RA on 07/03/2020.
//  Copyright © 2020 TapHarmonic, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlbumDetailsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *albumImageView;
@property (nonatomic, weak) IBOutlet UILabel *albumNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *genereLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIButton *saveToListButton;
@property (nonatomic, weak) IBOutlet UIButton *openInITunesButton;

@property (nonatomic, strong) Album *album;
@property (nonatomic, assign) BOOL saveToListEnabled;


- (IBAction)saveToList:(id)sender;
- (IBAction)openInITunes:(id)sender;


- (void)encodeWithCoder:(nonnull NSCoder *)coder;

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection;

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container;

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize;

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container;

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator;

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator;

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator;

- (void)setNeedsFocusUpdate;

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context;

- (void)updateFocusIfNeeded;

@end

NS_ASSUME_NONNULL_END

//
//  UIActionSheet+DisabledButtons.m
//
//  Created by John on 09/06/14.
//  Copyright (c) 2014 Appreviation AB. All rights reserved.
//

#import "UIActionSheet+DisabledButtons.h"
#import <objc/runtime.h>

static void * DisabledButtonsKey = &DisabledButtonsKey;

@implementation UIActionSheet (DisabledButtons)

- (void)setDisabledButtons:(NSArray *)disabledButtons {
    objc_setAssociatedObject(self, DisabledButtonsKey, disabledButtons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)disabledButtons {
    return objc_getAssociatedObject(self, DisabledButtonsKey);
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    for(UIView *view in [actionSheet subviews]) {
        if([view isKindOfClass:NSClassFromString(@"UIAlertButton")]) {
            if([view respondsToSelector:@selector(title)]) {
                if([[self disabledButtons] containsObject:[view performSelector:@selector(title)]])
                    [view performSelector:@selector(setEnabled:) withObject:NO];
            }
        }
    }
}

@end


//
//  ImageModel.m
//  UIExample
//
//  Created by jason brown on 12/06/1402 AP.
//
#import "ImageModel.h"
@interface ImageModel ()

@property (strong, nonatomic) NSArray* imageNames;
@property (strong, nonatomic) NSDictionary* imageNameDict;

@end

@implementation ImageModel;

@synthesize imageNames = _imageNames;
@synthesize imageNameDict = _imageNameDict;

+(ImageModel*)sharedInstance{
    static ImageModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    } );
    return _sharedInstance;
}

-(NSArray*) imageNames{
    _imageNames = @[@"footprint", @"heartsandsand", @"praa_sands", @"sanddunes1", @"white_sands", @"whitesands2"];
    
    return _imageNames;
}

-(NSDictionary*) imageNameDict{
    if(!_imageNameDict)
        _imageNameDict = @{@"footprint": [UIImage imageNamed:@"footprint"],
                           @"heartsandsand": [UIImage imageNamed:@"heartsandsand"],
                           @"praa_sands": [UIImage imageNamed:@"praa_sands"],
                           @"sanddunes1": [UIImage imageNamed:@"sanddunes1"],
                           @"white_sands": [UIImage imageNamed:@"white_sands"],
                           @"whitesands2": [UIImage imageNamed:@"whitesands2"]
                           
        };
    return _imageNameDict;
}


-(UIImage*)getImageWithName:(NSString*)name{
    return self.imageNameDict[name];
}

-(UIImage*)getImageWithIndex:(NSInteger)index{
    return self.imageNameDict[self.imageNames[index]];
}

-(NSInteger)numberOfImages{
    return self.imageNameDict.count;
}

-(NSString*)getImageNameForIndex:(NSInteger)index{
    return self.imageNames[index];
}

@end


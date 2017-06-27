
//
//  LHCollectionViewLayout.swift
//  collectionDemo+
//
//  Created by liuhang on 17/6/26.
//  Copyright © 2017年 liuhang. All rights reserved.
//

import UIKit

class LHCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
            super.prepare()
            scrollDirection = .horizontal
            // 设置内边距
            let inset = (collectionView!.frame.size.width - itemSize.width) * 0.5;
            self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //取出父类算出的布局属性
        let superLayoutAttrs = super.layoutAttributesForElements(in: rect)
        //collectionView中心点的值
        let centerX = collectionView!.frame.size.width / 2 + collectionView!.contentOffset.x;
        
        //一个个取出来进行更改
        for atts in superLayoutAttrs! {
            // cell的中心点x 和 collectionView最中心点的x值 的间距
            let space = abs(atts.center.x - centerX);
            let scale = 1 - space/collectionView!.frame.size.width;
            atts.transform = CGAffineTransform(scaleX: scale, y: scale);
            
        }
        return superLayoutAttrs;
    }
    /** 返回true将会标记collectionView的data为 'dirty'
     * collectionView检测到 'dirty'标记时会在下一个周期中更新布局
     * 滚动的时候实时更新布局
     */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // 计算出最终显示的矩形框
        var rect = CGRect()
        rect.origin.y = 0
        rect.origin.x = proposedContentOffset.x//最终要停下来的X
        rect.size = collectionView!.frame.size
        
        //获得计算好的属性
        let attsArray = super.layoutAttributesForElements(in: rect)
        //计算collection中心点X
        let centerX = proposedContentOffset.x + collectionView!.frame.size.width / 2
        var minSpace: CGFloat = CGFloat(MAXFLOAT)
        for attrs in attsArray! {
            if abs(minSpace) > abs(attrs.center.x - centerX) {
                minSpace = attrs.center.x - centerX
            }
        }
        // 修改原有的偏移量
        let offSet = CGPoint.init(x: minSpace + proposedContentOffset.x, y: proposedContentOffset.y)
        
        return offSet;

    }
}

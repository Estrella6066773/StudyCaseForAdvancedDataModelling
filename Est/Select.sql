-- 分析每个大学最受欢迎的商品类别、平均价格和活跃卖家数量
SELECT
    u.name AS university_name,
    u.city AS university_city,
    pc.category_name AS most_popular_category,
    COUNT(l.listing_id) AS total_listings,
    COUNT(DISTINCT l.seller_id) AS active_sellers,
    ROUND(AVG(l.price), 2) AS avg_price,
    MAX(l.price) AS highest_price,
    MIN(l.price) AS lowest_price,
    -- 子查询：获取该大学最畅销的商品
    (SELECT l2.title
     FROM LISTING l2
              JOIN CAMPUS camp ON l2.campus_id = camp.campus_id
     WHERE camp.university_id = u.university_id
       AND l2.status = 'active'
     ORDER BY (
                  SELECT COUNT(*)
                  FROM "ORDER" o
                  WHERE o.listing_id = l2.listing_id
              ) DESC
     LIMIT 1) AS best_selling_item
FROM UNIVERSITY u
         JOIN CAMPUS camp ON u.university_id = camp.university_id
         JOIN LISTING l ON camp.campus_id = l.campus_id
         JOIN PRIMARY_CATEGORY pc ON l.primary_category_id = pc.category_id
WHERE l.status = 'active'
  AND l.created_at >= date('now', '-30 days')  -- 最近30天的商品
GROUP BY u.university_id, u.name, pc.category_id, pc.category_name
HAVING COUNT(l.listing_id) >= 5  -- 只显示至少有5个商品的类别
ORDER BY
    u.name,
    total_listings DESC,
    avg_price DESC;

-- 分析用户综合行为：销售表现、购买历史、愿望清单和活跃度
WITH UserSales AS (
    -- 用户销售统计子查询
    SELECT
        seller_id,
        COUNT(*) AS total_listings_created,
        SUM(CASE WHEN status = 'sold' THEN 1 ELSE 0 END) AS sold_listings,
        SUM(price) AS total_sales_value,
        AVG(price) AS avg_listing_price
    FROM LISTING
    GROUP BY seller_id
),
     UserPurchases AS (
         -- 用户购买统计子查询
         SELECT
             buyer_id,
             COUNT(*) AS total_purchases,
             SUM(total) AS total_spent,
             AVG(total) AS avg_purchase_amount
         FROM "ORDER"
         WHERE status = 'completed'
         GROUP BY buyer_id
     ),
     UserWishlist AS (
         -- 用户愿望清单统计子查询
         SELECT
             user_id,
             COUNT(*) AS wishlist_count,
             -- 子查询：愿望清单中最贵的商品
             (SELECT MAX(l.price)
              FROM WISHLIST w2
                       JOIN LISTING l ON w2.listing_id = l.listing_id
              WHERE w2.user_id = w.user_id AND l.status = 'active') AS max_wishlist_price
         FROM WISHLIST w
         GROUP BY user_id
     )
SELECT
    u.user_id,
    u.first_name || ' ' || u.last_name AS user_name,
    u.email,
    uni.name AS university_name,
    -- 销售数据
    COALESCE(us.total_listings_created, 0) AS listings_created,
    COALESCE(us.sold_listings, 0) AS items_sold,
    COALESCE(us.total_sales_value, 0) AS total_sales,
    -- 购买数据
    COALESCE(up.total_purchases, 0) AS purchases_made,
    COALESCE(up.total_spent, 0) AS total_spent,
    -- 愿望清单数据
    COALESCE(uw.wishlist_count, 0) AS wishlist_items,
    COALESCE(uw.max_wishlist_price, 0) AS max_wishlist_price,
    -- 用户活跃度评分（自定义算法）
    ROUND(
            (COALESCE(us.total_listings_created, 0) * 0.3) +
            (COALESCE(up.total_purchases, 0) * 0.4) +
            (COALESCE(uw.wishlist_count, 0) * 0.2) +
            (CASE WHEN u.is_verified = 1 THEN 1 ELSE 0 END) +
            (CASE WHEN u.status = 'active' THEN 1 ELSE 0 END),
            2) AS activity_score,
    -- 用户类型分类
    CASE
        WHEN COALESCE(us.total_listings_created, 0) > 10 AND COALESCE(up.total_purchases, 0) > 5 THEN 'Power User'
        WHEN COALESCE(us.total_listings_created, 0) > 5 THEN 'Active Seller'
        WHEN COALESCE(up.total_purchases, 0) > 3 THEN 'Active Buyer'
        WHEN COALESCE(uw.wishlist_count, 0) > 5 THEN 'Window Shopper'
        ELSE 'New User'
        END AS user_type,
    -- 最近活动时间
    (SELECT MAX(recent_activity)
     FROM (
              SELECT MAX(l.created_at) AS recent_activity FROM LISTING l WHERE l.seller_id = u.user_id
              UNION ALL
              SELECT MAX(o.created_at) FROM "ORDER" o WHERE o.buyer_id = u.user_id
              UNION ALL
              SELECT MAX(w.added_at) FROM WISHLIST w WHERE w.user_id = u.user_id
          )) AS last_activity_date
FROM USER u
         LEFT JOIN UNIVERSITY uni ON u.university_id = uni.university_id
         LEFT JOIN UserSales us ON u.user_id = us.seller_id
         LEFT JOIN UserPurchases up ON u.user_id = up.buyer_id
         LEFT JOIN UserWishlist uw ON u.user_id = uw.user_id
WHERE u.status = 'active'
  AND (us.total_listings_created > 0 OR up.total_purchases > 0 OR uw.wishlist_count > 0)
ORDER BY
    activity_score DESC,
    total_sales DESC,
    total_spent DESC
LIMIT 20;  -- 显示前20名最活跃的用户
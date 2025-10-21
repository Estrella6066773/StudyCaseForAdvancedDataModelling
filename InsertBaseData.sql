-- Data were inserted by Ai.
-- 插入大学数据
INSERT INTO UNIVERSITY (name, city) VALUES
    ('Tsinghua University', 'Beijing'),
    ('Peking University', 'Beijing'),
    ('Fudan University', 'Shanghai'),
    ('Shanghai Jiao Tong University', 'Shanghai'),
    ('Zhejiang University', 'Hangzhou'),
    ('Nanjing University', 'Nanjing'),
    ('Wuhan University', 'Wuhan'),
    ('Huazhong University of Science and Technology', 'Wuhan');

-- 插入校区数据
INSERT INTO CAMPUS (university_id, name) VALUES
    (1, 'Main Campus'),
    (1, 'Shenzhen Campus'),
    (2, 'Yanyuan Campus'),
    (2, 'Medical Department Campus'),
    (3, 'Handan Campus'),
    (3, 'Jiangwan Campus'),
    (4, 'Minhang Campus'),
    (4, 'Xuhui Campus'),
    (5, 'Zijingang Campus'),
    (5, 'Yuquan Campus');

-- 插入用户数据
INSERT INTO USER (university_id, email, password_hash, first_name, last_name, phone, is_verified, status) VALUES
    (1, 'zhangsan@tsinghua.edu.cn', 'hashed_password_1', 'San', 'Zhang', '13800138001', 1, 'active'),
    (1, 'lisi@tsinghua.edu.cn', 'hashed_password_2', 'Si', 'Li', '13800138002', 1, 'active'),
    (2, 'wangwu@pku.edu.cn', 'hashed_password_3', 'Wu', 'Wang', '13800138003', 1, 'active'),
    (3, 'zhaoliu@fudan.edu.cn', 'hashed_password_4', 'Liu', 'Zhao', '13800138004', 1, 'active'),
    (4, 'sunqi@sjtu.edu.cn', 'hashed_password_5', 'Qi', 'Sun', '13800138005', 1, 'active'),
    (5, 'zhouba@zju.edu.cn', 'hashed_password_6', 'Ba', 'Zhou', '13800138006', 1, 'active'),
    (100, 'example@test.com', 'hashed_password_7', 'Shi', 'Ce', '13800138100', 0, 'active')
;

-- 插入收货地址数据
INSERT INTO DELIVERY_ADDRESS (user_id, address_line1, address_line2, city, area) VALUES
    (1, 'Tsinghua University Zijing Apartment Building 1', 'Room 101', 'Beijing', 'Haidian District'),
    (1, 'Tsinghua University Library', 'Front Desk Collection', 'Beijing', 'Haidian District'),
    (2, 'Tsinghua University Zijing Apartment Building 2', 'Room 205', 'Beijing', 'Haidian District'),
    (3, 'Peking University Changchunyuan', 'Building 3 Room 302', 'Beijing', 'Haidian District'),
    (4, 'Fudan University South District Student Apartment', 'Building 12 Room 408', 'Shanghai', 'Yangpu District'),
    (5, 'No. 800 Dongchuan Road, Shanghai Jiao Tong University', 'West District Dormitory', 'Shanghai', 'Minhang District');

-- 插入商品类别数据
INSERT INTO PRIMARY_CATEGORY (category_name) VALUES
    ('Books'),
    ('Furniture'),
    ('Electronics'),
    ('Clothing'),
    ('Sports Equipment'),
    ('Daily Necessities');

-- 插入商品橱窗数据
INSERT INTO LISTING (seller_id, primary_category_id, title, description, condition, price, campus_id, status) VALUES
    (1, 1, 'Advanced Mathematics Textbook', 'Almost new, no notes or markings', 'like new', 25.00, 1, 'active'),
    (2, 2, 'Wooden Desk', 'Sturdy and durable, size 120*60cm', 'good', 80.00, 1, 'active'),
    (3, 1, 'English CET-4 Vocabulary Book', 'Some notes, does not affect use', 'used', 15.00, 3, 'active'),
    (4, 3, 'Second-hand Laptop', 'Configuration: i5, 8GB RAM, runs smoothly', 'fair', 1200.00, 5, 'active'),
    (5, 2, 'Folding Chair', 'Portable and lightweight, suitable for dormitory use', 'good', 35.00, 7, 'active'),
    (1, 4, 'Winter Down Jacket', 'Size L, good warmth', 'like new', 150.00, 1, 'active'),
    (2, 1, 'Data Structures and Algorithms', 'Computer science textbook', 'used', 30.00, 1, 'sold'),
    (3, 5, 'Basketball', 'Standard size 7, fully inflated', 'good', 40.00, 3, 'active');

-- 插入商品图片数据
INSERT INTO LISTING_PHOTO (listing_id, url) VALUES
    (1, 'https://example.com/photos/math_book_1.jpg'),
    (1, 'https://example.com/photos/math_book_2.jpg'),
    (2, 'https://example.com/photos/desk_1.jpg'),
    (2, 'https://example.com/photos/desk_2.jpg'),
    (3, 'https://example.com/photos/english_book_1.jpg'),
    (4, 'https://example.com/photos/laptop_1.jpg'),
    (4, 'https://example.com/photos/laptop_2.jpg'),
    (5, 'https://example.com/photos/chair_1.jpg'),
    (6, 'https://example.com/photos/coat_1.jpg'),
    (7, 'https://example.com/photos/algorithm_book_1.jpg'),
    (8, 'https://example.com/photos/basketball_1.jpg');

-- 插入订单数据
INSERT INTO "ORDER" (listing_id, buyer_id, address_id, total, status) VALUES -- ORDER is a keyword
    (7, 4, 5, 30.00, 'completed'),
    (1, 3, 4, 25.00, 'pending'),
    (2, 5, 6, 80.00, 'shipped'),
    (4, 1, 1, 1200.00, 'processing');

-- 插入收藏夹数据
INSERT INTO WISHLIST (user_id, listing_id) VALUES
    (1, 2),
    (1, 4),
    (2, 1),
    (3, 2),
    (3, 5),
    (4, 3),
    (5, 1),
    (5, 6);

-- 插入图书商品数据
INSERT INTO Book_listing (category_id, ISBN, title, publisher, edition) VALUES
    (1, '9787040384398', 'Advanced Mathematics', 'Higher Education Press', 'Seventh Edition'),
    (1, '9787312027411', 'English CET-4 Vocabulary', 'Foreign Language Teaching and Research Press', '2023 Edition'),
    (1, '9787115546081', 'Data Structures and Algorithms', 'People''s Posts and Telecommunications Press', 'First Edition'),
    (1, '9787121346235', 'Computer Organization Principles', 'Electronic Industry Press', 'Second Edition');

-- 插入家具商品数据
INSERT INTO FURNITURE_LISTING (category_id, dimensions, colour, material) VALUES
    (2, '120*60*75cm', 'Natural Wood Color', 'Solid Wood'),
    (2, '40*40*80cm', 'Black', 'Metal + Plastic'),
    (2, '60*40*45cm', 'White', 'Composite Board'),
    (2, '150*200*50cm', 'Walnut Color', 'Solid Wood + Fabric');
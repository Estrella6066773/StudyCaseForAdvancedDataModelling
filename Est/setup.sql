-- UNIVERSITY 大学
CREATE TABLE UNIVERSITY (
                            university_id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name TEXT NOT NULL,
                            city TEXT NOT NULL
);

-- USER 用户
CREATE TABLE USER (
                      user_id INTEGER PRIMARY KEY AUTOINCREMENT,
                      university_id INTEGER,
                      email TEXT UNIQUE,
                      password_hash TEXT NOT NULL,
                      first_name TEXT NOT NULL,
                      last_name TEXT NOT NULL,
                      phone TEXT,
                      is_verified BOOLEAN DEFAULT 0, -- 已验证
                      status TEXT DEFAULT 'active',
                      join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                      FOREIGN KEY (university_id) REFERENCES UNIVERSITY(university_id) -- 绑定外键
);

-- CAMPUS 校区
CREATE TABLE CAMPUS (
                        campus_id INTEGER PRIMARY KEY AUTOINCREMENT,
                        university_id INTEGER NOT NULL,
                        name TEXT NOT NULL,
                        FOREIGN KEY (university_id) REFERENCES UNIVERSITY(university_id)
);

-- DELIVERY_ADDRESS 收货地址
CREATE TABLE DELIVERY_ADDRESS (
                                  address_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                  user_id INTEGER NOT NULL,
                                  address_line1 TEXT NOT NULL,
                                  address_line2 TEXT, -- 补充信息
                                  city TEXT NOT NULL,
                                  area TEXT,
                                  FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

-- PRIMARY_CATEGORY 商品类别
CREATE TABLE PRIMARY_CATEGORY (
                                  category_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                  category_name TEXT UNIQUE NOT NULL
);

-- LISTING 橱窗
CREATE TABLE LISTING (
                         listing_id INTEGER PRIMARY KEY AUTOINCREMENT,
                         seller_id INTEGER NOT NULL,
                         primary_category_id INTEGER NOT NULL,
                         title TEXT NOT NULL,
                         description TEXT,
                         condition TEXT NOT NULL,
                         price DECIMAL(10,2) NOT NULL,
                         campus_id INTEGER NOT NULL,
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         status TEXT DEFAULT 'active',
                         FOREIGN KEY (seller_id) REFERENCES USER(user_id),
                         FOREIGN KEY (primary_category_id) REFERENCES PRIMARY_CATEGORY(category_id),
                         FOREIGN KEY (campus_id) REFERENCES CAMPUS(campus_id)
);

-- LISTING_PHOTO 图库
CREATE TABLE LISTING_PHOTO (
                               photo_id INTEGER PRIMARY KEY AUTOINCREMENT,
                               listing_id INTEGER NOT NULL,
                               url TEXT NOT NULL,
                               FOREIGN KEY (listing_id) REFERENCES LISTING(listing_id) ON DELETE CASCADE
);

-- ORDER 订单
CREATE TABLE "ORDER" (
                         order_id INTEGER PRIMARY KEY AUTOINCREMENT,
                         listing_id INTEGER NOT NULL,
                         buyer_id INTEGER NOT NULL,
                         address_id INTEGER NOT NULL,
                         total DECIMAL(10,2) NOT NULL,
                         status TEXT DEFAULT 'pending',
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (listing_id) REFERENCES LISTING(listing_id),
                         FOREIGN KEY (buyer_id) REFERENCES USER(user_id),
                         FOREIGN KEY (address_id) REFERENCES DELIVERY_ADDRESS(address_id)
);

-- WISHLIST 收藏夹
CREATE TABLE WISHLIST (
                          wishlist_id INTEGER PRIMARY KEY AUTOINCREMENT,
                          user_id INTEGER NOT NULL,
                          listing_id INTEGER NOT NULL,
                          added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (user_id) REFERENCES USER(user_id),
                          FOREIGN KEY (listing_id) REFERENCES LISTING(listing_id) ON DELETE CASCADE,
                          UNIQUE(user_id, listing_id)
);

-- Book_listing 图书商品专区
CREATE TABLE Book_listing (
                              book_sub_id INTEGER PRIMARY KEY AUTOINCREMENT,
                              category_id INTEGER NOT NULL,
                              ISBN TEXT,
                              title TEXT NOT NULL,
                              publisher TEXT,
                              edition TEXT,
                              FOREIGN KEY (category_id) REFERENCES PRIMARY_CATEGORY(category_id)
);

-- FURNITURE_LISTING 家具商品专区
CREATE TABLE FURNITURE_LISTING (
                                   furniture_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                   category_id INTEGER NOT NULL,
                                   dimensions TEXT,
                                   colour TEXT,
                                   material TEXT,
                                   FOREIGN KEY (category_id) REFERENCES PRIMARY_CATEGORY(category_id)
);
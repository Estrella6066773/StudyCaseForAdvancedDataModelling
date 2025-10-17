-- Create
-- 插入新用户
INSERT INTO USER (university_id, email, password_hash, first_name, last_name, phone, is_verified)
VALUES (1, 'zhangsan@tsinghua.edu.cn', 'hashed_password_123', '张', '三', '13800138001', 1);

-- 插入另一个用户（使用默认值）
INSERT INTO USER (university_id, email, password_hash, first_name, last_name)
VALUES (2, 'lisi@pku.edu.cn', 'hashed_password_456', '李', '四');

-- 查询所有已验证的用户
SELECT user_id, first_name, last_name, email, phone, join_date
FROM USER
WHERE is_verified = 1
ORDER BY join_date DESC;

-- 查询特定邮箱的用户（登录验证）
SELECT user_id, email, password_hash, first_name, last_name, is_verified, status
FROM USER
WHERE email = 'zhangsan@tsinghua.edu.cn';

-- 更新用户手机号和验证状态
UPDATE USER
SET phone = '13800138002', is_verified = 1
WHERE user_id = 1;

-- 停用用户账号
UPDATE USER
SET status = 'inactive'
WHERE email = 'lisi@pku.edu.cn' AND status = 'active';

-- 删除未验证的测试用户
DELETE FROM USER
WHERE is_verified = 0 AND join_date < date('now', '-7 days');

-- 删除特定用户（谨慎使用）
DELETE FROM USER
WHERE user_id = 100 AND status = 'inactive';
-- Additive, repeat-safe daily essentials catalog seed.
-- Demo accounts use the documented password Password@123.
INSERT INTO users (name, email, password_hash, role)
SELECT 'rublinjoe', 'rublinjoej@gmail.com',
       '$2a$10$1KFDDCFIbl2E96TQ1V5K5O5QbfVGm6.NTfyaGwaXotoLFtekEVG9K', 'ADMIN'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'rublinjoej@gmail.com'
);

INSERT INTO users (name, email, password_hash, role)
SELECT 'Daily Needs Market', 'dailyneeds@rublinmart.com',
       '$2a$10$1KFDDCFIbl2E96TQ1V5K5O5QbfVGm6.NTfyaGwaXotoLFtekEVG9K', 'SELLER'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'dailyneeds@rublinmart.com'
);

INSERT INTO users (name, email, password_hash, role)
SELECT 'Emily Davis', 'buyer4@rublinmart.com',
       '$2a$10$1KFDDCFIbl2E96TQ1V5K5O5QbfVGm6.NTfyaGwaXotoLFtekEVG9K', 'BUYER'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'buyer4@rublinmart.com'
);

INSERT INTO users (name, email, password_hash, role)
SELECT 'Michael Wilson', 'buyer5@rublinmart.com',
       '$2a$10$1KFDDCFIbl2E96TQ1V5K5O5QbfVGm6.NTfyaGwaXotoLFtekEVG9K', 'BUYER'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'buyer5@rublinmart.com'
);

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Organic Bananas (Bunch)', 'Fresh, naturally sweet bananas for snacks, smoothies, and breakfast.', 2.49, 60, 'Groceries', 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Organic Bananas (Bunch)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Jasmine Rice 5 lb', 'Fragrant long-grain jasmine rice, ideal for everyday meals and family dinners.', 8.99, 35, 'Groceries', 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Jasmine Rice 5 lb');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Whole Wheat Pasta 1 lb', 'Durum whole-wheat pasta with a hearty texture for quick weeknight meals.', 2.79, 45, 'Groceries', 'https://images.unsplash.com/photo-1551462147-ff29053bfc14?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Whole Wheat Pasta 1 lb');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Extra Virgin Olive Oil 500 ml', 'Cold-pressed olive oil for cooking, dressing salads, and dipping bread.', 10.49, 24, 'Groceries', 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Extra Virgin Olive Oil 500 ml');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Free-Range Eggs (Dozen)', 'A dozen fresh free-range eggs, a versatile staple for everyday cooking.', 4.29, 30, 'Groceries', 'https://images.unsplash.com/photo-1506976785307-8732e854ad03?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Free-Range Eggs (Dozen)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Ground Coffee 12 oz', 'Medium-roast ground coffee with a smooth, balanced flavor for your morning brew.', 9.99, 28, 'Beverages', '/rublinmart/images/products/ground-coffee.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Ground Coffee 12 oz');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Green Tea (20 Bags)', 'Refreshing green tea bags with a light, clean taste for any time of day.', 4.49, 40, 'Beverages', '/rublinmart/images/products/green-tea.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Green Tea (20 Bags)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Orange Juice 1 L', 'Bright, refreshing orange juice for breakfast or an anytime drink.', 3.99, 32, 'Beverages', 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Orange Juice 1 L');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Sparkling Mineral Water (6-Pack)', 'Crisp sparkling mineral water in a convenient six-bottle pack.', 5.49, 26, 'Beverages', '/rublinmart/images/products/sparkling-water.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Sparkling Mineral Water (6-Pack)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Oat Milk 1 L', 'Smooth, plant-based oat milk for cereal, coffee, and everyday recipes.', 3.49, 30, 'Beverages', '/rublinmart/images/products/oat-milk.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Oat Milk 1 L');

UPDATE products SET image_url = '/rublinmart/images/products/ground-coffee.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Ground Coffee 12 oz'
  AND image_url = 'https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/green-tea.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Green Tea (20 Bags)'
  AND image_url IN ('https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500', 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=500');

UPDATE products SET image_url = '/rublinmart/images/products/sparkling-water.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Sparkling Mineral Water (6-Pack)'
  AND image_url IN ('https://images.unsplash.com/photo-1523362628745-0c100150b6bc?w=500', 'https://images.unsplash.com/photo-1564419320461-6870880221ad?w=500');

UPDATE products SET image_url = '/rublinmart/images/products/oat-milk.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Oat Milk 1 L'
  AND image_url IN ('https://images.unsplash.com/photo-1600788886242-5c96aabe3757?w=500', 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500');

UPDATE products SET image_url = 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Organic Bananas (Bunch)'
  AND image_url = 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500';

UPDATE products SET image_url = 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Jasmine Rice 5 lb'
  AND image_url = 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/dish-soap.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Dish Soap 24 oz'
  AND image_url = 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/paper-towels.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Paper Towels (6 Rolls)'
  AND image_url = 'https://images.unsplash.com/photo-1584556812952-905ffd0c611a?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/trash-bags.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Kitchen Trash Bags (30 Count)'
  AND image_url = 'https://images.unsplash.com/photo-1605600659873-d808a13e4d9a?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/toothpaste.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Fluoride Toothpaste (2-Pack)'
  AND image_url = 'https://images.unsplash.com/photo-1609840114035-3c981b782dfe?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/shampoo.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Moisturizing Shampoo 400 ml'
  AND image_url = 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/body-wash.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Body Wash 500 ml'
  AND image_url = 'https://images.unsplash.com/photo-1600428853876-fb5a850b444f?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/hand-soap.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Hand Soap (2-Pack)'
  AND image_url = 'https://images.unsplash.com/photo-1584305574647-0cc949a2bb9f?w=500';

UPDATE products SET image_url = '/rublinmart/images/products/toothbrushes.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Bamboo Toothbrushes (4-Pack)'
  AND image_url = 'https://images.unsplash.com/photo-1609840114035-3c981b782dfe?w=500';

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Laundry Detergent 64 Loads', 'Concentrated laundry detergent for a dependable clean in every load.', 12.99, 22, 'Household Essentials', '/rublinmart/images/products/laundry-detergent.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Laundry Detergent 64 Loads');

UPDATE products SET image_url = '/rublinmart/images/products/laundry-detergent.svg'
WHERE seller_id = (SELECT id FROM users WHERE email = 'dailyneeds@rublinmart.com')
  AND name = 'Laundry Detergent 64 Loads'
  AND image_url = 'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=500';

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Dish Soap 24 oz', 'Grease-cutting dish soap for clean dishes and everyday kitchen cleanup.', 3.29, 36, 'Household Essentials', '/rublinmart/images/products/dish-soap.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Dish Soap 24 oz');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Paper Towels (6 Rolls)', 'Soft, absorbent paper towels for kitchen spills and household cleaning.', 7.49, 25, 'Household Essentials', '/rublinmart/images/products/paper-towels.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Paper Towels (6 Rolls)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'All-Purpose Cleaner 32 oz', 'Everyday spray cleaner for counters, sealed surfaces, and common household messes.', 4.99, 28, 'Household Essentials', 'https://images.unsplash.com/photo-1563453392212-326f5e854473?w=500'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'All-Purpose Cleaner 32 oz');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Kitchen Trash Bags (30 Count)', 'Durable drawstring trash bags for daily kitchen and household waste.', 6.49, 32, 'Household Essentials', '/rublinmart/images/products/trash-bags.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Kitchen Trash Bags (30 Count)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Fluoride Toothpaste (2-Pack)', 'Daily cavity-protection toothpaste in a convenient two-tube value pack.', 5.99, 34, 'Personal Care', '/rublinmart/images/products/toothpaste.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Fluoride Toothpaste (2-Pack)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Moisturizing Shampoo 400 ml', 'Gentle everyday shampoo that cleanses while helping hair feel soft and hydrated.', 7.49, 24, 'Personal Care', '/rublinmart/images/products/shampoo.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Moisturizing Shampoo 400 ml');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Body Wash 500 ml', 'Refreshing body wash for a comfortable, clean start or end to your day.', 6.29, 26, 'Personal Care', '/rublinmart/images/products/body-wash.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Body Wash 500 ml');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Hand Soap (2-Pack)', 'Gentle liquid hand soap refill bottles for kitchens and bathrooms.', 4.79, 30, 'Personal Care', '/rublinmart/images/products/hand-soap.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Hand Soap (2-Pack)');

INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url)
SELECT u.id, 'Bamboo Toothbrushes (4-Pack)', 'Soft-bristle toothbrushes with bamboo handles in a family-friendly four-pack.', 8.49, 20, 'Personal Care', '/rublinmart/images/products/toothbrushes.svg'
FROM users u WHERE u.email = 'dailyneeds@rublinmart.com'
AND NOT EXISTS (SELECT 1 FROM products p WHERE p.seller_id = u.id AND p.name = 'Bamboo Toothbrushes (4-Pack)');

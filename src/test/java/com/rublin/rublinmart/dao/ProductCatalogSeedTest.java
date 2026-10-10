package com.rublin.rublinmart.dao;

import org.h2.tools.RunScript;
import org.junit.jupiter.api.Test;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

class ProductCatalogSeedTest {

    @Test
    void addsDailyEssentialsAndCanBeAppliedMoreThanOnce() throws Exception {
        String databaseName = "catalogseed_" + UUID.randomUUID().toString().replace("-", "");
        try (Connection connection = DriverManager.getConnection(
                "jdbc:h2:mem:" + databaseName + ";DB_CLOSE_DELAY=-1", "sa", "")) {
            executeScript(connection, "db/schema.sql");
            executeScript(connection, "db/seed.sql");

            executeScript(connection, "db/catalog.sql");
            assertEquals(28, queryInt(connection, "SELECT COUNT(*) FROM products"));
            assertEquals(5, queryInt(connection, "SELECT COUNT(*) FROM products WHERE category = 'Groceries'"));
            assertEquals(3, queryInt(connection, "SELECT COUNT(*) FROM users WHERE role = 'SELLER'"));
            assertEquals(5, queryInt(connection, "SELECT COUNT(*) FROM users WHERE role = 'BUYER'"));
            assertEquals(2, queryInt(connection, "SELECT COUNT(*) FROM users WHERE role = 'ADMIN'"));
            assertEquals("rublinjoe", queryString(connection,
                    "SELECT name FROM users WHERE email = 'rublinjoej@gmail.com'"));
            assertEquals("Emily Davis", queryString(connection,
                    "SELECT name FROM users WHERE email = 'buyer4@rublinmart.com'"));
            assertEquals("Michael Wilson", queryString(connection,
                    "SELECT name FROM users WHERE email = 'buyer5@rublinmart.com'"));
            assertEquals("https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Organic Bananas (Bunch)'"));
            assertEquals("https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Jasmine Rice 5 lb'"));
            assertEquals("/rublinmart/images/products/green-tea.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Green Tea (20 Bags)'"));
            assertEquals("/rublinmart/images/products/sparkling-water.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Sparkling Mineral Water (6-Pack)'"));
            assertEquals("/rublinmart/images/products/oat-milk.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Oat Milk 1 L'"));
            assertEquals("/rublinmart/images/products/ground-coffee.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Ground Coffee 12 oz'"));
            assertEquals("/rublinmart/images/products/trash-bags.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Kitchen Trash Bags (30 Count)'"));
            assertEquals("/rublinmart/images/products/laundry-detergent.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Laundry Detergent 64 Loads'"));

            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500' WHERE name = 'Green Tea (20 Bags)'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1523362628745-0c100150b6bc?w=500' WHERE name = 'Sparkling Mineral Water (6-Pack)'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1600788886242-5c96aabe3757?w=500' WHERE name = 'Oat Milk 1 L'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=500' WHERE name = 'Laundry Detergent 64 Loads'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500' WHERE name = 'Organic Bananas (Bunch)'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=500' WHERE name = 'Jasmine Rice 5 lb'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1583947215259-38e31be8751f?w=500' WHERE name = 'Dish Soap 24 oz'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1584556812952-905ffd0c611a?w=500' WHERE name = 'Paper Towels (6 Rolls)'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1605600659873-d808a13e4d9a?w=500' WHERE name = 'Kitchen Trash Bags (30 Count)'");
            execute(connection, "UPDATE products SET image_url = 'https://images.unsplash.com/photo-1609840114035-3c981b782dfe?w=500' WHERE name = 'Bamboo Toothbrushes (4-Pack)'");

            executeScript(connection, "db/catalog.sql");
            assertEquals(28, queryInt(connection, "SELECT COUNT(*) FROM products"));
            assertEquals(1, queryInt(connection,
                    "SELECT COUNT(*) FROM products WHERE name = 'Organic Bananas (Bunch)'"));
            assertEquals(5, queryInt(connection, "SELECT COUNT(*) FROM users WHERE role = 'BUYER'"));
            assertEquals(2, queryInt(connection, "SELECT COUNT(*) FROM users WHERE role = 'ADMIN'"));
            assertEquals("/rublinmart/images/products/green-tea.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Green Tea (20 Bags)'"));
            assertEquals("/rublinmart/images/products/laundry-detergent.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Laundry Detergent 64 Loads'"));
            assertEquals("/rublinmart/images/products/dish-soap.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Dish Soap 24 oz'"));
            assertEquals("/rublinmart/images/products/toothbrushes.svg",
                    queryString(connection, "SELECT image_url FROM products WHERE name = 'Bamboo Toothbrushes (4-Pack)'"));
            assertTrue(queryInt(connection,
                    "SELECT COUNT(DISTINCT category) FROM products") >= 7);
        }
    }

    private void executeScript(Connection connection, String resource) throws Exception {
        try (InputStream input = getClass().getClassLoader().getResourceAsStream(resource)) {
            if (input == null) {
                throw new IllegalStateException("SQL resource not found: " + resource);
            }
            RunScript.execute(connection, new InputStreamReader(input, StandardCharsets.UTF_8));
        }
    }

    private int queryInt(Connection connection, String sql) throws Exception {
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            resultSet.next();
            return resultSet.getInt(1);
        }
    }

    private String queryString(Connection connection, String sql) throws Exception {
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            resultSet.next();
            return resultSet.getString(1);
        }
    }

    private void execute(Connection connection, String sql) throws Exception {
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(sql);
        }
    }
}

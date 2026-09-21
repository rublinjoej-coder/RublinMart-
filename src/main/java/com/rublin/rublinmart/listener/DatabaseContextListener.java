package com.rublin.rublinmart.listener;

import com.rublin.rublinmart.dao.DBConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.h2.tools.RunScript;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebListener
public class DatabaseContextListener implements ServletContextListener {

    private static final Logger logger = LoggerFactory.getLogger(DatabaseContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("Initializing RublinMart Web Application Context & Database...");
        try {
            DBConnection.init();

            if (!databaseExists("users")) {
                executeSqlScript("db/schema.sql");
                executeSqlScript("db/seed.sql");
                logger.info("Database schema and seed scripts executed successfully.");
                return;
            }

            if (countRows("users") == 0) {
                executeSqlScript("db/seed.sql");
                logger.info("Database seed data restored because no users were present.");
                return;
            }

            logger.info("Database already initialized; skipping schema and seed re-execution.");
        } catch (Exception e) {
            logger.error("Error initializing database context", e);
            throw new RuntimeException("Database initialization failed", e);
        }
    }

    private boolean databaseExists(String tableName) throws Exception {
        String sql = "SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ? AND TABLE_SCHEMA = CURRENT_SCHEMA";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tableName.toUpperCase());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private int countRows(String tableName) throws Exception {
        if (!databaseExists(tableName)) {
            return 0;
        }

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + tableName)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        } catch (SQLException e) {
            if (e.getErrorCode() == 42104 || e.getMessage().contains("Table \"" + tableName.toUpperCase() + "\" not found")) {
                return 0;
            }
            throw e;
        }
    }

    private void executeSqlScript(String resourcePath) throws Exception {
        try (InputStream is = getClass().getClassLoader().getResourceAsStream(resourcePath)) {
            if (is == null) {
                throw new IllegalStateException("SQL resource not found: " + resourcePath);
            }

            try (Connection conn = DBConnection.getConnection();
                 BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
                RunScript.execute(conn, reader);
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("Shutting down RublinMart Web Application Context...");
        DBConnection.close();
    }
}

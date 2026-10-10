# RublinMart — Project Explanation Pro

## 1. What this project is

RublinMart is a Java web application for a multi-seller online marketplace. Buyers can discover products, keep a database-backed cart, place orders, review products, and check order history. Sellers manage their own products and fulfill orders. Administrators can inspect platform users and orders and moderate listings.

The application is built as a traditional Java Servlet web application. It is **not** a Spring Boot application: the browser loads static HTML, CSS, and JavaScript, and the Java server exposes JSON APIs under `/api/v1`.

## 2. Technology stack

| Area | Technology | How it is used |
| --- | --- | --- |
| Language | Java | Servlet controllers, services, data access, models, and utilities |
| Web server/API | Java Servlets 4 (`javax.servlet`) | Handles HTTP requests and responses; intended for Apache Tomcat 9 |
| Frontend | HTML5, CSS3, vanilla JavaScript | Renders pages, dashboards, and interactive shopping flows without a frontend framework |
| Browser/server communication | Fetch API and JSON | JavaScript calls the servlet API; Gson reads and writes JSON |
| Database | H2 | Relational storage in a local file by default |
| Database access | JDBC and HikariCP | SQL access and pooled database connections |
| Password security | jBCrypt | Hashes and verifies account passwords |
| Logging | SLF4J and Logback | Application logs |
| Build/package | Maven | Resolves dependencies, compiles code, runs tests, and creates the WAR |
| Tests | JUnit 5 and Mockito | Unit and database-backed tests |

### Java version note

The Maven compiler configuration in `pom.xml` sets Java **source and target to 17**. The main README currently lists JDK 25 as a prerequisite. Those declarations do not match; the Maven compiler settings are the concrete project build target. Confirm and align the desired JDK policy before changing the project version.

## 3. Architecture and request flow

The main request path is:

```text
Browser page + JavaScript
        |
        | HTTP request (JSON for API calls)
        v
Servlet controller (/api/v1/...)
        |
        v
Service (validation and marketplace rules)
        |
        v
DAO (JDBC queries and transactions)
        |
        v
H2 database
```

The browser receives JSON responses, usually through shared response helpers in `JsonUtil`. Authentication state is held in an HTTP session, not a JWT. `AuthFilter` checks access to protected pages and API routes, while servlet and service code performs additional user/role checks.

## 4. Main project areas

| Location | Responsibility |
| --- | --- |
| `src/main/java/com/rublin/rublinmart/controller/` | Servlet endpoints: authentication, products, cart, orders, reviews, seller, admin, chat, and health |
| `src/main/java/com/rublin/rublinmart/service/` | Application rules such as validation, cart management, checkout, and role-specific operations |
| `src/main/java/com/rublin/rublinmart/dao/` | Database connection management and JDBC operations for users, products, carts, orders, and reviews |
| `src/main/java/com/rublin/rublinmart/model/` | Core data objects such as `User`, `Product`, `Order`, `OrderItem`, `CartItem`, and `Review` |
| `src/main/java/com/rublin/rublinmart/dto/` | Response shapes returned to the browser |
| `src/main/java/com/rublin/rublinmart/filter/` | Request filters for authentication/authorization, encoding, and logging |
| `src/main/java/com/rublin/rublinmart/listener/` | Application startup and shutdown hooks, including database initialization |
| `src/main/java/com/rublin/rublinmart/util/` | Shared password, validation, and JSON helpers |
| `src/main/resources/db/` | SQL schema and repeatable starter/catalog data |
| `src/main/resources/application.properties` | Database pool and chatbot configuration |
| `src/main/webapp/pages/` | Storefront, login/registration, cart/checkout, order, seller, and admin pages |
| `src/main/webapp/js/` | Browser behavior for authentication, products, cart, checkout, dashboards, and chat |
| `src/main/webapp/css/` | Page styling and responsive layout |
| `src/test/java/` | Unit tests and database/seed behavior tests |

## 5. Features by role

### Buyer

- Register and sign in.
- Browse/search products and filter by category.
- View product details and reviews.
- Add items to a persistent cart, adjust quantities, or remove them.
- Check out and view order history/status.
- Submit a review after purchasing a product.

### Seller

- View and manage the seller's own product listings.
- View orders containing the seller's products.
- Update order fulfillment status.

### Administrator

- View registered users and filter them by role.
- View platform orders and products.
- Remove inappropriate product listings.

### Shared features

- A public health endpoint checks whether the database can be reached.
- A chat widget responds through a mock provider by default. A Gemini provider is also present and can be selected through configuration.

## 6. API overview

API routes are rooted at `/api/v1`. The principal endpoint groups are:

| Route | Purpose |
| --- | --- |
| `/auth/*` | Registration, login, logout, and current-session profile |
| `/products/*` | Product listing/search, categories, details, and seller product changes |
| `/cart/*` | Buyer cart retrieval and item changes |
| `/orders/*` | Checkout and buyer order history/details |
| `/reviews/*` | Read product reviews and submit reviews |
| `/seller/*` | Seller listings, incoming orders, and fulfillment updates |
| `/admin/*` | Administrative user, product, and order views |
| `/chat` | Chat assistant messages |
| `/health` | Application/database health check |

The existing README contains the detailed HTTP method, endpoint, and access table, plus the demo account list.

## 7. Data model and database

The H2 schema in `src/main/resources/db/schema.sql` defines:

- **users** — account name, unique email, password hash, role, and creation time.
- **products** — seller-owned listings, prices, stock, categories, and image URLs.
- **cart_items** — a user's selected products and quantities; a unique constraint prevents duplicate rows for the same user/product pair.
- **orders** and **order_items** — buyer purchases and their line items, quantities, and purchase prices.
- **reviews** — product ratings and comments associated with a user.

Foreign keys connect products to sellers, carts to users/products, order items to orders/products, and reviews to users/products. The schema also defines indexes for common lookups.

By default, `application.properties` points H2 at `./data/rublinmartdb`, so the database persists on disk relative to the process working directory. HikariCP manages connections. `DatabaseContextListener` initializes schema and initial seed data when needed, then applies `catalog.sql` at startup; that catalog script is designed to be repeatable and add its users/products without duplicating them.

The checkout service recalculates totals on the server and validates available stock. The DAO performs order creation, stock reduction, order-item insertion, and cart clearing in a database transaction. Payment is currently **simulated**: the order service marks a placed order `CONFIRMED`; there is no payment gateway integration in this project.

## 8. Authentication and security notes

- Passwords are stored as jBCrypt hashes, not plaintext.
- Login creates an HTTP session and invalidates an existing session first.
- The session inactivity timeout is 30 minutes.
- Admin and seller routes are restricted by role checks; cart, checkout, and order pages require an authenticated session.
- SQL is issued through JDBC prepared statements for parameterized values.
- Demo accounts and passwords are documented in the main README and are for local/demo use only. Change or remove seeded credentials before any production deployment.
- The configured session cookie has `secure=false`; production deployments must use HTTPS and configure secure cookies and other production security controls.

## 9. Build, test, and run

Run these commands from the repository root with a JDK compatible with the Maven compiler configuration and Maven installed:

```bash
# Run the automated test suite
mvn clean test

# Build the deployable WAR
mvn clean package
```

The WAR is written to `target/rublinmart.war`. The Maven Tomcat plugin is configured for port `8080` and context path `/rublinmart`; the README documents `mvn tomcat7:run` for local execution. Alternatively, deploy the WAR to a compatible Tomcat 9 server. The application landing page is:

```text
http://localhost:8080/rublinmart/pages/index.html
```

The database directory is relative to the server's working directory. Keep it in mind when starting the application from an IDE, Maven, or an external Tomcat installation, because different working directories can produce different H2 database files.

## 10. Chatbot configuration

The default `ai.chatbot.provider` is `mock`, so the application can answer common store questions without a third-party service. To use Gemini, configure the provider as `gemini` and supply a valid `gemini.api.key` in a secure local configuration. Do not commit API keys. If Gemini is unavailable or errors, the provider implementation falls back to mock responses. Chat input is limited to 500 characters and rate-limited per client IP.

## 11. Current scope and limitations

- The application serves a multi-page HTML frontend backed by a Servlet JSON API; it is not a SPA or Spring application.
- Payment processing is mocked; there is no real payment capture.
- The default chatbot is rule-based mock behavior; Gemini is optional.
- H2 is the configured database. A production database migration or cloud database configuration is not included here.
- Demo seed credentials are not production credentials.

## 12. Useful project references

- Build and dependencies: `pom.xml`
- Existing feature/API documentation and demo logins: `README.md`
- HTTP and session configuration: `src/main/webapp/WEB-INF/web.xml`
- Runtime settings: `src/main/resources/application.properties`
- Database schema and seed scripts: `src/main/resources/db/`
- Application startup database initialization: `src/main/java/com/rublin/rublinmart/listener/DatabaseContextListener.java`

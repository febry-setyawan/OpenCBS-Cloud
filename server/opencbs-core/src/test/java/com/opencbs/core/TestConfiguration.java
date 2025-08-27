package com.opencbs.core;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.test.context.TestPropertySource;

/**
 * Test configuration class for Spring Boot tests in opencbs-core module.
 * This class provides the necessary @SpringBootConfiguration for tests
 * without requiring a dependency on the main ServerApplication.
 * 
 * Configured to work with both Spring Boot 1.5.x and 2.7.x
 */
@SpringBootApplication
@EnableAsync
@ComponentScan("com.opencbs")
@EntityScan("com.opencbs")
@EnableScheduling
@TestPropertySource(properties = {
    "spring.datasource.url=jdbc:h2:mem:testdb",
    "spring.datasource.driver-class-name=org.h2.Driver",
    "spring.jpa.database-platform=org.hibernate.dialect.H2Dialect",
    "spring.jpa.hibernate.ddl-auto=create-drop"
})
public class TestConfiguration {
    // This class is intentionally empty and serves as a test configuration
}
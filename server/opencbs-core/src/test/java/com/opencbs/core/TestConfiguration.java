package com.opencbs.core;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Test configuration class for Spring Boot tests in opencbs-core module.
 * This class provides the necessary @SpringBootConfiguration for tests
 * without requiring a dependency on the main ServerApplication.
 */
@SpringBootApplication
@EnableAsync
@ComponentScan("com.opencbs")
@EntityScan("com.opencbs")
@EnableScheduling
public class TestConfiguration {
    // This class is intentionally empty and serves as a test configuration
}
package com.opencbs.core.config;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;

/**
 * Minimal test configuration that excludes problematic migration strategy
 * for testing PostgreSQL + Flyway configuration.
 */
@SpringBootApplication
@ComponentScan(basePackages = "com.opencbs",
        excludeFilters = {
                @ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE, 
                    classes = com.opencbs.core.configs.CoreFlywayMigrationStrategy.class),
                @ComponentScan.Filter(type = FilterType.ASSIGNABLE_TYPE, 
                    classes = com.opencbs.core.configs.SwaggerConfig.class)
        })
@EntityScan(basePackages = "com.opencbs")
public class TestConfig {
}
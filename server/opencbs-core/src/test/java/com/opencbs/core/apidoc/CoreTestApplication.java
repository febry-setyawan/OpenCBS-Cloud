package com.opencbs.core.apidoc;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;

/**
 * Test configuration for OpenCBS Core module tests.
 */
@Configuration
@EnableAutoConfiguration
@ComponentScan(basePackages = "com.opencbs", 
               excludeFilters = @ComponentScan.Filter(
                   type = FilterType.ASSIGNABLE_TYPE, 
                   classes = com.opencbs.core.configs.SwaggerConfig.class))
@EntityScan(basePackages = "com.opencbs")
public class CoreTestApplication {
}
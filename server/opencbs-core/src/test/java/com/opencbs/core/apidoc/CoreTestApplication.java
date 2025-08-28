package com.opencbs.core.apidoc;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * Test configuration for OpenCBS Core module tests.
 */
@Configuration
@EnableAutoConfiguration
@ComponentScan(basePackages = "com.opencbs")
@EntityScan(basePackages = "com.opencbs")
public class CoreTestApplication {
}
package com.opencbs.core.configs;

import lombok.extern.slf4j.Slf4j;
import org.flywaydb.core.Flyway;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationStrategy;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Configuration
public class CoreFlywayMigrationStrategy implements FlywayMigrationStrategy {

    @Autowired
    ApplicationContext context;
    
    @Value("${spring.flyway.enabled:true}")
    private boolean flywayEnabled;

    @Override
    public void migrate(Flyway flyway) {
        if (!flywayEnabled) {
            log.info("Flyway migration is disabled, skipping database migration");
            return;
        }
        
        log.info("Start migrate OpenCBS cloud database");

        // Create new flyway configuration for core migration
        Flyway coreFlywayConfig = Flyway.configure()
                .dataSource(flyway.getConfiguration().getDataSource())
                .schemas("public")
                .table("schema_version_core")
                .locations("classpath:db/migration/core")
                .load();
        coreFlywayConfig.migrate();

        for (FlywayConfig config : this.getConfigs()) {
            log.info(String.format("Start migrate to %s", config.getTable()));
            
            // Create new flyway configuration for each module
            Flyway moduleFlywayConfig = Flyway.configure()
                    .dataSource(flyway.getConfiguration().getDataSource())
                    .schemas(config.getSchema())
                    .table(config.getTable())
                    .locations(config.getLocation())
                    .baselineOnMigrate(config.getBaselineOnMigrate())
                    .load();
            moduleFlywayConfig.migrate();
        }
    }

    private List<FlywayConfig> getConfigs() {
        return this.context.getBeansOfType(FlywayConfig.class)
                .entrySet()
                .stream()
                .map(x -> x.getValue())
                .collect(Collectors.toList());
    }
}

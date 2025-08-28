package com.opencbs.core.apidoc;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.boot.test.mock.mockito.MockBean;

@SpringBootTest(classes = CoreTestApplication.class)
@ActiveProfiles("test")
public class PasswordDebugTest {
    
    /**
     * Mock PermissionInitializer to prevent it from running during tests
     */
    @MockBean
    private com.opencbs.core.security.permissions.PermissionInitializer permissionInitializer;
    
    /**
     * Mock other problematic services
     */
    @MockBean
    private com.opencbs.core.officedocuments.services.JasperReportService jasperReportService;
    
    @MockBean
    private com.opencbs.core.officedocuments.services.PrintingFormService printingFormService;
    
    @MockBean
    private org.springframework.mail.javamail.JavaMailSender javaMailSender;
    
    @MockBean
    private com.opencbs.core.officedocuments.services.ExcelReportService excelReportService;
    
    @MockBean
    private com.opencbs.core.accounting.services.AccountTagInitializer accountTagInitializer;
    
    @MockBean
    private com.opencbs.core.configs.UserSessionHandler userSessionHandler;
    
    @MockBean
    private com.opencbs.core.services.SystemSettingsService systemSettingsService;
    
    @Test
    public void testPasswordHash() {
        String password = "admin";
        String storedHash = "$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAPXvQOr0k8rUZ.aJfiVgI/JqFfG";
        
        // Test if password matches
        boolean matches = BCrypt.checkpw(password, storedHash);
        System.out.println("Password 'admin' matches stored hash: " + matches);
        
        // Generate a new hash to compare
        String newHash = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println("New hash for 'admin': " + newHash);
        
        boolean newMatches = BCrypt.checkpw(password, newHash);
        System.out.println("Password 'admin' matches new hash: " + newMatches);
    }
}
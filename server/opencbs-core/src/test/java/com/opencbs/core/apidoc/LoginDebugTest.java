package com.opencbs.core.apidoc;

import com.opencbs.core.dto.requests.LoginRequest;
import com.opencbs.core.dto.responses.ApiResponse;
import com.opencbs.core.controllers.LoginController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.boot.test.mock.mockito.MockBean;

@SpringBootTest(classes = CoreTestApplication.class)
@ActiveProfiles("test")
public class LoginDebugTest {
    
    @Autowired(required = false)
    private LoginController loginController;
    
    /**
     * Mock services to avoid initialization issues in tests
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
    private com.opencbs.core.security.permissions.PermissionInitializer permissionInitializer;
    
    @MockBean
    private com.opencbs.core.accounting.services.AccountTagInitializer accountTagInitializer;
    
    @MockBean
    private com.opencbs.core.configs.UserSessionHandler userSessionHandler;
    
    @MockBean
    private com.opencbs.core.services.SystemSettingsService systemSettingsService;
    
    @Test
    public void testLoginDirectly() {
        try {
            LoginRequest request = new LoginRequest();
            request.setUsername("admin");
            request.setPassword("admin");
            
            System.out.println("LoginController: " + loginController);
            
            if (loginController != null) {
                ApiResponse<String> result = loginController.login(request);
                System.out.println("Direct controller call result: " + result);
                System.out.println("Data: " + result.getData());
            }
        } catch (Exception e) {
            System.out.println("Exception in direct controller call: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
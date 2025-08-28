package com.opencbs.core.apidoc;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opencbs.core.dto.requests.LoginRequest;
import com.opencbs.core.helpers.DateHelper;
import com.opencbs.core.officedocuments.services.JasperReportService;

import org.junit.jupiter.api.extension.RegisterExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.restdocs.RestDocumentationContextProvider;
import org.springframework.restdocs.RestDocumentationExtension;
import org.springframework.restdocs.payload.FieldDescriptor;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.documentationConfiguration;
import static org.springframework.restdocs.payload.PayloadDocumentation.fieldWithPath;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

public abstract class BaseDocumentationTest {

    @RegisterExtension
    final RestDocumentationExtension restDocumentation = new RestDocumentationExtension("target/generated-snippets");

    MockMvc mockMvc;

    @Autowired
    private WebApplicationContext context;



    /**
     * Mock JasperReportService to avoid initialization issues in tests
     */
    @MockBean
    private JasperReportService jasperReportService;

    /**
     * Mock PrintingFormService to avoid initialization issues in tests
     */
    @MockBean
    private com.opencbs.core.officedocuments.services.PrintingFormService printingFormService;

    /**
     * Mock JavaMailSender to avoid mail configuration issues in tests
     */
    @MockBean
    private org.springframework.mail.javamail.JavaMailSender javaMailSender;

    /**
     * Mock ExcelReportService to avoid initialization issues in tests
     */
    @MockBean
    private com.opencbs.core.officedocuments.services.ExcelReportService excelReportService;

    /**
     * Mock PermissionInitializer to avoid database initialization issues in tests
     */
    @MockBean
    private com.opencbs.core.security.permissions.PermissionInitializer permissionInitializer;

    /**
     * Mock AccountTagInitializer to avoid initialization issues in tests
     */
    @MockBean
    private com.opencbs.core.accounting.services.AccountTagInitializer accountTagInitializer;

    /**
     * Mock UserSessionHandler to avoid authentication context issues in tests
     */
    @MockBean
    private com.opencbs.core.configs.UserSessionHandler userSessionHandler;

    /**
     * Mock SystemSettingsService to avoid system settings dependencies in tests
     */
    @MockBean
    private com.opencbs.core.services.SystemSettingsService systemSettingsService;

    protected void setup(RestDocumentationContextProvider restDocumentation) throws Exception {
        this.mockMvc = MockMvcBuilders
                .webAppContextSetup(this.context)
                .apply(springSecurity())
                .apply(documentationConfiguration(restDocumentation))
                .build();
    }

    String login() throws Exception {
        LoginRequest request = new LoginRequest();
        request.setUsername("admin");
        request.setPassword("admin");

        try {
            var result = this.mockMvc.perform(post("/api/login")
                    .content(asJson(request))
                    .contentType(MediaType.APPLICATION_JSON))
                    .andReturn();
            
            int status = result.getResponse().getStatus();
            String responseContent = result.getResponse().getContentAsString();
            
            System.out.println("Login HTTP Status: " + status);
            System.out.println("Login response content: '" + responseContent + "'");

            if (responseContent.isEmpty()) {
                throw new RuntimeException("Login returned empty response with status: " + status);
            }

            JsonNode jsonNode = new ObjectMapper().readValue(responseContent, JsonNode.class);
            System.out.println("JsonNode: " + jsonNode); // Debug output
            System.out.println("Data node: " + jsonNode.get("data")); // Debug output
            
            if (jsonNode.get("data") == null) {
                throw new RuntimeException("Login failed: " + responseContent);
            }
            
            return "Bearer " + jsonNode.get("data").asText();
        } catch (Exception e) {
            System.out.println("Exception during login: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    String asJson(Object object) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(object);
    }

    String asJson(Object object, Class ignoreMask) throws JsonProcessingException {
        Jackson2ObjectMapperBuilder builder = new Jackson2ObjectMapperBuilder();
        builder.indentOutput(true).dateFormat(new SimpleDateFormat(DateHelper.DATE_FORMAT));
        ObjectMapper objectMapper = builder.build();
        objectMapper.addMixIn(object.getClass(), ignoreMask);
        return objectMapper.writeValueAsString(object);
    }

    List<FieldDescriptor> getCustomFieldSectionWithValueFieldDescriptors() {
        List<FieldDescriptor> result = new ArrayList<>();
        result.add(fieldWithPath("customFieldSections[]").description("An array of custom field sections."));
        result.add(fieldWithPath("customFieldSections[].id").description("The ID of the custom field section."));
        result.add(fieldWithPath("customFieldSections[].caption").description("The caption of the custom field section."));
        result.add(fieldWithPath("customFieldSections[].order").description("The order of the custom field section."));
        result.add(fieldWithPath("customFieldSections[].values").description("An array of custom field values inside of the section."));
        result.add(fieldWithPath("customFieldSections[].values[].value").description("The textual representation of the custom field value."));
        result.add(fieldWithPath("customFieldSections[].values[].customField").description("TODO: add link to custom field section."));
        return result;
    }

    List<FieldDescriptor> getCustomFieldSectionFieldDescriptors(String prefix) {
        List<FieldDescriptor> result = new ArrayList<>();
        result.add(fieldWithPath(prefix + "id").description("The ID of the custom field section."));
        result.add(fieldWithPath(prefix + "caption").description("The caption of the custom field section."));
        result.add(fieldWithPath(prefix + "order").description("The order of the custom field section."));
        result.add(fieldWithPath(prefix + "customFields[]").description("An array of custom fields linked to the section."));
        return result;
    }

    List<FieldDescriptor> getCustomFieldFieldDescriptors(String prefix) {
        List<FieldDescriptor> result = new ArrayList<>();
        result.add(fieldWithPath(prefix + "id").description("The ID of the custom field."));
        result.add(fieldWithPath(prefix + "sectionId").description("The ID of the section the custom field belongs to."));
        result.add(fieldWithPath(prefix + "name").description("The system name of the custom field."));
        result.add(fieldWithPath(prefix + "caption").description("The caption of the custom field."));
        result.add(fieldWithPath(prefix + "fieldType").description("The type of the custom field. Can be one of the following: `TEXT`, `TEXT_AREA`, `NUMERIC`, `LIST`, `LOOKUP`"));
        result.add(fieldWithPath(prefix + "unique").description("Indicates whether the values linked to the custom field should be unique."));
        result.add(fieldWithPath(prefix + "required").description("Indicates whether the values linked to the custom field can be empty."));
        result.add(fieldWithPath(prefix + "order").description("The order of the custom field within the section."));
        result.add(fieldWithPath(prefix + "extra").description("TODO: add the definition of extra."));
        return result;
    }

    List<FieldDescriptor> getPageableDescriptors() {
        List<FieldDescriptor> result = new ArrayList<>();
        result.add(fieldWithPath("last").description("true if it is the last page, false otherwise."));
        result.add(fieldWithPath("totalPages").description("The total number of pages."));
        result.add(fieldWithPath("totalElements").description("The total number of items in the given resource."));
        result.add(fieldWithPath("sort").description("The type of sorting."));
        result.add(fieldWithPath("first").description("true if it the first page, false otherwise."));
        result.add(fieldWithPath("numberOfElements").description("The actual number of items returned on the page."));
        result.add(fieldWithPath("size").description("The size of the page."));
        result.add(fieldWithPath("number").description("The number of the page."));
        return result;
    }
}

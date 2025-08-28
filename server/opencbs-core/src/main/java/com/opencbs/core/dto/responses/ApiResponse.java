package com.opencbs.core.dto.responses;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created by Makhsut Islamov on 06.01.2017.
 */
public class ApiResponse <T> {
    @JsonProperty("data")
    private T data;

    public ApiResponse() {
    }

    public ApiResponse(T data){
        this.data = data;
    }
    
    public T getData() {
        return data;
    }
    
    public void setData(T data) {
        this.data = data;
    }
}
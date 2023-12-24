package com.example.backend.entity;


import lombok.Data;

@Data
public class DepartmentLog {
    private String operation_time;
    private String type;
    private Integer depart_no;
    private Integer id;
    private String bank_name;
    private String depart_name;
    private String pre_depart_name;
    private String depart_type;
    private String pre_depart_type;
}

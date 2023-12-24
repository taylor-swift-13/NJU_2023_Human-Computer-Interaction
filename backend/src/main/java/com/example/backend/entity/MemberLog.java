package com.example.backend.entity;


import lombok.Data;

@Data
public class MemberLog {
    String operation_time;
    String type;
    Integer id;
    String sex;
    String person_id;
    String begin_date;
    Integer depart_no;
    Integer pre_depart_no;
    Integer dep_depart_no;
    Integer pre_dep_depart_no;
    String bank_name;
    String pre_bank_name;
    String name;
    String pre_name;
    String phone;
    String pre_phone;
    String address;
    String pre_address;
    Integer salary;
    Integer pre_salary;
    Integer level;
    String pre_level;
}

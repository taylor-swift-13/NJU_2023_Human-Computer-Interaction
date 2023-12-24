package com.example.backend.mapper;
import com.example.backend.entity.DepartmentLog;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DepartmentLogMapper {

    @Insert("INSERT INTO department_log (operation_time, type,depart_no, id, bank_name, " +
            "depart_name, pre_depart_name, depart_type, pre_depart_type) " +
            "VALUES (#{operation_time}, #{type}, #{depart_no}, #{id}, #{bank_name}, #{depart_name}, " +
            "#{pre_depart_name}, #{depart_type}, #{pre_depart_type})")
    void insert(DepartmentLog departmentLog);

    @Select("SELECT * FROM department_log")
    List<DepartmentLog> page();

}


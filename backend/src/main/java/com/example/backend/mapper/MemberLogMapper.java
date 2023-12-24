package com.example.backend.mapper;

import com.example.backend.entity.MemberLog;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface MemberLogMapper {

    @Insert("INSERT INTO member_log (operation_time, type, id, sex, person_id, begin_date, depart_no, pre_depart_no, " +
            "dep_depart_no, pre_dep_depart_no, bank_name, pre_bank_name, name," +
            " pre_name, phone, pre_phone, address, pre_address, salary, pre_salary," +
            " level, pre_level) VALUES (#{operation_time}, #{type}, #{id}, #{sex}, #{person_id},#{begin_date}," +
            " #{depart_no}, #{pre_depart_no}, #{dep_depart_no}, #{pre_dep_depart_no}, #{bank_name}, " +
            "#{pre_bank_name}, #{name}, #{pre_name}, #{phone}, #{pre_phone}, #{address}, #{pre_address}, #{salary}, #{pre_salary}," +
            " #{level}, #{pre_level})")
    void insertMemberLog(MemberLog memberLog);

    @Select("select * from member_log")
    List<MemberLog> page();

}

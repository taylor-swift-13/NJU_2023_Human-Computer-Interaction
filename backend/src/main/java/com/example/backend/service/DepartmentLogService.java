package com.example.backend.service;
import com.example.backend.common.Response;
import com.example.backend.entity.Department;
import com.example.backend.entity.DepartmentLog;
import com.example.backend.entity.MemberLog;
import com.example.backend.mapper.DepartmentLogMapper;
import com.example.backend.mapper.MemberLogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class DepartmentLogService {

    final DepartmentLogMapper departmentLogMapper;

    @Autowired
    public DepartmentLogService(DepartmentLogMapper departmentLogMapper) {
        this.departmentLogMapper = departmentLogMapper;
    }

    public Response insert(DepartmentLog departmentLog) {
        departmentLogMapper.insert(departmentLog);
        return Response.success();
    }


    public Response page() {
        List<DepartmentLog> departmentLogList= departmentLogMapper.page();
        Map<String, Object> map = new HashMap<>();
        map.put("data", departmentLogList);
        return Response.success(map);
    }


}